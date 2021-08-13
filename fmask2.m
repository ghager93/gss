function [msig,mask] = fmask2(s1,s2)
%Binary TF mask for 2 signal STFTs
s1 = squeeze(s1);
s2 = squeeze(s2);

assert(length(s1) == length(s2));
assert(length(s1(1,:)) == length(s2(1,:)));

n1 = abs(s1)./sum(abs(s1),2);
n2 = abs(s2)./sum(abs(s2),2);

% low = 0.1;
low =0;
mask1 = low*ones(size(s1));
mask2 = low*ones(size(s2));

mask1(n1 >= n2) = 1;
mask2(n2 >= n1) = 1;

msig(1,:,:) = s1.*mask1;
msig(2,:,:) = s2.*mask2;

mask(1,:,:) = mask1;
mask(2,:,:) = mask2;

end

