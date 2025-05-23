% 2025-05-08
% Plot TS profiles intervals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INTERLVAL PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pkg load interval

midT1 = Te(ShotTimeROIind1);
radT1 = 0.05*midT1;
Tint1 = midrad(midT1, radT1);
midT2 = Te(ShotTimeROIind2);
radT2 = 0.05*midT2;
Tint2 = midrad(midT2, radT2);
%
figure
hold on
p1 = errorbar (R(ShotTimeROIind1), midT1, radT1,"~.b");
p2 = errorbar (R(ShotTimeROIind2), midT2, radT2,"~.r");
p1 = plot (R(ShotTimeROIind1), midT1,".b");
p2 = plot (R(ShotTimeROIind2), midT2, ".r");
 lgd12 = legend([p1 p2 ], ...
  {'before saw', 'after sawtooth'})
set(lgd12, 'fontsize', 14);
xlim([40 60]);
set(gca, 'fontsize', 14);
xlabel('R, cm');
ylabel('Te, eV');
titlestr = strcat('Te int', ' Shot=', ShotROIstr, ' T1=', T1str, ' T2=', T2str);
title(titlestr);
figure_name_out=strcat(titlestr, '.png');
print('-dpng', '-r300', figure_name_out), pwd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% /INTERLVAL PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
