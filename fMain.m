function [iy, iy0, y, y0, W, W0, R, R0] = fMain(s, fs, M, N, realTheta, epsilon_theta)
%Constants
slen = 160000; %Length of source signal
xlen = 100000; %Length of observed signal

s = s(:,1:slen);

if ~exist("epsilon_theta")
    epsilon_theta = zeros(1,M);
end

l = 0.04; %Distance between sensors, m
c = 343; %Speed of signals, m/s

win = hamming(512); %STFT analysis/synthesis window
hop = 120; %STFT hop size
nfft = 512; %STFT number of FFT points

N_frame = 6; %Number of frames used for each estimate of Rxx
rxx_window_length = 184; %Rxx estimate window length

epsilon = 0.01; %Cost threshold
mu = 0.1; %Step size

nTheta = 256; %DOA resolution
realTheta = realTheta*pi/180;
Theta = realTheta + epsilon_theta*pi/180;

%Simulate sensor obesrvations
x = fMicsim(s, fs, N, l, realTheta, xlen); %output - x

%noise = Noisevec(1:length(x(1,:)),1);
%x = x + ones(N,1)*noise';

%STFT
clear sx
clear sx_full
for i = 1:N
    [sx_full(i,:, :), fvec, tvec] = HZ_stft(x(i,:), win, hop, nfft, fs);
end

F = length(fvec);
fmax = max(fvec);
T = length(tvec);
tmax = max(tvec);

%Calculate DM
DM = zeros(F,N,M);
realDM = zeros(F,N,M);
for th = 1:M
    DM(:,:,th) = exp(-2*pi*1i*l*sin(Theta(th))/c.*fvec'*(1:N));
    realDM(:,:,th) = exp(-2*pi*1i*l*sin(realTheta(th))/c.*fvec'*(1:N));
end

for f = 1:F
    condDM(f) = cond(squeeze(DM(f,:,:)));
end
condDM_inv = 1./condDM;

%Initialise W
W = permute(conj(DM), [1 3 2]);
W0 = W;
realW0 = permute(conj(realDM), [1 3 2]);

eye_f = permute(repmat(eye(M), [1,1,F]), [3 1 2]);

clear iJ
clear iJC1
clear iJC2

main_loop = 0;
while (main_loop+1)*rxx_window_length <= T
    disp("main loop = " + main_loop);

    %current window of sx
    sx = sx_full(:,:,main_loop*rxx_window_length+1:(main_loop+1)*rxx_window_length);
    
    %Estimate rxx
    rxx = fRxx(sx, N_frame, rxx_window_length);

    %1st dependencies
    %Calculate alpha
    alpha = fAlpha(rxx);
    
    delta = 10e5;
    ls_loop = 1;
    while delta > epsilon && ls_loop < 1000
        ticls = tic;
        
        ticryy = tic;
        ryy = fRyy(W, rxx);
        tryy(main_loop+1, ls_loop) = toc(ticryy);
        
        [C2, JC2] = fC2(W, DM, eye_f);
        
        %2nd dependencies
        
        E = fE(ryy);
        
        delJC2 = fDelJC2(C2, DM, condDM_inv);
        
        %3rd dependencies

        J = fJ(E, alpha);
        
        ticdelj = tic;
        delJ = fDelJ(W, E, rxx, alpha);
        tdelj(main_loop+1,ls_loop) = toc(ticdelj);
        
        %Update W
        W = W - mu*(delJ + delJC2);
        
        iJ(main_loop+1, ls_loop) = sum(J);
        iJC(main_loop+1, ls_loop) = sum(JC2);
        
        if ls_loop > 1
            delta = iJ(main_loop+1,ls_loop-1)-iJ(main_loop+1,ls_loop);
            deltaC = iJC(main_loop+1,ls_loop-1)-iJC(main_loop+1,ls_loop);
        end
        ls_loop = ls_loop + 1;
        
        if mod(ls_loop,50) == 0
            disp("ls loop = " + ls_loop);
            disp("delta = " + delta);
            disp("deltaC = " + deltaC);
            disp("J = " + iJ(main_loop+1, ls_loop-1));
            disp("JC = " + iJC(main_loop+1, ls_loop-1));
        end
        tls(main_loop+1, ls_loop) = toc(ticls);
    end
    iJ(main_loop+1, ls_loop:end) = iJ(main_loop+1, ls_loop-1);
    iJC(main_loop+1, ls_loop:end) = iJC(main_loop+1, ls_loop-1);

    main_loop = main_loop + 1;
end

D = fD(F, N, nTheta, fs);
%D_hres = fD(F, N, nTheta*3, fs);
y = fY(W, sx_full);
y0 = fY(W0, sx_full);
R = fR(W, D);
R0 = fR(W0, D);

for m = 1:M 
    [iy(m,:), ~] = HZ_istft(y(:,:,m), win, win, hop, nfft, fs);
    [iy0(m,:), ~] = HZ_istft(y0(:,:,m), win, win, hop, nfft, fs);
end

