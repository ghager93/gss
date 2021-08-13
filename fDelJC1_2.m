function [delJC1] = fDelJC1_2(C1, DM)
%Derivative of constraint 1
delJC1 = 2*multiprod(C1, permute(DM, [1 3 2]), [2 3]) ...
                                / (2*(size(DM, 3) - 1));
end

