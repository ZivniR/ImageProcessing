function varargout = untitled1(varargin)
% UNTITLED1 MATLAB code for untitled1.fig
%      UNTITLED1, by itself, creates a new UNTITLED1 or raises the existing
%      singleton*.
%
%      H = UNTITLED1 returns the handle to a new UNTITLED1 or the handle to
%      the existing singleton*.
%
%      UNTITLED1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED1.M with the given input arguments.
%
%      UNTITLED1('Property','Value',...) creates a new UNTITLED1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled1

% Last Modified by GUIDE v2.5 27-Jul-2017 16:49:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled1_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled1_OutputFcn, ...
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


% --- Executes just before untitled1 is made visible.
function untitled1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled1 (see VARARGIN)

% Choose default command line output for untitled1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global im im2 num1;

ten=10;
%[impath, user_canceled] = imgetfile;
%if user_canceled
%    msgbox(sprintf('Cancelled by user!\nOperation could not be completed'),'error','error');
%    return;
%end

I1 = imresize(im, [300, 400]);
imwrite(I1,'p1.pgm');
I2 = imresize(im2, [300, 400]);
imwrite(I2,'p2.pgm');
value=match('p1.pgm','p2.pgm');
if value<ten
    set(handles.text2, 'String', 'no match');
else
    set(handles.text2, 'String', 'match');
    baseFileName = sprintf('%d.jpg', num1); % e.g. "1.png"
    fullFileName = fullfile('C:\','Users','Ziv-Nir','Desktop','IP final','ANS', baseFileName); % No need to worry about slashes now!
    imwrite(im, fullFileName);
    %imwrite(im,sprintf('C:\Users\Ziv-Nir\Desktop\IP final\ANS\p%d',num1),'jpg');
    handles.num1=num1;
    handles.output = hObject;
    filelist2=dir(fullfile('C:\','Users','Ziv-Nir','Desktop','IP final','ANS\*.jpg'));
    handles.filelist2 = filelist2;
    handles.frameindex = 1;
    % Update handles structure
    guidata(hObject, handles);
    axes(handles.axes3);
    num1=Counter(hObject, eventdata, handles,num1);
    handles.num1=num1;
    guidata(hObject, handles);
    filelist = handles.filelist;
    frameindex  = handles.frameindex;
    myfolder='C:\Users\Ziv-Nir\Desktop\IP final\ANS';
    currentframefile = filelist(frameindex).name;
    handles.frameindex = frameindex-1;
    ff=fullfile(myfolder,currentframefile);
    im=imread(ff);
    imshow(im);
    guidata(hObject, handles);

end
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on pushbutton1 and none of its controls.
function pushbutton1_KeyPressFcn(hObject, eventdata, handles)

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global im im2;
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
filelist = handles.filelist;
frameindex  = handles.frameindex;
myfolder='C:\Users\Ziv-Nir\Desktop\IP final\DB';
currentframefile = filelist(frameindex).name;
handles.frameindex = frameindex-1;
ff=fullfile(myfolder,currentframefile);
im=imread(ff);
imshow(im);
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global im im2;
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
filelist = handles.filelist;
frameindex  = handles.frameindex;
myfolder='C:\Users\Ziv-Nir\Desktop\IP final\DB';
currentframefile = filelist(frameindex).name;
handles.frameindex = frameindex+1;
ff=fullfile(myfolder,currentframefile);
im=imread(ff);
imshow(im);
guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global im im2;
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
filelist2 = handles.filelist2;
frameindex  = handles.frameindex;
myfolder='C:\Users\Ziv-Nir\Desktop\IP final\Q';
currentframefile = filelist2(frameindex).name;
handles.frameindex = frameindex-1;
ff=fullfile(myfolder,currentframefile);
im2=imread(ff);
imshow(im2);
guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
global im im2;
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
filelist2 = handles.filelist2;
frameindex  = handles.frameindex;
myfolder='C:\Users\Ziv-Nir\Desktop\IP final\Q';
currentframefile = filelist2(frameindex).name;
handles.frameindex = frameindex+1;
ff=fullfile(myfolder,currentframefile);
im2=imread(ff);
imshow(im2);
guidata(hObject, handles);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global im im2;
% hObject handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
filelist=dir(fullfile('C:\','Users','Ziv-Nir','Desktop','IP final','DB\*.jpg'));
handles.filelist = filelist;
handles.frameindex = 1;
% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
global im im2;
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
filelist2=dir(fullfile('C:\','Users','Ziv-Nir','Desktop','IP final','Q\*.jpg'));
handles.filelist2 = filelist2;
handles.frameindex = 1;
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes3);
filelist3 = handles.filelist3;
frameindex  = handles.frameindex;
myfolder='C:\Users\Ziv-Nir\Desktop\IP final\ANS';
currentframefile = filelist3(frameindex).name;
handles.frameindex = frameindex+1;
ff=fullfile(myfolder,currentframefile);
im2=imread(ff);
imshow(im2);
guidata(hObject, handles);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes3);
filelist3 = handles.filelist3;
frameindex  = handles.frameindex;
myfolder='C:\Users\Ziv-Nir\Desktop\IP final\ANS';
currentframefile = filelist3(frameindex).name;
handles.frameindex = frameindex-1;
ff=fullfile(myfolder,currentframefile);
im2=imread(ff);
imshow(im2);
guidata(hObject, handles);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
filelist3=dir(fullfile('C:\','Users','Ziv-Nir','Desktop','IP final','ANS\*.jpg'));
handles.filelist3 = filelist3;
handles.frameindex = 1;
% Update handles structure
guidata(hObject, handles); 


% --- Executes during object creation, after setting all properties.
function counter=Counter(hObject, eventdata, handles,counter)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

counter= counter +1
