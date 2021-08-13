function [r, w, mask_c] = fmask_soft(c, x)
%calculates and applies oracle soft TF mask

%r = real(c./x);
r = abs(c)./abs(x);
w = zeros(size(r));
for i = 1:length(r)
    for j = 1:length(r(1,:))
        if r(i,j) < 0
            w(i,j) = 0;
        else if r(i,j) > 1
            w(i,j) = 1;
        else
            w(i,j) = r(i,j);
        end
    end
end

mask_c = w.*c;
end

