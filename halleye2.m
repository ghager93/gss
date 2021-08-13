h(1) = 1;

for i = 1:10
    f(i) = vpa((1-2*h(i))^2-exp(-4*h(i)));
    fh(i) = vpa(-4*(1-2*h(i))+4*exp(-4*h(i)));
    fhh(i) = vpa(8-16*exp(-4*h(i)));
    h(i+1) = vpa(h(i) - (2*f(i)*fh(i))/(2*fh(i)*fh(i)-f(i)*fhh(i)));
end