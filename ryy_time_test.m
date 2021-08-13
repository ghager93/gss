F = 1024;
numFrames = 36;
M = 20;
N = 8;

Rxx = randn(F, numFrames, N, N);
W = randn(F, M, N);
alpha = fAlpha2(Rxx);

tic;
Ryy = fRyy(W, Rxx);
toc;

tic;
Ryy2 = fRyy2(W, Rxx);
toc;

tic;
Ryy3 = fRyy3(W, Rxx);
toc;

all(Ryy == Ryy2, 'all')
all(Ryy == Ryy3, 'all')
