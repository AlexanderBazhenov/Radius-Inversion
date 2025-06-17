% 2025-06-16
% mode ii = 2
ii = 2
[BtIpIntInd] = find(BtIpInt > xxBtIp(ii) & BtIpInt < xxBtIp(ii+1))

   % IntervalHIST
  RinvGmidOUT = Routmid(BtIpIntInd)
  RinvGradOUT = Routrad(BtIpIntInd)
% Correct RestOUT
indradTHR = find (RinvGradOUT < radTHR)
  RinvGmidOUT = RinvGmidOUT(indradTHR )
  RinvGradOUT = RinvGradOUT(indradTHR )
%
  X = midrad(RinvGmidOUT, RinvGradOUT)
  % W = ?
[mode, mu_array, max_mu, mode_ind, c_array, C, multi]= modeIR4(X)

figure
hold on
retval = ModePlot (mode, mu_array, max_mu, mode_ind, c_array, C, multi)
titlestr = strcat('Interval mode', ' Group number=', num2str(ii))
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd


out = PlotModeInd(mode, mu_array, max_mu, mode_ind, c_array, C)


