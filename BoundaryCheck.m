% 2025-06-27
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%epstol = 0.1

##for ii = 1:length(tolpos0)
##   [outinf, outsup]  = wedge(yint(ii), Yp(ii) );
##   widwedge(ii) = outsup - outinf;
##end
##figure
##plot(x0(tolpos0), widwedge, 'sk')
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
