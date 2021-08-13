function [delJC1] = fDelJC1(C1, DM)
%Derivative of constraint 1

delJC1 = zeros(size(DM));
for f = 1:size(DM, 1)
    delJC1(f,:,:) = 2*squeeze(C1(f,:,:))*(squeeze(DM(f,:,:))');
end

delJC1 = delJC1/(2*(size(DM, 3)-1));
end

