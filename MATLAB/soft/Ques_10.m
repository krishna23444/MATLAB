% Air conditioner controller using Fuzzy sets.

clc;
clear;
  
%% Desired temperature, T0.

T0 = 20;

%% Room temperature, T.

T = 20;

%% Control temperature.

for n = 1 : 10
    
    % Random change in temperature, dT.
    dT = rand(1, 10) > 0.5;
    dT = 2*dT - 1;
    dT = sum(dT);

    T = T + dT;
    
    % Temperature difference.
    t = T - T0;
    
    if t == 0
    
        if dT > 0
            disp('Temperature now is stable but rising.  => Blow COLD air.');
        elseif dT < 0
            disp('Temperature now is stable but falling. => Blow HOT air.');
        else
            disp('Temperature now is stable.             => Blow NO air.');
        end
        
    elseif t > 0
    
        if dT > 0
            disp('Temperature now is high and rising.    => Blow COLD air.');
        elseif dT < 0
            disp('Temperature now is high but falling.   => Blow NO air.');
        else
            disp('Temperature now is high but stable.    => Blow COOL air.');
        end
        
    else
        
        if dT > 0
            disp('Temperature now is low bot rising.     => Blow NO air.');
        elseif dT < 0
            disp('Temperature now is low and falling.    => Blow HOT air.');
        else
            disp('Temperature now is low but stable.     => Blow WARM air.');
        end
    
    end
    
end