clear all; close all; clc;

originalImg = im2double(imread('sample.jpg'));
[h, w, c] = size(originalImg);
resultImg = zeros(h,w,c);
imshow(originalImg);

%% Mouse input
xlabel ('Select 4 points along the outline', 'FontName', '·L³n¥¿¶ÂÅé', 'FontSize', 14);
[ x, y ] = ginput(4);
point = [x y];

A = [-x(1) -y(1) -1 0 0 0 x(1)*1 y(1)*1;
     0 0 0 -x(1) -y(1) -1 x(1)*1 y(1)*1;
     -x(2) -y(2) -1 0 0 0 x(2)*150 y(2)*150;
     0 0 0 -x(2) -y(2) -1 x(2)*1 y(2)*1;
     -x(3) -y(3) -1 0 0 0 x(3)*150 y(3)*150;
     0 0 0 -x(3) -y(3) -1 x(3)*1 y(3)*150;
     -x(4) -y(4) -1 0 0 0 x(4)*1 y(4)*1;
     0 0 0 -x(4) -y(4) -1 x(4)*150 y(4)*150
     ];
 
 z = [1;1;150;1;150;150;1;150];
 H = [A\z ; 1];
 H_reshape = reshape(H,3,3);
 H_reshape = H_reshape';
 H_plum = inv(H_reshape);
 
 for i = 1:150
     for j = 1:150
         p = H_plum * [i; j; 1];
         resultImg(i,j,:) = originalImg(round(p(1), round(p(2))), :);
     end
 end
 
 imshow(resultImg);