clc;
clear;

for i = 1:10
    allMPCs(i) = James_MotorCombo(i);
end

for i = 1:15
    allBats(i) = BatteryInfo(i);
end

%% generate big boy
I = 0;
J = 0;
Payload = 25;
Distance = 16;
for i = 1:10
    for j = 1:15

            [CC, TC, F] = Current_thrust_Check(allMPCs(i),allBats(j),Payload,1);
            if (CC == 1 && TC == 1)
                [MC, BCR, BCRP, MT] = MissionSim(allMPCs(i),allBats(j),Distance,F);
                A = [MC, BCR, BCRP, MT];
            end
            if (CC == 1 && TC == 1 && MC == 1)
                I = I + 1;
                T = array2table(A);
                T.Properties.VariableNames(1:4) = {'Battery Remaining (mAh)','Battery Remaining (%)', 'Mission time (min)','Total Down Force'};
                APCs(I) = struct('MCP',allMPCs(i),'Battery',allBats(j),'Mission',T);
            end
    end
end
%%
for i = 1:6
    s(i) = APCs(i).Mission.(3);
end
[~,Best_indx] = max(s)
Best_Config = APCs(Best_indx)
