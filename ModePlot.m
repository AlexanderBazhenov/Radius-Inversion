## Author: user <user@DESKTOP-SLVDEOK>
## Created: 2022-06-21
% 2023-01-25
% add PlotColor
function retval = ModeMedPlot (mode, mu_array, max_mu, mode_ind, c_array, C, multi) %, PlotColor)
Colors_special
figure
h = stairs(C(1:length(C)-1), mu_array,'-b')
set(h, 'color', OxfordBlue)
set(h, 'linewidth', 2)
xmargin = 1
xlim([ floor(min(C))-xmargin ceil(max(C))+xmargin] )
hold on
% 1st last
xx=[C(1) C(1)]
yy=[0 mu_array(1)]
h = plot(xx,yy, "-b")
set(h, 'color', OxfordBlue)
set(h, 'linewidth', 2)
xx=[C(end) C(end)]
yy=[0 mu_array(end)]
h = plot(xx,yy, "-b")
        set(h, 'color', OxfordBlue)
        set(h, 'linewidth', 2)
        xx=[C(end-1) C(end)]
        yy=[mu_array(end) mu_array(end)]
h = plot(xx,yy, '-b')
        set(h, 'color', OxfordBlue)
        set(h, 'linewidth', 2)
ylim([0 max_mu+1])
% PLOT mu_max
% 2022-09-09
% mode index
out = PlotModeInd(mode, mu_array, max_mu, mode_ind, c_array, C)
##for ii=1:length(mode_ind)
##% Horizontal top
##    cnow=c_array(mode_ind(ii));
##        xx=[inf(cnow) sup(cnow)]
##        yy=[mu_array(mode_ind(ii)) mu_array(mode_ind(ii))]
##        h = plot(xx,yy, '-r', "linewidth", 3)
##                          set(h, 'color', RoyalMail)
## %         set(h, 'linewidth', 2)
## % Horizontal y=0
##        xx=[inf(cnow) sup(cnow)]
##        yy=[0 0]
##        h = plot(xx,yy, '-r', "linewidth", 3)
##          set(h, 'color', RoyalMail)
##%          set(h, 'linewidth', 2)
##% Vertical inf
##        xx=[inf(cnow) inf(cnow)]
##        yy=[0 mu_array(mode_ind(ii))]
##        h = plot(xx,yy, ':r', "linewidth", 1)
##                  set(h, 'color', RoyalMail)
##          set(h, 'linewidth', 2)
##% Vertical sup
##        xx=[sup(cnow) sup(cnow)]
##        yy=[0 mu_array(mode_ind(ii)+1)]
##        h = plot(xx,yy, ':r', "linewidth", 1)
##          set(h, 'color', RoyalMail)
##          set(h, 'linewidth', 2)
##% numbers
##        yy = max_mu +0.5
##        xx= mid(cnow)
##        text(xx, yy, num2str(mode_ind(ii)), 'fontsize', 12, 'HorizontalAlignment', 'center')
##end
##yy = max_mu +0.5
##xx= min(inf(mode))-1
##text(xx, yy, 'mode index:', 'fontsize', 14, 'HorizontalAlignment', 'right')
%
title_str='' %strcat('\it ModeFig')
title_str='Interval data regularizated mode';
title(title_str, 'FontSize', 14, 'Fontweight', 'normal')
title('')
set(gca, 'FontSize', 14)
xlabel('\it x');
ylabel('\it \mu_i');
retval = 1;
endfunction
