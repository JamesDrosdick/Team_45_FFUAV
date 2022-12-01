%% Optimization Script
% housekeeping
clc; clear; close all;
% initialize
Passed_configs = zeros(1,6);
Payload = 25; %lbs
t = 0;
Distance = 16; %distance in miles
% loop
for i = 1:10
    D = James_MotorCombo(i);
    for j = 1:15
        B = BatteryInfo(j);
        for k = 1:3
            % checks
            [CurrentCheck, ThrustCheck, TDF] = Current_thrust_Check(D,B,Payload,k);
            % Tracking 
            if (CurrentCheck == 1 && ThrustCheck == 1)
                % Run the mission sim
                [Mission_Check, BCR, BCRP] = MissionSim(D, B, Distance, TDF);
                if (Mission_Check == 1)
                    t = t+1;
                    Passed_configs(t,:) = [i,j,k, BCR, BCRP, Payload];
                end
            end
        end 
    end
end
%% find best run
format shortG
T = array2table(Passed_configs);
T.Properties.VariableNames(1:6) = {'MP#','B#','# of Bats','BCR mAh','BCRP','Payload lbs'};
disp(T)
% find best run
[BCRP,I] = max(Passed_configs(:,5));
best = Passed_configs(I,:);
best_percent = num2str(BCRP) + "%";
format shortG
fprintf('Best run configuration is [')
fprintf('%g, ',best(1:end-1));
fprintf('%g]\nwith %s Battery Remaining\n', best(end),best_percent)