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
imshow(BW);
[H,T,R] = hough(BW);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
P  = houghpeaks(H,100,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
lines = houghlines(BW,T,R,P,'FillGap',1,'MinLength',1);
lines1 = houghlines(BW,T,R,P,'FillGap',1,'MinLength',10000);
figure, imshow(rotI), hold on
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