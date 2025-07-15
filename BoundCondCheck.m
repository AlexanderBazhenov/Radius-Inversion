## Author: AlexBazhenov <AlexBazhenov@DESKTOP-06TNMPO>
## Created: 2025-07-15
% ydata = yint, Ymod = Y
% Ymod = Y1
function [DifY] = BoundCondCheck (ydata, Ymod)
  DifY = []
for ii = 1:length(ydata)
   dif1 = abs(inf(ydata(ii))-inf(Ymod(ii)));
   dif2 = abs(sup(ydata(ii))-sup(Ymod(ii)));
   dif3 = abs(inf(ydata(ii))-sup(Ymod(ii)));
   dif4 = abs(sup(ydata(ii))-inf(Ymod(ii)));
   Dif = [dif1, dif2, dif3, dif4];
   DifY(ii) = min(Dif);
end
##[DifYzero, DifYzeroInd] = find(DifY< epstol)
endfunction

##%%%%%%%%%%%%%%%%%%%%%%%%%%       BoundaryCheck  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##epstol = 0.01
##DifY = []
##for ii = 1:length(tolpos0)
##   dif1 = abs(inf(yint(ii))-inf(Yp(ii)));
##   dif2 = abs(sup(yint(ii))-sup(Yp(ii)));
##   dif3 = abs(inf(yint(ii))-sup(Yp(ii)));
##   dif4 = abs(sup(yint(ii))-inf(Yp(ii)));
##   Dif = [dif1, dif2, dif3, dif4];
##   DifY(ii) = min(Dif);
##end
##[DifYzero, DifYzeroInd] = find(DifY< epstol)
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
