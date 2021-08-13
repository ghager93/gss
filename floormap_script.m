x2d = 1:X;
y2d = 1:Y;
theta_x = ((X-1)/pi)*(atan((X-x2d-X/2)./(Y-y2d'+1))+pi/2);
theta_y = ((Y-1)/pi)*(atan((Y-y2d'-Y/2)./(X-x2d+1))+pi/2);

floormap = zeros(M,X,Y);
for i = 1:X
    for j = 1:Y
        xcomp = floor(theta_x(i,j))+1;
        ycomp = floor(theta_y(i,j))+1;
        floormap(:,i,j) = sumRsq(:, xcomp, ycomp);
    end
end