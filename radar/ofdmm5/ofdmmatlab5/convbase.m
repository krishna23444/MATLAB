function  DataOut = convbase(DataIn,CurrBase,NewBase)
%CONVBASE Converts the number base of the input data (DataIn)
%	DataOut = convbase(DataIn,CurrBase,NewBase)
%	from the current base (CurrBase) to the new base required
%	(NewBase). If the new base is less the the old base, e.g
%	NewBase = 2 and CurrBase = 8, the DataOut will have more
%	data words. For the above example DataOut will be 4 times
%	longer then DataIn.
%	The actual base used = 2^NewBase, thus NewBase = 8, is base 256
%	E.g. DataIn = [ 2 64 20 ] with CurrBase = 8, NewBase = 2
%	DataOut = [0 0 0 2, 1 0 0 0, 0 1 1 0]
%	Note : Both the input and output data is in a serial format.
%====================================
% Convert the number base of the data
%====================================
if CurrBase > NewBase,
	%Convert the input data into the base (NewBase) required
	leftover = DataIn';
	DataOut = [];
	for k = 1:(CurrBase/NewBase)
		DataOut = [DataOut rem(leftover,2^NewBase)];
		leftover = floor(leftover./(2^NewBase));
	end
	DataOut = reshape(DataOut',1,size(DataOut,1)*size(DataOut,2));
elseif CurrBase < NewBase,
	%=======================
	%Convert back to decimal
	%=======================
	remainder = rem(length(DataIn),NewBase/CurrBase);
	if (remainder > 0),
		disp('WARNING : Received data length problem when converting base');
		disp('Clipping data to make possible');
		DataIn = DataIn(1:length(DataIn)-remainder);
	end
	Datawords=reshape(DataIn,NewBase/CurrBase,size(DataIn,1)*size(DataIn,2)/...
		(NewBase/CurrBase))';
	DataOut = zeros(size(Datawords,1),1);
	for k = 1:(NewBase/CurrBase)
		DataOut = DataOut+Datawords(:,k)*(2^CurrBase)^(k-1);
	end
	DataOut = DataOut.';
else
	DataOut = DataIn;	%No change of base.
end
