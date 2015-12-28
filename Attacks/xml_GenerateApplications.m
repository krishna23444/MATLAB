% Copyright (c) 2001, Shelby Pereira, University of Geneva
% 
%  Permission to use, copy, modify, and distribute this software and its
%  documentation for any non-commercial purpose and without fee is hereby
%  granted (GPL), provided that the above copyright notice appear in all
%  copies and that both that copyright notice and this permission notice
% appear in supporting documentation. This software is provided "as is" 
% without express or implied warranty. The authors shall not be held
% liable in any event for incidental or consequential damages in
% connection with, or arising out of, the furnishing, performance, or
% use of this program.
% 
% If you use the Checkmark software package for your research, please cite:
%
% Shelby Pereira, Sviatoslav Voloshynovskiy, Maribel Madueño, Stéphane Marchand-Maillet
% and Thierry Pun, Second generation benchmarking and application oriented evaluation,
% In Information Hiding Workshop, Pittsburgh, PA, USA, April 2001.
%
%  http://cui.unige.ch/~vision/Publications/watermarking_publications.html
%
%  
%
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%
function []=xml_GenerateApplications(fid,applicname)
imtype='xml';  % This justs sets the directory to nothing useful for manipulating the filenames
slow1=1;
P=getparams('testvalues'); % All tests timnum=1;
% create a list of all possible attacks from the following types
% each one has an associated function which defines the specifics for the attack

for application={applicname} 
	writeGenericApplication(fid,char(application))
end
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% write a generic xml class
function []=writeGenericApplication(fid,applicName)
timnum=1;slow1=1;
fprintf(fid,'<application id="%s"> \n',applicName);
fprintf(fid,'<name>%s</name> \n',applicName);
i=0;tstvec=0;
P=getparams('globals');
% call the function which generates the application
funcname=sprintf('@xml_APP_%s',applicName) ;	func=eval(funcname);
feval(func,fid,P); % add the contents specific to a given attack
fprintf(fid,'</application>\n\n');
return

 