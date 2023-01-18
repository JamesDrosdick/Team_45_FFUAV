data = readmatrix('Acceptable_Motors3.csv','Range','A2:BS12');
    % Thrust struct for all thrust values of a motor
    Thrust = [ data(1,12:26) ; data(i,12:26)]';

    % Current struct for all current values of a motor
    Current = [ data(1,27:41) ; data(i,27:41)]';

    % Power struct for all power values of a motor
    Power = [ data(1,42:56) ; data(i,42:56)]';

    % Rpm  struct for all rpm values of a motor
    Rpm = [ data(1,57:71) ; data(i,57:71)]';