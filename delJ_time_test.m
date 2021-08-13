F = 1024;
numFrames = 36;
M = 10;
N = 8;

Rxx = randn(F, numFrames, N, N);
W = randn(F, M, N);
alpha = fAlpha2(Rxx);

tic;
Ryy = fRyy3(W, Rxx);
E = fE(Ryy);
delJ = fDelJ(W, E, Rxx, alpha);
toc;

tic;
delJ2 = fDelJ2(W, Rxx, alpha);
toc;
