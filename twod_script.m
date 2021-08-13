Theta2 = [pi/6 0 -pi/18];
Theta3 = [pi/18 0 pi/5];

% Theta3.*180/pi
% Theta2.*180/pi
% a_2d
% b_2d

X = 32;
Y = 64;
x2d = 1:X;
y2d = 1:Y;
hyp = sqrt(2)*sqrt((L-2*eps*y2d).^2+(eps*x2d').^2);
sin2d = (-L+eps*x2d'+2*eps*y2d)./hyp;

twod_D = zeros(F,N,X,Y);

for x = 1:X
    for y = 1:Y
        twod_D(:,:,x,y) = exp(2*pi*1i*l*(sin2d(x,y))/c.*Freq'*(1:N));
    end
end

twod_R = zeros(F,M,X,Y);
for f = 1:F
    for x = 1:X
        for y = 1:Y
            twod_R(f,:,x,y) = squeeze(W(f,:,:))*squeeze(twod_D(f,:,x,y)');
        end
    end
end

