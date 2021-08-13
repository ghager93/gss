function [alpha] = fAlpha(rxx)
% J(W) normaliser
[F, N_frame, ~, ~] = size(rxx);
alpha = zeros(F,1);

for f = 1:F
    for t = 1:N_frame
        alpha(f) = alpha(f) + norm(squeeze(rxx(f,t,:,:)),'fro');
    end
end
alpha = 1./alpha.^2;
end

