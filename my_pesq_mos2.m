function[mos] = my_pesq_mos2(path, sig, deg, fs)

audiowrite(char(path + "s1.wav"), sig, fs);
audiowrite(char(path + "s2.wav"), deg, fs);

[~, ~] = system('cd ' + path + ' && C:/Users/User/OneDrive/Documents/2018s2/Thesis/Matlab/gss/pesq_win.exe +16000 s1.wav s2.wav');
data = importdata(path + '_pesq_results.txt');
mos = data.data(end, 1);