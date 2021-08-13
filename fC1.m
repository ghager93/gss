function [C1, JC1] = fC1(W,DM)
% Constraint 1: diag(WD)-I=0
F = length(W(1,:,:));
M = length(W(:,1,:));
C1 = zeros(F,M,M);
JC1 = zeros(F,1);

for f = 1:F
    C1(f,:,:) = diag(squeeze(W(f,:,:))*squeeze(DM(f,:,:))).*eye(M) - eye(M);
    JC1(f) = norm(squeeze(C1(f,:,:)),'fro')^2;
end
end

