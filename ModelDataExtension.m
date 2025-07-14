% 2025-07-14
% Model for Data Extension

x0 = [ 1 2 3 4 5 ]'
X0 = [ x0.^0 x0 ];
%
Y0 = [infsup(-2,2) infsup(-1,3) infsup(-3,1) infsup(-1,3) infsup(-2,2) ]'
Yadd = [ 5 4 3 2 1 ]'
%
[tolmax0,argmax0, env0] = tolsolvty(X0,X0,inf(Y0+Yadd),sup(Y0+Yadd),1);

