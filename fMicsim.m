function [x] = fMicsim(s, fs, N, l, realTheta, xlen)
%Simulates microphone signals
c = 343;
buffer = 1000;
x = zeros(N,xlen);
delay = l/c*sin(realTheta);
M = length(s(:,1));

for i = 1:N
    idelay = floor(delay*i*fs);
    for j = 1:M
        x(i,:) = x(i,:) + s(j,buffer-idelay(j):buffer-idelay(j)+xlen-1);
    end
end
end

