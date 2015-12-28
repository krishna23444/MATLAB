function varargout = new2(varargin)
% NEW2 MATLAB code for new2.fig
%      NEW2, by itself, creates a new NEW2 or raises the existing
%      singleton*.
%
%      H = NEW2 returns the handle to a new NEW2 or the handle to
%      the existing singleton*.
%
%      NEW2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEW2.M with the given input arguments.
%
%      NEW2('Property','Value',...) creates a new NEW2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before new2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to new2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help new2

% Last Modified by GUIDE v2.5 05-Sep-2012 13:24:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @new2_OpeningFcn, ...
                   'gui_OutputFcn',  @new2_OutputFcn, ...
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


% --- Executes just before new2 is made visible.
function new2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to new2 (see VARARGIN)

% Choose default command line output for new2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes new2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = new2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



filename='19F_2D_Pulacq_13_13_2_raw_act.SDAT';
num= 50;
fid = fopen(filename,'r','ieee-le');
X = freadVAXG(fid, 1000000000,'float'); 
fclose(fid);
j = 1;
for i =1+2048*(num-1):2:2048*(num)
    X_real(j) = X(i);
    X_imag(j) = X(i+1);
    j = j + 1; 
end 
X_real = X_real';
X_imag = X_imag';
%Each data point is a complex pair with real, imaginary,real, imaginary..
% Complex conjugate the data if BRUKER = T. 
X1 = conj(complex(X_real,X_imag));


plot(real(X1))

index_points = 1:1:1024;
index = (index_points -129.448433)*1000000/127793081;
index_ppm = index;



















% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



filename='19F_2D_Pulacq_13_13_2_raw_act.SDAT';
num= 50;
fid = fopen(filename,'r','ieee-le');
X = freadVAXG(fid, 1000000000,'float'); 
fclose(fid);
j = 1;
for i =1+2048*(num-1):2:2048*(num)
    X_real(j) = X(i);
    X_imag(j) = X(i+1);
    j = j + 1; 
end 
X_real = X_real';
X_imag = X_imag';
%Each data point is a complex pair with real, imaginary,real, imaginary..
% Complex conjugate the data if BRUKER = T. 
X1 = conj(complex(X_real,X_imag));
X_FT = fft(X1);
X_FT_shift = fftshift(X_FT);
plot(real(X_FT_shift))


% check the number of points to be plotted it should be 2048
index_points = 1:1:1024;
index = (index_points -129.448433)*1000000/127793081;
index_ppm = index;












% Y = fft(x)
% Y = fft(X,n)
% Y = fft(X,[],dim)
% Y = fft(X,n,dim)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 
filename='19F_2D_Pulacq_13_13_2_raw_act.SDAT';
num= 50;
fid = fopen(filename,'r','ieee-le');
X = freadVAXG(fid, 1000000000,'float'); 
fclose(fid);
j = 1;
for i =1+2048*(num-1):2:2048*(num)
    X_real(j) = X(i);
    X_imag(j) = X(i+1);
    j = j + 1; 
end 
X_real = X_real';
X_imag = X_imag';

Ts = 1e-6; % Symbol time (sec)
NT = 3; % Number of symbol periods between beginning and peak of impulse response

a = Ts*[.5, .75, 1, 2];
B = sqrt(log(2)/2)./(a);

t = linspace(-NT*Ts,NT*Ts,1000)';
hg = zeros(length(t),length(a));
for k = 1:length(a),
    hg(:,k) = sqrt(pi)/a(k)*exp(-(pi*t/a(k)).^2);
end

plot(t/Ts,hg)
title('Impulse response of a continuous-time Gaussian filter for various bandwidths');
xlabel('Normalized time (t/Ts)')
ylabel('Amplitude')
legend(sprintf('a = %g*Ts',a(1)/Ts),sprintf('a = %g*Ts',a(2)/Ts),sprintf('a = %g*Ts',a(3)/Ts),sprintf('a = %g*Ts',a(4)/Ts))
%
%Idea from the below paper
% - V. Mazet, C. Carteret, D. Brie, J. Idier, B. Humbert. Chemom. Intell. Lab. Syst. 76 (2), 2005.
% -Amogha
%gui for this was done using guide


% Check arguments
