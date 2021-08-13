function [delJC2] = fDelJC2_2(D, C2)
%Derivative of constraint 2
delJC2 = D.invCondMatrix'.*buildMatrix(D, C2) ...
                                        / (size(D.steeringMatrix, 3)-1);
end

function mat = buildMatrix(D, C2)
    mat = multiprod(C2, conj(permute(D.steeringMatrix, [1 3 2])),[2 3]);
end

