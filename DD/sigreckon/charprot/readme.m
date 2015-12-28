% Copy all files in Matlab current directory and type "charec" on Matlab command window.
% A simple and intuitive GUI should appear.
% 
% Now you can:
%          - select an image (all image file formats supported by Matlab)
%          - select an UNIPEN file (see the included .txt files as examples)
% After this selection you can:
%          - add this image to database
%          - make character recognition (in this case database has to
%            include at least one character image)
%
% For the recognition two options are available:
%          - standard recognition based on Neural Networks
%          - Uniform Differential Normalized Coordinates based character
%            recognition. In this case all input characters have to be in
%            UNIPEN format.
%
% If you add an image to database you have to specify an ID, a progressive integer number which uniquely
% identifies a character. The system we have developed is writer
% independent, robust to scale variations, rotations and character translations.
% 
% 
% FUNCTIONS
%
% Read image:                                           read the input image.
%
% Read UNIPEN file:                                     read the input UNIPEN file.
%
% Add selected image to database:                       the input character is added to database and will be used for training.
%
% Database Info:                                        show informations about the images present in database.
%
% Character Recognition - Standard approach:            character recognition using standard approach.
%                                                       The selected input image or UNIPEN file is processed.
%
% Character Recognition - UDNC approach:                character recognition using Uniform Differential Normalized Coordinates.
%                                                       This feature is supported only for UNIPEN file format.
%                                                       The selected UNIPEN file is processed.
%
% Delete Database:                                      remove database from the current directory.
%
% Info:                                                 show informations about this software.
%
%
% Source code for Optical Character Recognition System: how to obtain the complete source code
%
% Exit:                                                 quit program
%
%
%
%
%
% Luigi Rosa
% Via Centrale 35
% 67042 Civita di Bagno
% L'Aquila - ITALY 
% email  luigi.rosa@tiscali.it
% mobile +39 3207214179
% website http://www.advancedsourcecode.com

%