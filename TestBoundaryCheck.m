% Test BoundaryCheck.m
% 2025-07-01
% INI
ROI = [1:4 50:55 67:75]

clear  Yp, ypmid, yprad, yint
% Forecast
for ii = 1:length(tolpos0)
  Yp(ii) = infsup(yp(ii,1), yp(ii,2));
end
% Model Interval all data
for ii = 1:length(x0)
  ypmid(ii) = (yp(ii,1) + yp(ii,2))/2;
  yprad(ii) = (-yp(ii,1) + yp(ii,2))/2;
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
end
