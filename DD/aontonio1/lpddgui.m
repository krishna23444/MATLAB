function varargout = lpddgui(varargin)
% LPDDGUI M-file for lpddgui.fig
%      LPDDGUI, by itself, creates a new LPDDGUI or raises the existing
%      singleton*.
%
%      H = LPDDGUI returns the handle to a new LPDDGUI or the handle to
%      the existing singleton*.
%
%      LPDDGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LPDDGUI.M with the given input arguments.
%
%      LPDDGUI('Property','Value',...) creates a new LPDDGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lpddgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lpddgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lpddgui

% Last Modified by GUIDE v2.5 11-Mar-2012 21:58:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lpddgui_OpeningFcn, ...
                   'gui_OutputFcn',  @lpddgui_OutputFcn, ...
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


% --- Executes just before lpddgui is made visible.
function lpddgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lpddgui (see VARARGIN)

% Choose default command line output for lpddgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lpddgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lpddgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

format long G
load('F:\Users\JC\Documents\xx.mat')
hf=Expression1;
R=20000;
for i=0:(R/2)-1
    u(i+1)=(2/R)*i;
end
%% MAA coefficients low pass diff 1
la1=[1 -.4398 .4672 -.0403 -.017]; %MAA .35 coeffs
lb1=[.0386 .0772 0 -.0772 -.0386];
[ma1,maw1]=freqz(lb1,la1,R/2);ma1=abs(ma1);
la2=[1 .0133 .4366 .0003 -.0092]; %MAA .42 coeffs
lb2=[.0573 .1147 0 -.1147 -.0573 ];
[ma2,maw2]=freqz(lb2,la2,R/2);ma2=abs(ma2);
la3=[1 .6228 .5531 .0768 .0011]; %MAA .52 coeffs
lb3=[.0897 .1794 0 -.1794 -.0897];
[ma3,maw3]=freqz(lb3,la3,R/2);ma3=abs(ma3);
la4=[1 1.624 1.171 .3223 .0265]; %MAA .7 coeffs
lb4=[.1649 .3298 0 -.3298 -.1649 ];
[ma4,maw4]=freqz(lb4,la4,R/2);ma4=abs(ma4);
%% MAA coefficients low pass diff 2
% lla1=[1 -.9429 .3151 .1809 -.0691 -.0192]; %MAA .22 coeffs
% llb1=[.0092 .0277 .0185 0 -.0185  -.0277 -.0092];
% [lma1,lmaw1]=freqz(llb1,lla1,R/2);
% lla2=[1 -.4525 .2623 .1386 -.0427 -.0127]; %MAA .29 coeffs
% llb2=[0.0178 .0533 .0355 0 -.0355 -.0533 -0.0178];
% [lma2,lmaw2]=freqz(llb2,lla2,R/2);
% lla3=[1 .1501 .362 .1439 -.015 -.0068]; %MAA .38 coeffs
% llb3=[.0325 .0975 0.065 0 -0.065 -.0975 -.0325];
% [lma3,lmaw3]=freqz(llb3,lla3,R/2);

 %%  length(h) = K+2L+2 salesnick's filter responses and maa
 if get(handles.radiobutton6,'value')==1
 K=13;
  L = (-K+29)/2-1;  
h1 = lowdiff(K,L);
[H1,w1] = freqz(h1,1,R/2);
hh=abs(H1)/pi;
axes(handles.axes1);
 plot(w1/pi,hh,'k','LineWidth',1.3);
hold on
grid on

 end
 
 if get(handles.radiobutton3,'value')==1
%      axes(handles.axes1);
% plot(maw1/pi,u,'-.k','LineWidth',1.3)
% hold on
% grid on
axes(handles.axes1);
plot(maw1/pi,abs(ma1),'r','LineWidth',1.3)
hold on
grid on

 end

%% fourier series diff plots
if get(handles.radiobutton2,'value')==1
[Hf,wf] = freqz(hf,1,R/2);
% ho=abs(Hf)*.1/abs(Hf(1000));
   ho=abs(Hf)/pi;
   axes(handles.axes1);
plot(maw1/pi,ho,'LineWidth',1.3);
hold on
grid on

