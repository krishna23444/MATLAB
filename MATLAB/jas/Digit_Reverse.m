function y = Digit_Reverse(x,r)
    % Digit_Reverse(x,r)
    % y = Digit_Reverse(x,r) returns the input data in digit-reversed order in vector or matrix y. 
    % The digit-reversal is computed using the number system base r. 
    % The length of x must be an integer power of r. 
    % y is the same size as x.

    rowCount = size(x,1);
    colCount = size(x,2);

    if rowCount == 1
        x = x';  
        colCount = 1;
    end

    if r^(floor(log(size(x,1))/log(r))) ~= size(x,1)
      error(generatemsgid('MustBeInteger'),['The length of the input x must be an integer power of ' num2str(r) '.']);
    end

    %Iterate column-wise.
    for a = 1 : colCount
        X = x(:,a);

        if r == 2
            z = zeros(1,length(X));
            for b = 1 : length(X)
                z(b) = bin2dec(fliplr(dec2bin(b-1,log2(length(X))))) + 1;
            end

            pX = X;
            for b = 1 : length(X)
                X(b) = pX(z(b));
            end
        else
            z = zeros(length(X) / r, r);

            for b = 1 : length(X)
                z(b) = b;
            end

            z = z';

            pX = X;
            for b = 1 : length(X)
                X(b) = pX(z(b));
            end
        end

        x(:,a) = X;
    end

    if rowCount == 1
        y = x';
    else
        y = x;
    end
end