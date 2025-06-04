## Copyright (C) 2022 aspire
## Author: aspire <aspire@ASPIRE-ПК>
## Created: 2022-01-05

% Test data
% x1 = infsup(1,3), x2=infsup(2, 4)
% x1 = infsup(1,2), x2=infsup(3, 4)
% x1=X0(1), x2=K(1) 
function [outinf, outsup] = wedge (x1, x2)
outinf = max(inf(x1), inf(x2));  
outsup = min(sup(x1), sup(x2)) ;
%retval = [outinf, outsup];
end
