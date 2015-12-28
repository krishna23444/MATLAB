function rgpoAnim()
% RGPOANIM  Visual animation of range gate pull out
% 
%   rgpoAnim()
% 
%   AIM: To demonstrate RGPO
% 
% TODO: Help

%% Initiate plot and time info

% number of frames to be animated
frames=4;
% time between frames (s)
wait=.01;
% movement resolution (how small the steps are between movements)
%  a higher number means more steps
res=1000;

% Initiate target info
tweight=0.4;
t=[4.75,-2,0.5,4];              % [xStart,yStart,width,height]
tx=t(1);
ty=t(2);
tw=t(3);
th=t(4);

% False target info
% ftx=[4.75,4.75,5.5,6.25];
ftweight=1-tweight;                   % weight of pulse for ratio calcs
ftx=linspace(4.75,6.75,res);    % x pos for left side of pulse
fty=-6;                         % y pos for bottom of pulse (-value as we 
                                 % we only want the top of the oval
ftw=0.5;                        % width of the pulse
fth=13;                         % height of the pulse

% Early gate info
% ex=[4,4,4,5.5];
ex=linspace(4,5.5,res);
ey=0;
ew=1;
eh=6;

% Late gate info
% lx=[5,5,5,6.5];
lx=linspace(5,6.5,res);
ly=0;
lw=1;
lh=6;

% Early gate bar info
ebx=9.1;
eby=0;
ebw=0.25;
% ebh=[2 5 2 5];
ebh=linspace(2,5,res);
ebhmax=7;               % Maximum height of the early gate ratio bar

% Late gate bar info
lbx=9.7;
lby=0;
lbw=0.25;
% lbh=[2 5 7 5];
lbh=linspace(2,7,res);
lbhmax=7;               % Maximum height of the late gate ratio bar

%% Initiate plot
% clear the figure
% clf
set(0,'Units','pixels')             % Sets units to pixels
screensize = get(0,'ScreenSize');   % Gets exact screen size of the computer
figure('Position',[screensize(1),screensize(2),...
    screensize(3),(screensize(4)-50)],'Name',...
    'Range Gate Pull Out Demonstration','NumberTitle','off')  
            % Generates fig. to occupy the whole screen size automatically
% found this tip at http://www.dsprelated.com/groups/matlab/show/1377.php

% axis limits
axis([2 10 0 8])
% false target
ftarg=rectangle('Position',[0,0,0.01,0.01],'Curvature',[1,1],'FaceColor','r');
% target
targ=rectangle('Position',t,'Curvature',[1,1],'FaceColor','g');
% early gate
earlgate=rectangle('Position',[4,0,1,6]);
% late gate
lategate=rectangle('Position',[5,0,1,6],'EdgeColor','b');
% gate ratio label
text(8.6,7.5,'Gate Ratio','FontSize',14);
% remove tick labels
set(gca,'XTickLabel',' ')
set(gca,'YTickLabel',' ')
hold on
% bar for early gate
earlbar=rectangle('Position',[9.1,0,0.25,2],'FaceColor','k');
% bar for late gate
latebar=rectangle('Position',[9.5,0,0.25,2],'FaceColor','b');
% Plot labels
%{
% Title uses too much processing power for some reason
title('Range Gate Pull Out Demonstration','Interpreter','Latex',...
    'fontsize',14,'fontweight','b')
%}
xlabel('Range','Interpreter','Latex','fontsize',12,'fontweight','b')
ylabel('Power','Interpreter','Latex','fontsize',12,'fontweight','b')

% begin animation
% for i=2:frames
% for i=2:res
for i=1:res
    % control animation speed
    if i==1
        pause(1)
    else
        pause(wait)
    end
    
    %---plot section
    % false targ pulse
    ftinfo=[ftx(i),fty,ftw,fth];
    set(ftarg,'Position',ftinfo)
    % early gate
    eginfo=[ex(i),ey,ew,eh];
    set(earlgate,'Position',eginfo)
    % late gate
    lginfo=[lx(i),ly,lw,lh];
    set(lategate,'Position',lginfo,'EdgeColor','b')
    % bar for early gate
    egbinfo=[ebx,eby,ebw,ebh(i)];
    set(earlbar,'Position',egbinfo,'FaceColor','k')
    % bar for late gate
    lgbinfo=[lbx,lby,lbw,lbh(i)];
    set(latebar,'Position',lgbinfo,'FaceColor','b')
    
    %---ratio calculation section    
    j=0;
    lcomp=1;
    ecomp=0;
    while((lcomp>ecomp*1.1)&&(j<100)) 
        j=j+1;
        % centre of both gates
        gc=lx(i);
        % taget ratio in early and late gates
        if (tx>ex(i)) && (tx+tw>gc) % portion of target in both gates
            teg=(gc-tx)/tw;
            tlg=1-teg;
        elseif (tx>ex(i)) && (tx+tw<gc) % all target in early gate
            teg=1;
            tlg=0;
        elseif (tx>ex(i)-tw) && (tx+tw<gc) % portion of target in early gate
            teg=(tx+tw-ex(i))/tw;
            tlg=0;
        else % not in either gate
            teg=0;
            tlg=0;
        end

        % false taget ratio in early and late gates
        if ~(ftx(i)>gc) % portion of target in both gates
            fteg=(gc-ftx(i))/tw;
            ftlg=1-fteg;
        else % all target in late gate
            fteg=0;
            ftlg=1;
        end
        ecomp=teg*tweight+fteg*ftweight;     % component of energy in early gate
        lcomp=tlg*tweight+ftlg*ftweight;     % component of energy in late gate
        %---ratio bar setting
        if j==1&&i<res
            if ecomp==0
                ebh(i+1)=0.1;
            else
                ebh(i+1)=ecomp*ebhmax;
            end
            if lcomp==0
                lbh(i+1)=0.1;
            else
                lbh(i+1)=lcomp*lbhmax;
            end
        end

        %--- gate centering section
        if lcomp>(ecomp*1.2)&&i<res&&teg>0
            %move the next gate start points to (current value)*1.2
            lx(i)=lx(i)+0.01;
            ex(i)=ex(i)+0.01;
        end        
    end
%     j
    % set early/late gates and bar ratios if only on false pulse
    if teg<=0&&i<res
        lx(i+1)=ftx(i)+ftw/2;
        ex(i+1)=ftx(i)+ftw/2-ew;
%         lbh(i+1)=ftweight*lbhmax;
%         ebh(i+1)=ftweight*ebhmax;
    else
        lx(i+1)=lx(i);
        ex(i+1)=ex(i);  
    end
end
hold off