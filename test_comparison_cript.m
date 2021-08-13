M = 2;
N = 8;
realTheta = [0 30];
th_var = [ 10 0.5 ];
[out.iy, out.iy0, ~, ~, ~, ~, out.R, ~] = fGMain(s, fs, M, N, realTheta, th_var, [0 0]);
outG = out;
eps_theta = 2*sqrt(10)*(-20:20)/41;
for i = -20:20
    [out.iy, out.iy0, ~, ~, ~, ~, out.R, ~] = fMain(s, fs, M, N, realTheta, eps_theta(i, :));
    out1(i) = out;
end
    