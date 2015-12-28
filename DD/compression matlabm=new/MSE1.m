function mse = MSE1(A,B)
% PSNR (Peak Signal to noise ratio)

if (size(A) ~= size(B))
   error('The size of the 2 matrix are unequal')

   psnr_Value = NaN;
   return; 
elseif (A == B)
   disp('Images are identical: PSNR has infinite value')

   psnr_Value = Inf;
   return;   
else

    maxValue = double(max(A(:)));

    % Calculate MSE, mean square error.
    mseImage = (abs(double(A) - double(B)) .^ 2);
    [rows columns] = size(A);
    
    mse = sum(mseImage(:)) / (rows * columns);

    
end


end