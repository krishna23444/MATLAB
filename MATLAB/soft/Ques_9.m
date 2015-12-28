% Question.
%
% Convert the given set of values 
% to certain linguistics terms :-
%
%      If        Age
%   55 – 65     elder
%   45 – 50     not elder
%   20 – 40     young
%      < 20     not young
%

clc;
clear;
  
%% Random inputs.

A = floor(1 + 65 * rand(1, 10));
  
%% Display the result.

disp('Age - Conclusion');
disp(' ');
for n = 1 : length(A)
    
    result = [num2str(A(n)) ' years of age is NOT DEFINED.'];
    
    if A(n) < 20 
        result = [num2str(A(n)) ' years of age is NOT YOUNG.'];
    end
    
    if A(n) >= 20 && A(n) <= 40
        result = [num2str(A(n)) ' years of age is YOUNG.'];
    end
    
    if A(n) >= 45 && A(n) <= 50
        result = [num2str(A(n)) ' years of age is NOT ELDER.'];
    end
     
    if A(n) >= 55 && A(n) <= 65
        result = [num2str(A(n)) ' years of age is ELDER.'];
    end
      
    disp(result);
end