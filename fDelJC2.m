function [delJC2] = fDelJC2(C2, DM, condDM_inv)
%Derivative of constraint 2
delJC2 = condDM_inv'.*multiprod(C2, conj(permute(DM, [1 3 2])),[2 3]) ...
                                / (size(DM, 3)-1);
end

