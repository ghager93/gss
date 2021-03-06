mospath = "gssp\tests\mos\";
pesq = zeros(5,10,5,10,2);
pesq0 = zeros(5,10,5,10,2);
pesqg = zeros(5,10,5,10,2);
pesqp = zeros(5,10,5,10,2);
sir = zeros(5,10,5,10,2);
sir0 = zeros(5,10,5,10,2);
sirg = zeros(5,10,5,10,2);
sirp = zeros(5,10,5,10,2);


for i = 1:5
    for j = 1:10
        clear eps_sample
        clear cist
        load("gssp\tests\new3\new\" + "i_" + i + "j_" + j + ".mat");
        ieps_s(i,j,:,:,:) = eps_sample;
        for p = 1:10
            sx_full = squeeze(psx_full(p,:,:,:));
            for k = 1:5
                tic
                w = cist(k,p).w;
                w0 = cist(k,p).w0;
                wg = cist(k,p).wg;
                wp = cist(k,p).wp;
                
                y = fY(w,sx_full);
                y0 = fY(w0,sx_full);
                yg = fY(wg,sx_full);
                yp = fY(wp,sx_full);
                
                [my,~] = fmask2(y(:,:,1),y(:,:,2));
                [myg,~] = fmask2(yg(:,:,1),yg(:,:,2));
                [myp,~] = fmask2(yp(:,:,1),yp(:,:,2));
                
                for m = 1:2 
                    [iy(m,:), ~] = HZ_istft(y(:,:,m), win, win, hop, nfft, fs);
                    [iy0(m,:), ~] = HZ_istft(y0(:,:,m), win, win, hop, nfft, fs);
                    [iyg(m,:), ~] = HZ_istft(yg(:,:,m), win, win, hop, nfft, fs);
                    [iyp(m,:), ~] = HZ_istft(yp(:,:,m), win, win, hop, nfft, fs);
                    [iym(m,:), ~] = HZ_istft(squeeze(my(m,:,:)), win, win, hop, nfft, fs);
                    [iygm(m,:), ~] = HZ_istft(squeeze(myg(m,:,:)), win, win, hop, nfft, fs);
                    [iypm(m,:), ~] = HZ_istft(squeeze(myp(m,:,:)), win, win, hop, nfft, fs); 
                end
                
                [~, sir(i,j,k,p,:), ~] = bss_eval_sources(iy,s_eval);
                [~, sir0(i,j,k,p,:), ~] = bss_eval_sources(iy0,s_eval);
                [~, sirg(i,j,k,p,:), ~] = bss_eval_sources(iyg,s_eval);
                [~, sirp(i,j,k,p,:), ~] = bss_eval_sources(iyp,s_eval);
                [~, sirm(i,j,k,p,:), ~] = bss_eval_sources(iym,s_eval);
                [~, sirgm(i,j,k,p,:), ~] = bss_eval_sources(iygm,s_eval);
                [~, sirpm(i,j,k,p,:), ~] = bss_eval_sources(iypm,s_eval);
                
                pesq(i,j,k,p,1) = my_pesq_mos3(mospath, 1, iy(1,:), fs);
                pesq(i,j,k,p,2) = my_pesq_mos3(mospath, 2, iy(2,:), fs);
                pesq0(i,j,k,p,1) = my_pesq_mos3(mospath, 1, iy0(1,:), fs);
                pesq0(i,j,k,p,2) = my_pesq_mos3(mospath, 2, iy0(2,:), fs);
                pesqg(i,j,k,p,1) = my_pesq_mos3(mospath, 1, iyg(1,:), fs);
                pesqg(i,j,k,p,2) = my_pesq_mos3(mospath, 2, iyg(2,:), fs);
                pesqp(i,j,k,p,1) = my_pesq_mos3(mospath, 1, iyp(1,:), fs);
                pesqp(i,j,k,p,2) = my_pesq_mos3(mospath, 2, iyp(2,:), fs);
                
                
                pesqm(i,j,k,p) = my_pesq_mos3(mospath, 1, iym(1,:), fs);
                pesqgm(i,j,k,p) = my_pesq_mos3(mospath, 1, iygm(1,:), fs);
                pesqpm(i,j,k,p) = my_pesq_mos3(mospath, 1, iypm(1,:), fs);
                
                toc
            end
        end
    end
end