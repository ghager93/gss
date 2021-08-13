function [R] = fR(W, D)
% Frequency/Angle Magnitude response for demixing matrix W

R = multiprod(W,D,[2 3]);

end

