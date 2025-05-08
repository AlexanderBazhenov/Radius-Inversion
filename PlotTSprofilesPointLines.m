% 2025-05-08
% Plot TS profiles point-lines
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% POINT-LINE PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
plot(R(ShotTimeROIind1), Te(ShotTimeROIind1), '.bs');
plot(R(ShotTimeROIind1), Te(ShotTimeROIind1), '-b');
plot(R(ShotTimeROIind2), Te(ShotTimeROIind2), '.rs');
plot(R(ShotTimeROIind2), Te(ShotTimeROIind2), '-r');
xlim([40 60]);
set(gca, 'fontsize', 14);
xlabel('R, cm');
ylabel('Te, eV');
titlestr = strcat('Te', ' Shot=', ShotROIstr, ' T1=', T1str, ' T2=', T2str);
title(titlestr);
figure_name_out=strcat(titlestr, '.png');
print('-dpng', '-r300', figure_name_out), pwd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% /POINT-LINE PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
