function Dolph_Tschebyscheff_Array_Radiation_Pattern
clc;
clear;

%% Initialize figure. 
fig_RP = figure('Name','Dolph Tschebyscheff N-Element Linear Array - Radiation Patterns','NumberTitle','off','Units','normalized','Position',[0.05 .05 .9 .85]);

%% Draw Control Panel.
panel_Handle = uipanel(fig_RP,'Position',[0 0 1 .25],'Backgroundcolor','w','Units','normalized');

N_slider_Handle = uicontrol(panel_Handle,'SliderStep',[1/48 1/4.8],'Value',10,'Min',2,'Max',50,'Callback',@N_sliderValueChanged_Callback,'Units','normalized','Position',[0.15 .7 .45 .15],'Style','Slider');
d_slider_Handle = uicontrol(panel_Handle,'SliderStep',[0.01 0.1],'Value',0.25,'Min',0,'Max',5,'Callback',@d_sliderValueChanged_Callback,'Units','normalized','Position',[0.15 .4 .45 .15],'Style','Slider');
SLL_slider_Handle = uicontrol(panel_Handle,'SliderStep',[1/180 1/18],'Value',26,'Min',0,'Max',180,'Callback',@SLL_sliderValueChanged_Callback,'Units','normalized','Position',[0.15 .1 .45 .15],'Style','Slider');

N_edit_Handle = uicontrol(panel_Handle,'Units','normalized','Position',get(N_slider_Handle, 'position') + [0.46 0 -0.37 0],'Style','Edit','String','10','Fontsize',10,'Backgroundcolor','w','Callback',@N_editValueChanged_Callback);
d_edit_Handle = uicontrol(panel_Handle,'Units','normalized','Position',get(d_slider_Handle, 'position') + [0.46 0 -0.37 0],'Style','Edit','String','0.25','Fontsize',10,'Backgroundcolor','w','Callback',@d_editValueChanged_Callback);
SLL_edit_Handle = uicontrol(panel_Handle,'Units','normalized','Position',get(SLL_slider_Handle, 'position') + [0.46 0 -0.37 0],'Style','Edit','String','26','Fontsize',10,'Backgroundcolor','w','Callback',@SLL_editValueChanged_Callback);

uicontrol(panel_Handle,'Units','normalized','Position',get(N_slider_Handle,'position') + [-0.1 -0.035 -0.36 0] ,'Style','Text','String','Total Elements, N','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r');
uicontrol(panel_Handle,'Units','normalized','Position',get(d_slider_Handle,'position') + [-0.1 -0.035 -0.36 0] ,'Style','Text','String','Dipole Spacing, d','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r');
uicontrol(panel_Handle,'Units','normalized','Position',get(SLL_slider_Handle,'position') + [-0.1 -0.035 -0.36 0] ,'Style','Text','String','Side Lobe Level','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r');

uicontrol(panel_Handle,'Units','normalized','Position',get(d_edit_Handle,'position') + [.085 -0.02 0 0],'Style','Text','String','(l)','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r','Fontname','symbol');
uicontrol(panel_Handle,'Units','normalized','Position',get(SLL_edit_Handle,'position') + [.085 -0.02 0 0],'Style','Text','String','(db)','HorizontalAlignment','left','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','r');

EC_listbox_Handle = uicontrol(panel_Handle,'Units','normalized','Position',get(N_edit_Handle,'position') + [.12 -0.6 .1 .5],'Style','Listbox','Fontsize',12,'Backgroundcolor','w');
uicontrol(panel_Handle,'Units','normalized','Position',get(EC_listbox_Handle,'position') + [0 0.67 0 -0.5],'Style','Text','String','Excitation Coefficients','HorizontalAlignment','center','Fontsize',12,'Backgroundcolor','w','Foregroundcolor','r');

%% Draw initial patterns.
DrawPatterns(10,0.25,26);

%% Function called when number of elements 'N' are changed from edit box.
    function N_editValueChanged_Callback(hObject, eventdata, handles)
        set(N_slider_Handle,'Value',str2double(get(hObject,'String'))); 
        DrawPatterns(floor(get(N_slider_Handle,'Value')),get(d_slider_Handle,'Value'),get(SLL_slider_Handle,'Value'));
    end

%% Function called when spacing 'd' between two elements is changed from edit box.
    function d_editValueChanged_Callback(hObject, eventdata, handles)
        set(d_slider_Handle,'Value',str2double(get(hObject,'String'))); 
        DrawPatterns(floor(get(N_slider_Handle,'Value')),get(d_slider_Handle,'Value'),get(SLL_slider_Handle,'Value'));
    end

%% Function called when Side Lobe Level 'R0' is changed from edit box.
    function SLL_editValueChanged_Callback(hObject, eventdata, handles)
        set(SLL_slider_Handle,'Value',str2double(get(hObject,'String'))); 
        DrawPatterns(floor(get(N_slider_Handle,'Value')),get(d_slider_Handle,'Value'),get(SLL_slider_Handle,'Value'));
    end

