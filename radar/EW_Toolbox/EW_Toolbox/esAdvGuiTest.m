function varargout = esAdvGuiTest(varargin)
% ESADVGUITEST M-file for esAdvGuiTest.fig
% 
%      Created by Jason Moyle using MATLAB's GUIDE feature. Code was then
%      adjusted to meet the desired requirements of the GUI. The purpose of
%      the GUI is so that users can adjust selected radar and ES system
%      parameters and see the effect this has on the advantage of the ES
%      system over the radar.
% 
%      ESADVGUITEST, by itself, creates a new ESADVGUITEST or raises the existing
%      singleton*.
%
%      H = ESADVGUITEST returns the handle to a new ESADVGUITEST or the handle to
%      the existing singleton*.
%
%      ESADVGUITEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESADVGUITEST.M with the given input arguments.
%
%      ESADVGUITEST('Property','Value',...) creates a new ESADVGUITEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before esAdvGuiTest_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to esAdvGuiTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help esAdvGuiTest

% Last Modified by GUIDE v2.5 01-Oct-2008 13:52:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @esAdvGuiTest_OpeningFcn, ...
                   'gui_OutputFcn',  @esAdvGuiTest_OutputFcn, ...
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

% --- Executes just before esAdvGuiTest is made visible.
function esAdvGuiTest_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<INUSL>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to esAdvGuiTest (see VARARGIN)

% Choose default command line output for esAdvGuiTest
handles.output = hObject;

% Update handles structure
handles.edit1=1;
guidata(hObject, handles);


% This sets up the initial plot - only do when we are invisible
% so window can get raised using esAdvGuiTest.
if strcmp(get(hObject,'Visible'),'off')
%     set(handles.edit1,'String','1');
    x=1;
    plot(x,x);
    text(0.5,1,'Press Update to Start','FontSize',20,'FontWeight','Bold')
end

% UIWAIT makes esAdvGuiTest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = esAdvGuiTest_OutputFcn(hObject, eventdata, handles) %#ok<INUSL,INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles) %#ok<INUSL,INUSL>
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;
ges=handles.edit1;
popup1_sel_index = get(handles.popupmenu1, 'Value');
popup2_sel_index = get(handles.popupmenu2, 'Value');
popup3_sel_index = get(handles.popupmenu3, 'Value');
popup4_sel_index = get(handles.popupmenu4, 'Value');
switch popup1_sel_index
    case 1        
        Pt=3e3;       
    case 2
        Pt=5e3;
    case 3
        Pt=10e3;
    case 4
        Pt=50e6;
    case 5
        Pt=50;
end
switch popup2_sel_index
    case 1        
        RCS=2;       
    case 2
        RCS=3;
    case 3
        RCS=4;
    case 4
        RCS=5;
end
switch popup3_sel_index
    case 1        
        Freq=9e9;       
    case 2
        Freq=9.5e9;       
    case 3
        Freq=10e9;       
    case 4
        Freq=10.5e9;       
    case 5
        Freq=11e9;       
end
switch popup4_sel_index
    case 1        
        RdrGain=100;       
    case 2
        RdrGain=300;       
    case 3
        RdrGain=1000;       
    case 4
        RdrGain=3000;       
end
esVrdrNoPlot(Pt,RdrGain,RCS,ges,Freq);

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles) %#ok<INUSD,INUSD,DEFNU>
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles) %#ok<INUSD,INUSD,DEFNU>
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles) %#ok<INUSL,DEFNU>
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% set(hObject, 'String', {'ES Advantage Pt=5kW', 'ES Advantage Pt=5MW', 'ES Advantage Pt=50W', 'plot(membrane)', 'surf(peaks)'});



function edit1_Callback(hObject, eventdata, handles) %#ok<DEFNU>
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
esGain=str2double(get(hObject,'String'));
num=true;
if isnan(esGain)
    set(hObject, 'String', 1);
    errordlg('Input must be a number','Error');
    num=false;
end

% Save new Radar power value
handles.edit1=esGain;
guidata(hObject,handles)
if num
    pushbutton1_Callback(hObject,eventdata,handles)
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles) %#ok<INUSD,DEFNU>
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


