function C2 = fC2_2(W, DM, eye_f)
% Constraint 2: WD-I=0
C2 = multiprod(W, DM, [2 3]) - eye_f;
end

