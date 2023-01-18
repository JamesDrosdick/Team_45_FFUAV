%% Optimization Script
% housekeeping
clc; clear; close all;
% initialize
Passed_configs = cell(1,8);
Payload = 25; %lbs
Chassis = 14.8; % Kg - Aluminum 6061
% Chassis = 13.1; % kg - Carbon tubes, and aluminum
% Chassis = 12.31; % Kg - Carbon Tubes, Hub, alum joint
t = 0;
Distance = 11; %distance in miles
% loop
for i = 5:10
    D = James_MotorCombo(i);
    for j = 6
        B = BatteryInfo(j);
        for k = 1
            % checks
            [CurrentCheck, ThrustCheck, TDF] = Current_thrust_Check(D,B,Payload,k,Chassis);
            % Tracking 
            if (CurrentCheck == 1 && ThrustCheck == 1)
                % Run the mission sim
                [Mission_Check, BCR, BCRP, Mission_Time] = MissionSim(D, B, Distance, TDF);
                if (Mission_Check == 1)
                    t = t+1;
                    PC(t,:) = {D.Motor_Name D.PropD B.Battery_Name k BCR BCRP Mission_Time Payload};
                end
            end
        end 
    end
end
%% find best run
format shortG
T = cell2table(PC);
T.Properties.VariableNames(1:8) = {'Motor','Prop Diameter (in)','Battery','# of Bats','Battery Remaining (mAh)','Battery Remaining (%)','Mission Time (min)','Payload (lbs)'};
disp(T)
% find best run
[BCRP,I] = max(cell2mat(PC(1:end,6)));
best = PC(I,:);
best_percent = num2str(BCRP) + "%";
format shortG
fprintf('Best run configuration is \n[')
fprintf('%s, ',best{1,1})
fprintf('%g, ',best{1,2})
fprintf('%s, ',best{1,3})
for i = 4:5
    fprintf('%g, ',best{1,i})
end
fprintf('%s, ',best_percent)
fprintf('%g, ',best{1,7})
fprintf('%g]\nwith %s Battery Remaining\n', best{1,end},best_percent)

