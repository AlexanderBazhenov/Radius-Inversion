% 2025-06-23
%%%%%%%%%%%%%%%%%%%%%%%%%%%   INN CORR      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% argmax
##x0 = BtIpInt'
##X0 = [ x0.^0 x0 ];
##[tolmax0,argmax0, env0] = tolsolvty(X0,X0,Rinnmid-Rinnrad,Rinnmid+Rinnrad,1);
%
##for ii=1:length(X0)
##  ytol0(ii) = argmax0(1) + argmax0(2)*X0(ii, 2);
##end
##%
##tolneg0 = find(env0(:,2)<0)
##tolpos0 = find(env0(:,2)>=0)
##eqnumber0 = env0(:,1)
##eqtol0 = env0(:,2)
%
widadd = min(env0(tolpos0,2))
envp = env0(tolpos0,2)
step = 5
widadd = envp(step)

[eqnumber0sort, indeqnumber0sort] = sort(eqnumber0)
eqtol0sort = eqtol0(indeqnumber0sort)

infR0 =    Rinnmid-Rinnrad;
supR0 =    Rinnmid+Rinnrad;
infR = infR0;
supR = supR0;
for ii=1:length(infR)
  tolii = eqtol0sort(ii);
  if tolii < 0
    infR(ii) =  infR0(ii) + tolii - widadd;
    supR(ii) =  supR0(ii) - tolii + widadd ;
  end
end
%
figure
hold on
plot(infR, '-b')
plot(supR, '-r')
plot(infR0, '--b')
plot(supR0, '--r')
%
[tolmax0C,argmax0C, env0C] = tolsolvty(X0,X0,infR,supR,1);
%
for ii=1:length(X0)
  ytol0C(ii) = argmax0C(1) + argmax0C(2)*X0(ii, 2);
end
%

%
figure
hold on
errorbar(BtIpInt, Rinnmid, Rinnmid-infR,"~.b");
p1 = plot(BtIpInt, Rinnmid, 'sb')
p2 = plot(BtIpInt, ytol0C, 'sr')
plot(BtIpInt, ytol0C, '-r')

pcolor = [0.7 0.9 0.7]
lb = [-inf inf];                                # нижние границы beta1 и beta2
irp_steam = ir_problem(X0, Rinnmid, Rinnmid-infR, lb);
%xlimits = [0.0019 0.0056];
% Points to predict
xpfuture = [0.004 0.0045 0.005]'
xp = [x; xpfuture]
Xp = [xp.^0 xp];
%ir_plotmodelset(irp_steam, xlimits)
yp = ir_predict(Xp, irp_steam)
px = [ xp; xp(end:-1:1) ]
py = [ yp(:, 1); yp(end:-1:1, 2) ]
h2 =  patch(px,py,pcolor);

 lgd12 = legend([p1 p2 ], ...
  {'Data INN', 'argmaxtol'})
  set(lgd12, 'fontsize', 14);
    set(lgd12, 'location', 'northeast');
set(gca, 'fontsize', 14)
xlabel('Bt/Ip')
ylabel('Rinv')
grid on
titlestr = strcat('Rinv vs BtIp interval Inn argmax Tolcorr', ' addPosNoStep=', num2str(step))
ht = title(titlestr)
set(ht, 'fontweight', 'normal')
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
%%%%%%%%%%%%%%%%%%%%%%%%%%%   /INN CORR    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
