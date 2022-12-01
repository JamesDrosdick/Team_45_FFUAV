%% Optimization Script
%% housekeeping
clc; clear; close all;
%% Declarations
Passed_configs = zeros(1,6);
best = [];
Payload = 35; %lbs
Distance = 12; %distance in miles
t = 0;
% loop
Payload = Payload - 1;
while(1)
    [oldBRP,I] = max(Passed_configs(:,5));
    oldbest = Passed_configs(I,:);
    %iterate and reset
    Payload = Payload + 1;
    t = 0;
    Passed_configs = zeros(1,6);
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
                        [Mission_Check, Bat_Remainder] = MissionSim(D, B, Payload, Distance, TDF);
                        if (Mission_Check == 1)
                            t = t+1;
                            Bat_Remainder_percent = (Bat_Remainder/str2double(B.Battery_Cap_mAH)*100);
                            Passed_configs(t,:) = [i,j,k, Bat_Remainder, Bat_Remainder_percent, Payload];
                        end
                    end
                end 
            end
        end
    %% find best run from configs that pass
    [newBRP,I] = max(Passed_configs(:,5));
    newbest = Passed_configs(I,:);
    if (newBRP < 10)
        BRP = oldBRP;
        best = oldbest;
        break;
    else
        BRP = newBRP;
        best = newbest;
    end
end
%% Presentation
best_percent = num2str(BRP) + "%";
format shortG
fprintf('Best run configuration is [')
fprintf('%g, ',best(1:end-1));
fprintf('%g]\nwith %s Battery Remaining\n', best(end),best_percent)