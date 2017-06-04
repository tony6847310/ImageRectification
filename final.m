clear all; close all; clc;

rbImage = im2double(imread('icon_back.png'));
[h, w, ~] = size(rbImage);
imshow(rbImage);

%% Mouse input
xlabel ('Select 4 points along the outline', 'FontName', '·L³n¥¿¶ÂÅé', 'FontSize', 14);
[ x, y ] = ginput(100);
point = [x y];

A = [-x(1) -y(1) -1 0 0 0 x(1)*0 y(1)*0;
     0 0 0 -x(1) -y(1) -1 x(1)*0 y(1)*0;
     -x(2) -y(2) -1 0 0 0 x(2)*150 y(2)*150;
     0 0 0 -x(2) -y(2) -1 x(2)*0 y(2)*0;
     -x(3) -y(3) -1 0 0 0 x(3)*150 y(3)*150;
     0 0 0 -x(3) -y(3) -1 x(3)*0 y(3)*150;
     -x(4) -y(4) -1 0 0 0 x(4)*0 y(4)*0;
     0 0 0 -x(4) -y(4) -1 x(4)*150 y(4)*150
     ];
 
 z = [0;0;150;0;150;150;0;150];
 H = A\z;