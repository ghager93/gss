function [masked_s1,masked_s2,masked_s3,mask1,mask2,mask3] = f3mask(s1,s2,s3)
%Binary TF mask for 2 signal STFTs
assert(length(s1) == length(s2));
assert(length(s1(1,:)) == length(s2(1,:)));
mask1 = 0.2*ones(size(s1));
mask2 = 0.2*ones(size(s1));
mask3 = 0.2*ones(size(s1));
for i = 1:length(s1(:,1))
    for j = 1:length(s2(1,:))
        if abs(s1(i,j)) >= abs(s2(i,j)) && abs(s1(i,j)) >= abs(s3(i,j))
            mask1(i,j) = 1;
        end
        if abs(s2(i,j)) >= abs(s1(i,j)) && abs(s2(i,j)) >= abs(s3(i,j))
            mask2(i,j) = 1;
        end
        if abs(s3(i,j)) >= abs(s1(i,j)) && abs(s3(i,j)) >= abs(s2(i,j))
            mask3(i,j) = 1;
    end
end

masked_s1 = s1.*mask1;
masked_s2 = s2.*mask2;
masked_s3 = s3.*mask3;
end

