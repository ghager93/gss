function [E] = fE(Ryy)
%E = Ryy - diag(Ryy)
[F, numFrames, M, ~] = size(Ryy);

E = Ryy;
    for i = 1:M
        E(:,:,i,i) = zeros(F,numFrames);
    end
end

