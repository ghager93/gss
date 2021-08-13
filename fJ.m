function [J] = fJ(E, alpha)
%Main cost function
normryy = squeeze(sum(sum(sum(abs(E).^2,2),3),4));
J = alpha.*normryy;
end

