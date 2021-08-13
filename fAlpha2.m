function alpha = fAlpha2(Rxx)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
alpha = 1./sum(sqrt(sum(Rxx.*conj(Rxx), [3 4])), 2).^2;
end

