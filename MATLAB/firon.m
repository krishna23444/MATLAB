function varargout = firon(varargin)
% FIRON M-file for firon.fig
%      FIRON, by itself, creates a new FIRON or raises the existing
%      singleton*.
%
%      H = FIRON returns the handle to a new FIRON or the handle to
%      the existing singleton*.
%
%      FIRON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRON.M with the given input arguments.
%
%      FIRON('Property','Value',...) creates a new FIRON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before firon_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to firon_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help firon

% Last Modified by GUIDE v2.5 03-Nov-2010 09:43:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @firon_OpeningFcn, ...
                   'gui_OutputFcn',  @firon_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before firon is made visible.
function firon_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to firon (see VARARGIN)

% Choose default command line output for firon
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes firon wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = firon_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string',{'LPF','HPF','BPF','BSF'})


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
val=get(handles.popupmenu2,'value');
f1=str2num(get(handles.edit6,'string'));
a=str2num(get(handles.edit7,'string'));
fs=str2num(get(handles.edit8,'string'));
tw=str2num(get(handles.edit9,'string'));
 
if get(handles.ko,'value')==1
dp=str2num(get(handles.edit12,'string'));
ds=str2num(get(handles.edit13,'string'));
d=min(dp,ds)

if -20*log10(d)>a & dp~=0 & ds~=0
    a=-20*log10(d);
end
end

if val >2
    f22=str2num(get(handles.edit10,'string'));
    f2=(f22+(tw/2))/fs;
    w2=2*pi*f2;
 if f22>=fs/2&&val==3
             z1=sprintf('This is High Pass Filter ');
             set(handles.text17,'string',z1);
     val==2;
    elseif f1==0&&val==4
             z=sprintf('This is Low Pass Filter ');
             set(handles.text17,'string',z);
    val==1;
    end
end

K=0

if val>2
    f=(f1-(tw/2))/fs;
else

f=(f1+(tw/2))/fs;
end
twn=tw/fs;

if get(handles.ko,'value')==1

if a<=21
    b=0
elseif a>21&&a<50
    b=.5842*(a-21)^.4+.07886*(a-21)
elseif a>=50
    b=.1102*(a-8.7)
end

N=ceil((a-7.95)/(14.36*twn))
else
    if (get(handles.rec,'value')==1&&a>21)||(get(handles.han,'value')==1&&a>44)||(get(handles.ham,'value')==1&&a>53)||(get(handles.bla,'value')==1&&a>75)
        errordlg('Specifications cant be achieved by selected window!','FIR ERROR');
    else
        
        
    if (get(handles.all,'value')==1&&a<=21)||get(handles.rec,'value')==1
        N=ceil(.9/twn)
        K=1
    elseif (get(handles.all,'value')==1&&(a>21&&a<=44))||get(handles.han,'value')==1
        N=ceil(3.3/twn)
    K=2
    elseif (get(handles.all,'value')==1&&(a>44&&a<=53))||get(handles.ham,'value')==1
        N=ceil(3.5/twn )
      K=3
    elseif (get(handles.all,'value')==1&&(a>53&&a<=75))||get(handles.bla,'value')==1
        N=ceil(5.5/twn)
        K=5
    elseif (get(handles.all,'value')==1&&a>75)||get(handles.ka,'value')==1
        N=ceil(5.71/twn)
        b=8.96
        K=6
    end
  end
end

if N/2==ceil(N/2)
    N=N+1;
end


w=2*pi*f;
n=(N-1)/2;

for i=-n:n
    if val==1
    hd(i+n+1)=2*f*sin(w*i)/(w*i);
    hd(n+1)=2*f;
    
    elseif val==2
    hd(i+n+1)=-2*f*sin(w*i)/(w*i);
    hd(n+1)=1-2*f;
        
    elseif val==3
    hd(i+n+1)=2*f2*sin(w2*i)/(w2*i)-(2*f*sin(w*i)/(w*i));
    hd(n+1)=2*(f2-f);

    else
    hd(i+n+1)=2*f*sin(w*i)/(w*i)-(2*f2*sin(w2*i)/(w2*i));
    hd(n+1)=1-2*(f2-f);
    end
end

for i= -n:n
    
            if K==1||get(handles.rec,'value')==1
                    r(i+n+1)=1;
            z=sprintf('Window Used : Rectangular ');
             set(handles.text16,'string',z);
            else if K==2||get(handles.han,'value')==1
                     r(i+n+1)=.5+.5*cos(2*pi*i/(N-1));
            z=sprintf('Window Used : Hann');
             set(handles.text16,'string',z);
            else if K==3||get(handles.ham,'value')==1
                     r(i+n+1)=.54+.46*cos(2*pi*i/(N-1));
           z=sprintf(' Window Used : Hamming');
             set(handles.text16,'string',z);
            else if K==5||get(handles.bla,'value')==1
                     r(i+n+1)=.42+.5*cos(2*pi*i/(N-1))+.08*cos(4*pi*i/(N-1));
             z=sprintf('Window Used : Blackman ');
             set(handles.text16,'string',z);
            else  if K==6||get(handles.ka,'value')||get(handles.ko,'value')==1
                     r(i+n+1)=I(b*sqrt(1-(2*i/(N-1))^2))/I(b);
                     z=sprintf('Window Used : Kaiser ');
             set(handles.text16,'string',z);
                      end
                   end
                end
            end
        end
end
 
y=fft(r.*hd,fs);
set(handles.listbox2,'string',r.*hd)
j=20*log10(abs(y));
axes(handles.axes3)
plot(j(1:fs/2));xlabel('Frequency (Hz)');ylabel('Magnitude Response (dB)');
grid on;
axes(handles.axes4);
b=phase(y);
plot(b(1:fs/2));xlabel('Frequency (Hz)');ylabel('Phase Response (degrees)');
grid on;  


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit6,'string','');
set(handles.edit7,'string','');
set(handles.edit8,'string','');
set(handles.edit9,'string','');
set(handles.edit10,'string','');



% --- Executes on button press in ham.
function ham_Callback(hObject, eventdata, handles)
% hObject    handle to ham (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ham


% --- Executes on button press in ka.
function ka_Callback(hObject, eventdata, handles)
% hObject    handle to ka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ka


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in rec.
function rec_Callback(hObject, eventdata, handles)
% hObject    handle to rec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rec


% --- Executes on button press in han.
function han_Callback(hObject, eventdata, handles)
% hObject    handle to han (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of han


% --- Executes on button press in bla.
function bla_Callback(hObject, eventdata, handles)
% hObject    handle to bla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bla




% --- Executes on button press in all.
function all_Callback(hObject, eventdata, handles)
% hObject    handle to all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of all


% --- Executes on button press in ko.
function ko_Callback(hObject, eventdata, handles)
% hObject    handle to ko (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ko


% --- Executes during object creation, after setting all properties.
function text17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
