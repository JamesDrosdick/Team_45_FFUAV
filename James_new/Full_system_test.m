% Start of program
% load data from CSVs
clear; clc; close all;

load('Full_System_Test.mat')
trial.Set1 = Fullset1;
trial.Set2 = Fullset2;
trial.Set3 = Fullset3;
trial.Set4 = Fullset4;
trial.Set5 = Fullset5;
%% plot raw data
for j = 1
    figure(j)
    hold on
    grid on
    for k = 1:8
        if k == 1
            char_i = '';
        else
            char_i = num2str(k-1);
        end

        plot(trial.(['Set',num2str(j)]).(['PackageNumber',char_i]), trial.(['Set',num2str(j)]).(['InputCurrent',char_i]))
    end
end
title("Full System Raw ESC Currents")
xlabel("Packet Number")
ylabel("Current (Amps)")

% Initialize Variables
k = 0;
k = 0;
Trial_ID = 0;
save = false;
% Loop
for k = 1:8 % K is ESC index
    if k == 1
        char_k = '';
    else
        char_k = num2str(k-1);
    end
    save = false;
    Trial_ID = 0;
    j = 0;
    while j < height(Fullset1)
        j = j + 1;
        % Check if current value is reading
        if(Fullset1.(['InputCurrent',char_k])(j) > 0)
            save = true;
            Trial_ID = Trial_ID + 1;
        end
        % read all current values until it cannot
        while(save)
            j = j + 1;
            Current.(['ESC',char_k])(j,Trial_ID) = Fullset1.(['InputCurrent',char_k])(j);
            Voltage.(['ESC',char_k])(j,Trial_ID) = Fullset1.(['Voltage',char_k])(j);
            outputPower.(['ESC',char_k])(j,Trial_ID) = Current(k,j,Trial_ID) * Voltage(k,j,Trial_ID);
            RPM.(['ESC',char_k])(j,Trial_ID) = Fullset1.(['RPM',char_k])(j);
            % look for end of trial
            if(Fullset1.(['InputCurrent',char_k])(j) <= 0)
                save = false;
                j = 0;
            end
        end
    end
end

% % POWER: Generate Datapoint from each trial
% for k = 1:width(outputPower)
%     trial = nonzeros(outputPower(:,k));
%     L = length(trial);
%     trial(round(L*0.75):end) = [];
%     trial(1:round(L*0.25)) = [];
%     Output_Power_points(k) = mean(trial);
%  end
% % RPM: Generate Datapoint from each trial
% for k = 1:width(RPM)
%     trial = nonzeros(RPM(:,k));
%     L = length(trial);
%     trial(round(L*0.75):end) = [];
%     trial(1:round(L*0.25)) = [];
%     RPM_points(k) = mean(trial);
% end
% 
% %specific tuning (remove dud runs, fix duplicates, etc)
%  Output_Power_points([18,35,45]) = []; 
%  RPM_points([18,35,45]) = [];
% % Average each throttle % into one point
% k = 1;
% k = 0;
% while k <= length(Output_Power_points)
%     k = k+1;
%     Average_power_at_each_throttle(k) = mean(Output_Power_points(k:k+2));
%     Average_RPM_at_each_throttle(k) = mean(RPM_points(k:k+2));
%     k = k+3;
% end
% 
% %% Thrust
% Thrust = table2array(TestDay3thrust(:,4));
% 
% % Throttle Percentage
% for k = 1:length(Thrust)
%     throttle_percent(k) = 30 + (k-1)*5;
% end
% throttle_percent = flip(throttle_percent);
% 
% % Plotting
% figure(2)
% plot(Thrust*453.5928, Average_power_at_each_throttle,'b--o') % convert thrust to lbs --> grams, 
% grid on 
% hold on
% xlabel('Thrust [g]')
% ylabel('Power [W]')
% title('Single Motor: Experimental Power vs Thrust')
% 
% figure(3)
% plot(Thrust*453.5928*8,Average_power_at_each_throttle*8,'b--o')
% grid on
% hold on
% xlabel('Total thrust [g]')
% ylabel('Total Power [watts]')
% title('Full System: Experiementally Projected P vs T')
% 
% figure(4)
% plot(throttle_percent,Average_RPM_at_each_throttle,'b--o')
% grid on
% hold on
% xlabel('Throttle [%]')
% ylabel('RPM')
% title('Throttle % to RPM')