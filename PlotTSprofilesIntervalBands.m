% 2025-05-08
% Plot TS profiles interval bands
%%%%%%%%%%%%%%%%%%%%%%%%%% INTERLVAL PLOT w LINEs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
p1 = plot(R(ShotTimeROIind1), inf(Tint1), "-b");
p2 = plot(R(ShotTimeROIind1), sup(Tint1), "-b");
p3 = plot(R(ShotTimeROIind2), inf(Tint2), "-r");
p4 = plot(R(ShotTimeROIind2), sup(Tint2), "-r");
errorbar (R(ShotTimeROIind1), midT1, radT1,"~.b");
errorbar (R(ShotTimeROIind2), midT2, radT2,"~.r");
xlim([40 60]);
set(gca, 'fontsize', 14);
xlabel('R, cm');
ylabel('Te, eV');
titlestr = strcat('Te band', ' Shot=', ShotROIstr, ' T1=', T1str, ' T2=', T2str);
title(titlestr);
figure_name_out=strcat(titlestr, '.png');
print('-dpng', '-r300', figure_name_out), pwd;
%%%%%%%%%%%%%%%%%%%%%%%%%% INTERLVAL PLOT w LINEs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

