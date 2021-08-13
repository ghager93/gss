ka = linspace(0,2,256);
wfl = sqrt((1-2*ka).^2-exp(-4*ka));

figure;
subplot(2,1,1);
title('Re(\omega/\omega_{edge})')
xlabel('ka')
ylabel('Re(\omega/\omega_{edge})')
plot(ka,real(wfl))

subplot(2,1,2);
title('Im(\omega/\omega_{edge})')
xlabel('ka')
ylabel('Im(\omega/\omega_{edge})')
plot(ka,imag(wfl))
