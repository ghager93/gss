test_eps_script_M2
%test_eps_script_M3

clear
th_var(1) = 1;
th_var(2) = 5;
test_scatter_script
save("tests\scatter test\var_1_5_" + char(datetime('now','Format','yyyy-MM-dd''T''HHmmss')));
clear
th_var(1) = 2;
th_var(2) = 2;
th_var(3) = 2;
test_scatter3_script
save("tests\scatter test\M3_var2_" + char(datetime('now','Format','yyyy-MM-dd''T''HHmmss')));