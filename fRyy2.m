function [ryy] = fRyy2(W, rxx)
%Estimated cross spectral density of recovered signals
W_rep = permute(reshape(repmat(W, [1 1 size(rxx, 2)]), [size(W) size(rxx, 2)]), [1 4 2 3]);
W_H_rep = permute(conj(W_rep), [1 2 4 3]);

ryy = multiprod(multiprod(W_rep, rxx,[3 4]), W_H_rep, [3 4]);





