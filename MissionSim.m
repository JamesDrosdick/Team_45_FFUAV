function [Check,BCR,BCRP] = MissionSim(D,B,Distance,TDF)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%% Load Battery Capacity  BCR = Battery Capacity Remaining
BCR =  str2double(B.Battery_Cap_mAH);
%% Takeoff ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Load in Constants
F_Height = 100; % meters  --- Cruising Altitude
Takeoff_s = 20 * 1000/3600; % m/s --- Takeoff Speed
Takeoff_As = 3 * 0.092903; % m^2 --- Takeoff Surface Area *Var
P_row = 1.205; % kg/m^2 -- Air density
C_d = 1.2; % Coefficient of Drag *double check* 
% Calc Forces
Takeoff_Drag = 0.5*P_row*(Takeoff_s^2)*C_d*Takeoff_As; 
Takeoff_Est_t = F_Height/Takeoff_s; % in seconds
Takeoff_Total_DF = TDF + Takeoff_Drag;
% Determine Thrust and Current Needed for lift (approximately equilibrium)
[thrust_indx, ~] = ThrustGivenF_WIP(D, Takeoff_Total_DF);
Battery_Cap_Discharge = 0.8; 
Takeoff_Current_Draw = 8*D.Current_A(thrust_indx, 2);
Takeoff_Capacity_Usage_mAh = (Takeoff_Est_t / 3600) * (Takeoff_Current_Draw*1000) / Battery_Cap_Discharge;  
%% calculate battery remaining
BCR = BCR - Takeoff_Capacity_Usage_mAh;

%% Flight * probably needs to be its own function later
%% load constants
Distance = Distance*1609.34;  % miles --> meters
% Note: Cruising_s could be pulled from structures stuct
Cruising_s = 40 * 1000/3600; % m/s --- Cruising Speed

Cruising_As = 2; % ft^2 --- Takeoff Surface Area
Cruising_As = Cruising_As*0.092903; % m^2

P_row = 1.205; % kg/m^2 -- Air density
C_d = 1.2; % Coefficient of Drag *double check* 

Cruising_Drag = 0.5*P_row*(Cruising_s^2)*C_d*Cruising_As  ;
syms Ft t1; 
eqn1 = Ft*cosd(t1) == TDF;
eqn2 = Ft*sind(t1) == Cruising_Drag;
S = solve([eqn1, eqn2], [Ft,t1], "Real",true);
Thrust_Est_Cruise = double(S.Ft(1,1)); 
Angle_Est_Cruise = double(S.t1(1,1));

Cruising_Est_t = (Distance/Cruising_s)/60; % in minutes

[thrust_indx2, ~] = ThrustGivenF_WIP(D, Thrust_Est_Cruise) ;


Flight_Current_Draw = 8*D.Current_A(thrust_indx2, 2);
Flight_Capacity_Usage_mAh = (((Cruising_Est_t/60)*Flight_Current_Draw*1000)/Battery_Cap_Discharge); % mAh
%% calculate battery remaining
BCR = BCR - Flight_Capacity_Usage_mAh;
BCRP = BCR / str2double(B.Battery_Cap_mAH) * 100;
%% Hover --------------------------------------------------------------

%% Landing -------------------------------------------------------------
%% Check that there is Battery remaining
if (BCRP > 10)
    Check = true;
else
    Check = false;
end


end