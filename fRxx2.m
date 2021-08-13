function [rxx] = fRxx2(sx, N_frame)
%Cross spectral density of spatial image x
[N, F, ~] = size(sx);
rxx = zeros(F,N_frame,N,N);
L_frame = floor(size(sx, 3)/N_frame);

psx = permute(sx, [2 1 3]);
for i = 0:N_frame-1
    rxx(:,i+1,:,:) = multiprod(psx(:,:,i*L_frame+1:i*L_frame+L_frame), ...
        permute(conj(psx(:,:,i*L_frame+1:i*L_frame+L_frame)),[1 3 2]),[2 3]);
end
rxx = rxx/L_frame;

end

