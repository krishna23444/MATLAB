function Finite_Dipole_Radiation_Pattern
clc;
clear;

%% Initialize LAMBDA and k.
lambda = 1;
k = 2 * pi / lambda;

%% Initialize figures. 
fig_CD = figure('Name','Current Distribution','NumberTitle','off');
fig_RP = figure('Name','Finite Dipole - Radiation Patterns','NumberTitle','off','Units','normalized','Position',[0.05 .05 .9 .85]);

%% Draw Control Panel.
panel_Handle = uipanel(fig_RP,'Position',[.40 .02 .55 .25],'Backgroundcolor','w','Units','normalized');

text_Pwr_Handle = uicontrol(panel_Handle,'Units','normalized','Position',[.03 .65 .5 .3],'Style','Text','String','Radiated Power = ','HorizontalAlignment','left','Fontsize',12,'FontWeight','bold','Backgroundcolor','w','Foregroundcolor','b');
text_RR_Handle = uicontrol(panel_Handle,'Units','normalized','Position',[.03 .40 .5 .3],'Style','Text','String','Radiation Resistance = ','HorizontalAlignment','left','Fontsize',12,'FontWeight','bold','Backgroundcolor','w','Foregroundcolor','b');
text_Dr_Handle = uicontrol(panel_Handle,'Units','normalized','Position',[.03 .15 .5 .3],'Style','Text','String','Directivity = ','HorizontalAlignment','left','Fontsize',12,'FontWeight','bold','Backgroundcolor','w','Foregroundcolor','b');

uicontrol(panel_Handle,'Units','normalized','Position',[.7 .45 .3 .5],'Style','Text','String','Maximum Current(in amps)','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r');
edit_I_Handle = uicontrol(panel_Handle,'Units','normalized','Position',[.725 .6 .2 .2],'Style','Edit','String','1.0','Fontsize',12,'Backgroundcolor','w','Callback',@editTextBox_maxI_Changed_Callback);

text_DL_Handle = uicontrol(panel_Handle,'Units','normalized','Position',[.73 .35 .13 .2],'Style','Text','String','Dipole Length','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r');
uicontrol(panel_Handle,'Units','normalized','Position',get(text_DL_Handle,'position') + [.13 .005 0 0],'Style','Text','String','(l)','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r','Fontname','symbol');
edit_DL_Handle = uicontrol(panel_Handle,'Units','normalized','Position',[.725 .23 .2 .2],'Style','Edit','String','1.0','Fontsize',12,'Backgroundcolor','w','Callback',@editTextBoxValueChanged_Callback);

sliderHandle = uicontrol(panel_Handle,'Max',10,'Min',0,'Value',0.5,'Units','normalized','Position',[0 0 1 .2],'Style','Slider','SliderStep',[0.01 0.05],'Callback',@sliderValueChanged_Callback);

%% Draw initial patterns.
DrawPatterns(0.5,1);

%% Function called when maximum current is changed.
    function editTextBox_maxI_Changed_Callback(hObject, eventdata, handles)
       DrawPatterns(str2double(get(edit_DL_Handle,'string')),str2double(get(hObject,'string')));
    end

%% Function called when dipole length is changed from the textbox.
    function editTextBoxValueChanged_Callback(hObject, eventdata, handles)
        set(sliderHandle,'Value', str2double(get(hObject,'string'))); 
        DrawPatterns(str2double(get(hObject,'string')),str2double(get(edit_I_Handle,'string')));
    end

%% Function called when dipole length is changed from the slider.
    function sliderValueChanged_Callback(hObject, eventdata, handles)
        DrawPatterns(get(hObject,'Value'),str2double(get(edit_I_Handle,'string')));
    end

%% Function for drawing all the plots.
    function DrawPatterns(dipoleLength, maxCurrent)
        l = dipoleLength;
        I_0 = maxCurrent;
        
        %% Calculate Radiated Power.
        U = @(theta) ((cos(k*l*cos(theta)/2)-cos(k*l/2)).^ 2 ) ./ sin(theta);
        Pr = 30 * quad(U,0,pi) * I_0^2;
        
        %% Calculate Maximum Radiation Intensity.
        theta = -pi : pi/100 : pi;
        U = (120*(I_0^2)/(8*pi) )* ( (cos(k*l*cos(theta)/2) - cos(k*l/2)) ./ sin(theta) ) .^ 2;
            
        %% Calculate Radiation Resistance.
        RadRes = 2*Pr/I_0^2;
        
        %% Calculate Directivity.
        Directivity = 4*pi*max(U)/Pr;
        Directivity_db = 10*log10(4*pi*max(U)/Pr);
        
        %% Update values.
        set(edit_DL_Handle,'string',num2str(l));
        set(text_Pwr_Handle,'string',['Radiated Power = ' num2str(Pr) ' W']);
        set(text_RR_Handle,'string',['Radiation Resistance = ' num2str(RadRes) ' OHM']);
        set(text_Dr_Handle,'string',['Directivity = ' num2str(Directivity) ' = ' num2str(Directivity_db) ' DB']);
       
        %% Plot Current Distribution.
        set(0,'CurrentFigure',fig_CD);
        I0 = 1;
        z1 = 0 : l/200 : l/2;
        I1 = I0 * sin(k * (l/2 - z1));

        z2 = -l/2 : l/200 : 0;
        I2 = I0 * sin(k * (l/2 + z2));
        
        plot([I2 I1], [z2 z1], 'r');
        title(['Current Distribution for Dipole of length, L = ' num2str(l) ' \lambda'],'FONTSIZE', 14);
        ylabel('Z - axis','FONTSIZE', 14);

        %% Plot Elevation & Azimuthal Plane Radiation Pattern.
        
        set(0,'CurrentFigure',fig_RP);
        theta = -pi : pi/100 : pi;
        phi = 0 : pi/100 : (2*pi);

        U = ( (cos(k*l*cos(theta)/2) - cos(k*l/2)) ./ sin(theta) ) .^ 2;
        U = U ./ max(U);  
        
        subplot(4,3,[1 4]);
        polar(theta,U,'r');
                
        set(gca,'View',[-90 90],'YDir','reverse');
        
        t_el = title(['Elevation (L = ' num2str(l) ' \lambda)'],'FONTSIZE', 14);
        t_pos = get(t_el,'position');
        t_pos(1) = t_pos(1) + 0.2;
        set(t_el,'position',t_pos) 
        
        theta = pi/2;
        U = ( (cos(k*l*cos(theta)/2) - cos(k*l/2)) ./ sin(theta) ) .^ 2;
        U = repmat(U,1,201);
        
        subplot(4,3,[7 10]);
        polar(phi,U,'r');
        set(gca,'View',[-90 90],'YDir','reverse');
        
        %% Plot 3D Radiation Pattern.
        theta = -pi : pi/100 : pi;
        [phi_3d,theta_3d] = meshgrid(phi,theta);

        U = abs( ( (cos(k*l*cos(theta_3d)/2) - cos(k*l/2)) ./ sin(theta_3d) ) .^ 2);
        U = U ./ max(max((U)));

        [X,Y,Z] = sph2cart(phi_3d,pi/2 - theta_3d, U);

        subplot(4,3,[2 3 5 6 8 9]);
        surf(X,Y,Z);

        title(['3D Radiation Pattern (L = ' num2str(l) ' \lambda)'],'FONTSIZE', 14);
    end
end