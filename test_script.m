clear

%initialise parameters
M = 3; %Number of sources
Theta = [-30*pi/180 -10*pi/180 45*pi/180]; %Angle of sources, rad

%source audio file names
src_file1 = "Dev_2ch_3src_Ca_Ce_A_Src1.wav";
src_file2 = "Dev_2ch_3src_Ca_Ce_A_Src3.wav";
src_file3 = "Dev_2ch_3src_Ca_Ce_A_Src2.wav";

[Src1, fs] = audioread(src_file1);
[Src2, ~] = audioread(src_file2);
[Src3, ~] = audioread(src_file3);

slen = 160000; %Length of source signal

%Shorten source signals to proper size
clear s
s(1,:) = Src1(1:slen);
s(2,:) = Src2(1:slen);
s(3,:) = Src3(1:slen);

%Variance of uncertain DOA
th_var(1) = 10;
th_var(2) = 25;
th_var(3) = 12;

%Error in DOA [eps_theta_1 eps_theta_2 ... ]
eps_theta = [0 -10 5];

%Constants
N = 8; %Number of sensors
l = 0.4; %Distance between sensors, m
c = 343; %Speed of signals, m/s

xlen = 100000; %Length of observed signal

win = hamming(1024); %STFT analysis/synthesis window
hop = 120; %STFT hop size
nfft = 1024; %STFT number of FFT points

N_frame = 18; %Number of frames used for each estimate of Rxx
rxx_window_length = 92; %Rxx estimate wndow length

epsilon = 0.01; %Cost threshold
mu = 1e-1; %Step size

buffer = 1000; %buffer at startof signal to prevent negative indexing

nTheta = 256; %Angle resolution of D

isC1 = false; %if true, use constraint C1, otherwise use constraint C2

realTheta = Theta;

% 6 test cases, 2 standard GSS runs, 2 GSS_g runs, 2 initial weight cases


% 1. True Angles, GSS and W0
disp("Case 1")

iswrongDOA = false;

main_script;

y1 = y; % STFT of recovered signals
W1 = W; % GSS demixing matrix
W0_true = W0; % Initial beamformer demixing matrix
R1 = R; % Beamformer reponse field
R0_true = R0; 
y0_true = y0;

% Inverse STFT
% [iy1(1,:), ~] = HZ_istft(y(:,:,1), win, win, hop, nfft, fs);
% [iy1(2,:), ~] = HZ_istft(y(:,:,2), win, win, hop, nfft, fs);

for i = 1:M
    [iy1(i,:), ~] = HZ_istft(y(:,:,i), win, win, hop, nfft, fs);
end

%Evaluation sample of source signals
s_eval = s(:,900:length(iy1(1,:))+899);

% SIR, SDR, SAR, permutation evaluation of recovered signals
[sdr1,sir1,sar1,perm1, ~] = bss_eval_sources(iy1,s_eval);

% Inverse STFT
% [iy0_true(1,:), ~] = HZ_istft(y0_true(:,:,1), win, win, hop, nfft, fs);
% [iy0_true(2,:), ~] = HZ_istft(y0_true(:,:,2), win, win, hop, nfft, fs);

for i = 1:M
    [iy0_true(i,:), ~] = HZ_istft(y0_true(:,:,i), win, win, hop, nfft, fs);
end
% SIR, SDR, SAR, permutation evaluation of recovered signals
[sdr0_true,sir0_true,sar0_true,perm0_true, ~] = bss_eval_sources(iy0_true,s_eval);
% 2. True Angles, GSS_g
disp("Case 2")

main_g_script;

yg = y;
Wg = W;
Rg = R;

% Inverse STFT
% [iyg(1,:), ~] = HZ_istft(yg(:,:,1), win, win, hop, nfft, fs);
% [iyg(2,:), ~] = HZ_istft(yg(:,:,2), win, win, hop, nfft, fs);
for i = 1:M
    [iyg(i,:), ~] = HZ_istft(yg(:,:,i), win, win, hop, nfft, fs);
