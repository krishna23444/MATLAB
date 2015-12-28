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
function []=xml_APP_allattacktest(fid,GLOBALS)

 %%%%%%%%%%%%%%%%%%%%%%%%%%% ALL ATTACKS for high compression %%%%%%%%%%%%%%%%%
 groupweight=1; groupcount=1;
 [P,count,groupcount,refs]=initgroup(fid,groupcount,groupweight,'allattacks');
 labels={GLOBALS.PARAMS_SCQ};weight=1;% weight of attacks in the group
 refs(1).value='4';
 for attack={'all'}
   insert_attackGroup2(fid,attack,weight,labels,refs,'attackType');
 end
 endgroup(fid,'attackGroup'); 
 
 