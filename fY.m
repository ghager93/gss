function [y] = fY(W, sx_full)
y = permute(multiprod(W,permute(sx_full, [2 1 3]), [2 3]), [1 3 2]);
end

