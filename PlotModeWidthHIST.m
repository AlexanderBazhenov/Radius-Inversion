% 2025-06-02
 [mode, mu_array, max_mu, mode_ind, c_array, C, multi]= modeIR5(X)

wid_c_array = wid(c_array)

figure
hist(wid_c_array, 20)
set(gca, 'fontsize', 14)
ylabel('Number')
xlabel('Width')
titlestr = strcat('Width interval mode', ' Group number=', num2str(ii))
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

figure
hold on
retval = ModePlot (mode, mu_array, max_mu, mode_ind, c_array, C, multi)
titlestr = strcat('Interval mode', ' Group number=', num2str(ii))
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd


out = PlotModeInd(mode, mu_array, max_mu, mode_ind, c_array, C)