%% Function called when number of elements 'N' are changed from the slider.
    function N_sliderValueChanged_Callback(hObject, eventdata, handles)
        set(N_edit_Handle,'String',num2str(get(hObject,'Value'))); 
        if floor(get(N_slider_Handle,'Value')) >= 2
            DrawPatterns(floor(get(N_slider_Handle,'Value')),get(d_slider_Handle,'Value'),get(SLL_slider_Handle,'Value'));
        end
     end

%% Function called when spacing 'd' between two elements is changed from the slider.
    function d_sliderValueChanged_Callback(hObject, eventdata, handles)
        set(d_edit_Handle,'String',num2str(get(hObject,'Value'))); 
        DrawPatterns(floor(get(N_slider_Handle,'Value')),get(d_slider_Handle,'Value'),get(SLL_slider_Handle,'Value'));
     end

%% Function called when Side Lobe Level 'R0' is changed from the slider.
    function SLL_sliderValueChanged_Callback(hObject, eventdata, handles)
        set(SLL_edit_Handle,'String',num2str(get(hObject,'Value'))); 
        DrawPatterns(floor(get(N_slider_Handle,'Value')),get(d_slider_Handle,'Value'),get(SLL_slider_Handle,'Value'));
    end

%% Function to get Tschebyscheff Polynomial.
    function Tm = Tschebyscheff_Polynomial(m)
        t0 = 1;
        t1 = [1 0];
        if m == 0
            Tm = t0;
        elseif m == 1;
            Tm = t1;
        else
            for k = 2 : m 
                Tm = [2*t1 0] - [0 0 t0];
                t0 = t1;
                t1 = Tm;
            end
        end
    end

%% Function for drawing all the plots.
    function DrawPatterns(numberOfElements, dipoleSpacing, sideLobeLevel)
        N = numberOfElements;
        d = dipoleSpacing;
        R0_db = sideLobeLevel;
              
        %% Step 1 - Determine the Array Factor 'AF' type - ODD or EVEN.
        
        if mod(N,2) == 0
            M = N/2;
            n = 1 : 1 : M; 
        else
            M = (N-1)/2;
            n = 1 : 1 : M + 1;
        end

        AF = 2*n - 1;

        %% Step 2 - Determine the 'z0' from 'R0'.
        
        R0 = 10^(R0_db/20);
        z0 = cosh( ( 1/(N-1) ) * acosh(R0) );

        %% Step 3 - Substitute 'z0' in 'AF'.
        
        AFn = Tschebyscheff_Polynomial(AF(1));
        for k = 2 : max(n)
            Tmk = Tschebyscheff_Polynomial(AF(k));
            AFn = [zeros(size(AFn,1) , length(Tmk) - length(AFn)) AFn ; Tmk];
        end

        for k = 1 : length(AFn)
            AFn(:,k) = AFn(:,k) ./ ( z0^( length(AFn) - k ) );
        end

       %% Step 4 - Determine the Excitation Coefficients 'excitationCoeffs'.

        TmAF = Tschebyscheff_Polynomial(N-1);

        excitationCoeffs = zeros(1,length(AFn));
        count = max(n);

        for k = 1 : length(AFn)
            colSum = sum( AFn(:,k) );
            if colSum ~= 0
                excitationCoeffs(k) = ( TmAF(k) - sum( AFn(count+1:end ,k) ) ) / AFn(count ,k);
                AFn(count,:) = AFn(count,:) .* excitationCoeffs(k);  
                count = count - 1;
            end
        end

        excitationCoeffs = excitationCoeffs ./ max(excitationCoeffs);
        AFn = excitationCoeffs;

        excitationCoeffs(excitationCoeffs == 0) = [];
                       
        Ec = '';
        for k = 1 : length(excitationCoeffs)
            Ec = strvcat(Ec, ['a' num2str(k) ' = ' num2str(excitationCoeffs(k))]);
        end
        set(EC_listbox_Handle,'String',Ec);
       
        %% Plot 2D Radiation Pattern.
        
        set(0,'CurrentFigure',fig_RP);
        theta = -pi : pi/100 : pi;
        
        u = (pi * d) * cos(theta);

        AF = 0;
        for k = 1 : length(AFn)
            if AFn(k) ~= 0
                AF = AF + ( AFn(k) .* cos(k .* u) );
            end
        end

        AF = AF ./ max(AF);
        
        subplot(4,2,[1 3 5]);
        polar(theta,AF,'r');
                
        set(gca,'View',[-90 90],'YDir','reverse');
                             
        %% Plot 3D Radiation Pattern.
        theta = -pi : pi/100 : pi;
        phi = 0 : pi/100 : (2*pi);

        [phi_3d,theta_3d] = meshgrid(phi,theta);
 
        u = (pi * d) * cos(theta_3d);

        AF = 0;
        for k = 1 : length(AFn)
            if AFn(k) ~= 0
                AF = AF + ( AFn(k) .* cos(k .* u) );
            end
        end

        AF = AF ./ max(max(AF));
        [X,Y,Z] = sph2cart(phi_3d,pi/2 - theta_3d, AF);

        subplot(4,2,[2 4 6]);
        surf(X,Y,Z);      
    end    
end