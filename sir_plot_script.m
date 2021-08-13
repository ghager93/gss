%bar plot of SIR
sir_vec = [results.sir];
sir_mat = zeros(M,2,3);
for i = 1:M
    sir_mat(i,:,:) = reshape(sir_vec(i,:),2,3);
    c = categorical({'1.true angle', '2.false angle'});
    figure
    bar(c,squeeze(sir_mat(i,:,:)));
    title('SIR, dB');
    
    savefig(ws_path + 'sir_plot' + i);
    saveas(gcf, ws_path + 'sir_plot' + i + '.png');
end