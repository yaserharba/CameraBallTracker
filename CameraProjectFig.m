function varargout = CameraProjectFig(varargin)
% CAMERAPROJECTFIG MATLAB code for CameraProjectFig.fig
%      CAMERAPROJECTFIG, by itself, creates a new CAMERAPROJECTFIG or raises the existing
%      singleton*.
%
%      H = CAMERAPROJECTFIG returns the handle to a new CAMERAPROJECTFIG or the handle to
%      the existing singleton*.
%
%      CAMERAPROJECTFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMERAPROJECTFIG.M with the given input arguments.
%
%      CAMERAPROJECTFIG('Property','Value',...) creates a new CAMERAPROJECTFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CameraProjectFig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CameraProjectFig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CameraProjectFig

% Last Modified by GUIDE v2.5 18-Jun-2021 11:51:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CameraProjectFig_OpeningFcn, ...
                   'gui_OutputFcn',  @CameraProjectFig_OutputFcn, ...
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
end

function radio_off(handles)
set(handles.CyanRadio, 'value', 0);
set(handles.GreenRadio, 'value', 0);
set(handles.RedRadio, 'value', 0);
set(handles.PurpleRadio, 'value', 0);
end

% --- Executes just before CameraProjectFig is made visible.
function CameraProjectFig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CameraProjectFig (see VARARGIN)

% Choose default command line output for CameraProjectFig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CameraProjectFig wait for user response (see UIRESUME)
% uiwait(handles.figure1);
assignin('base','handles', handles);
radio_off(handles);
set(handles.RedRadio, 'value', 1);
end

% --- Outputs from this function are returned to the command line.
function varargout = CameraProjectFig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end

% --- Executes on button press in RedRadio.
function RedRadio_Callback(hObject, eventdata, handles)
% hObject    handle to RedRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RedRadio
radio_off(handles);
set(handles.RedRadio, 'value', 1);
ballColor = 'Red';
assignin('base','ballColor', ballColor);
end

% --- Executes on button press in GreenRadio.
function GreenRadio_Callback(hObject, eventdata, handles)
% hObject    handle to GreenRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GreenRadio
radio_off(handles);
set(handles.GreenRadio, 'value', 1);
ballColor = 'Green';
assignin('base','ballColor', ballColor);
end

% --- Executes on button press in PurpleRadio.
function PurpleRadio_Callback(hObject, eventdata, handles)
% hObject    handle to PurpleRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PurpleRadio
radio_off(handles);
set(handles.PurpleRadio, 'value', 1);
ballColor = 'Purple';
assignin('base','ballColor', ballColor);
end

% --- Executes on button press in CyanRadio.
function CyanRadio_Callback(hObject, eventdata, handles)
% hObject    handle to CyanRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CyanRadio
disp('hi');
radio_off(handles);
set(handles.CyanRadio, 'value', 1);
ballColor = 'Cyan';
assignin('base','ballColor', ballColor);
end


function KPIN_Callback(hObject, eventdata, handles)
% hObject    handle to KPIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KPIN as text
%        str2double(get(hObject,'String')) returns contents of KPIN as a double
kp = str2double(get(hObject,'String'));
assignin('base','kp', kp);
end

% --- Executes during object creation, after setting all properties.
function KPIN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KPIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function KIIN_Callback(hObject, eventdata, handles)
% hObject    handle to KIIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KIIN as text
%        str2double(get(hObject,'String')) returns contents of KIIN as a double
ki = str2double(get(hObject,'String'));
assignin('base','ki', ki);
end

% --- Executes during object creation, after setting all properties.
function KIIN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KIIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function KDIN_Callback(hObject, eventdata, handles)
% hObject    handle to KDIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KDIN as text
%        str2double(get(hObject,'String')) returns contents of KDIN as a double
kd = str2double(get(hObject,'String'));
assignin('base','kd', kd);
end

% --- Executes during object creation, after setting all properties.
function KDIN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KDIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