end
% SIR, SDR, SAR, permutation evaluation of recovered signals
[sdrg,sirg,sarg,permg, ~] = bss_eval_sources(iyg,s_eval);

% 3. False Angles, GSS and W0
disp("Case 3")

iswrongDOA = true;
Theta = realTheta + eps_theta*pi/180;

main_script;

y_false = y; % STFT of recovered signals
W_false = W; % GSS demixing matrix
W0_false = W0; % Initial beamformer demixing matrix
R_false = R; % Beamformer reponse field
R0_false = R0; 
y0_false = y0;

% Inverse STFT
% [iy_false(1,:), ~] = HZ_istft(y_false(:,:,1), win, win, hop, nfft, fs);
% [iy_false(2,:), ~] = HZ_istft(y_false(:,:,2), win, win, hop, nfft, fs);

for i = 1:M
    [iy_false(i,:), ~] = HZ_istft(y_false(:,:,i), win, win, hop, nfft, fs);
end

% SIR, SDR, SAR, permutation evaluation of recovered signals
[sdr_false,sir_false,sar_false,perm_false, ~] = bss_eval_sources(iy_false,s_eval);

% Inverse STFT
% [iy0_false(1,:), ~] = HZ_istft(y0_false(:,:,1), win, win, hop, nfft, fs);
% [iy0_false(2,:), ~] = HZ_istft(y0_false(:,:,2), win, win, hop, nfft, fs);
for i = 1:M
    [iy0_false(i,:), ~] = HZ_istft(y0_false(:,:,i), win, win, hop, nfft, fs);
end
% SIR, SDR, SAR, permutation evaluation of recovered signals
[sdr0_false,sir0_false,sar0_false,perm0_false, ~] = bss_eval_sources(iy0_false,s_eval);

% 4. False Angles, GSS_g
disp("Case 4")

main_g_script;

yg_false = y; % STFT of recovered signals
Wg_false = W; % GSS demixing matrix
Rg_false = R; % Beamformer reponse field

% Inverse STFT
% [iyg_false(1,:), ~] = HZ_istft(yg_false(:,:,1), win, win, hop, nfft, fs);
% [iyg_false(2,:), ~] = HZ_istft(yg_false(:,:,2), win, win, hop, nfft, fs);

for i = 1:M
    [iyg_false(i,:), ~] = HZ_istft(yg_false(:,:,i), win, win, hop, nfft, fs);
end
% SIR, SDR, SAR, permutation evaluation of recovered signals
[sdrg_false,sirg_false,sarg_false,permg_false, ~] = bss_eval_sources(iyg_false,s_eval);



% Save results to workspace

% Test workspace name
ws_filename = "M_" + M;

for i = 1:M
    ws_filename = ws_filename + "_Th" + i + "_" + (floor(realTheta(i)*180/pi) + 1);
end

% Test workspace path
ws_path = "tests\" + ws_filename + "\";

% Make test directory
if exist(ws_path, 'dir')
    ws_filename = ws_filename + "__" + char(datetime('now','Format','yyyy-MM-dd''T''HHmmss'));
    ws_path = "tests\" + ws_filename + "\";
end

mkdir(ws_path)

% Save workspace 
save(ws_path + ws_filename + ".mat");

