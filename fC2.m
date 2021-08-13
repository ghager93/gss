function [C2, JC2] = fC2(W, DM, eye_f)
% Constraint 2: WD-I=0
F = length(W(:,1,1));
JC2 = zeros(F,1);
C2 = multiprod(W,DM, [2 3]) - eye_f;

for f = 1:F
    JC2(f) = norm(squeeze(C2(f,:,:)),'fro');
end
JC2 = JC2.^2;


end

