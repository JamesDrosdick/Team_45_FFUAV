% James' version of the Motor Combo function
function D = James_MotorCombo(Combo_number)
    % Function Description
    % Takes in a number coresponding to a motor and prop combination and
    % outputs the struct "D" which contains all Data related to the information
    
    % cd into relevent folder
    oldfolder = cd('CSVs');
    
    % Offset to ignore all the column headers    
    i = Combo_number+1; 
    
    % Read data in table
    data = readmatrix('Acceptable_Motors3.csv','Range','A2:BS12');
    
    % Thrust struct for all thrust values of a motor
    Thrust = [ data(1,12:26) ; data(i,12:26)]';

    % Current struct for all current values of a motor
    Current = [ data(1,27:41) ; data(i,27:41)]';

    % Power struct for all power values of a motor
    Power = [ data(1,42:56) ; data(i,42:56)]';

    % Rpm  struct for all rpm values of a motor
    Rpm = [ data(1,57:71) ; data(i,57:71)]';

    % Compiles the static characteristics and then puts the structs above
    % into a larger struct so we can treat them all as one combination
    data = readtable('Acceptable_Motors2.csv', "Delimiter", ',','Range','A3:BS12');
    i = Combo_number;
    D = struct("Motor_Name", data.Var1(i), "Cost", data.Var2(i), "Weight_g", data.Var3(i), "Kv", data.Var4(i),  ...
    "MotorDiam",data.Var5(i),"MotorLen", data.Var6(i), "ShaftDiam", data.Var7(i), "Volt_min", data.Var8(i), "Volt_max", data.Var9(i), "PropD", data.Var10(i),...
    "Prop_Pitch", data.Var11(i), ...
    "Thrust_N", Thrust, "Current_A",Current, "Power_W", Power, "Rpm", Rpm); 
    
    % cd out to main
    cd(oldfolder);
end 