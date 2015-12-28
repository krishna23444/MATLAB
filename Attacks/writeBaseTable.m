function [percentD,nb_images,totalAttacks] = writeBaseTable(name,data,images,groups, technology, application)
% writefile Writes a html file from the data in the images cell
% writefile(name, data, images, groups) Name is the name of the file to write. There
% is a path that is added to this file, it's the global variable
% HTML_OUPUT_PATH. Images is a cell which each element is a matrix
% with the data concerning an image. In order to get the images names and the 
% group names, we need the repective cell array strings (groups, images).
%
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
% See the also the "Copyright" file provided in this package for
% copyright information about code used in the Checkmark package.
%
global HTML_OUTPUT_PATH;
global IMAGES_PATH;
global BASEHREF;

path_n_file = [HTML_OUTPUT_PATH, name];
nb_images = size(images,1);
nb_groups = size(groups,1);

result_table = zeros(nb_groups+1,nb_images+1)-1;
% --- Locating groups ----
loc_groups = cell(nb_images,1);
for img=1:nb_images
    loc_groups{img} = 1;
    old_group = data{img}(1,1);
    for j=2:size(data{img},1)
        if (data{img}(j,1) ~= old_group)
            loc_groups{img} = [loc_groups{img} ; j];
            old_group = data{img}(j,1);
        end
    end
    loc_groups{img} = [loc_groups{img} ; size(data{img},1)];
end

% Calculation of sum row-results
total_for_percent_table = zeros(nb_groups,nb_images);
for img=1:nb_images
    nb_groups_for_image = size(loc_groups{img},1)-1;
    for i=1:nb_groups_for_image
        which_group = data{img}(loc_groups{img}(i),1); 
        result_table(which_group,img) = sum(data{img}(loc_groups{img}(i):loc_groups{img}(i+1)-1,3));
        total_for_percent_table(which_group,img) = loc_groups{img}(i+1) - loc_groups{img}(i);
    end
end

% Calculation of averages
result_table(:,nb_images+1) = mean(result_table(:,1:nb_images),2);
result_table(nb_groups+1,:) = mean(result_table(1:nb_groups,:),1);

percent_table = zeros(nb_groups+1,nb_images+1);
% Percent table and percent averages
percent_table(1:nb_groups, 1:nb_images) = (result_table(1:nb_groups, 1:nb_images) ./ total_for_percent_table ) .* 100;
percent_table(:,nb_images+1) = mean(percent_table(:,1:nb_images),2);
percent_table(nb_groups+1,:) = mean(percent_table(1:nb_groups,:),1);

% --- Sorting by averages
[ Y I ] = sortrows(percent_table(1:nb_groups,:),nb_images+1);
I = flipud(I);
groups = groups(I);
total_for_percent_table = total_for_percent_table(I,:);
I(nb_groups+1) = nb_groups+1;
percent_table = percent_table(I,:);
result_table  = result_table(I,:);

fprintf('writing file: %s\n',path_n_file);
% --- Writing file ---
% -- Saving into html file --
fid = fopen(path_n_file,'w');
baseref=[BASEHREF technology '/'];
writeheader(fid, technology, application,baseref);

fprintf(fid,'<table width="85%%" border="1" cellspacing="2" cellpadding="2" align="center">\n');
% First line
fprintf(fid,'<tr bgcolor="CCCCCC">\n<td><div align="center"><b><font face="Arial, Helvetica, sans-serif">Attacks/Images</font></b></div></td>\n');
for i=1:nb_images
    fprintf(fid,'<td>\n<div align="center"><b><font face="Arial, Helvetica, sans-serif">%s</font></b></div>\n</td>\n',char(images(i)));
end
fprintf(fid,'<td><div align="center">Avg</div></td>');
fprintf(fid,'\n</tr>\n');

% second:last-1 line
for j=1:nb_groups
%  link=[technology '/' application '_' char(groups(j)) '.html'];
  link=[application '_' char(groups(j)) '.html'];
    fprintf(fid,'<tr>\n');
    fprintf(fid,'<td>\n<div><b><font face="Arial, Helvetica, sans-serif">');
    text1=[char(groups(j)) '(' num2str(total_for_percent_table(j,1)) ')'];
    insertlink(fid,link,text1)
    closetag(fid,'font');closetag(fid,'b');closetag(fid,'div');closetag(fid,'td');
    % data for each group
    for i=1:nb_images
        fprintf(fid,'  <td>\n');
        if (result_table(j,i) < 0)
            fprintf(fid,'  <div align="center"><font face="Arial, Helvetica, sans-serif">-</font></div>');
        else
            fprintf(fid,'  <table border="0" width="100%%" cellspacing="0">\n');
	    inserttr(fid,'#FFFFFF');
	    inserttd(fid,num2str(round(result_table(j,i))));closetag(fid,'td');closetag(fid,'tr');
	    
	    inserttr(fid,'#EEEEEE');
	    text1=[num2str(round(percent_table(j,i))) '%'];
	    inserttd(fid,text1);closetag(fid,'td');closetag(fid,'tr');

	    closetag(fid,'table');
        end
        fprintf(fid,'  </td>\n');
    end
    % data for average
     text1=[num2str(round(percent_table(j,nb_images+1))) '%'];
     inserttd(fid,text1);closetag(fid,'td');closetag(fid,'tr');
end

totalAttacks=sum(total_for_percent_table(:,1))*nb_images;
% last line
fprintf(fid,'<tr bgcolor="#DDDDDD">\n');
fprintf(fid,'<td>\n<div align="center"><b><font face="Arial, Helvetica, sans-serif">Average (%d)</font></b></div>\n</td>\n',totalAttacks);
for i=1:(nb_images+1)
    fprintf(fid,'  <td>\n');
    fprintf(fid,'  <div align="center"><font face="Arial, Helvetica, sans-serif">%d%%</font></div>',round(percent_table(nb_groups+1,i)));
    fprintf(fid,'  </td>\n');
end            
fprintf(fid,'</table>\n');

% Printing totals
fprintf(fid,'<p>\n<font face="Arial, Helvetica, sans-serif">\n');
fprintf(fid,'Total number of attacks: %d <br>\n',sum(sum(total_for_percent_table)));
fprintf(fid,'Number detected: %d <br>\n',sum(sum(result_table(1:nb_groups,1:nb_images))));
percentD=round(100 * sum(sum(result_table(1:nb_groups,1:nb_images))) / sum(sum(total_for_percent_table)) );
fprintf(fid,'Percent detected: %d%% <br>\n',percentD);
fprintf(fid,'</font></p>\n');

writeFooter(fid);
fprintf(fid,'  </body>\n');

fclose(fid);

a = 1;