function varargout = DTMF(varargin)
% DTMF M-file for DTMF.fig
%      DTMF, by itself, creates a new DTMF or raises the existing
%      singleton*.
%
%      H = DTMF returns the handle to a new DTMF or the handle to
%      the existing singleton*.
%
%      DTMF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DTMF.M with the given input arguments.
%
%      DTMF('Property','Value',...) creates a new DTMF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DTMF_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DTMF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DTMF

% Last Modified by GUIDE v2.5 31-Dec-2006 20:53:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DTMF_OpeningFcn, ...
                   'gui_OutputFcn',  @DTMF_OutputFcn, ...
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


% --- Executes just before DTMF is made visible.
function DTMF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DTMF (see VARARGIN)

% Choose default command line output for DTMF
handles.output = hObject;
global Noise
Noise=1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DTMF wait for user response (see UIRESUME)
% uiwait(handles.fig0);


% --- Outputs from this function are returned to the command line.
function varargout = DTMF_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
clear all;
global Noise
Noise=0;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000];
d1=sin(0.5474*n)+sin(0.9495*n); 
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(d1);grid;
title('时域波形');xlabel('单位:(t)');
% 显示号码
n1=strcat(get(handles.edit1,'string'),'1'); 
set(handles.edit1,'string',n1); 
space=zeros(1,100);
% 产生拨号音
global NUM
phone=[NUM,d1];
NUM=[phone,space];
wavplay(d1,8000); 

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000];
d2=sin(0.5474*n)+sin(1.0493*n); 
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(d2);grid;
title('时域波形');xlabel('单位:(t)');
 % 显示号码
n2=strcat(get(handles.edit1,'string'),'2');
set(handles.edit1,'string',n2);
space=zeros(1,100); 
% 产生拨号音
global NUM
phone=[NUM,d2];
NUM=[phone,space];
wavplay(d2,8000);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000]; 
d3=sin(0.5474*n)+sin(1.1600*n); 
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(d3);grid;
title('时域波形');xlabel('单位:(t)');
% 显示号码
n3=strcat(get(handles.edit1,'string'),'3');
set(handles.edit1,'string',n3); 
space=zeros(1,100); 
% 产生拨号音
global NUM
phone=[NUM,d3];
NUM=[phone,space]; 
wavplay(d3,8000); 

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000]; 
d4=sin(0.6048*n)+sin(0.9495*n);
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(d4);grid;
title('时域波形');xlabel('单位:(t)');
% 显示号码
n4=strcat(get(handles.edit1,'string'),'4');
set(handles.edit1,'string',n4);
space=zeros(1,100);
% 产生拨号音
global NUM
phone=[NUM,d4];
NUM=[phone,space]; 
wavplay(d4,8000); 

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000]; 
d5=sin(0.6048*n)+sin(1.0493*n); 
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(d5);grid;
title('时域波形');xlabel('单位:(t)');
% 显示号码
n5=strcat(get(handles.edit1,'string'),'5'); 
set(handles.edit1,'string',n5); 
space=zeros(1,100);
% 产生拨号音 
global NUM
phone=[NUM,d5];
NUM=[phone,space]; 
wavplay(d5,8000);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000]; 
d6=sin(0.6048*n)+sin(1.1600*n); 
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(d6);grid;
title('时域波形');xlabel('单位:(t)');
% 显示号码
n6=strcat(get(handles.edit1,'string'),'6'); 
set(handles.edit1,'string',n6); 
space=zeros(1,100);
% 产生拨号音
global NUM
phone=[NUM,d6];
NUM=[phone,space];
wavplay(d6,8000); 

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Noise
cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000];
d7=sin(0.6692*n)+sin(0.9495*n);
%画信号和噪声的时域波形
SNR=25;
if (Noise<5)
    cla(handles.fig0,'reset');
    d7=sin(0.6692*n)+sin(0.9495*n);
    set(gcf,'CurrentAxes',handles.fig3);
    plot(d7);grid;
    title('纯信号时域波形');xlabel('单位:(t)');
else
    dd= awgn(d7,SNR);
    set(gcf,'CurrentAxes',handles.fig0);
    plot(dd-d7);grid;title('噪声时域波形');xlabel('单位:(t)');
    set(gcf,'CurrentAxes',handles.fig3);
    plot(dd);grid;
    title('信号与噪声的时域波形');xlabel('单位:(t)');
