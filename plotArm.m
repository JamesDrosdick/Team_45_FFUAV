function P = plotArm(L, offset, R, MotorDia, MotorLen, M1)
    % Arms
    x = [offset, offset+L]; 
    y = [offset, offset];
    z = [offset, offset]; 
    x2 = [offset, offset-L]; 
    y2 = [offset, offset]; 
    z2 = [offset, offset]; 
    x3 = [offset, offset];  
    y3 = [offset, offset+L];
    z3 = [offset, offset]; 
    x4 = [offset, offset]; 
    y4 = [offset, offset-L];
    z4 = [offset, offset]; 
    x5 = [offset, offset+L/sqrt(2)]; 
    y5 = [offset, offset+L/sqrt(2)];
    z5 = [offset, offset]; 
    x6 = [offset, offset-L/sqrt(2)]; 
    y6 = [offset, offset-L/sqrt(2)];
    z6 = [offset, offset]; 
    x7 = [offset, offset-L/sqrt(2)]; 
    y7 = [offset, offset+L/sqrt(2)];
    z7 = [offset, offset]; 
    x8 = [offset, offset+L/sqrt(2)]; 
    y8 = [offset, offset-L/sqrt(2)];
    z8 = [offset, offset]; 
    
    % Props 
    th = 0:pi/50:2*pi;
    xunit = R*cos(th) + offset+L;
    yunit = R*sin(th) + offset;
    zunit = zeros(length(yunit))+offset+MotorLen;
    xunit2 = R*cos(th) + offset-L;
    yunit2 = R*sin(th) + offset;
    zunit2 = zeros(length(yunit))+offset+MotorLen;
    xunit3 = R*cos(th) + offset;
    yunit3 = R*sin(th) + offset+L;
    zunit3 = zeros(length(yunit))+offset+MotorLen;
    xunit4 = R*cos(th) + offset;
    yunit4 = R*sin(th) + offset-L;
    zunit4 = zeros(length(yunit))+offset+MotorLen;
    xunit5 = R*cos(th) + offset+L/sqrt(2);
    yunit5 = R*sin(th) + offset-L/sqrt(2);
    zunit5 = zeros(length(yunit))+offset+MotorLen;
    xunit6 = R*cos(th) + offset-L/sqrt(2);
    yunit6 = R*sin(th) + offset-L/sqrt(2);
    zunit6 = zeros(length(yunit))+offset+MotorLen;
    xunit7 = R*cos(th) + offset+L/sqrt(2);
    yunit7 = R*sin(th) + offset+L/sqrt(2);
    zunit7 = zeros(length(yunit))+offset+MotorLen;
    xunit8 = R*cos(th) + offset-L/sqrt(2);
    yunit8 = R*sin(th) + offset+L/sqrt(2);
    zunit8 = zeros(length(yunit))+offset+MotorLen;
    
    % Motor
    R1 = MotorDia/2
    xmotor = R1*cos(th) + offset+L;
    ymotor = R1*sin(th) + offset;
    zmotor = zeros(length(yunit))+offset+MotorLen/2;
    xmotor2 = R1*cos(th) + offset-L;
    ymotor2 = R1*sin(th) + offset;
    zmotor2 = zeros(length(yunit))+offset+MotorLen/2;
    xmotor3 = R1*cos(th) + offset;
    ymotor3 = R1*sin(th) + offset+L;
    zmotor3 = zeros(length(yunit))+offset+MotorLen/2;
    xmotor4 = R1*cos(th) + offset;
    ymotor4 = R1*sin(th) + offset-L;
    zmotor4 = zeros(length(yunit))+offset+MotorLen/2;
    xmotor5 = R1*cos(th) + offset+L/sqrt(2);
    ymotor5 = R1*sin(th) + offset-L/sqrt(2);
    zmotor5 = zeros(length(yunit))+offset+MotorLen/2;
    xmotor6 = R1*cos(th) + offset-L/sqrt(2);
    ymotor6 = R1*sin(th) + offset-L/sqrt(2);
    zmotor6 = zeros(length(yunit))+offset+MotorLen/2;
    xmotor7 = R1*cos(th) + offset+L/sqrt(2);
    ymotor7 = R1*sin(th) + offset+L/sqrt(2);
    zmotor7 = zeros(length(yunit))+offset+MotorLen/2;
    xmotor8 = R1*cos(th) + offset-L/sqrt(2);
    ymotor8 = R1*sin(th) + offset+L/sqrt(2);
    zmotor8 = zeros(length(yunit))+offset+MotorLen/2;
    
    motor_origin = [offset+L,offset,offset+MotorLen/2;offset-L,offset,offset+MotorLen/2;offset,offset+L,offset+MotorLen/2;offset,offset-L,offset+MotorLen/2;offset+L/sqrt(2),offset-L/sqrt(2),offset+MotorLen/2;offset-L/sqrt(2),offset-L/sqrt(2),offset+MotorLen/2;offset+L/sqrt(2),offset+L/sqrt(2),offset+MotorLen/2;offset-L/sqrt(2),offset+L/sqrt(2),offset+MotorLen/2]
   
    Xcm_Mot = sum((motor_origin(:,1)*M1))/(M1*8)
    Ycm_Mot = sum((motor_origin(:,2)*M1))/(M1*8)
    Zcm_Mot = sum((motor_origin(:,3)*M1))/(M1*8)
    
    figure(1) 
    hold on
    view(2)
    grid on 
    plot3(x,y,z, 'b')
    plot3(x2,y2,z2, 'b')
    plot3(x3,y3,z3, 'b')
    plot3(x4,y4,z4, 'b')
    plot3(x5,y5,z5, 'b')
    plot3(x6,y6,z6, 'b')
    plot3(x7,y7,z7, 'b')
    plot3(x8,y8,z8, 'b')
    plot3(xunit,yunit,zunit, 'r')
    plot3(xunit2,yunit2,zunit2, 'r')
    plot3(xunit3,yunit3,zunit3, 'r')
    plot3(xunit4,yunit4,zunit4, 'r')
    plot3(xunit5,yunit5,zunit5, 'r')
    plot3(xunit6,yunit6,zunit6, 'r')
    plot3(xunit7,yunit7,zunit7, 'r')
    plot3(xunit8,yunit8,zunit8, 'r')
    plot3(xmotor,ymotor,zmotor, 'g')
    plot3(xmotor2,ymotor2,zmotor2, 'g')
    plot3(xmotor3,ymotor3,zmotor3, 'g')
    plot3(xmotor4,ymotor4,zmotor4, 'g')
    plot3(xmotor5,ymotor5,zmotor5, 'g')
    plot3(xmotor6,ymotor6,zmotor6, 'g')
    plot3(xmotor7,ymotor7,zmotor7, 'g')
    plot3(xmotor8,ymotor8,zmotor8, 'g')
    plot3(Xcm_Mot,Ycm_Mot,Zcm_Mot, 'or'); 
    
    figure(2)
    view(3)
    hold on
    grid on 
    plot3(x,y,z, 'b')
    plot3(x2,y2,z2, 'b')
    plot3(x3,y3,z3, 'b')
    plot3(x4,y4,z4, 'b')
    plot3(x5,y5,z5, 'b')
    plot3(x6,y6,z6, 'b')
    plot3(x7,y7,z7, 'b')
    plot3(x8,y8,z8, 'b')
    plot3(xunit,yunit,zunit, 'r')
    plot3(xunit2,yunit2,zunit2, 'r')
    plot3(xunit3,yunit3,zunit3, 'r')
    plot3(xunit4,yunit4,zunit4, 'r')
    plot3(xunit5,yunit5,zunit5, 'r')
    plot3(xunit6,yunit6,zunit6, 'r')
    plot3(xunit7,yunit7,zunit7, 'r')
    plot3(xunit8,yunit8,zunit8, 'r')
    plot3(xmotor,ymotor,zmotor, 'g')
    plot3(xmotor2,ymotor2,zmotor2, 'g')
    plot3(xmotor3,ymotor3,zmotor3, 'g')
    plot3(xmotor4,ymotor4,zmotor4, 'g')
    plot3(xmotor5,ymotor5,zmotor5, 'g')
    plot3(xmotor6,ymotor6,zmotor6, 'g')
    plot3(xmotor7,ymotor7,zmotor7, 'g')
    plot3(xmotor8,ymotor8,zmotor8, 'g')
    zlim([400,600]); 
    
    plot3(Xcm_Mot,Ycm_Mot,Zcm_Mot, 'or'); 
    
    P = []; 
end 
