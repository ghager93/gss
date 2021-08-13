function [ryy] = fRyy3(W, rxx)
%Estimated cross spectral density of recovered signals
W_rep = repmat(W, [size(rxx, 2) 1]);
W_H_rep = permute(conj(W_rep), [1 3 2]);

ryy = multiprod(multiprod(W_rep, reshape(rxx, [size(rxx, 1) * size(rxx, 2), size(rxx, [3 4])]), [2 3]), W_H_rep, [2 3]);
ryy = reshape(ryy, [size(rxx, [1 2]) size(W, [2 2])]);





