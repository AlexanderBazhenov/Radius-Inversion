%%%%%%%%%%%%%%%%     Time marks before-after sawtooth  %%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
plot(Time1Rinv)
plot(Time2Rinv)
ylim([min(Time1Rinv(3:end))*0.95 1.05*max(Time2Rinv(3:end)) ])
xlim([0 length(DATARinv)]);
set(gca, 'fontsize', 14);
xlabel('Shot count, inversion radius file');
ylabel('Time, ms');
titlestr = strcat('Time before-after sawtooth');
title(titlestr);
##figure_name_out=strcat(titlestr, '.png');
##print('-dpng', '-r300', figure_name_out), pwd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

