function varargout = task2(varargin)
% TASK2 MATLAB code for task2.fig
%      TASK2, by itself, creates a new TASK2 or raises the existing
%      singleton*.
%
%      H = TASK2 returns the handle to a new TASK2 or the handle to
%      the existing singleton*.
%
%      TASK2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TASK2.M with the given input arguments.
%
%      TASK2('Property','Value',...) creates a new TASK2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before task2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to task2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help task2

% Last Modified by GUIDE v2.5 01-Aug-2017 12:11:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @task2_OpeningFcn, ...
                   'gui_OutputFcn',  @task2_OutputFcn, ...
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


% --- Executes just before task2 is made visible.
function task2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to task2 (see VARARGIN)

% Choose default command line output for task2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes task2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = task2_OutputFcn(hObject, eventdata, handles) 
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
axes(handles.axes1);
hold off;
cla reset;
I=imread('pic1.png');
I=rgb2gray(I);
rotI=imrotate(I,0,'crop');
BW=edge(rotI,'log');
%BW=fspecial('prewitt');
imshow(BW);
[H,T,R] = hough(BW);
%imshow(H,[],'XData',T,'YData',R,...
%            'InitialMagnification','fit');
%xlabel('\theta'), ylabel('\rho');
%axis on, axis normal, hold on;
P  = houghpeaks(H,30,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',30);
lines1 = houghlines(BW,T,R,P,'FillGap',1,'MinLength',10000);
 imshow(rotI), hold on
max_len = 0;
Max=[600,300;600,300];
Min=[400,150;400,150];
i=1;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   
    if(xy<Max)
       if(xy>Min)           
           lines1(i)=lines(k);
           i=i+1;
       end
    end

     
   if(xy<Max)
       if(xy>Min)
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   
       end
   end    
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
% highlight the longest line segment
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
num3=0;
Tnew=struct2table(lines1);
Anew=struct2array(lines1); 
q=zeros(5,6);

for k = 1:length(lines1)
    for t = 1+num3:6+num3
    q(k,t-num3)=Anew(1,t);
    end
    num3=num3+6;
end

f = figure;
t = uitable(f,'Data',q,'Position',[10 100 483 204]);
t.ColumnName = {'point1.x','point1.y','point2.x','point2.y','theta','rho'};
t.ColumnEditable = true;
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
hold off;
cla reset;
I = imread('pic2.png');
I=rgb2gray(I);
I=imsharpen(I);
I=imsharpen(I);
I=imsharpen(I);
rotI=imrotate(I,0,'crop');
BW=edge(rotI,'log');
BW=edge(BW,'log');
BW=edge(BW,'log');
BW=edge(BW,'log');
%BW=fspecial('prewitt');
%imshow(BW);
[H,T,R] = hough(BW);
%imshow(H,[],'XData',T,'YData',R,...
%            'InitialMagnification','fit');
%xlabel('\theta'), ylabel('\rho');
%axis on, axis normal, hold on;
P  = houghpeaks(H,100,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
lines = houghlines(BW,T,R,P,'FillGap',1,'MinLength',1);
lines2 = houghlines(BW,T,R,P,'FillGap',1,'MinLength',10000);
 imshow(rotI), hold on
max_len = 0;
Max=[100,315;200,400];
Min=[20,250;0,250];
i=1;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   
    if(xy<Max)
       if(xy>Min)           
           lines1(i)=lines(k);
           i=i+1;
       end
    end

     
   if(xy<Max)
       if(xy>Min)
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   
       end
   end    
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
% highlight the longest line segment
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
num3=0;
Tnew=struct2table(lines1);
Anew=struct2array(lines1); 
q=zeros(6,6);

for k = 1:length(lines1)
    for t = 1+num3:6+num3
    q(k,t-num3)=Anew(1,t);
    end
    num3=num3+6;
end

f = figure;
t = uitable(f,'Data',q,'Position',[10 100 483 204]);
t.ColumnName = {'point1.x','point1.y','point2.x','point2.y','theta','rho'};
t.ColumnEditable = true;
guidata(hObject, handles);

% --------------------------------------------------------------------
function uitable3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
