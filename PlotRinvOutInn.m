% 2025-05-11
% PlotRinvOutInn

%%%%%%%%%%%%%%%%%%%%%%% PLOT Rinv inn(er) out(er) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
plot(Rover, JiT1T2over)
%
xx = [min(Rover) max(Rover)]
yy = [0 0]
plot(xx, yy, ':k')
xx = [min(Rover) max(Rover)]
yy = [max(JiT1T2over)/2 max(JiT1T2over)/2]
plot(xx, yy, ':k')
Jizero = find(JiT1T2over >= 0)
Rinvoutinf = Rover(min(Jizero))
Rinvoutsup = Rover(max(Jizero))
xx = [Rinvoutinf Rinvoutinf]
yy = [0 -1]
plot(xx, yy, ':k')
xx = [Rinvoutsup Rinvoutsup]
yy = [0 -1]
plot(xx, yy, ':k')
xx = [Rinvoutinf Rinvoutsup]
yy = [0 0]
p1 = plot(xx, yy, '-r')
set(p1, 'linewidth', 2)
Jizero2 = find(JiT1T2over >= max(JiT1T2over)/2)
Rinvinninf = Rover(min(Jizero2))
Rinvinnsup = Rover(max(Jizero2))
xx = [Rinvinninf Rinvinninf]
yy = [max(JiT1T2over)/2 -1]
plot(xx, yy, ':k')
xx = [Rinvinnsup Rinvinnsup]
yy = [max(JiT1T2over)/2 -1]
plot(xx, yy, ':k')
xx = [Rinvinninf Rinvinnsup]
yy = [max(JiT1T2over)/2 max(JiT1T2over)/2]
p2 = plot(xx, yy, '-r')
set(p2, 'linewidth', 2)
%
set(gca, 'fontsize', 14)
ylabel('Ji (Te1, Te2)')
xlabel('R')
titlestr = strcat('Rinv interval', ' Shot=', ShotROIstr, ' T1=', T1str, ' T2=', T2str)
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
%%%%%%%%%%%%%%%%%%%%%%% PLOT Rinv inn(er) out(er) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% INTERLVAL PLOT w LINEs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
plot(R1sort, inf(Tint1(I1)), '-b')
plot(R2sort, inf(Tint2(I2)), '-r')
plot(R1sort, sup(Tint1(I1)), '-b')
plot(R2sort, sup(Tint2(I2)), '-r')
xx = [Rinvoutinf Rinvoutinf]
yy = [sup(Tint2over(min(Jizero))) 0]
plot(xx, yy, ':k')
xx = [Rinvoutsup Rinvoutsup]
yy = [inf(Tint2over(max(Jizero))) 0]
plot(xx, yy, ':k')
xx = [Rinvoutinf Rinvoutsup]
yy = [0 0]
p1  = plot(xx, yy, '-r')
set(p1, 'linewidth', 2)
##errorbar (R(ShotTimeROIind1), midT1, radT1,"~.b");
##errorbar (R(ShotTimeROIind2), midT2, radT2,"~.r");
xlim([40 60]);
set(gca, 'fontsize', 14);
xlabel('R, cm');
ylabel('Te, eV');
titlestr = strcat('Rinv Te band', ' Shot=', ShotROIstr, ' T1=', T1str, ' T2=', T2str);
title(titlestr);
figure_name_out=strcat(titlestr, '.png');
print('-dpng', '-r300', figure_name_out), pwd;
%%%%%%%%%%%%%%%%%%%%%%%%%% INTERLVAL PLOT w LINEs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



