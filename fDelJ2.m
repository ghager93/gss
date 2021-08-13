function [delJ] = fDelJ2(W, Rxx, alpha)
% Derivative of cost function J(W) with respect to W -> dJ(W)/d(W(omega))
[F,M,N] = size(W);
N_frame = size(Rxx, 2);

Ryy = fRyy(W, Rxx)

delJ = zeros(F,M,N);
for t = 1:N_frame
    delJ = delJ + multiprod(multiprod( ...
        squeeze(E(:,t,:,:)),W,[2 3]), squeeze(Rxx(:,t,:,:)), [2 3]);
    
end

delJ = 4*alpha.*delJ/N_frame;
end

