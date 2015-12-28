function varargout = F19_signal(varargin)
% F19_SIGNAL MATLAB code for F19_signal.fig
%      F19_SIGNAL, by itself, creates a new F19_SIGNAL or raises the existing
%      singleton*.
%
%      H = F19_SIGNAL returns the handle to a new F19_SIGNAL or the handle to
%      the existing singleton*.
%
%      F19_SIGNAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in F19_SIGNAL.M with the given input arguments.
%
%      F19_SIGNAL('Property','Value',...) creates a new F19_SIGNAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before F19_signal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to F19_signal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help F19_signal

% Last Modified by GUIDE v2.5 05-Sep-2012 10:55:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @F19_signal_OpeningFcn, ...
                   'gui_OutputFcn',  @F19_signal_OutputFcn, ...
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


% --- Executes just before F19_signal is made visible.
function F19_signal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to F19_signal (see VARARGIN)

% Choose default command line output for F19_signal


handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes F19_signal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = F19_signal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in signal.
function signal_Callback(hObject, eventdata, handles)
% hObject    handle to signal (see GCBO)
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


% --- Executes on button press in plot.
function plot_Callback(hObject, eventdata, handles)
% hObject    handle to plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1
