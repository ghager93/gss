function [D] = fD(F, N, nTheta, fs)
% D(f) is an (N x nTheta) matrix of the sensors steering vectors at
% frequency f
% D(f,n,theta) is the n-th sensors response to signals coming from a DOA of
% theta at frequency f
c = 343;
l = 0.4;
D = zeros(F, N, nTheta);
ThetaD = linspace(-pi/2,pi/2,nTheta);
Freq = linspace(0,fs/2, F);
for n = 1:N
    D(:,n,:) = exp(-2*pi*1i*l*n*Freq'.*sin(ThetaD)/c);
end
end

