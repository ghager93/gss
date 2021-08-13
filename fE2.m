function E = fE2(Ryy)
    [F, numFrames, M, ~] = size(Ryy);
    idx = permute(reshape(repmat(eye(M, 'logical'), [1 F*numFrames]), [M M F numFrames]), [3 4 1 2]);
    E = Ryy;
    E(idx) = 0;
end