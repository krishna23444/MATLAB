function tdoaDemo
% TDOADEMO shows the effects of different baselines and timimg errors vs aoa
% further development: aoa comparison. between tdoa and interferometer
% TODO: Help file
close all
x=linspace(0,75,18);
y=linspace(0,1e-9,length(x));
d=12;
z=[];
for j=1:length(y)
    z(j,:)=tdoaerr([x],y(j),d);
end
%% Surface plot of aoa vs timing error
figure(1)
surf(x,y,z,'FaceColor','interp',...
 'EdgeColor','none',...
 'FaceLighting','phong')

%% Mesh plot of aoa vs timing error
figure(2)
mesh(x,y,z)
tit={'Error effects of AOA vs timing error'};
title(tit,'FontSize',12,'Interpreter', 'latex');
xlbl={'Arrival angle [$^\circ$]'};
xlabel(xlbl,'FontSize',12,'Interpreter', 'latex');
ylbl={'Timing error [s]'};
ylabel(ylbl,'FontSize',12,'Interpreter', 'latex');
zlbl={'Angular error [$^\circ$]'};
zlabel(zlbl,'FontSize',12,'Interpreter', 'latex');

%% Baseline vs aoa
angle=linspace(0,75,18);
timerr=linspace(1e-9,1e-9,length(angle));
baseline=linspace(5,15,length(angle));
angerr=[];
for j=1:length(baseline)
    angerr(j,:)=tdoaerr([angle],timerr(1),baseline(j));
end
% size(angle)
% size(timerr)
% size(angerr)
%% Mesh plot baseline vs aoa
figure(3)
mesh(angle,baseline,angerr)
tit={'Error effects of baseline vs aoa'};
title(tit,'FontSize',12,'Interpreter', 'latex');
xlbl={'Arrival angle [$^\circ$]'};
xlabel(xlbl,'FontSize',12,'Interpreter', 'latex');
ylbl={'Baseline [m]'};
ylabel(ylbl,'FontSize',12,'Interpreter', 'latex');
zlbl={'Angular error [$^\circ$]'};
zlabel(zlbl,'FontSize',12,'Interpreter', 'latex');

%% Mesh plot baseline vs aoa
figure(4)
surf(angerr)

%% Combined error
figure(5)
combinedError=z+angerr;
% gca
surf(combinedError)
tit={'Error effects of baseline and timing error combined'};
title(tit,'FontSize',12,'Interpreter', 'latex');
xlbl={'Arrival angle [$^\circ$]'};
xlabel(xlbl,'FontSize',12,'Interpreter', 'latex');
ylbl={'Baseline and timing error'};
ylabel(ylbl,'FontSize',12,'Interpreter', 'latex');
zlbl={'Angular error [$^\circ$]'};
zlabel(zlbl,'FontSize',12,'Interpreter', 'latex');

%% Two plots held on

% figure(6)
% hold on
% surf(z)
% surf(angerr)