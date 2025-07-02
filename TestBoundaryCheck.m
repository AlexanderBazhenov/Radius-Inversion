% Test BoundaryCheck.m
% 2025-07-01
% INI
ROI = [1:4 50:55 67:75]
ROI = [1:4 40:45 50:75]
ROI = [1:75]

clear  Yp, ypmid, yprad, yint
% Forecast
for ii = 1:length(tolpos0)
  jj = tolpos0(ii);
  Yp(ii) = infsup(yp(jj,1), yp(jj,2));
end
% Model Interval all data
for ii = 1:length(tolpos0)
    jj = tolpos0(ii);
  ypmid(ii) = (yp(jj,1) + yp(jj,2))/2;
  yprad(ii) = (-yp(jj,1) + yp(jj,2))/2;
end
% Data Interval @ tolpos0
yint = infsup(Rinnmid(tolpos0)-Rinnrad(tolpos0), Rinnmid(tolpos0)+Rinnrad(tolpos0))


%%%%%%%%%%%%%%%%%%%%%%%%%%       BoundaryCheck  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
epstol = 0.01
DifY = []
for ii = 1:length(tolpos0)
   dif1 = abs(inf(yint(ii))-inf(Yp(ii)));
   dif2 = abs(sup(yint(ii))-sup(Yp(ii)));
   dif3 = abs(inf(yint(ii))-sup(Yp(ii)));
   dif4 = abs(sup(yint(ii))-inf(Yp(ii)));
   Dif = [dif1, dif2, dif3, dif4];
   DifY(ii) = min(Dif);
end
[DifYzero, DifYzeroInd] = find(DifY< epstol)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2025-06-28
% Yp \subset yint
BoundWid = []
for ii = 1 :length(DifYzeroInd)
    [outinf, outsup] = wedge(yint(DifYzeroInd(ii)), Yp(DifYzeroInd(ii)));
    BoundWid (ii) = (outsup - outinf) / (sup(Yp(DifYzeroInd(ii))) - inf(Yp(DifYzeroInd(ii))));
    ForecastWid (ii) = (outsup - outinf) ;
end
[ForecastWidMin, ForecastWidMinInd] = min(ForecastWid )
DifYzeroInd(ForecastWidMinInd)

figure
hold on
pcolor = [0.7 0.9 0.7]
h2 =  patch(px,py,pcolor);
  xlim([0.0018 0.0039])
% Plot Pos Neg Data
PlotPosNeg
%
plot(x0(tolpos0(DifYzeroInd)), ypmid(DifYzeroInd), '.r')
errorbar(x0(tolpos0(DifYzeroInd)), ypmid(DifYzeroInd),  yprad(DifYzeroInd),  "~.r")
p5 = plot(x0(tolpos0(DifYzeroInd(ForecastWidMinInd))), ypmid(DifYzeroInd(ForecastWidMinInd)), 'or')
set(p5, 'markersize', 8)
set(p5, 'markerfacecolor', 'r')

lgd12345 = legend([p1 p2 p3  p4 p5], ...
  {'Neg', 'arrmax all', 'Pos',  'argmax pos', 'Min Wid Forecast'})
  set(lgd12345, 'fontsize', 14);

%
titlestr = strcat('Rinv INN vs BtIp All Pos ROI count=', num2str(length(ROI)), ...
' Forecast Min Wid=',num2str(ForecastWidMin))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd



