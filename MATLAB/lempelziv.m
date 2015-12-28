function varargout = lempelziv(varargin)
% LEMPELZIV M-file for lempelziv.fig
%      LEMPELZIV, by itself, creates a new LEMPELZIV or raises the existing
%      singleton*.
%
%      H = LEMPELZIV returns the handle to a new LEMPELZIV or the handle to
%      the existing singleton*.
%
%      LEMPELZIV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEMPELZIV.M with the given input arguments.
%
%      LEMPELZIV('Property','Value',...) creates a new LEMPELZIV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lempelziv_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lempelziv_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lempelziv

% Last Modified by GUIDE v2.5 13-Jun-2012 15:21:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lempelziv_OpeningFcn, ...
                   'gui_OutputFcn',  @lempelziv_OutputFcn, ...
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


% --- Executes just before lempelziv is made visible.
function lempelziv_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lempelziv (see VARARGIN)

% Choose default command line output for lempelziv
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lempelziv wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lempelziv_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc
tic
if get(handles.radiobutton5,'value')==1
O=get(handles.edit3,'string');
X=dec2bin(double(O));
S=size(X);
e=1;
for i=1:S(1)
    for j=1:S(2)
        o(e)=X(i,j);
        e=e+1;
    end
end
elseif get(handles.radiobutton6,'value')==1
    O=get(handles.edit3,'string')
g=size(O)
for n=1:g(2)  
o(n)=str2num(O(n))
end
end
if get(handles.radiobutton1,'value')==0
  l=str2double(get(handles.edit5,'string'));
else


%[0 0 0 1 0 1 1 1 0 0 1 0 1 0 0 1 0 1]
%011011100011110010101101100111

a='0';
b='1';
t=strcat(a);
u=strcat(b);
y(1)={t};
y(2)={u};
q(1)={t};
q(2)={u};

p=1;
j=3;

while p<=length(o)

i=1;
a=1;

while (a~=0)
    
i=i+1;
if (p+i-1)>length(o)
        errordlg('Codeword table cant be completed with given sequence','Coding Error');
    end
a=strmatch(num2str(o(p:(p+i-1))),y,'exact');
end

y(j)={num2str(o(p:(p+i-1)))};

t=strmatch(num2str(o(p:(p+i-2))),y,'exact');;
b=dec2bin(t);
q(j)={strcat(num2str(b),num2str(o(p+i-1)))};

I=cell2mat(cellfun(@size,q,'UniformOutput',0));
l=max(I);
p=p+i;
j=j+1;
end
clear y q b a p j i I t u
end




a='0';
b='1';
t=strcat(a);
u=strcat(b);
y(1)={t};
y(2)={u};
q(1)={t};
q(2)={u};


p=1;
j=3;

while p<=length(o)

i=1;
a=1;

while (a~=0)
i=i+1;
a=strmatch(num2str(o(p:(p+i-1))),y,'exact');
end

y(j)={num2str(o(p:(p+i-1)))};

t=strmatch(num2str(o(p:(p+i-2))),y,'exact');
b=dec2bin(t);
q(j)={strcat(num2str(b),num2str(o(p+i-1)))};
s=size(q{j});
q(j)={strcat(num2str(zeros(1,l-s(2))),num2str(b),num2str(o(p+i-1)))};
p=p+i;
j=j+1;
end
y(:,1:2)=[];
q(:,1:2)=[];

P=strread(cell2mat(q),'%s').';
encod=cell2mat(P);
set(handles.text10,'string',encod);
g=size(encod);

for n=1:g(2)
 H(n)=str2num(encod(n));
end
 
%%
 %Lempel Ziv Decoder
 v=1;
for j=1:length(H)/l
    for i=1:l    
         c(j,i)=H(v);
         v=v+1;
    end
end

A='0';
B='1';
T=strcat(A);
U=strcat(B);
Y(1)={T};
Y(2)={U};
for i=1:length(H)/l
    Y(i+2)=[strcat(Y(bin2dec(num2str(c(i,1:(l-1))))),(num2str(c(i,l))))];
end
Y(:,1:2)=[];
    
R=strread(cell2mat(Y),'%s').';
decod=cell2mat(R);
set(handles.text11,'string',decod);
set(handles.text12,'string',l);

if get(handles.radiobutton5,'value')==1 
 for i=1:length(decod)/7
  A(i) = char(bin2dec(decod( 7*(i-1)+1:i*7)));
 end
% set(handles.text13,'string',A);
end

toc;
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


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4



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
