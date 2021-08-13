function my_spec_plot(x, fs)
%spectrogram plot 

th = linspace(-pi/2,pi/2,length(x(1,:)));
f = linspace(0,fs/2,length(x(:,1)));
s = surf(th,f,abs(x));
view(0,90);
axis tight;
s.EdgeColor = 'none';