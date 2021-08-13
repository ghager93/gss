clear

%initialise parameters
M = 2; %Number of sources
realTheta = [-30 30]; %Angle of sources, rad

%source audio file names
src_file1 = "Dev_2ch_3src_Ca_Ce_A_Src1.wav";
src_file2 = "Dev_2ch_3src_Ca_Ce_A_Src2.wav";
src_file3 = "Dev_2ch_3src_Ca_Ce_A_Src3.wav";

[Src1, fs] = audioread(src_file1);
[Src2, ~] = audioread(src_file2);
[Src3, ~] = audioread(src_file3);

slen = 160000; %Length of source signal
xlen = 100000;

%Shorten source signals to proper size
clear s
s(1,:) = Src1(1:slen);
s(2,:) = Src2(1:slen);
%s(3,:) = Src3(1:slen);

%Variance of uncertain DOA
th_var(1) = 16;
th_var(2) = 16;
%th_var(3) = 2;

%Constants
N = 8; %Number of sensors
l = 0.4; %Distance between sensors, m
c = 343; %Speed of signals, m/s

mos_path = "tests\mos\";

win = hamming(512);
hop = 120;
nfft = 512;


%Evaluation sample of source signals
s_eval = s(:,900:99992+899);

audiowrite(char(mos_path + "s1.wav"), s_eval(1,:), fs);
audiowrite(char(mos_path + "s2.wav"), s_eval(2,:), fs);
%audiowrite(char(mos_path + "s3.wav"), s_eval(3,:), fs);

eps_theta(:,1) = (-20:20)*1/41*4*sqrt(th_var(1))+5;
eps_theta(:,2) = 5*ones(1,41);
%eps_theta(:,3) = zeros(1,13);

for i = 1:41
    [out.iy, out.iy0, ~, ~, out.W, out.W0, out.R, ~] = fMain(s, fs, M, N, realTheta, eps_theta(i,:));
    out1(i) = out;
end
out3 = out1(8);

eps_theta(:,2) = (-20:20)*1/41*4*sqrt(th_var(2))+5;
eps_theta(:,1) = 5*ones(1,41);

for i = 1:41
    [out.iy, out.iy0, ~, ~, out.W, out.W0, out.R, ~] = fMain(s, fs, M, N, realTheta, eps_theta(i,:));
    out2(i) = out;
end
out4 = out1(34);
x = fMicsim(s, fs, N, l, realTheta*pi/180, xlen); %output - x

clear sx
clear sx_full
for i = 1:N
[sx_full(i,:, :), fvec, tvec] = HZ_stft(x(i,:), hamming(512), 120, 512, fs);
end

W2_gauss = zeros(size(out1(1).W));
for i = 1:41
W2_gauss = W2_gauss + out2(i).W*(1/sqrt(2*pi*16)*exp(-(4*sqrt(16)*(i-21)/41)^2/16));
end
W_gauss = zeros(size(out1(1).W));
for i = 1:41
W_gauss = W_gauss + out1(i).W*(1/sqrt(2*pi*16)*exp(-(4*sqrt(16)*(i-21)/41)^2/16));
end
D = fD(257, 8, 256, 16000);
R_wgauss = fR(W_gauss, D);
R2_wgauss = fR(W2_gauss, D);

figure
imagesc(abs(squeeze(R_wgauss(:,1,:))));
figure
imagesc(abs(squeeze(R2_wgauss(:,1,:))));
figure
imagesc(abs(squeeze(R_wgauss(:,2,:))));
figure
imagesc(abs(squeeze(R2_wgauss(:,2,:))));

y_gauss = fY(W_gauss, sx_full);
[iy_gauss(1,:), ~] = HZ_istft(y_gauss(:,:,1), win, win, hop, nfft, fs);
[iy_gauss(2,:), ~] = HZ_istft(y_gauss(:,:,2), win, win, hop, nfft, fs);
y2_gauss = fY(W2_gauss, sx_full);
[iy2_gauss(1,:), ~] = HZ_istft(y2_gauss(:,:,1), win, win, hop, nfft, fs);
[iy2_gauss(2,:), ~] = HZ_istft(y2_gauss(:,:,2), win, win, hop, nfft, fs);