end
%% convex optimization 
if get(handles.radiobutton5,'value')==1
n = 29;
v=1;
wpass = 0.35*pi;   % end of the passband
wstop = 0.5*pi;   % start of the stopband
delta = .01;         % maximum passband ripple in dB (+/- around 0 dB)

m = 15*n;
w = linspace(0,pi,m)'; % omega

% A is the matrix used to compute the power spectrum
% A(w,:) = [1 2*cos(w) 2*cos(2*w) ... 2*cos(n*w)]
A = [ones(m,1) 2*cos(kron(w,[1:n-1]))];

% passband 0 <= w <= w_pass
ind1 = find((0 <= w) & (w <= wpass));    % passband
Lp  = ((w(ind1)).^v)+10^(-delta/20)*ones(length(ind1),1)-1;
Up  = ((w(ind1)).^v)+10^(+delta/20)*ones(length(ind1),1)-1 ;
Ap  = A(ind1,:);
bb=find(Lp>=0);
Lp(1:bb(1)-1)=0;
% transition band is not constrained (w_pass <= w <= w_stop)

% stopband (w_stop <= w)
ind = find((wstop <= w) & (w <= pi));   % stopband
As  = A(ind,:);

%********************************************************************
% optimization
%********************************************************************
% formulate and solve the magnitude design problem
cvx_begin
  variable r(n,1)

  % this is a feasibility problem
  minimize( max( abs( As*r ) ) )
  subject to
    % passband constraints
    Ap*r >= (Lp.^2);
    Ap*r <= (Up.^2);
    % nonnegative-real constraint for all frequencies (a bit redundant)
    A*r >= 0;
cvx_end

% compute the spectral factorization
hc = spectral_fact(r);
[Hfc,wfc] = freqz(hc,1,R/2);
   hoc=abs(Hfc)/pi;
   axes(handles.axes1);
plot(maw1/pi,hoc,'-.b','LineWidth',1.3);
hold on
grid on

end
%% parks-mcclellan
if get(handles.radiobutton1,'value')==1
load('D:\MATLAB 2010 Portable\bin\cvx\examples\filter_design\fipm.mat')
[Hfpm,wfpm] = freqz(Num,1,R/2);
   hopm=abs(Hfpm);
   axes(handles.axes1);
plot(maw1/pi,hopm,'-.r','LineWidth',1.3);
hold on
grid on

end
%% error plots

if get(handles.radiobutton6,'value')==1
for i=1:R/2
    
    E(i)=u(i)-hh(i);
end
th=find(E*1000/pi>=10);
axes(handles.axes2);
plot(maw1(1:th(1))/pi,E(1:th)*1000/pi,'k','LineWidth',1.3)
hold on
grid on

hold on
end

if get(handles.radiobutton3,'value')==1
for i=1:R/2
    E(i)=u(i)-ma1(i);
end
th=find(E*1000/pi>=10);
axes(handles.axes2);
plot(maw1(1:th(1))/pi,E(1:th)*1000/pi,'r','LineWidth',1.3)
hold on
grid on

end

if get(handles.radiobutton2,'value')==1
for i=1:R/2
    E(i)=u(i)-ho(i);
end
th=find(E*1000/pi>=10);
axes(handles.axes2);
plot(maw1(1:th(1))/pi,E(1:th)*1000/pi,'LineWidth',1.3)
hold on
grid on

grid on
end

if get(handles.radiobutton5,'value')==1
for i=1:R/2
    E(i)=u(i)-hoc(i);
end
th=find(E*1000/pi>=10);
axes(handles.axes2);
plot(maw1(1:th(1))/pi,E(1:th)*1000/pi,'g','LineWidth',1.3)
hold on
grid on

end

if get(handles.radiobutton1,'value')==1
for i=1:R/2
    E(i)=u(i)-hopm(i);
end
th=find(E*1000/pi>=10);
axes(handles.axes2);
plot(maw1(1:th(1))/pi,E(1:th)*1000/pi,'-k','LineWidth',1.3);xlabel('Frequency (Hz)');ylabel('%age error');
hold on
grid on

end
