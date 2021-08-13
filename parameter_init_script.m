
slen = 100000; %Length of entire signal
fs = 8e3; %Sampling frequency, Hz

M = 2; %Number of sources
Theta = [0 pi/6]; %Angle of sources, rad

N = 8; %Number of sensors
l = 0.4; %Distance between sensors, m
c = 343; %Speed of signals, m/s

win = hamming(1024); %STFT analysis/synthesis window
hop = 120; %STFT hop size
nfft = 1024; %STFT number of FFT points

N_frame = 18; %Number of frames used for each estimate of Rxx
rxx_window_length; %Rxx estimate wndow length


