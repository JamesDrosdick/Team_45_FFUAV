% Start of program
% load data from CSVs
clear; clc; close all;

load('Propulsion_Test_Day_1.mat')

%% plot raw data - Test Day 1
packet_num = [Datalink_Day1_set1; Datalink_Day1_set2; Datalink_Day1_set3; Datalink_Day1_set4];
% Plotting
figure(1)
plot(packet_num.PackageNumber, packet_num.OutputCurrent)
grid on
title('Day 1: raw output current')

% Initialize Variables
i = 0;
k = 0;
Trial_ID = 0;
save = false;
% Loop
while i < height(packet_num)
    i = i+1;
    % Check if current value is reading
    if(packet_num.OutputCurrent(i) > 0)
        save = true;
        Trial_ID = Trial_ID + 1;
    end
    % read all current values until it cannot
    while(save)
        k = k + 1;
        OutputCurrent(k,Trial_ID) = packet_num.OutputCurrent(i);
        outputVoltage(k,Trial_ID) = packet_num.Voltage(i);
        outputPower(k,Trial_ID) = OutputCurrent(k,Trial_ID)* outputVoltage(k,Trial_ID);
        RPM(k,Trial_ID) = packet_num.RPM(i);
        i = i + 1;
        % look for end of trial
        if(packet_num.OutputCurrent(i) <= 0)
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
Output_Power_points(27) = [];  % remove trial 27 as it was a dud trial
RPM_points(27) = [];
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
Thrust = table2array(LoadCellTest1Thrust(4,2:16));

% Throttle Percentage
for i = 1:length(Thrust)
    throttle_percent(i) = 30 + (i-1)*5;
end

% Plotting
figure(3)
plot(Thrust*453.5928, Average_power_at_each_throttle,'b--o') % convert thrust to lbs --> grams, 
grid on 
hold on
xlabel('Thrust [g]')
ylabel('Power [W]')
title('Single Motor: Experimental Power vs Thrust')

figure(4)
plot(Thrust*453.5928*8,Average_power_at_each_throttle*8,'b--o')
grid on
hold on
xlabel('Total thrust [g]')
ylabel('Total Power [watts]')
title('Full System: Experiementally Projected P vs T')

figure(5)
plot(throttle_percent,Average_RPM_at_each_throttle,'b--o')
grid on
hold on
xlabel('Throttle [%]')
ylabel('RPM')
title('Throttle % to RPM')


%% Propulsion Test Day #2: Full Batteries
% load data from CSVs
clear;
load('Test_Day_2.mat')

%% plot raw data - Test Day 2
packet_num = [Data1; Data2; Data3; Data4];
figure(6)
plot(packet_num.PackageNumber, packet_num.RPM)
grid on
title('Full Battery: raw output current Full Battery')

% Initialize Variables
i = 0;
k = 0;
j = 0;
Trial_ID = 0;
save = false;
% Loop
while i < height(packet_num)
    i = i+1;
    % Check if current value is reading
    if(packet_num.InputCurrent(i) > 0)
        save = true;
        Trial_ID = Trial_ID + 1;
    end
    % read all current values until it cannot
    while(save)
        k = k + 1;
        InputCurrent(k,Trial_ID) = packet_num.InputCurrent(i);
        outputVoltage(k,Trial_ID) = packet_num.Voltage(i);
        outputPower(k,Trial_ID) = InputCurrent(k,Trial_ID)*outputVoltage(k,Trial_ID);
        RPM(k,Trial_ID) = packet_num.RPM(i);
        i = i + 1;
        % look for end of trial
        if(packet_num.InputCurrent(i) <= 0)
            save = false;
            k = 0;
        end
    end
end
% POWER: Generate Datapoint from each trial
for i = 1:width(outputPower)
    trial = nonzeros(outputPower(:,i));
    L = length(trial);
    trial(round(L*0.75:end)) = [];
    trial(1:round(L*0.25)) = [];
    Output_Power_points(i) = mean(trial);
end
% RPM: Generate Datapoint from each trial
for i = 1:width(RPM)
    trial = nonzeros(RPM(:,i));
    L = length(trial);
    trial(round(L*0.75:end)) = [];
    trial(1:round(L*0.25)) = [];
    RPM_points(i) = mean(trial);
end
% manual Tuning - Removing Outliers/Dud Runs
Output_Power_points(:,[1,2,9,15,22,23,34]) = [];
RPM_points(:,[1,2,9,15,22,23,34]) = [];

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
Thrust = table2array(Avg_Load);
% Throttle Percentage
for i = 1:length(Thrust)
    throttle_percent(i) = 40 + (i-1)*5;
end
Average_RPM_at_each_throttle = flip(Average_RPM_at_each_throttle);
Average_power_at_each_throttle = flip(Average_power_at_each_throttle);
Thrust = flip(Thrust);

% Plotting
figure(3)
plot(Thrust*453.5928, Average_power_at_each_throttle,'r--o') % convert thrust to lbs --> grams, 
legend('Low Battery','Full Battery','Location','northwest')
figure(4)
plot(Thrust*453.5928*8,Average_power_at_each_throttle*8,'r--o')
legend('Low Battery','Full Battery','Location','northwest')
figure(5)
plot(throttle_percent,Average_RPM_at_each_throttle,'r--o')
legend('Low Battery','Full Battery','Location','northwest')
