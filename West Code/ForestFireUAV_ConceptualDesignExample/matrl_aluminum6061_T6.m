function [matrl] = matrl_aluminum6061_T6(units)
%matrl_aluminum6061_T6 - Load the following material properties for
% UNS A96061-T6 aluminum:
%   1. material identifier
%   2. weight density
%   3. mass density
%   4. elastic modulus
%   5. shear modulus
%   6. minimun yield strength
%   7. minimum ultimate strength
%   8. fatigue strength coefficient
%   9. fatigue strength exponent
%  10. fatigue limit cycles
%   
%   Calling Sequence:
%   matrl = matrl_aluminum6061_T6(units)
%
%   Inputs:  units - material property units ('psi' or 'MPa')
%                    psi = inch:pound-force:second
%                    MPa = mm:Newton:second
%
%   Outputs: matrl.material                - material identifier
%            matrl.DensityWeight           - material weight density
%            matrl.DensityMass             - material mass density
%            matrl.ModulusElastic          - material elastic modulus
%            matrl.ModulusShear            - material shear modulus
%            matrl.PoissonsRatio           - material Poisson's Ratio
%            matrl.StrengthYield           - material minimum yield strength
%            matrl.StrengthUltimate        - material minimum ultimate strength
%            matrl.FatigueStrengthCoeff    - material ummodified minimum fatigue strength
%            matrl.FatigueStrengthExponent - material ummodified minimum fatigue strength
%            matrl.FatigueLimitCycles      - material cycles for fatigue strength
%
% Define Reference Material Properties for current material
% Citation for Material Properties:
%
% MATWEB: https://www.matweb.com/search/datasheet.aspx?matguid=b8d536e0b9b54bd7b69e4124d8f1d20a
% 
matrl.Material   = 'alumn6061-T6';                      % set material id
% do case of units
switch units
    case 'psi'
        % material mass properties
        g = 386.0885852;                                % acceleration due to gravity [in/s^2]
        matrl.DensityWeight = 0.0975;                   % weight density [lbf/in^3]
        matrl.DensityMass   = matrl.DensityWeight/g;    % mass density [lbf-s^2/in^4]
        % material elastic properties
        matrl.ModulusElastic = 10.0e6;                  % elastic modulus [psi]
        matrl.ModulusShear =  3.77e6;                   % shear modulus [psi]
        matrl.PoissonsRatio = 0.33;                     % Poisson's Ratio
        % material strength properties        
        matrl.StrengthYield = 40.0e3;                   % Min Sy [psi]
        matrl.StrengthUltimate = 45.0e3;                % Min Sut [psi]
        % material fatigue properties
        matrl.FatigueStrengthCoeff = 213;               % sigma_f_prime [psi], completely reversed
        matrl.FatigueStrengthExponent = -0.143;         % b
        matrl.StrengthFatigueCycles = 5.0e8;            % N_inf = fatigue limit
       
    case 'MPa'
        % material mass properties
        g = 9806.6499994;                               % acceleration due to gravity [mm/s^2]
        matrl.DensityWeight = 2.70e-5;                  % weight density [N/mm^3]
        matrl.DensityMass   = matrl.DensityWeight/g;    % mass density [N-s^2/mm^4]
        % material elastic properties
        matrl.ElasticModulus = 68.9;                    % elastic modulus [MPa]
        matrl.ShearModulus   = 26.0;                    % shear modulus [MPa]
        matrl.PoissonsRatio  = 0.33;                    % Poisson's Ratio   
        % material strength properties        
        matrl.StrengthYield = 276;                      % Min Sy [MPa]
        matrl.StrengthUltimate = 310;                   % Min Sut [MPa]
        % material fatigue properties
        matrl.FatigueStrengthCoeff = 1466;              % sigma_f_prime [MPa], completely reversed
        matrl.FatigueStrengthExponent = -0.143;         % b 
        matrl.StrengthFatigueCycles = 5.0e8;            % N_inf = fatigue limit
       
    otherwise
        sprintf ('%s%s%s',   'Requested material units (', units, ') are NOT in the project materials database')
        sprintf ('%s%s%s%s', 'Recognized units for material properties are: ', 'psi', ' or ', 'MPa')
    end
% end case of units
end

