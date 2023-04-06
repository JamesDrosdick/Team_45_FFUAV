% Start of program
clc;
clear;
close all;
% load data from CSVs
load('DataLink_Data_Test1.mat')
load('Load Cell Test 1- Thrust.mat')

% Start of processing
Time = PercentDataTestDay1.PackageNumber.0.05 
AvgLoad = LoadCellTest1Thrust(4,:)
AvgLoad = table2array(AvgLoad)
Voltage = 46; 
AvgCurrent = [4, 5, 7, 9, 11, 14, 16.5, 19.3, 23.7, 27, 33, 37, 43, 42.8, 42.7]
Power = Voltage.AvgCurrent
AvgLoad(1) = []
grid on 
scatter(AvgLoad453.5928, Power*8) % convert thrust to grams, 
xlabel('Thrust [g]')
ylabel('Power [W]')
title('Power vs Thrust Experimental')




%OutputC = PercentDataTestDay1.OutputCurrent
%OutputC = rmoutliers(OutputC, "movmean",10) 



%plot(Time, OutputC)

% for i = 1:1:length(Time)
%
% end
% Voltage = PercentDataTestDay1.Voltage;
% holder = [Time, Voltage]; 
% [A, B] = rmoutliers(Voltage, "movmean", 5, "SamplePoints",Time)
% 
% plot(holder(:,1),holder(:,2))
% xlabel("Seconds")