end
% 显示号码
n7=strcat(get(handles.edit1,'string'),'7'); 
set(handles.edit1,'string',n7); 
space=zeros(1,100); 
% 产生拨号音
global NUM
phone=[NUM,d7];
NUM=[phone,space]; 
wavplay(d7,8000); 

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Noise
cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000]; 
d8=sin(0.6692*n)+sin(1.0493*n); 
%画信号和噪声的时域波形
SNR=25;
if (Noise<2)
   cla(handles.fig0,'reset');
   d8=sin(0.6692*n)+sin(1.0493*n);
   set(gcf,'CurrentAxes',handles.fig3);
   plot(d8);grid;
   title('纯信号时域波形');xlabel('单位:(t)');
else
   ddd= awgn(d8,SNR);
   set(gcf,'CurrentAxes',handles.fig0);
   plot(ddd-d8);grid;title('噪声时域波形'),xlabel('单位:(t)')
   set(gcf,'CurrentAxes',handles.fig3);
   plot(ddd);grid;
   title('信号与噪声的时域波形');xlabel('单位:(t)');
end
% 显示号码
n8=strcat(get(handles.edit1,'string'),'8'); 
set(handles.edit1,'string',n8); 
space=zeros(1,100);
 % 产生拨号音
global NUM
phone=[NUM,d8];
NUM=[phone,space]; 
wavplay(d8,8000);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000]; 
d9=sin(0.6692*n)+sin(1.1600*n);
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(d9);grid;
title('时域波形');xlabel('单位:(t)');
% 显示号码
n9=strcat(get(handles.edit1,'string'),'9');
set(handles.edit1,'string',n9); 
space=zeros(1,100);
 % 产生拨号音
global NUM
phone=[NUM,d9];
NUM=[phone,space];
wavplay(d9,8000);

% --- Executes on button press in pushbutton_XING.
function pushbutton_XING_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_XING (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% “ * ”键作为删除键
n=[1:1000];
num=get(handles.edit1,'string');
l=length(num);
n11=strrep(num,num,num(1:l-1)); %去掉末尾号码在面板上的显示
d11=sin(0.7438*n)+sin(0.9495*n);
set(handles.edit1,'string',n11);
global NUM
L=length(NUM);
NUM=NUM(1:L-1100); %删除末尾号码在拨号音信号中的存储
wavplay(d11,8192);

% --- Executes on button press in pushbutton0.
function pushbutton0_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000]; 
d0=sin(0.7438*n)+sin(1.0493*n); 
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(d0);grid;
title('时域波形');xlabel('单位:(t)');
% 显示号码
n0=strcat(get(handles.edit1,'string'),'0'); 
set(handles.edit1,'string',n0); 
space=zeros(1,100); 
% 产生拨号音
global NUM
phone=[NUM,d0];
NUM=[phone,space]; 
wavplay(d0,8000); 

% --- Executes on button press in pushbutton_jing.
function pushbutton_jing_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_jing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonD.
function pushbuttonD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000]; 
dD=sin(0.7438*n)+sin(1.2826*n); 
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(dD);grid;
title('时域波形');xlabel('单位:(t)');
% 产生拨号音
global NUM
phone=[NUM,dD];
space=zeros(1,100);
NUM=[phone,space]; 
wavplay(dD,8000); 

% --- Executes when uipanel1 is resized.
function uipanel1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.

function pushbuttonC_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000]; 
dC=sin(0.6692*n)+sin(1.2826*n); 
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(dC);grid;
title('时域波形');xlabel('单位:(t)');
% 产生拨号音
global NUM
phone=[NUM,dC];
space=zeros(1,100);
NUM=[phone,space]; 
wavplay(dC,8000); 

% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


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



% --- Executes on button press in pushbutton_exit.
function pushbutton_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);



% --- Executes on button press in pushbuttonA.
function pushbuttonA_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000]; 
dA=sin(0.5474*n)+sin(1.2826*n); 
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(dA);grid;
title('时域波形');xlabel('单位:(t)');
% 产生拨号音
global NUM
phone=[NUM,dA];
space=zeros(1,100);
NUM=[phone,space]; 
wavplay(dA,8000); 

