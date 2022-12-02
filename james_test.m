clc;
clear;

for i = 1:10
    allMPCs(i) = James_MotorCombo(i);
end

for i = 1:15
    allBats(i) = BatteryInfo(i);
end