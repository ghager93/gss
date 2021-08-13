%clear

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
th_var(1,:) = linspace(0.1,20,20).^2;
th_var(2,:) = linspace(0.1,20,20).^2;
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
% 
% eps_theta(:,2) = (-20:20)*1/10*sqrt(th_var(1));
% eps_theta(:,1) = zeros(1,41);
%eps_theta(:,3) = zeros(1,13);

for i = 1:length(th_var)
    for j = 1:length(th_var)
        eps_theta = [0 0];
        tic
        [out.iy, out.iy0, ~, ~, ~, ~, out.R, ~] = fMain(s, fs, M, N, realTheta, eps_theta);
        disp("gss: " + toc)

        iy(i,j, :, :) = out.iy;
        iy0(i,j, :, :) = out.iy0;

        if ~mod(i-1,10)
            R(i,j,1,:,:) = abs(squeeze(out.R(:,1,:)));
            R(i,j,2,:,:) = abs(squeeze(out.R(:,2,:)));
        end

        % SIR, SDR, SAR, permutation evaluation of recovered signals
        [out.sdr, out.sir, out.sar, ~, ~] = bss_eval_sources(out.iy,s_eval);
        sdr(i,j, :) = out.sdr;
        sir(i,j, :) = out.sir;
        sar(i,j, :) = out.sar;

        audiowrite(char(mos_path + "y1.wav"), out.iy(1,:), fs);
        audiowrite(char(mos_path + "y2.wav"), out.iy(2,:), fs);
        %audiowrite(char(mos_path + "y3.wav"), out.iy(3,:), fs);
        out.mos(1) = my_pesq_mos(mos_path, "s1", "y1"); 
        out.mos(2) = my_pesq_mos(mos_path, "s2", "y2");
        %out.mos(3) = my_pesq_mos(mos_path, "s3", "y3");

        pesq(i,j,:) = out.mos;

        out.stoi(1) = stoi(s_eval(1,:), out.iy(1,:), fs);
        out.stoi(2) = stoi(s_eval(2,:), out.iy(2,:), fs);
        %out.stoi(3) = stoi(s_eval(3,:), out.iy(3,:), fs);

        vstoi(i,j, :) = out.stoi;

        [out.sdr, out.sir, out.sar, ~, ~] = bss_eval_sources(out.iy0,s_eval);
        sdr0(i,j, :) = out.sdr;
        sir0(i,j, :) = out.sir;
        sar0(i,j, :) = out.sar;

        audiowrite(char(mos_path + "y1.wav"), out.iy0(1,:), fs);
        audiowrite(char(mos_path + "y2.wav"), out.iy0(2,:), fs);
        %audiowrite(char(mos_path + "y3.wav"), out.iy0(3,:), fs);
        out.mos(1) = my_pesq_mos(mos_path, "s1", "y1"); 
        out.mos(2) = my_pesq_mos(mos_path, "s2", "y2");
        %out.mos(3) = my_pesq_mos(mos_path, "s3", "y3");

        pesq0(i,j,:) = out.mos;

        out.stoi(1) = stoi(s_eval(1,:), out.iy0(1,:), fs);
        out.stoi(2) = stoi(s_eval(2,:), out.iy0(2,:), fs);
        %out.stoi(3) = stoi(s_eval(3,:), out.iy0(3,:), fs);

        stoi0(i,j, :) = out.stoi;
        tic
        [out.iy, out.iy0, ~, ~, ~, ~, out.R, ~] = fGMain(s, fs, M, N, realTheta, [th_var(1,i) th_var(2,j)], eps_theta);
        disp("gss_g: " + toc)
        iyg(i,j, :, :) = out.iy;

        if ~mod(i-1,10)
            Rg(i,j,1,:,:) = abs(squeeze(out.R(:,1,:)));
            Rg(i,j,2,:,:) = abs(squeeze(out.R(:,2,:)));
        end

        %Evaluation sample of source signals
        %s_eval = s(:,900:length(out.iy(1,:))+899);

        % SIR, SDR, SAR, permutation evaluation of recovered signals
        [out.sdr, out.sir, out.sar, ~, ~] = bss_eval_sources(out.iy,s_eval);
        sdrg(i,j, :) = out.sdr;
        sirg(i,j, :) = out.sir;
        sarg(i,j, :) = out.sar;

        audiowrite(char(mos_path + "y1.wav"), out.iy(1,:), fs);
        audiowrite(char(mos_path + "y2.wav"), out.iy(2,:), fs);
        %audiowrite(char(mos_path + "y3.wav"), out.iy(3,:), fs);
        out.mos(1) = my_pesq_mos(mos_path, "s1", "y1"); 
        out.mos(2) = my_pesq_mos(mos_path, "s2", "y2");
        %out.mos(3) = my_pesq_mos(mos_path, "s3", "y3");

        pesqg(i,j,:) = out.mos;

        out.stoi(1) = stoi(s_eval(1,:), out.iy(1,:), fs);
        out.stoi(2) = stoi(s_eval(2,:), out.iy(2,:), fs);
        %out.stoi(3) = stoi(s_eval(3,:), out.iy(3,:), fs);

        stoig(i,j, :) = out.stoi;
    end
end

save("tests\variance test\M2_eps_0" + char(datetime('now','Format','yyyy-MM-dd''T''HHmmss')));