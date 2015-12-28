function Array_Radiation_Pattern
clc;
clear;

%% Initialize figure. 
fig_RP = figure('Name','N-Element Linear Array - Radiation Patterns','NumberTitle','off','Units','normalized','Position',[0.05 .05 .9 .85]);

%% Draw Control Panel.
panel_Handle = uipanel(fig_RP,'Position',[0 0 1 .25],'Backgroundcolor','w','Units','normalized');

N_slider_Handle = uicontrol(panel_Handle,'SliderStep',[1/50 1/10],'Value',10,'Min',0,'Max',50,'Callback',@N_sliderValueChanged_Callback,'Units','normalized','Position',[0.15 .7 .45 .15],'Style','Slider');
d_slider_Handle = uicontrol(panel_Handle,'SliderStep',[0.01 0.1],'Value',0.25,'Min',0,'Max',1,'Callback',@d_sliderValueChanged_Callback,'Units','normalized','Position',[0.15 .4 .45 .15],'Style','Slider');
PS_slider_Handle = uicontrol(panel_Handle,'SliderStep',[1/360 1/36],'Value',0,'Min',-180,'Max',180,'Callback',@PS_sliderValueChanged_Callback,'Units','normalized','Position',[0.15 .1 .45 .15],'Style','Slider');

N_edit_Handle = uicontrol(panel_Handle,'Units','normalized','Position',get(N_slider_Handle, 'position') + [0.46 0 -0.37 0],'Style','Edit','String','10','Fontsize',10,'Backgroundcolor','w','Callback',@N_editValueChanged_Callback);
d_edit_Handle = uicontrol(panel_Handle,'Units','normalized','Position',get(d_slider_Handle, 'position') + [0.46 0 -0.37 0],'Style','Edit','String','0.25','Fontsize',10,'Backgroundcolor','w','Callback',@d_editValueChanged_Callback);
PS_edit_Handle = uicontrol(panel_Handle,'Units','normalized','Position',get(PS_slider_Handle, 'position') + [0.46 0 -0.37 0],'Style','Edit','String','0','Fontsize',10,'Backgroundcolor','w','Callback',@PS_editValueChanged_Callback);

uicontrol(panel_Handle,'Units','normalized','Position',get(N_slider_Handle,'position') + [-0.1 -0.035 -0.36 0] ,'Style','Text','String','Total Elements, N','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r');
uicontrol(panel_Handle,'Units','normalized','Position',get(d_slider_Handle,'position') + [-0.1 -0.035 -0.36 0] ,'Style','Text','String','Dipole Spacing, d','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r');
uicontrol(panel_Handle,'Units','normalized','Position',get(PS_slider_Handle,'position') + [-0.095 -0.035 -0.36 0] ,'Style','Text','String','Phase Shift, PHI','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r');

uicontrol(panel_Handle,'Units','normalized','Position',get(d_edit_Handle,'position') + [.085 -0.02 0 0],'Style','Text','String','(l)','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r','Fontname','symbol');
uicontrol(panel_Handle,'Units','normalized','Position',get(PS_edit_Handle,'position') + [.085 -0.02 0 0],'Style','Text','String','(deg)','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r');

Pwr_text_Handle = uicontrol(panel_Handle,'Units','normalized','Position',[.75 .60 .5 .3],'Style','Text','String','Radiated Power = ','HorizontalAlignment','left','Fontsize',12,'FontWeight','bold','Backgroundcolor','w','Foregroundcolor','b');
Dr_text_Handle = uicontrol(panel_Handle,'Units','normalized','Position',[.75 .4 .5 .3],'Style','Text','String','Directivity = ','HorizontalAlignment','left','Fontsize',12,'FontWeight','bold','Backgroundcolor','w','Foregroundcolor','b');

%% Draw initial patterns.
DrawPatterns(10,0.25,0);

%% Function called when number of elements 'N' are changed from edit box.
    function N_editValueChanged_Callback(hObject, eventdata, handles)
        set(N_slider_Handle,'Value',str2double(get(hObject,'String'))); 
        DrawPatterns(get(N_slider_Handle,'Value'),get(d_slider_Handle,'Value'),get(PS_slider_Handle,'Value'));
    end

