x = zeros(N,xlen);
delay = l/c*sin(realTheta);

for i = 1:N
    idelay = floor(delay*i*fs);
    for j = 1:M
        x(i,:) = x(i,:) + s(j,buffer-idelay(j):buffer-idelay(j)+xlen-1);
    end
end