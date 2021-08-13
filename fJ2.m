function J = fJ2(Ryy, alpha)
    J = sum(alpha.*squeeze(sum(abs(fE(Ryy)).^2, [2, 3, 4])));
end