%% Function called when spacing 'd' between two elements is changed from edit box.
    function d_editValueChanged_Callback(hObject, eventdata, handles)
        set(d_slider_Handle,'Value',str2double(get(hObject,'String'))); 
        DrawPatterns(get(N_slider_Handle,'Value'),get(d_slider_Handle,'Value'),get(PS_slider_Handle,'Value'));
    end

%% Function called when current phase shift 'PS' is changed from edit box.
    function PS_editValueChanged_Callback(hObject, eventdata, handles)
        set(PS_slider_Handle,'Value',str2double(get(hObject,'String'))); 
        DrawPatterns(get(N_slider_Handle,'Value'),get(d_slider_Handle,'Value'),get(PS_slider_Handle,'Value'));
    end

%% Function called when number of elements 'N' are changed from the slider.
    function N_sliderValueChanged_Callback(hObject, eventdata, handles)
        set(N_edit_Handle,'String',num2str(get(hObject,'Value'))); 
        DrawPatterns(get(N_slider_Handle,'Value'),get(d_slider_Handle,'Value'),get(PS_slider_Handle,'Value'));
     end

%% Function called when spacing 'd' between two elements is changed from the slider.
    function d_sliderValueChanged_Callback(hObject, eventdata, handles)
        set(d_edit_Handle,'String',num2str(get(hObject,'Value'))); 
        DrawPatterns(get(N_slider_Handle,'Value'),get(d_slider_Handle,'Value'),get(PS_slider_Handle,'Value'));
     end

%% Function called when current phase shift 'PS' is changed from the slider.
    function PS_sliderValueChanged_Callback(hObject, eventdata, handles)
        set(PS_edit_Handle,'String',num2str(get(hObject,'Value'))); 
        DrawPatterns(get(N_slider_Handle,'Value'),get(d_slider_Handle,'Value'),get(PS_slider_Handle,'Value'));
    end

%% Function for drawing all the plots.
    function DrawPatterns(numberOfElements, dipoleSpacing, phaseShift)
        N = numberOfElements;
        d = dipoleSpacing;
        PHI = phaseShift * pi / 180;
        k = 2 * pi;
        
        %% Calculate Radiated Power.
        U = @(theta) (( sin( (N/2) * (k * d * cos(theta) + PHI) ) ./ ( (N/2) * (k * d * cos(theta) + PHI) ) ) .^2) .* sin(theta);
        Pr = 2 * pi * quad(U,0,pi);
        if isnan(Pr)
            PHI = PHI + 0.0000001;
            U = @(theta) (( sin( (N/2) * (k * d * cos(theta) + PHI) ) ./ ( (N/2) * (k * d * cos(theta) + PHI) ) ) .^2) .* sin(theta);
            Pr = 2 * pi * quad(U,0,pi);
        end
                
        %% Calculate Directivity.
        Directivity = 4 * pi /Pr;
        Directivity_db = 10 * log10(Directivity);
        
        %% Update values.
        set(Pwr_text_Handle,'string',['Radiated Power = ' num2str(Pr) ' W']);
        set(Dr_text_Handle,'string',['Directivity = ' num2str(Directivity) ' = ' num2str(Directivity_db) ' DB']);
       
        %% Plot 2D Radiation Pattern.
        
        set(0,'CurrentFigure',fig_RP);
        theta = -pi : pi/100 : pi;
        
        AF = abs( ( sin( (N/2) * (k * d * cos(theta) + PHI) ) ./ ( (N/2) * (k * d * cos(theta) + PHI) ) ) );
        AF = AF ./ max(AF);  
        
        subplot(4,2,[1 3 5]);
        polar(theta,AF,'r');
                
        set(gca,'View',[-90 90],'YDir','reverse');
                             
        %% Plot 3D Radiation Pattern.
        theta = -pi : pi/100 : pi;
        phi = 0 : pi/100 : (2*pi);

        [phi_3d,theta_3d] = meshgrid(phi,theta);

        AF = abs( ( sin( (N/2) * (k * d * cos(theta_3d) + PHI) ) ./ ( (N/2) * (k * d * cos(theta_3d) + PHI) ) ) );
        AF = AF ./ max(max((AF)));

        [X,Y,Z] = sph2cart(phi_3d,pi/2 - theta_3d, AF);

        subplot(4,2,[2 4 6]);
        surf(X,Y,Z);      
    end
end