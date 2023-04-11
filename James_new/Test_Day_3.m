% Start of program
% load data from CSVs
clear; clc; close all;

load('Test_Day_3.mat')

%% plot raw data
packets = [FullBat2Set1; FullBat2Set2; FullBat2Set3; FullBat2Set4];
% Plotting
figure(1)
plot(packets.PackageNumber, packets.OutputCurrent)
grid on
title('Day 3: raw output current')

% Initialize Variables
i = 0;
k = 0;
Trial_ID = 0;
save = false;
% Loop
while i < height(packets)
    i = i+1;
    % Check if current value is reading
    if(packets.InputCurrent(i) > 0)
        save = true;
        Trial_ID = Trial_ID + 1;
    end
    % read all current values until it cannot
    while(save)
        k = k + 1;
        Current(k,Trial_ID) = packets.InputCurrent(i);
        Voltage(k,Trial_ID) = packets.Voltage(i);
        outputPower(k,Trial_ID) = Current(k,Trial_ID)* Voltage(k,Trial_ID);
        RPM(k,Trial_ID) = packets.RPM(i);
        i = i + 1;
        % look for end of trial
        if(packets.InputCurrent(i) <= 0)
            save = false;
            k = 0;
        end
    end
end

% POWER: Generate Datapoint from each trial
for i = 1:width(outputPower)
    trial = nonzeros(outputPower(:,i));
    L = length(trial);
    trial(round(L*0.75):end) = [];
    trial(1:round(L*0.25)) = [];
    Output_Power_points(i) = mean(trial);
 end
% RPM: Generate Datapoint from each trial
for i = 1:width(RPM)
    trial = nonzeros(RPM(:,i));
    L = length(trial);
    trial(round(L*0.75):end) = [];
    trial(1:round(L*0.25)) = [];
    RPM_points(i) = mean(trial);
end

%specific tuning (remove dud runs, fix duplicates, etc)
 Output_Power_points([18,35,45]) = []; 
 RPM_points([18,35,45]) = [];
% Average each throttle % into one point
i = 1;
k = 0;
while i <= length(Output_Power_points)
    k = k+1;
    Average_power_at_each_throttle(k) = mean(Output_Power_points(i:i+2));
    Average_RPM_at_each_throttle(k) = mean(RPM_points(i:i+2));
    i = i+3;
end

%% Thrust
Thrust = table2array(TestDay3thrust(:,4));

% Throttle Percentage
for i = 1:length(Thrust)
    throttle_percent(i) = 30 + (i-1)*5;
end
throttle_percent = flip(throttle_percent);

% Plotting
figure(2)
plot(Thrust*453.5928, Average_power_at_each_throttle,'b--o') % convert thrust to lbs --> grams, 
grid on 
hold on
xlabel('Thrust [g]')
ylabel('Power [W]')
title('Single Motor: Experimental Power vs Thrust')

figure(3)
plot(Thrust*453.5928*8,Average_power_at_each_throttle*8,'b--o')
grid on
hold on
xlabel('Total thrust [g]')
ylabel('Total Power [watts]')
title('Full System: Experiementally Projected P vs T')

figure(4)
plot(throttle_percent,Average_RPM_at_each_throttle,'b--o')
grid on
hold on
xlabel('Throttle [%]')
ylabel('RPM')
title('Throttle % to RPM')

