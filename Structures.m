%% Structures
clc;
clear;
close all; 

D = James_MotorCombo(9)
B = BatteryInfo(6)
Bdim = Bat_Dimen(B)
S1 = Structure(D,B,1,25)


function S = Structure(D, B, NB, Payload)
    Prop_Dia = D.PropD; 
    Bdim = Bat_Dimen(B)
    Motor_Dia = D.MotorDiam; 
    Motor_Len = D.MotorLen; 
    Motor_Mass = D.Weight_g; 
    R = (Prop_Dia/2)*25.4; 
    L = (R*1.1)/sind(22.5)
    S = plotArm(L,0,R, Motor_Dia, Motor_Len, Motor_Mass, Bdim)
 
    
end 