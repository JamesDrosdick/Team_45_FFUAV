function [Current_Check, Thrust_Check, TotalDownForce] = Current_thrust_Check(D,B,Payload,NB)
%UNTITLED Summary of this function goes here
%   Combined version of 

%% Current Check
% Motor Total current Draw
mTotal_C = max(D.Current_A(:,2)) * 8;
% battery total continuous discharge assuming parallel
bTotal_C = B.Const_Discharge_A * NB;

% Factor of Safety 3%
FS = 3/100;
FS_C = 1.0 + FS;

Threshold_C = FS_C * mTotal_C;
    if (bTotal_C > Threshold_C)
        Current_Check = true;
    else
        Current_Check = false;
    end

%% Thrust Check
% Unit Conversions
Payload = Payload * 0.453592; % lb - > kg

% Weight Factor of Safety
WeightFS = 1.2;
%Total Down Force
TotalDownForce = 9.81 * WeightFS * ( Payload + (8*D.Weight_g/1000) + B.Weight_kg*NB );
% Max thrust needed from motor estimation
Motor_MaxThrustEst = 2.0 * 9.81 * WeightFS /8 * ( Payload + (8*D.Weight_g/1000) + B.Weight_kg*NB );

% For later - >  When body weight is calculated/estimated
% Motor_MaxThrustEst = 2 / 8  * 9.81 * WeightFS * ( Payload + (8*D.Weight_g/1000) + B.Weight_kg*NB + TOTALBODYWEIGHT )
% TotalDownForce = 9.81 * WeightFS * ( Payload + (8*D.Weight_g/1000) + B.Weight_kg*NB + TOTALBODYWEIGHT )
% Thrust check
    if (Motor_MaxThrustEst > max(D.Thrust_N(:,2)) )
        Thrust_Check = false;
    else
        Thrust_Check = true;
    end
end