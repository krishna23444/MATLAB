function FIR_Filter_Window_Method
    clc;
    clear;
   
    %% Initialize figure. 
    fig_FIR = figure('Name','FIR Filters using Window Method','NumberTitle','off','Units','normalized','Position',[0.05 .05 .9 .85]);

    %% Draw Control Panel.
    mainPanel_Handle = uipanel(fig_FIR,'Units','normalized','Position',[0 0 1 .25],'Backgroundcolor','w');

    filterTypeButtonGroup_Handle = uibuttongroup(mainPanel_Handle,'Title','Filter Type','Units','normalized','Position',[0.01 0.03 0.1 0.9],'Backgroundcolor','w','SelectionChangeFcn',@filterTypeButtonGroup_SelectionChangeFcn);
    LP_RB_Handle = uicontrol(filterTypeButtonGroup_Handle,'String','Low Pass','Value',1,'Units','normalized','Position',[0.1 .85 0.9 .1],'Style','RadioButton','Backgroundcolor','w','Tag','LP');
    HP_RB_Handle = uicontrol(filterTypeButtonGroup_Handle,'String','High Pass','Value',0,'Units','normalized','Position',[0.1 .60 0.9 .1],'Style','RadioButton','Backgroundcolor','w','Tag','HP');
    BP_RB_Handle = uicontrol(filterTypeButtonGroup_Handle,'String','Band Pass','Value',0,'Units','normalized','Position',[0.1 .35 0.9 .1],'Style','RadioButton','Backgroundcolor','w','Tag','BP');
    BR_RB_Handle = uicontrol(filterTypeButtonGroup_Handle,'String','Band Reject','Value',0,'Units','normalized','Position',[0.1 .1 0.9 .1],'Style','RadioButton','Backgroundcolor','w','Tag','BR');

    filterSpecificationsPanel_Handle = uipanel(mainPanel_Handle,'Title','Filter Specifications','Units','normalized','Position',get(filterTypeButtonGroup_Handle, 'position') + [0.11 0 0.53 0],'Backgroundcolor','w');
    Fs_text_Handle = uicontrol(filterSpecificationsPanel_Handle,'String','Sampling Frequency, Fs (Hz)','Units','normalized','Position',[0 0.75 0.3 0.15],'HorizontalAlignment','Right','Style','Text','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','b');
    fp1_text_Handle = uicontrol(filterSpecificationsPanel_Handle,'String','Passband Edge Frequency, fp (Hz)','Units','normalized','Position',[0 0.45 0.3 0.15],'HorizontalAlignment','Right','Style','Text','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','b');
    As_text_Handle = uicontrol(filterSpecificationsPanel_Handle,'String','Stopband Attenuation, As (db)','Units','normalized','Position',[0 0.15 0.3 0.15],'HorizontalAlignment','Right','Style','Text','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','b');

    tw_text_Handle = uicontrol(filterSpecificationsPanel_Handle,'String','Transition Width (Hz)','Units','normalized','Position',[0.45 0.75 0.3 0.15],'HorizontalAlignment','Right','Style','Text','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','b');
    fp2_text_Handle = uicontrol(filterSpecificationsPanel_Handle,'String','Passband Frequency, fp2 (Hz)','Units','normalized','Position',[0.45 0.45 0.3 0.15],'HorizontalAlignment','Right','Style','Text','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','b','Visible','off');
    Ap_text_Handle = uicontrol(filterSpecificationsPanel_Handle,'String','Passband Ripple, Ap (db)','Units','normalized','Position',[0.45 0.15 0.3 0.15],'HorizontalAlignment','Right','Style','Text','Fontsize',10,'Backgroundcolor','w','Foregroundcolor','b');

    Fs_edit_Handle = uicontrol(filterSpecificationsPanel_Handle,'Units','normalized','Position',get(Fs_text_Handle,'position') + [0.31 0 -0.15 0],'Style','Edit','String','8000','Fontsize',10,'Backgroundcolor','w','Callback',@editValueChanged_Callback);
    fp1_edit_Handle = uicontrol(filterSpecificationsPanel_Handle,'Units','normalized','Position',get(fp1_text_Handle,'position') + [0.31 0 -0.15 0],'Style','Edit','String','1500','Fontsize',10,'Backgroundcolor','w','Callback',@editValueChanged_Callback);
    As_edit_Handle = uicontrol(filterSpecificationsPanel_Handle,'Units','normalized','Position',get(As_text_Handle,'position') + [0.31 0 -0.15 0],'Style','Edit','String','20','Fontsize',10,'Backgroundcolor','w','Callback',@As_editValueChanged_Callback);

    tw_edit_Handle = uicontrol(filterSpecificationsPanel_Handle,'Units','normalized','Position',get(tw_text_Handle,'position') + [0.31 0 -0.15 0],'Style','Edit','String','500','Fontsize',10,'Backgroundcolor','w','Callback',@editValueChanged_Callback);
    fp2_edit_Handle = uicontrol(filterSpecificationsPanel_Handle,'Units','normalized','Position',get(fp2_text_Handle,'position') + [0.31 0 -0.15 0],'Style','Edit','String','0','Fontsize',10,'Backgroundcolor','w','Callback',@editValueChanged_Callback,'Visible','off');
    Ap_edit_Handle = uicontrol(filterSpecificationsPanel_Handle,'Units','normalized','Position',get(Ap_text_Handle,'position') + [0.31 0 -0.15 0],'Style','Edit','String','0.1','Fontsize',10,'Backgroundcolor','w','Callback',@editValueChanged_Callback);

    windowTypeButtonGroup_Handle = uibuttongroup(mainPanel_Handle,'Title','Window Type','Units','normalized','Position',get(filterSpecificationsPanel_Handle, 'position') + [0.64 0 -0.52 0],'Backgroundcolor','w','SelectionChangeFcn',@windowTypeButtonGroup_SelectionChangeFcn);
    Rect_RB_Handle = uicontrol(windowTypeButtonGroup_Handle,'String','Rectangular','Value',1,'Units','normalized','Position',[0.15 .85 0.85 .1],'Style','RadioButton','Backgroundcolor','w','Tag','Rectangular');
    Hanning_RB_Handle = uicontrol(windowTypeButtonGroup_Handle,'String','Hanning','Value',0,'Units','normalized','Position',[0.15 .65 0.85 .1],'Style','RadioButton','Backgroundcolor','w','Tag','Hanning');
    Hamming_RB_Handle = uicontrol(windowTypeButtonGroup_Handle,'String','Hamming','Value',0,'Units','normalized','Position',[0.15 .45 0.85 .1],'Style','RadioButton','Backgroundcolor','w','Tag','Hamming');
    Blackman_RB_Handle = uicontrol(windowTypeButtonGroup_Handle,'String','Blackman','Value',0,'Units','normalized','Position',[0.15 .25 0.85 .1],'Style','RadioButton','Backgroundcolor','w','Tag','Blackman');
    Kaiser_RB_Handle = uicontrol(windowTypeButtonGroup_Handle,'String','Kaiser','Value',0,'Units','normalized','Position',[0.15 .05 0.85 .1],'Style','RadioButton','Backgroundcolor','w','Tag','Kaiser');

    plotTypeButtonGroup_Handle = uibuttongroup(mainPanel_Handle,'Title','Plot','Units','normalized','Position',get(windowTypeButtonGroup_Handle, 'position') + [0.12 0 0 0],'Backgroundcolor','w','SelectionChangeFcn',@plotTypeButtonGroup_SelectionChangeFcn);
    Frequency_RB_Handle = uicontrol(plotTypeButtonGroup_Handle,'String','Frequency','Value',1,'Units','normalized','Position',[0.15 .85 0.85 .1],'Style','RadioButton','Backgroundcolor','w');
    Time_RB_Handle = uicontrol(plotTypeButtonGroup_Handle,'String','Time','Value',0,'Units','normalized','Position',[0.15 .65 0.85 .1],'Style','RadioButton','Backgroundcolor','w');
    FrequencyAndTime_RB_Handle = uicontrol(plotTypeButtonGroup_Handle,'String','Both','Value',0,'Units','normalized','Position',[0.15 .45 0.85 .1],'Style','RadioButton','Backgroundcolor','w');

    %% Plot initial Filter Response.
    PlotResponse();
    
    %% Function called when Filter Type is changed.
    function filterTypeButtonGroup_SelectionChangeFcn(hObject,eventdata)
        switch get(eventdata.NewValue,'Tag')
            case 'LP'
                set(fp2_edit_Handle,'Visible','off');
                set(fp2_text_Handle,'Visible','off');
                set(fp1_text_Handle,'String','Passband Edge Frequency, fp (Hz)');
            case 'HP'
                set(fp2_edit_Handle,'Visible','off');
                set(fp2_text_Handle,'Visible','off');
                set(fp1_text_Handle,'String','Passband Edge Frequency, fp (Hz)');
            case 'BP'
                set(fp2_edit_Handle,'Visible','on');
                set(fp2_text_Handle,'Visible','on');
                set(fp1_text_Handle,'String', 'Passband Frequency, fp1 (Hz)');
            case 'BR'
                set(fp2_edit_Handle,'Visible','on');
                set(fp2_text_Handle,'Visible','on');
                set(fp1_text_Handle,'String', 'Passband Frequency, fp1 (Hz)');
            otherwise
                %Do Nothing.
        end
        PlotResponse();
    end
    
    %% Function called when Window Type is changed.
    function windowTypeButtonGroup_SelectionChangeFcn(hObject,eventdata)
        PlotResponse();
    end

    %% Function called when Stopband Attenuation, As is changed.
    function As_editValueChanged_Callback(hObject, eventdata, handles)
        As =  str2double(get(As_edit_Handle,'String'));
        if As < 0 
            set(Rect_RB_Handle,'Enable','Off');
            set(Hanning_RB_Handle,'Enable','Off');
            set(Hamming_RB_Handle,'Enable','Off');
            set(Blackman_RB_Handle,'Enable','Off');
            set(Kaiser_RB_Handle,'Enable','Off');
            set(Rect_RB_Handle,'Value',0); 
            set(Hanning_RB_Handle,'Value',0);
            set(Hamming_RB_Handle,'Value',0);
            set(Blackman_RB_Handle,'Value',0);
            set(Kaiser_RB_Handle,'Value',0);
        elseif As <= 21
            set(Rect_RB_Handle,'Enable','On');
            set(Hanning_RB_Handle,'Enable','On');
            set(Hamming_RB_Handle,'Enable','On');
            set(Blackman_RB_Handle,'Enable','On');
            set(Kaiser_RB_Handle,'Enable','On');
            set(Rect_RB_Handle,'Value',1);
        elseif As <= 44
            set(Rect_RB_Handle,'Enable','Off');
            set(Hanning_RB_Handle,'Enable','On');
            set(Hamming_RB_Handle,'Enable','On');
            set(Blackman_RB_Handle,'Enable','On');
            set(Kaiser_RB_Handle,'Enable','On');
            set(Hanning_RB_Handle,'Value',1);
        elseif As <= 53
            set(Rect_RB_Handle,'Enable','Off');
            set(Hanning_RB_Handle,'Enable','Off');
            set(Hamming_RB_Handle,'Enable','On');
            set(Blackman_RB_Handle,'Enable','On');
            set(Kaiser_RB_Handle,'Enable','On');
            set(Hamming_RB_Handle,'Value',1);
        elseif As <= 75
            set(Rect_RB_Handle,'Enable','Off');
            set(Hanning_RB_Handle,'Enable','Off');
            set(Hamming_RB_Handle,'Enable','Off');
            set(Blackman_RB_Handle,'Enable','On');
            set(Kaiser_RB_Handle,'Enable','On');
            set(Blackman_RB_Handle,'Value',1);
        elseif As <= 90
            set(Rect_RB_Handle,'Enable','Off');
            set(Hanning_RB_Handle,'Enable','Off');
            set(Hamming_RB_Handle,'Enable','Off');
            set(Blackman_RB_Handle,'Enable','Off');
            set(Kaiser_RB_Handle,'Enable','On');
            set(Kaiser_RB_Handle,'Value',1);
        else
            set(Rect_RB_Handle,'Enable','Off');
            set(Hanning_RB_Handle,'Enable','Off');
            set(Hamming_RB_Handle,'Enable','Off');
            set(Blackman_RB_Handle,'Enable','Off');
            set(Kaiser_RB_Handle,'Enable','Off');
            set(Rect_RB_Handle,'Value',0); 
            set(Hanning_RB_Handle,'Value',0);
            set(Hamming_RB_Handle,'Value',0);
            set(Blackman_RB_Handle,'Value',0);
            set(Kaiser_RB_Handle,'Value',0);
        end
        PlotResponse();
    end

    %% Function called when any of the filter specifications is changed.
    function editValueChanged_Callback(hObject, eventdata, handles)
        PlotResponse();
    end

    %% Function called when Plot Type is changed.
    function plotTypeButtonGroup_SelectionChangeFcn(hObject,eventdata)
        PlotResponse();
    end

    %% Function for plotting Filter response.
    function PlotResponse()
        fs = str2double(get(Fs_edit_Handle,'String'));
        fp1 = str2double(get(fp1_edit_Handle,'String')) / fs;
        fp2 = str2double(get(fp2_edit_Handle,'String')) / fs;
        tw = str2double(get(tw_edit_Handle,'String')) / fs;
        As = str2double(get(As_edit_Handle,'String'));
        Ap = str2double(get(Ap_edit_Handle,'String'));

        wn = 0;
        N = 0;
        hn = 0;
        hn_f = 0;
        
        fig_title = '';
       
        try
            if get(Rect_RB_Handle,'Value') == 1
                N = 0.9 / tw;
                N = floor(N);
                if mod(N,2) == 0
                    N = N + 1;
                else
                    N = N + 2;
                end
                wn = ones(1,N);
                fig_title = 'Rectangular Window';
            elseif get(Hanning_RB_Handle,'Value') == 1
                N = 3.1 / tw;
                N = floor(N);
                if mod(N,2) == 0
                    N = N + 1;
                else
                    N = N + 2;
                end
                n = -(N-1)/2 : 1 : (N - 1)/2;
                wn = 0.5 + 0.5 * cos(2 * pi * n / N);
                fig_title = 'Hanning Window';
            elseif get(Hamming_RB_Handle,'Value') == 1
                N = 3.3 / tw;
                N = floor(N);
                if mod(N,2) == 0
                    N = N + 1;
                else
                    N = N + 2;
                end
                n = -(N-1)/2 : 1 : (N - 1)/2;
                wn = 0.54 + 0.46 * cos(2 * pi * n / N);
                fig_title = 'Hamming Window';
            elseif get(Blackman_RB_Handle,'Value') == 1
                N = 5.5 / tw;
                N = floor(N);
                if mod(N,2) == 0
                    N = N + 1;
                else
                    N = N + 2;
                end
                n = -(N-1)/2 : 1 : (N - 1)/2;
                wn = 0.42 + 0.5 * cos(2 * pi * n /(N - 1)) + 0.08 * cos(4 * pi * n /(N - 1));
                fig_title = 'Blackman Window';
            elseif get(Kaiser_RB_Handle,'Value') == 1
                deltaP = (10^(Ap/20)) - 1;
                deltaS = (10^(-As/20));
                A = -20 * log10( min(deltaP,deltaS) );
                
                BETA = 0;
                
                if A <= 21
                    BETA = 0;
                elseif As < 50
                    BETA = 0.5842 * ( ( A - 21)^0.4 ) + 0.07886 * (A - 21); 
                elseif As >= 50
                    BETA = 0.1102 * ( A - 8.7);
                end

                N = floor( (A - 7.95) / (14.36 * tw) );
                               
                if mod(N,2) == 0
                    N = N + 1;
                else
                    N = N + 2;
                end
                
                k = 1 : 1 : 20;
                I_0_BETA = zeros(1,N);
                count = 1;
                for n = -(N-1)/2 : 1 : (N - 1)/2
                    I_0_BETA(count) = 1 + sum (((((BETA .* sqrt(  1 - (2*n ./ (N-1)).^2 )) /2).^k) ./ factorial(k)).^2);
                    count = count + 1;
                end

                I_BETA = 1 + sum((((BETA/2).^k)./factorial(k)).^2);

                wn = I_0_BETA / I_BETA;
                
                fig_title = 'Kaiser Window';
            else
                fig_title = 'ERROR - Wrong Filter Specifications.';
                title(fig_title,'FONTSIZE',14);
                return;
            end

            if get(LP_RB_Handle,'Value') == 1 
                fc = fp1 + tw/2;
                
                n = -(N-1)/2 : 1 : -1;
                hD1 = 2*fc*sin(n*2*pi*fc) ./ (n*2*pi*fc);

                n = 1 : 1 : (N-1)/2;
                hD2 = 2*fc*sin(n*2*pi*fc) ./ (n*2*pi*fc);

                hD = [hD1 2*fc hD2];

                hn = hD .* wn;

                hn_f = 20 * log10( abs( fft(hn,fs) / max(fft(hn,fs)) ));
                
                fig_title = ['Low Pass Filter using ' fig_title];
            
            elseif get(HP_RB_Handle,'Value') == 1 
                fc = fp1 + tw/2;
                
                n = -(N-1)/2 : 1 : -1;
                hD1 = -2*fc*sin(n*2*pi*fc) ./ (n*2*pi*fc);

                n = 1 : 1 : (N-1)/2;
                hD2 = -2*fc*sin(n*2*pi*fc) ./ (n*2*pi*fc);

                hD = [hD1 1-2*fc hD2];

                hn = hD .* wn;

                hn_f = 20 * log10( abs( fft(hn,fs) / max(fft(hn,fs)) ));
            
                fig_title = ['High Pass Filter using '  fig_title];
            
            elseif get(BP_RB_Handle,'Value') == 1 
                fc1 = fp1 - tw/2;
                fc2 = fp2 + tw/2;
                
                n = -(N-1)/2 : 1 : -1;
                hD1 = ( 2*fc2*sin(n*2*pi*fc2) ./ (n*2*pi*fc2) ) - (2*fc1*sin(n*2*pi*fc1) ./ (n*2*pi*fc1));

                n = 1 : 1 : (N-1)/2;
                hD2 = ( 2*fc2*sin(n*2*pi*fc2) ./ (n*2*pi*fc2) ) - (2*fc1*sin(n*2*pi*fc1) ./ (n*2*pi*fc1));

                hD = [hD1 2*(fc2-fc1) hD2];

                hn = hD .* wn;

                hn_f = 20 * log10( abs( fft(hn,fs) / max(fft(hn,fs)) ));
                
                fig_title = ['Band Pass Filter using ' fig_title];
                
            elseif get(BR_RB_Handle,'Value') == 1 
                fc1 = fp1 - tw/2;
                fc2 = fp2 + tw/2;
                
                n = -(N-1)/2 : 1 : -1;
                hD1 = ( 2*fc1*sin(n*2*pi*fc1) ./ (n*2*pi*fc1) ) - (2*fc2*sin(n*2*pi*fc2) ./ (n*2*pi*fc2));

                n = 1 : 1 : (N-1)/2;
                hD2 = ( 2*fc1*sin(n*2*pi*fc1) ./ (n*2*pi*fc1) ) - (2*fc2*sin(n*2*pi*fc2) ./ (n*2*pi*fc2));

                hD = [hD1 1-2*(fc2-fc1) hD2];

                hn = hD .* wn;

                hn_f = 20 * log10( abs( fft(hn,fs) / max(fft(hn,fs)) ));
                
                fig_title = ['Band Reject Filter using ' fig_title];
            else
                fig_title = 'ERROR - Wrong Filter Specifications.';
                title(fig_title,'FONTSIZE',14);
                return;
            end

            if get(Time_RB_Handle,'Value') == 1 
                subplot(4,2,[1 2 3 4 5 6]);
                plot(hn);
                xlim([0 N]);
                title(fig_title,'FONTSIZE',14);
                ylabel('h(n)','FONTSIZE',12);
            elseif get(Frequency_RB_Handle,'Value') == 1 
                subplot(4,2,[1 2 3 4 5 6]);
                plot(hn_f);
                title(fig_title,'FONTSIZE',14);
                ylabel('|H(f)|, db','FONTSIZE',12);
            elseif get(FrequencyAndTime_RB_Handle,'Value') == 1 
                subplot(4,2,[1 3 5]);
                plot(hn);
                xlim([0 N]);
                title('Time Domain','FONTSIZE',14);
                ylabel('h(n)','FONTSIZE',12);
                
                subplot(4,2,[2 4 6]);
                plot(hn_f);
                title('Frequency Domain','FONTSIZE',14);
                ylabel('|H(f)|, db','FONTSIZE',12);
            end
            grid on
        catch
            title('ERROR - Wrong Filter Specifications.','FONTSIZE',14);
        end
    end

end