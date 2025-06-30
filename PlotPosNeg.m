% 2025-06-30
% PlotPosNeg
p1 = plot(x0(tolneg0),  Rinnmid(tolneg0), 'ok')
errorbar(x0(tolneg0),  Rinnmid(tolneg0),  Rinnrad(tolneg0),"~.k")
p2 = plot(x0, ytol0, '--k')
%p1 = plot(eqnumber0, eqtol0,'sk')
p3 = plot(x0(tolpos0),  Rinnmid(tolpos0),'sb')
%p2 = plot(x0(tolneg0), Rinnmid(tolneg0),'sr')
errorbar(x0(tolpos0),  Rinnmid(tolpos0),  Rinnrad(tolpos0),"~.b")
%errorbar(x0(tolneg0), Rinnmid(tolneg0), Rinnrad(tolneg0), "~.r")
p4 = plot(x0(tolpos0), ytolmaxpos, '--b')
 lgd1234 = legend([p1 p2 p3  p4], ...
  {'Neg', 'arrmax all', 'Pos',  'argmax pos'})
  set(lgd1234, 'fontsize', 14);
 %   set(lgd12, 'location', 'northwest');
set(gca, 'fontsize', 14)
ylabel('Rinv')
xlabel('BtIp')
##xlim([xxBtIp(1) xxBtIp(end)])
grid on
