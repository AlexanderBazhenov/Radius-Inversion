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
p1 = plot (R(ShotTimeROIind1), midT1,".b");
p2 = plot (R(ShotTimeROIind2), midT2, ".r");
 lgd12 = legend([p1 p2 ], ...
  {'before saw', 'after sawtooth'})
%
xx = [Rinvoutinf Rinvoutinf]
yy = [0 750]
plot(xx, yy, ':r')
xx = [Rinvoutsup Rinvoutsup]
yy = [0 550]
plot(xx, yy, ':r')
%
%
xx = [Rinvinninf Rinvinninf]
yy = [0 700]
plot(xx, yy, ':b')
xx = [Rinvinnsup Rinvinnsup]
yy = [0 650]
plot(xx, yy, ':b')
%
xx = [RinvR RinvR]
yy = [0 670]
plot(xx, yy, '-.k')
%
xx = [Rinvoutinf Rinvoutsup]
yy = [0 0]
p1 = plot(xx, yy, '-r')
set(p1, 'linewidth', 2)
%
xx = [Rinvinninf Rinvinnsup]
yy = [10 10]
p2 = plot(xx, yy, '-b')
set(p2, 'linewidth', 2)
%
set(lgd12, 'fontsize', 14);
xlim([40 60]);
set(gca, 'fontsize', 14);
xlabel('R, cm');
ylabel('Te, eV');
titlestr = strcat('Te Rinv', ' Shot=', ShotROIstr, ' T1=', T1str, ' T2=', T2str);
title(titlestr);
figure_name_out=strcat(titlestr, '.png');
print('-dpng', '-r300', figure_name_out), pwd;
%%%%%%%%%%%%%%%%%%%%%%%%%% INTERLVAL PLOT w LINEs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

