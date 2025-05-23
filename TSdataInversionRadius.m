% 2025-05-08
% TS data inversion radius

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DATA = csvread("normalised_export.csv");
##shotn,time,R-R_lcfs,T_e/<Te>,n_e/<ne>,I_p,B_T,Volume,W_e,l42,<n>l,elong,before sawtooth #,Upl*Ipl,NBI1,NBI2,<Te>,<ne>,R
##№,ms,mm,1,1,kA,T,m^3,kJ,cm,10^19 m^-3,1,№,kW,kW,kW,eV,10^19 m^-3,cm

Shot = DATA (:, 1);
Rlcfs = DATA (:, 3);
Tenorm = DATA (:, 4);
nenorm = DATA (:, 5);
BeforeSaw = DATA (:, 13);

% 2025-04-28
% DATARinv = csvread("inversion radius.csv");
##"shotn,",ts_time 1,delay 1,amp1,period,ts_time 2,delay 2,amp,period,R_inv
##,,,,,,,,ms,
##43043,164.2,-0.1505,0.132153,2.943,167.3,0.1655,0.119628,2.714,493.438877755511
% "normalised_export.csv"
##43043,164.23,-10.903,2.799,2.11,219,0.824,0.556,1.273,61.39,2.011,1.508,5,308.28,0,1076.24,259.28,2.23,49
##43043,167.26,-10.851,2.165,1.896,219,0.824,0.553,1.391,61.03,1.939,1.504,7,273.33,0,1076.24,328.55,2.31,49
ShotRinv = DATARinv (:, 1);
Time1Rinv = DATARinv (:, 2);
Time2Rinv = DATARinv (:, 6);
RinvPoint = DATARinv (:, 10);
%


##2.799 *308.28 = 863
##2.165 * 328.55 = 711

time =  DATA (:, 2);
Temean = DATA (:, 17);
R = DATA (:, 19);
for ii = 1:length(DATA)
Te(ii)=  Tenorm (ii)* Temean(ii);
end


% 2025-04-30
Bt = DATA (:, 7);
Ip = DATA (:, 6);
for ii = 1:length(DATA)
  BtIp(ii)=  Bt (ii) / Ip(ii);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% /DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

