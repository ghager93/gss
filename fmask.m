function [masked_s1,masked_s2,mask1,mask2] = fmask(s1,s2)
%Binary TF mask for 2 signal STFTs
assert(length(s1) == length(s2));
assert(length(s1(1,:)) == length(s2(1,:)));
mask1 = zeros(size(s1));
mask2 = zeros(size(s1));

low = 0.1;
for i = 1:length(s1(:,1))
    for j = 1:length(s2(1,:))
        if abs(s1(i,j)) >= abs(s2(i,j))
            mask1(i,j) = 1;
            mask2(i,j) = low;
        end
        if abs(s1(i,j)) < abs(s2(i,j))
            mask1(i,j) = low;
            mask2(i,j) = 1;
        end
    end
end

masked_s1 = s1.*mask1;
masked_s2 = s2.*mask2;
end

