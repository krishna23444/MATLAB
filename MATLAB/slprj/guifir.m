function varargout = guifir(varargin)
% GUIFIR M-file for guifir.fig
%      GUIFIR, by itself, creates a new GUIFIR or raises the existing
%      singleton*.
%
%      H = GUIFIR returns the handle to a new GUIFIR or the handle to
%      the existing singleton*.
%
%      GUIFIR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIFIR.M with the given input arguments.
%
%      GUIFIR('Property','Value',...) creates a new GUIFIR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guifir_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guifir_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guifir

% Last Modified by GUIDE v2.5 10-Oct-2010 12:43:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guifir_OpeningFcn, ...
                   'gui_OutputFcn',  @guifir_OutputFcn, ...
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


% --- Executes just before guifir is made visible.
function guifir_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guifir (see VARARGIN)

% Choose default command line output for guifir
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guifir wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guifir_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1







% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string',{'LPF','HPF','BPF','BSF'})



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(handles.popupmenu1,'value');
f1=str2num(get(handles.edit1,'string'));
a=str2num(get(handles.edit2,'string'));
fs=str2num(get(handles.edit3,'string'));
tw=str2num(get(handles.edit4,'string'));
if val >2
    f22=str2num(get(handles.edit5,'string'));
    f2=(f22+(tw/2))/fs;
    w2=2*pi*f2;
 if f22>=fs/2&&val==3
z1=sprintf('This is High Pass Filter ');
             set(handles.text10,'string',z1);
     val==2;
    elseif f1==0&&val==4
             z=sprintf('This is Low Pass Filter ');
             set(handles.text10,'string',z);
    val==1;
    end
end


f=(f1+(tw/2))/fs;
twn=tw/fs;

if a<=21
    b=0;
elseif a>21&&a<50
    b=.5842*(a-21)^.4+.07886*(a-21);
elseif a>=50
    b=.1102*(a-8.7);
end

N=ceil((a-7.95)/(14.36*twn));

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

    r(i+n+1)=I(b*sqrt(1-(2*i/(N-1))^2))/I(b);
end
y=fft(r.*hd,fs);
set(handles.listbox2,'string',r.*hd)
j=20*log10(abs(y));
axes(handles.axes1)
plot(j(1:fs/2));xlabel('Frequency (Hz)');ylabel('Magnitude Response (dB)');
grid on;
axes(handles.axes2);
b=phase(y);
plot(b(1:fs/2));xlabel('Frequency (Hz)');ylabel('Phase Response (degrees)');
grid on;  