% --- Executes on button press in pushbuttonB.
function pushbuttonB_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.fig3,'reset');
cla(handles.fig2,'reset');
cla(handles.fig0,'reset');
n=[1:1000]; 
dB=sin(0.6048*n)+sin(1.2826*n); 
%画信号的时域波形
set(gcf,'CurrentAxes',handles.fig3);
plot(dB);grid;
title('时域波形');xlabel('单位:(t)');
% 产生拨号音
global NUM
phone=[NUM,dB];
space=zeros(1,100);
NUM=[phone,space]; 
wavplay(dB,8000); 

% --- Executes during object creation, after setting all properties.
function pushbuttonB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbuttonB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_info.
function pushbutton_info_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

msgbox('The program name: Automatic Telephone Number Generation System      Created by: 于小家  黄盛刚 丁润伟 王志云                                      Instructor with signature: Dr. Cynthia Zou    ','Info','none')

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


% --- Executes on button press in pushbutton_dec.
function pushbutton_dec_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global NUM
global Noise
wavplay(NUM,8000);
L=length(NUM);
n=L/1100;
SNR=25;
number='';
for i=1:n
    j=(i-1)*1100+1;
    d=NUM(j:j+999); % 截取出每个数字
    f=fft(d,2048); % 以 N=2048 作 FFT 变换
    a=abs(f);
    p=a.*a/10000; % 计算功率谱
    num(1)=find(p(1:250)==max(p(1:250))); % 找行频
    num(2)=300+find(p(300:380)==max(p(300:380))); % 找列频
    if (num(1) < 185) row=1; % 确定行数
    elseif (num(1) < 205) row=2;
    elseif (num(1) < 230) row=3;
    else row=4;
    end
    if (num(2) < 325) column=1; % 确定列数
    elseif (num(2) < 356) column=2;
    elseif(num(2)<394) column=3;
    else column=4;
    end
    z=[row,column]; % 确定数字
    if z==[4,2] tel=0;
    elseif z==[1,1] tel=1;
    elseif z==[1,2] tel=2;
    elseif z==[1,3] tel=3;
    elseif z==[2,1] tel=4;
    elseif z==[2,2] tel=5;
    elseif z==[2,3] tel=6;
    elseif z==[3,1] tel=7;
    elseif z==[3,2] tel=8;
    elseif z==[3,3] tel=9;
    end
    %画信号的频谱图
    m=[1:1000];
    switch (tel)  
        case 0 
            d=sin(0.7438*m)+sin(1.0493*m);
        case 1 
            d=sin(0.5474*m)+sin(0.9495*m);
        case 2 
            d=sin(0.5474*m)+sin(1.0493*m);
        case 3
            d=sin(0.5474*m)+sin(1.1600*m);
        case 4
            d=sin(0.6048*m)+sin(0.9495*m);
        case 5
           d=sin(0.6048*m)+sin(1.0493*m);
        case 6
            d=sin(0.6048*m)+sin(1.1600*m);
        case 7
            if (Noise<2)
                d=sin(0.6692*m)+sin(0.9495*m);
            else
                d= awgn(sin(0.6692*m)+sin(0.9495*m),SNR);
            end 
        case 8
            if (Noise<2)
                d=sin(0.6692*m)+sin(1.0493*m);
            else
                d= awgn(sin(0.6692*m)+sin(1.0493*m),SNR);
            end 
        otherwise
            d=sin(0.6692*m)+sin(1.1600*m);
    end
    Spectrum=fft(d);
    Spectrum=fftshift(Spectrum);%计算信号的频谱
    N=length(Spectrum);    nStep=(2*pi)/(N-1);
    w=-pi:nStep:pi;
    set(gcf,'CurrentAxes',handles.fig2);
    plot(w/(2*pi)*8000,abs(Spectrum));grid;
    axis([0,2000,0,200]); xlabel('频率 单位:(Hz)');
    ylabel('信号能量');    title('功率谱');
    %连接字符串
    c=strcat(number,int2str(tel));
    number=c;
    i=i+1;
end
set(handles.edit3,'string',number);

% --- Executes on button press in pushbutton_NOISE.
function pushbutton_NOISE_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_NOISE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Noise
Noise=10;

