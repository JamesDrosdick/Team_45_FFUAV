function [thrust_indx, thrust_N] = ThrustGivenF_WIP(D,F)
% Function Description
% Takes in a struct containing info on a motor and prop "D", and a force
% "F" and outputs the throttle required to maintian equilibrium

% Variables
% F = total Down force\
% D = Motor Data

% Constants
numMotors = 8;

req_motor_thrust = F/numMotors;
count = 1; 

while (D.Thrust_N(count, 2) < req_motor_thrust)
    count = count + 1; 
end 
    thrust_indx = count; 
    thrust_N = D.Thrust_N(count,2); 
end