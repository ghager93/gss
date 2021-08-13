function [delJC1] = fDelJC1(C1, DM)
%Derivative of constraint 1
F = length(DM(1,:,:));
M = length(DM(:,1,:));
N = length(DM(:,:,1));

delJC1 = zeros(F,M,N);

for f = 1:F
    delJC1(f,:,:) = 2*squeeze(C1(f,:,:))*(squeeze(DM(f,:,:))');
end

delJC1 = delJC1/(2*(N-1));
end

