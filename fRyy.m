function [Ryy] = fRyy(W, Rxx)
%Estimated cross spectral density of recovered signals
F = length(W(:,1,1));
numFrames = length(Rxx(1,:,1,1));
M = length(W(1,:,1));
Ryy = zeros(F, numFrames, M, M);

perm_conj_W = permute(conj(W), [1 3 2]);
for i = 0:numFrames-1
    Ryy(:,i+1,:,:) = multiprod(multiprod(W,squeeze(Rxx(:,i+1,:,:)),[2 3]), perm_conj_W, [2 3]);
end
end

