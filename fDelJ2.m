function [delJ] = fDelJ2(W, Rxx, alpha)
% Derivative of cost function J(W) with respect to W -> dJ(W)/d(W(omega))
delJ = 4*alpha.*delmatrix(W, Rxx) / size(Rxx, 2);

end

function mat = delmatrix(W, Rxx)
    [F,M,N] = size(W);
    numFrames = size(Rxx, 2);
    
    Rxx = reshape(Rxx, [F * numFrames N N]);
    mat = squeeze(sum(reshape(matrixmult(W, Rxx), [F numFrames M N]), 2));
end

function mat = matrixmult(W, Rxx)
    [F,M,~] = size(W);
    numFrames = size(Rxx, 2);
    
    E = reshape(fE(fRyy3(W, Rxx)), [F * numFrames M M]);
    mat = multiplyEWbyRxx(multiplyEbyrepW(E, repW(W, size(Rxx, 2))));
end

function mat = multiplyEWbyRxx(EW, Rxx)
    mat = multiprod(EW, Rxx, [2 3]);
end

function mat = multiplyEbyrepW(E, repW)
    mat = multiprod(E, repW, [2 3]);
end

function rW = repW(W, numFrames)
    rW = repmat(W, [numFrames 1]);
end



