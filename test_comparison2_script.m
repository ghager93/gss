clear

%initialise parameters
M = 2; %Number of sources
realTheta = [0 30]; %Angle of sources, rad

%source audio file names
src_file1 = "Dev_2ch_3src_Ca_Ce_A_Src1.wav";
src_file2 = "Dev_2ch_3src_Ca_Ce_A_Src2.wav";
src_file3 = "Dev_2ch_3src_Ca_Ce_A_Src3.wav";

[Src1, fs] = audioread(src_file1);
[Src2, ~] = audioread(src_file2);
[Src3, ~] = audioread(src_file3);

slen = 160000; %Length of source signal

%Shorten source signals to proper size
clear s
s(1,:) = Src1(1:slen);
s(2,:) = Src2(1:slen);
%s(3,:) = Src3(1:slen);

%Variance of uncertain DOA
th_var(1) = 16;
th_var(2) = 1;
%th_var(3) = 2;

%Constants
N = 8; %Number of sensors
l = 0.4; %Distance between sensors, m
c = 343; %Speed of signals, m/s

mos_path = "tests\mos\";


%Evaluation sample of source signals
s_eval = s(:,900:99992+899);

audiowrite(char(mos_path + "s1.wav"), s_eval(1,:), fs);
audiowrite(char(mos_path + "s2.wav"), s_eval(2,:), fs);
%audiowrite(char(mos_path + "s3.wav"), s_eval(3,:), fs);

eps_theta(:,1) = (-20:20)*1/41*4*sqrt(th_var(1))+5;
eps_theta(:,2) = zeros(1,41);
%eps_theta(:,3) = zeros(1,13);

for i = 1:41
    [out.iy, out.iy0, ~, ~, out.W, out.W0, out.R, ~] = fMain(s, fs, M, N, realTheta, eps_theta(i,:));
    out1(i) = out;
end
out2 = out1(21);
[out.iy, out.iy0, ~, ~, out.W, out.W0, out.R, ~] = fGMain(s, fs, M, N, realTheta, th_var, eps_theta(21,:));
outg = out;


