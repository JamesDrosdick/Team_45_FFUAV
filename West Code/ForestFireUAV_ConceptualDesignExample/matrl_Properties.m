function [matrl] = matrl_Properties(material, units)
%matrl_Properties - Load the following material properties:
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
%   Materials in database:
%       'Alumn6061-T6'
%       'Alumn7075-T6'
%
%   Calling Sequence:
%   matrl = matrl_Properties(material, units)
%
%   Inputs:  material   - material identifier
%            units      - material property units
%
%   Outputs: matrl.MaterialID              - material identifier
%            matrl.DensityWeight           - material weight density
%            matrl.DensityMass             - material mass density
%            matrl.ModulusElastic          - material elastic modulus
%            matrl.ModulusShear            - material shear modulus
%            matrl.PoissonsRatio           - material Poisson's ratio
%            matrl.StrengthYield           - material minimum yield strength
%            matrl.StrengthUltimate        - material minimum ultimate strength
%            matrl.FatigueStrengthCoeff    - material fatigue strength coefficient
%            matrl.FatigueStrengthExponent - material fatigue strength exponent
%            matrl.FatigueLimitCycles      - material fatigue limit cycles
%
% do case of material
switch material
    case 'Alumn6061-T6'
        [matrl]=matrl_aluminum6061_T6(units)      
    case 'Alumn7075-T6'
        [matrl]=matrl_aluminum7075_T6(units)
    case 'Alumn2024-T4'
        [matrl]=matrl_aluminum2024_T4(units)
    otherwise
        sprintf ('%s%s%s',   'Requested material (', material, ') is NOT in the project database')
end
% end case of material
end