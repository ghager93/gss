%bar plot of PESQ
pesq_vec = [results.pesq];
pesq_mat = zeros(M,2,3);
for i = 1:M
    pesq_mat(i,:,:) = reshape(pesq_vec(i,:),2,3);
    c = categorical({'1.true angle', '2.false angle'});
    figure
    bar(c,squeeze(pesq_mat(i,:,:)));
    title('PESQ');
    
    savefig(ws_path + 'pesq_plot' + i);
    saveas(gcf, ws_path + 'pesq_plot' + i + '.png');
end