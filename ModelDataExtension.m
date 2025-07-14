% 2025-07-14
% Model for Data Extension

x0 = [ 1 2 3 4 5 ]'
X0 = [ x0.^0 x0 ];
%
Y0 = [infsup(-2,2) infsup(-1,3) infsup(-3,1) infsup(-1,3) infsup(-2,2) ]'
Yadd = [ 5 4 3 2 1 ]'
Y = Y0+Yadd
%
[tolmax0,argmax0, env0] = tolsolvty(X0,X0,inf(Y),sup(Y),1);
for ii=1:length(X0)
  ytol0(ii) = argmax0(1) + argmax0(2)*X0(ii, 2);
end
%
epsilon = rad(Y)
lb = [-inf inf];                                # нижние границы beta1 и beta2
irp_ModelOut = ir_problem(X0, mid(Y), epsilon, lb);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure
hold on
errorbar(x0,mid(Y), rad(Y),"~.b");
p1 = plot(x0,mid(Y), 'sb')
p2 = plot(x0, ytol0, 'sr')
plot(x0, ytol0, '-r')
 lgd12 = legend([p1 p2 ], ...
  {'Data OUT', 'argmaxtol'})
  set(lgd12, 'fontsize', 14);
    set(lgd12, 'location', 'northeast');
set(gca, 'fontsize', 14)
xlabel('x0')
ylabel('y')
grid on
titlestr = strcat('Model Data interval Out argmax')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
## figure_name_out=strcat(titlestr, '.png')
##print('-dpng', '-r300', figure_name_out), pwd

xpfuture = [0 6]'
xpfuture = []
xp = [x0; xpfuture]
Xp = [xp.^0 xp];
%ir_plotmodelset(irp_steam, xlimits)
yp = ir_predict(Xp, irp_ModelOut)
px = [ xp; xp(end:-1:1) ]
py = [ yp(:, 1); yp(end:-1:1, 2) ]

figure
hold on
pcolor = [0.7 0.9 0.7]
h2 =  patch(px,py,pcolor);
  xlim([0 6])
%
errorbar(x0,mid(Y), rad(Y),"~.b");
p1 = plot(x0,mid(Y), 'sb')
p2 = plot(x0, ytol0, 'sr')
plot(x0, ytol0, '-r')
%
set(gca, 'fontsize', 14)
grid on
titlestr = strcat('Model Data interval Out argmax')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
## figure_name_out=strcat(titlestr, '.png')
##print('-dpng', '-r300', figure_name_out), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y1 = midrad(mid(Y), rad(Y)/2)
[tolmax1,argmax1, env1] = tolsolvty(X0,X0,inf(Y1),sup(Y1),1);

figure
hold on
pcolor = [0.7 0.9 0.7]
h2 =  patch(px,py,pcolor);
  xlim([0 6])
%
errorbar(x0,mid(Y), rad(Y),"~.b");
p1 = plot(x0,mid(Y), 'sb')
p2 = plot(x0, ytol0, '.k')
plot(x0, ytol0, '-r')
errorbar(x0,mid(Y1), rad(Y1),"~.r");
p3 = plot(x0,mid(Y1), 'or')

lgd123 = legend([p1 p2 p3], ...
  {'Data OUT', 'argmaxtol', 'Data INN'})
  set(lgd123, 'fontsize', 14);
    set(lgd123, 'location', 'northeast');

set(gca, 'fontsize', 14)
grid on
titlestr = strcat('Model Data interval Out argmax Inn')
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
## figure_name_out=strcat(titlestr, '.png')
##print('-dpng', '-r300', figure_name_out), pwd
