% Start of program
clc;
clear;
close all;
% load data from CSVs
load('Propulsion_Test_Day_1.mat')

%% plot raw data
packet_num = [Datalink_Day1_set1; Datalink_Day1_set2; Datalink_Day1_set3; Datalink_Day1_set4];
figure(1)
grid on
hold on
plot(packet_num.PackageNumber, packet_num.OutputCurrent)

%% Get Current
% Initialize Variables
i = 0;
k = 0;
Trial_ID = 0;
save_Current = false;
% Loop
while i < height(packet_num)
    i = i+1;
    % Check if current value is reading
    if(packet_num.OutputCurrent(i) > 0)
        save_Current = true;
        Trial_ID = Trial_ID + 1;
    end
    % read all current values until it cannot
    while(save_Current)
        k = k + 1;
        outputcurrent(k,Trial_ID) = packet_num.OutputCurrent(i);
        i = i + 1;
        % look for end of trial
        if(packet_num.OutputCurrent(i) <= 0)
            save_Current = false;
            k = 0;
        end
    end
end

% Generate Datapoint from each trial
for i = 1:width(outputcurrent)
    trial = nonzeros(outputcurrent(:,i));
    L = length(trial);
    trial(round(L*0.75:end)) = [];
    trial(1:round(L*0.25)) = [];
    Output_Current_points(i) = mean(trial);
end

%specific tuning (remove dud runs, fix duplicates, etc)
Output_Current_points(27) = [];

% Average each throttle % into one point
i = 1;
k = 0;
while i <= 45
    k = k+1;
    Average_current_at_each_throttle(k) = mean(Output_Current_points(i:i+2))
    i = i+3;
end

%% Get Voltage
Voltage = mean(packet_num.Voltage);
%% Get Power
Power = Average_current_at_each_throttle*Voltage;
%% Thrust
Thrust = table2array(LoadCellTest1Thrust(4,2:16));

%% Plotting
figure(2)
grid on 
hold on
scatter(Thrust*453.5928, Power) % convert thrust to lbs --> grams, 
plot(Thrust*453.5928, Power) % Plot a normal line behind the scatter
xlabel('Thrust [g]')
ylabel('Power [W]')
title('Single Motor: Experimental Power vs Thrust')

figure(3)
grid on; hold on;
scatter(Thrust*453.5928*8,Power*8)
plot(Thrust*453.5928*8,Power*8)
xlabel('Total thrust')
ylabel('Total Power')
title('Full System: Experiemental Projected P vs T')

