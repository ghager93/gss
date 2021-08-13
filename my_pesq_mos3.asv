function[mos] = my_pesq_mos3(path, sig, deg, fs)

    
% audiowrite(char(path + "s1.wav"), sig, fs);
audiowrite(char(path + "s2.wav"), deg, fs);

if sig == 1
    [~, ~] = system('cd ' + path + ' && E:/Documents/MATLAB/gss/pesq_win.exe +16000 s11.wav s2.wav');
end
if sig == 2
    [~, ~] = system('cd ' + path + ' && E:/Documents/MATLAB/gss/pesq_win.exe +16000 s12.wav s2.wav');
end
data = importdata(path + '_pesq_results.txt');
mos = data.data(end, 1);