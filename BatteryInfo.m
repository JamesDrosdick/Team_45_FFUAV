function D = BatteryInfo(Battery_number)    
    % Function Desciption
    % Takes in a number coresponding to a given motor and prop conbination
    % and returns a struct that contains all data related to Battery

    % cd into relevent folder
    oldfolder = cd('CSVs');
    % Read data in table
    data = readtable('Battery Data 2.csv', "Delimiter", ',','Range','A2:L17'); 
    
    % Offset to ignore all the column headers    
    i = Battery_number; 
    
        D = struct("Battery_Name", data.BatteryName(i), "Battery_Cap_mAH", data.PowerCapacity_mAh_(i), "Voltage", data.Voltage_V_(i), "Energy_Wh", data.Energy_Wh_(i), "Cont_Discharge_C", data.ContinuousDischargeRate_C_(i), ...
            "Const_Discharge_A",data.ContinuousDischargeRate_A_(i),"Max_Discharge_C", data.MaximumDischargeRate_c_(i), "Weight_kg", data.Weight_kg_(i), "Dimensions", data.DimensionsMmXMmXMm(i), "Number_Cells_S", data.x_OfCells(i), "Cost", data.Cost___(i)); 
    
    % cd back to main
    cd(oldfolder);
end