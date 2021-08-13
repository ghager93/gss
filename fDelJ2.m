function [delJ] = fDelJ2(W, Rxx, alpha)
% Derivative of cost function J(W) with respect to W -> dJ(W)/d(W(omega))
[F,M,N] = size(W);
numFrames = size(Rxx, 2);

Ryy = fRyy(W, Rxx);
E = fE(Ryy);

E = reshape(E, [F * numFrames M M]);
Rxx = reshape(Rxx, [F * numFrames N N]);

W_rep = repmat(W, [numFrames 1]);

delJ = squeeze(sum(reshape(multiprod(multiprod(E, W_rep, [2 3]), Rxx, [2 3]), [F numFrames M N]), 2));

delJ = 4*alpha.*delJ/numFrames;
end

