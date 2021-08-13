close all
figure
for m = 1:M
    sub = subplot(M,1,m);
    plot(eps_theta(:,ieps), sir0(:,m), eps_theta(:,ieps), sir(:,m), eps_theta(:,ieps), sirg(:,m));
    vline(sqrt(th_var(m)))
    vline(-sqrt(th_var(m)))
    title(sub,"SIR source: " + m)
    xlabel(sub, "Angle (Deg)")
    ylabel(sub, "dB")
end

figure
for m = 1:M
    sub = subplot(M,1,m);
    plot(eps_theta(:,ieps), pesq0(:,m), eps_theta(:,ieps), pesq(:,m), eps_theta(:,ieps), pesqg(:,m));
    vline(sqrt(th_var(m)))
    vline(-sqrt(th_var(m)))
    title(sub,"PESQ source: " + m)
    xlabel(sub, "Angle (Deg)")
    ylabel(sub, "dB")
end

figure
for m = 1:M
    sub = subplot(M,1,m);
    plot(eps_theta(:,ieps), stoi0(:,m), eps_theta(:,ieps), vstoi(:,m), eps_theta(:,ieps), stoig(:,m));
    vline(sqrt(th_var(m)))
    vline(-sqrt(th_var(m)))
    title(sub,"STOI source: " + m)
    xlabel(sub, "Angle (Deg)")
    ylabel(sub, "dB")
end