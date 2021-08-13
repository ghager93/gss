function [J] = fJ(E, alpha)
%Main cost function
normryy = squeeze(sum(sum(sum(abs(E).^2,2),3),4));
J = alpha.*normryy;
end

function [E] = fE(ryy)
%E = Ryy - diag(Ryy)
[F, N_frame, M, ~] = size(ryy);

E = ryy;
    for i = 1:M
        E(:,:,i,i) = zeros(F,N_frame);
    end
end


