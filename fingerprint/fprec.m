
clear;
clc;
close all;
global immagine n_bands h_bands n_arcs h_radius h_lato n_sectors matrice num_disk%defines variables used throughout code


n_bands=4;
h_bands=20;
n_arcs=16;
h_radius=12;
h_lato=h_radius+(n_bands*h_bands*2)+16;
if mod(h_lato,2)==0
    h_lato=h_lato-1;
end
n_sectors=n_bands*n_arcs;
matrice=zeros(h_lato);
for ii=1:(h_lato*h_lato)
    matrice(ii)=whichsector(ii);
end
num_disk=8;
% 1--> add database
% 0--> recognition
%ok=0;
chos=0;
possibility=7;

messaggio='Insert the number of set: each set determins a class. This set should include a number of images for each person, with some variations in expression and in the lighting.';

while chos~=possibility,
    chos=menu('Fingerprint Recognition System','Select image and add to database','Select image for fingerprint recognition','Info','Delete database',...
        'Fingerprint image: visualization','Gabor Filter: visualization','Exit');
    %--------------------------------------------------------------------------
    %--------------------------------------------------------------------------
    %--------------------------------------------------------------------------
    % Calculate FingerCode and Add to Database
    if chos==1
        clc;
        close all;
        selezionato=0;
        while selezionato==0
            [namefile,pathname]=uigetfile({'*.bmp;*.tif;*.tiff;*.jpg;*.jpeg;*.gif','IMAGE Files (*.bmp,*.tif,*.tiff,*.jpg,*.jpeg,*.gif)'},'Chose GrayScale Image');%open an image file if choice 1 is taken
            
            if namefile~=0
                [img,map]=imread(strcat(pathname,namefile));
                selezionato=1;
            else
                disp('Select a grayscale image');
            end
            if (any(namefile~=0) && (~isgray(img)))
                disp('Select a grayscale image');
                selezionato=0;
            end
        end
        
        immagine=double(img);% convert unsigned int format of image to double format
        
        if isa(img,'uint8')
            graylevmax=2^8-1;% set graylevel max value depending on number of bits needed to represent each pixel
        end
        if isa(img,'uint16')
            graylevmax=2^16-1;
        end
        if isa(img,'uint32')
            graylevmax=2^32-1;
        end
        fingerprint = immagine;% put image into fingerprint
        
        N=h_lato;
        
        [BinarizedPrint,XofCenter,YofCenter]=centralizing(fingerprint,0);%gabor filtered data and center coordinates are calculated
        [CroppedPrint]=cropping(XofCenter,YofCenter,fingerprint);%select desired part of image from last step 0f 175x175
        [NormalizedPrint,vector]=sector_norm(CroppedPrint,0);% normalization
        
        for (angle=0:1:num_disk-1)    
            gabor=gabor2d_sub(angle,num_disk);
            ComponentPrint=conv2fft(NormalizedPrint,gabor,'same');
            [disk,vector]=sector_norm(ComponentPrint,1);    
            finger_code1{angle+1}=vector(1:n_sectors);
        end
        
        
        img=imrotate(img,180/(num_disk*2));
        fingerprint=double(img);
        
        [BinarizedPrint,XofCenter,YofCenter]=centralizing(fingerprint,0);
        [CroppedPrint]=cropping(XofCenter,YofCenter,fingerprint);
        [NormalizedPrint,vector]=sector_norm(CroppedPrint,0);% same procedure as above
        
        for (angle=0:1:num_disk-1)    
            gabor=gabor2d_sub(angle,num_disk);
            ComponentPrint=conv2fft(NormalizedPrint,gabor,'same');
            [disk,vector]=sector_norm(ComponentPrint,1);    
            finger_code2{angle+1}=vector(1:n_sectors);
        end
        % FingerCode added to database
        if (exist('fp_database.dat')==2)
            load('fp_database.dat','-mat');
            fp_number=fp_number+1;
            data{fp_number,1}=finger_code1;
            data{fp_number,2}=finger_code2;
            save('fp_database.dat','data','fp_number','-append');
        else
            fp_number=1;
            data{fp_number,1}=finger_code1;
            data{fp_number,2}=finger_code2;
            save('fp_database.dat','data','fp_number');
        end
        
        message=strcat('FingerCode was succesfully added to database. Fingerprint no. ',num2str(fp_number));
        msgbox(message,'FingerCode DataBase','help');
    end
    %--------------------------------------------------------------------------
    %--------------------------------------------------------------------------
    %--------------------------------------------------------------------------
    % Fingerprint recognition
    if chos==2
        clc;
        close all;
        selezionato=0;
        while selezionato==0
            [namefile,pathname]=uigetfile({'*.bmp;*.tif;*.tiff;*.jpg;*.jpeg;*.gif','IMAGE Files (*.bmp,*.tif,*.tiff,*.jpg,*.jpeg,*.gif)'},'Chose GrayScale Image');
            if namefile~=0
                [img,map]=imread(strcat(pathname,namefile));
                selezionato=1;
            else
                disp('Select a grayscale image');
            end
            if (any(namefile~=0) && (~isgray(img)))
                disp('Select a grayscale image');
                selezionato=0;
            end
        end
        
        immagine=double(img);
        
        if isa(img,'uint8')
            graylevmax=2^8-1;
        end
        if isa(img,'uint16')
            graylevmax=2^16-1;
        end
        if isa(img,'uint32')
            graylevmax=2^32-1;
        end
        fingerprint = immagine;
        
        N=h_lato;
        
        [BinarizedPrint,XofCenter,YofCenter]=centralizing(fingerprint,0);
        [CroppedPrint]=cropping(XofCenter,YofCenter,fingerprint);
        [NormalizedPrint,vector]=sector_norm(CroppedPrint,0);
        
        % memoria per feature vector d'ingresso
        vettore_in=zeros(num_disk*n_sectors,1);
        for (angle=0:1:num_disk-1)    
            gabor=gabor2d_sub(angle,num_disk);
            ComponentPrint=conv2fft(NormalizedPrint,gabor,'same');
            [disk,vector]=sector_norm(ComponentPrint,1);    
            finger_code{angle+1}=vector(1:n_sectors);% filter data by rotating with different angles
            vettore_in(angle*n_sectors+1:(angle+1)*n_sectors)=finger_code{angle+1};
        end
        
        
        
        % FingerCode of input fingerprint has just been calculated.
        % Checking with DataBase
        if (exist('fp_database.dat')==2)
            load('fp_database.dat','-mat');
            %---- alloco memoria -----------------------------------
            %...
            vettore_a=zeros(num_disk*n_sectors,1);
            vettore_b=zeros(num_disk*n_sectors,1);
            best_matching=zeros(fp_number,1);
            valori_rotazione=zeros(n_arcs,1);
            % start checking ---------------------------------------
            for scanning=1:fp_number
                fcode1=data{scanning,1};
                fcode2=data{scanning,2};
                for rotazione=0:(n_arcs-1)
                    p1=fcode1;
                    p2=fcode2;
                    % ruoto i valori dentro disco
                    for conta_disco=1:num_disk
                        disco1=p1{conta_disco};
                        disco2=p2{conta_disco};
                        for old_pos=1:n_arcs
                            new_pos=mod(old_pos+rotazione,n_arcs);
                            if new_pos==0
                                new_pos=n_arcs;
                            end
                            for conta_bande=0:1:(n_bands-1)
                                disco1r(new_pos+conta_bande*n_arcs)=disco1(old_pos+conta_bande*n_arcs);
                                disco2r(new_pos+conta_bande*n_arcs)=disco2(old_pos+conta_bande*n_arcs);
                            end
                        end
                        p1{conta_disco}=disco1r;
                        p2{conta_disco}=disco2r;
                    end
                    % ruoto i dischi circolarmente
                    for old_disk=1:num_disk
                        new_disk=mod(old_disk+rotazione,num_disk);
                        if new_disk==0
                            new_disk=num_disk;
                        end
                        pos=old_disk-1;
                        vettore_a(pos*n_sectors+1:(pos+1)*n_sectors)=p1{new_disk};
                        vettore_b(pos*n_sectors+1:(pos+1)*n_sectors)=p2{new_disk};                    
                    end
                    d1=norm(vettore_a-vettore_in);
                    d2=norm(vettore_b-vettore_in);
                    if d1<d2
                        val_minimo=d1;
                    else
                        val_minimo=d2;
                    end
                    valori_rotazione(rotazione+1)=val_minimo;
                end
                [minimo,posizione_minimo]=min(valori_rotazione);
                best_matching(scanning)=minimo;
            end
            [distanza_minima,posizione_minimo]=min(best_matching);
            beep;
            message=strcat('The nearest fingerprint present in DataBase which matchs input fingerprint is  : ',num2str(posizione_minimo),...
                ' with a distance of : ',num2str(distanza_minima));
            msgbox(message,'DataBase Info','help');
            
        else
            message='DataBase is empty. No check is possible.';
            msgbox(message,'FingerCode DataBase Error','warn');    
        end
        
    end % fine caso 2
    if chos==3
        clc;
        close all;
        helpwin fprec;% show help contents for file if third choice is taken
    end % fine caso 3
    if chos==4
        clc;
        close all;
        if (exist('fp_database.dat')==2)
            button = questdlg('Do you really want to remove the Database?');
            if strcmp(button,'Yes')
                delete('fp_database.dat');
                msgbox('Database was succesfully removed from the current directory.','Database removed','help');% choice 4 = delete file
            end
        else
            warndlg('Database is empty.',' Warning ')
        end
    end % fine caso 4
    if chos==5
        clc;
        close all;
        selezionato=0;
        while selezionato==0
            [namefile,pathname]=uigetfile({'*.bmp;*.tif;*.tiff;*.jpg;*.jpeg;*.gif','IMAGE Files (*.bmp,*.tif,*.tiff,*.jpg,*.jpeg,*.gif)'},'Chose GrayScale Image');
            if namefile~=0
                [img,map]=imread(strcat(pathname,namefile));% show all images if 5th option is taken
                selezionato=1;
            else
                disp('Select a grayscale image');
            end
            if (any(namefile~=0) && (~isgray(img)))
                disp('Select a grayscale image');
                selezionato=0;
            end
        end
        figure('Name','Selected image');
        imshow(img);
    end % fine caso 5
    if chos==6
        clc;
        close all;
        figure('Name','Gabor Filter');
        mesh(gabor2d_sub(0,num_disk));% show response of filter
    end % fine caso 6
end % fine while