function[mos] = my_pesq_mos(path, sig, deg)
system('cd ' + path + ' && E:/Documents/MATLAB/gss/pesq_win.exe +16000 ' + sig + '.wav ' + deg + '.wav');
data = importdata(path + '_pesq_results.txt');
mos = data.data(end, 1);

