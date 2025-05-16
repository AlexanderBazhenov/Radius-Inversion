% 2025-05-11
% Rinv interval no figures

% OUTer
Jizero = find(JiT1T2over >= 0);
Rinvoutinf = Rover(min(Jizero));
Rinvoutsup = Rover(max(Jizero));
% INNer
Jizero2 = find(JiT1T2over >= max(JiT1T2over)/2);
Rinvinninf = Rover(min(Jizero2));
Rinvinnsup = Rover(max(Jizero2));
% IR
RinvOUT = infsup(Rinvoutinf, Rinvoutsup);
RinvINN = infsup(Rinvinninf, Rinvinnsup);
