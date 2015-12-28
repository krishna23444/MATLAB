function [percentD,numims,numattacks]=baseAppTechPage(data_file, technology, application)
dum=1;
% create_html_pages Creates a set of html pages from a data file.
% create_html_pages(data_file, technology, application) data_file is the
% file from which the function takes all data. Technology and application
% are strings in order to put a title for the files to generate.
% The main generated file is technology+'_'+application+'.html'.
% The others oare in the directory technology+'_'+application.
% 
% Written by Vladimir Calderon
%
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
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%
global HTML_OUTPUT_PATH;
global IMAGES_PATH;
global DATA_INPUT_PATH;

%filename = [DATA_INPUT_PATH data_file];
filename = [data_file];
outputfile = [char(technology) '_' char(application)];

[ Iorig Gorig P O AIN R P1 V1 P2 V2 P3 V3 P4 V4 P5 V5 P6 V6] = readfile(filename);
% ------ Data ------------
% Iorig original images, Gorig, original groups
% I - Image
% G - attack group 
% P - weights
% 0 - Only ones
% AIN - attackedimage Name
% R - result
% Pi, Vi Couples of parameters and values
% ------------------------
filename
images = getimages(filename);
groups = getgroups(filename);
I = getnumber(Iorig,images);
G = getnumber(Gorig,groups);
%  Sorting I and saving index
[ I index ] = sort(I);
B = [ G(index) P(index) R(index) ];


params=[P1,P2,P3,P4,P5,P6];
values=[V2,V3,V4,V5,V6];

% --- A contains info for all images
% Every cell of A contains a matrix with 
% column 1: groups
% column 2: weights
% column 3: results
nb_images = size(images,1);
A = cell(nb_images,1);
% --- Locating images ----
loc_images = 1;
old_image = I(1);
for j=2:size(I,1)
    if (I(j) ~= old_image)
        loc_images = [ loc_images ; j];
        old_image = I(j);
    end
end
loc_images = [loc_images ; size(I,1)+1];

for i=1:nb_images
    A{i} = B(loc_images(i):loc_images(i+1)-1,:);
    [ Asort index_groups ] = sort(A{i}(:,1));
    A{i} = [ Asort A{i}(index_groups,2) A{i}(index_groups,3) ];
end

outputPath=technology;
outputhtmlfile = [char(outputPath),'/',char(outputfile), '.html']
% Creating pages for every group
create_dir_result = mkdir(HTML_OUTPUT_PATH);
create_dir_result = mkdir(HTML_OUTPUT_PATH,char(outputPath));
switch create_dir_result
case 1
    fprintf('Directory created, writing pages...\n');
case 2
    fprintf('Directory was already there, rewriting...\n');
otherwise
    error('Cant create directory under ');
end

sprintf('generating base table for technology %s application %s',technology,application)
[percentD,numims,numattacks]=writeBaseTable(outputhtmlfile, A, images, groups, technology, application);

sprintf('generating group details for technology %s application %s',technology,application)
% V1 are the compressiontypes

writeGroupDetail(AIN,R,params,values,V1, Iorig,Gorig, images, groups, technology, application);
