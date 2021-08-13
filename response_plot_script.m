%Response plot script
%Plot Responses of each source bf, gss and gss_g

%Response to true angle
for i = 1:M
    subplot(M,3,3*(i-1)+1)
    x_plot = abs(squeeze(R0_true(:,i,:)));
    my_spec_plot(x_plot,fs);
    vline(realTheta(i), 'r--');
    for j = 1:M
        if j ~= i
            vline(realTheta(j),'w--');
        end
    end
    subplot(M,3,3*(i-1)+2)
    x_plot = abs(squeeze(R1(:,i,:)));
    my_spec_plot(x_plot,fs);
    vline(realTheta(i), 'r--');
    for j = 1:M
        if j ~= i
            vline(realTheta(j),'w--');
        end
    end
    subplot(M,3,3*(i-1)+3)
    x_plot = abs(squeeze(Rg(:,i,:)));
    my_spec_plot(x_plot,fs);
    vline(realTheta(i), 'r--');
    vline(realTheta(i) + sqrt(th_var(i))*pi/180, 'r:');
    vline(realTheta(i) - sqrt(th_var(i))*pi/180, 'r:');
    for j = 1:M
        if j ~= i
            vline(realTheta(j),'w--');
        end
    end
end

hp4 = get(subplot(M,3,3*M),'Position');
colorbar('Position', [hp4(1)+hp4(3)+0.01  hp4(2)  0.02  hp4(2)+hp4(3)*3.3])

savefig(ws_path + 'response_true')
saveas(gcf, ws_path + 'response_true.png')  

figure
%response to false angle
for i = 1:M
    subplot(M,3,3*(i-1)+1)
    x_plot = abs(squeeze(R0_false(:,i,:)));
    my_spec_plot(x_plot,fs);
    vline(realTheta(i), 'r--');
    vline(Theta(i), 'r.-');
    for j = 1:M
        if j ~= i
            vline(realTheta(j),'w--');
            vline(Theta(j),'w.-');
        end
    end
    subplot(M,3,3*(i-1)+2)
    x_plot = abs(squeeze(R_false(:,i,:)));
    my_spec_plot(x_plot,fs);
    vline(realTheta(i), 'r--');
    vline(Theta(i),'r.-');
    for j = 1:M
        if j ~= i
            vline(realTheta(j),'w--');
            vline(Theta(j),'w.-');
        end
    end
    subplot(M,3,3*(i-1)+3)
    x_plot = abs(squeeze(Rg_false(:,i,:)));
    my_spec_plot(x_plot,fs);
    vline(realTheta(i), 'r--');
    vline(Theta(i), 'r.-');
    vline(realTheta(i) + sqrt(th_var(i))*pi/180, 'r:');
    vline(realTheta(i) - sqrt(th_var(i))*pi/180, 'r:');
    for j = 1:M
        if j ~= i
            vline(realTheta(j),'w--');
            vline(Theta(j),'w.-');
        end
    end
end

hp4 = get(subplot(M,3,3*M),'Position');
colorbar('Position', [hp4(1)+hp4(3)+0.01  hp4(2)  0.02  hp4(2)+hp4(3)*3.3])


savefig(ws_path + 'response_false')
saveas(gcf, ws_path + 'response_false.png')
