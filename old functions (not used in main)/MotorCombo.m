function D = MotorCombo(Combo_number)
    % Function Description
    % Takes in a number coresponding to a motor and prop combination and
    % outputs the struct "D" which contains all Data related to the information
    
    % Offset to ignore all the column headers    
    i = Combo_number+1; 
    
    % Read data in table
    data = readtable('Acceptable_Motors.csv', "Delimiter", ',' ); 
    
    % Thrust struct for all thrust values of a motor
    Thrust = struct("t25", data.ThrustAtAllThrottle__s_g_(i), "t37_5", data.Var13(i), "t40", data.Var14(i), "t45", data.Var15(i), "t50", ...
        data.Var16(i), "t55", data.Var17(i), "t60", data.Var18(i), "t62_5", data.Var19(i), "t65", data.Var20(i), "t70", data.Var21(i), ...
        "t75", data.Var22(i), "t80", data.Var23(i), "t87_5", data.Var24(i), "t90", data.Var25(i), "t100", data.Var26(i)); 
    
    % Current struct for all current values of a motor
    Current = struct("c25", data.CURRENTAtAllThrottle__s_A_(i), "c37_5", data.Var28(i), "c40", data.Var29(i), "c45", data.Var30(i), "c50", ...
        data.Var31(i), "c55", data.Var32(i), "c60", data.Var33(i), "c62_5", data.Var34(i), "c65", data.Var35(i), "c70", data.Var36(i), ...
        "c75", data.Var37(i), "c80", data.Var38(i), "c87_5", data.Var39(i), "c90", data.Var40(i), "c100", data.Var41(i));
    
    % Power struct for all power values of a motor
    Power = struct("p25", data.POWERAtAllThrottle__s_W_(i), "p37_5", data.Var43(i), "p40", data.Var44(i), "p45", data.Var45(i), "p50", ...
        data.Var46(i), "p55", data.Var47(i), "p60", data.Var48(i), "p62_5", data.Var49(i), "p65", data.Var50(i), "p70", data.Var51(i), ...
        "p75", data.Var52(i), "p80", data.Var53(i), "p87_5", data.Var54(i), "p90", data.Var55(i), "p100", data.Var56(i));
    
    % Rpm  struct for all rpm values of a motor
    Rpm = struct("r25", data.RPMAtAllThrottle__s(i), "r37_5", data.Var58(i), "r40", data.Var59(i), "r45", data.Var60(i), "r50", ...
        data.Var61(i), "r55", data.Var62(i), "r60", data.Var63(i), "r62_5", data.Var64(i), "r65", data.Var65(i), "r70", data.Var66(i), ...
        "r75", data.Var67(i), "r80", data.Var68(i), "r87_5", data.Var69(i), "r90", data.Var70(i), "r100", data.Var71(i));
    
    % Compiles the static characteristics and then puts the structs above
    % into a larger struct so we can treat them all as one combination
        
    D = struct("Motor_Name", data.Var1(i), "Cost", data.Var2(i), "Weight_g", data.Var3(i), "Kv", data.Var4(i), "MotorDiam", data.Dimensions_mm_(i), ...
        "MotorLen", data.Var6(i), "ShaftDiam", data.Var7(i), "Volt_min", data.Voltages_V_(i), "Volt_max", data.Var9(i), "PropD", data.Var10(i),...
        "Prop_Pitch", data.Var11(i), ...
        "Thrust_g", Thrust, "Current_A",Current, "Power_W", Power, "Rpm", Rpm); 

end 