% Save signals as .wav
% audiowrite(char(ws_path + "iy1_1.wav"), iy1(1,:), fs);
% audiowrite(char(ws_path + "iy1_2.wav"), iy1(2,:), fs);
% 
% audiowrite(char(ws_path + "iy_false_1.wav"), iy_false(1,:), fs);
% audiowrite(char(ws_path + "iy_false_2.wav"), iy_false(2,:), fs);
% 
% audiowrite(char(ws_path + "iy0_true_1.wav"), iy0_true(1,:), fs);
% audiowrite(char(ws_path + "iy0_true_2.wav"), iy0_true(2,:), fs);
% 
% audiowrite(char(ws_path + "iy0_false_1.wav"), iy0_false(1,:), fs);
% audiowrite(char(ws_path + "iy0_false_2.wav"), iy0_false(2,:), fs);
% 
% audiowrite(char(ws_path + "iyg_true_1.wav"), iyg(1,:), fs);
% audiowrite(char(ws_path + "iyg_true_2.wav"), iyg(2,:), fs);
% 
% audiowrite(char(ws_path + "iyg_false_1.wav"), iyg_false(1,:), fs);
% audiowrite(char(ws_path + "iyg_false_2.wav"), iyg_false(2,:), fs);
% 
% audiowrite(char(ws_path + "s1.wav"), s_eval(1,:), fs);
% audiowrite(char(ws_path + "s2.wav"), s_eval(2,:), fs);
for i = 1:M
    audiowrite(char(ws_path + "iy1_" + i + ".wav"), iy1(i,:), fs);

    audiowrite(char(ws_path + "iy_false_" + i + ".wav"), iy_false(i,:), fs);

    audiowrite(char(ws_path + "iy0_true_" + i + ".wav"), iy0_true(i,:), fs);

    audiowrite(char(ws_path + "iy0_false_" + i + ".wav"), iy0_false(i,:), fs);

    audiowrite(char(ws_path + "iyg_true_" + i + ".wav"), iyg(i,:), fs);

    audiowrite(char(ws_path + "iyg_false_" + i + ".wav"), iyg_false(i,:), fs);

    audiowrite(char(ws_path + "s" + i + ".wav"), s_eval(i,:), fs);
end

%pesq score
deg = "iy1";

% mos(1) = my_pesq_mos(ws_path, 's1', deg + '_1');
% mos(2) = my_pesq_mos(ws_path, 's2', deg + '_2');

for i = 1:M
    mos(i) = my_pesq_mos(ws_path, "s" + i, deg + '_' + i);
end

%save results in struct
results(2).sig = deg;
results(2).sir = sir1;
results(2).pesq = mos';

%pesq score
deg = "iy_false";

% mos(1) = my_pesq_mos(ws_path, 's1', deg + '_1');
% mos(2) = my_pesq_mos(ws_path, 's2', deg + '_2');

for i = 1:M
    mos(i) = my_pesq_mos(ws_path, "s" + i, deg + '_' + i);
end

%save results in struct
results(5).sig = deg;
results(5).sir = sir_false;
results(5).pesq = mos';

%pesq score
deg = "iy0_true";

% mos(1) = my_pesq_mos(ws_path, 's1', deg + '_1');
% mos(2) = my_pesq_mos(ws_path, 's2', deg + '_2');

for i = 1:M
    mos(i) = my_pesq_mos(ws_path, "s" + i, deg + '_' + i);
end

%save results in struct
results(1).sig = deg;
results(1).sir = sir0_true;
results(1).pesq = mos';

%pesq score
deg = "iy0_false";

% mos(1) = my_pesq_mos(ws_path, 's1', deg + '_1');
% mos(2) = my_pesq_mos(ws_path, 's2', deg + '_2');

for i = 1:M
    mos(i) = my_pesq_mos(ws_path, "s" + i, deg + '_' + i);
end

%save results in struct
results(4).sig = deg;
results(4).sir = sir0_false;
results(4).pesq = mos';

%pesq score
deg = "iyg_true";

% mos(1) = my_pesq_mos(ws_path, 's1', deg + '_1');
% mos(2) = my_pesq_mos(ws_path, 's2', deg + '_2');

for i = 1:M
    mos(i) = my_pesq_mos(ws_path, "s" + i, deg + '_' + i);
end

%save results in struct
results(3).sig = deg;
results(3).sir = sirg;
results(3).pesq = mos';

%pesq score
deg = "iyg_false";

% mos(1) = my_pesq_mos(ws_path, 's1', deg + '_1');
% mos(2) = my_pesq_mos(ws_path, 's2', deg + '_2');

for i = 1:M
    mos(i) = my_pesq_mos(ws_path, "s" + i, deg + '_' + i);
end

%save results in struct
results(6).sig = deg;
results(6).sir = sirg_false;
results(6).pesq = mos';


% Save workspace 
save(ws_path + ws_filename + ".mat");

response_plot_script;
sir_plot_script;
pesq_plot_script;
