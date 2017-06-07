clear all; close all; clc;

originalImg = im2double(imread('sample.jpg'));
[h, w, c] = size(originalImg);
resultImg = zeros(600,450,c);
imshow(originalImg);

%% Mouse input
xlabel ('Select 4 points along the outline', 'FontName', '·L³n¥¿¶ÂÅé', 'FontSize', 14);
[ x, y ] = ginput(4);
point = [x y];

% A = [-x(1) -y(1) -1 0 0 0 x(1)*1 y(1)*1;
%      0 0 0 -x(1) -y(1) -1 x(1)*1 y(1)*1;
%      -x(2) -y(2) -1 0 0 0 x(2)*450 y(2)*450;
%      0 0 0 -x(2) -y(2) -1 x(2)*1 y(2)*1;
%      -x(3) -y(3) -1 0 0 0 x(3)*450 y(3)*450;
%      0 0 0 -x(3) -y(3) -1 x(3)*600 y(3)*600;
%      -x(4) -y(4) -1 0 0 0 x(4)*1 y(4)*1;
%      0 0 0 -x(4) -y(4) -1 x(4)*600 y(4)*600
%      ];
m = [x(1) y(1) 1 0 0 0 -x(1)*1 -y(1)*1;
     x(2) y(2) 1 0 0 0 -x(2)*450 -y(2)*450;
     x(3) y(3) 1 0 0 0 -x(3)*450 -y(3)*450;
     x(4) y(4) 1 0 0 0 -x(4)*1 -y(4)*1;
     0 0 0 x(1) y(1) 1 -x(1)*1 -y(1)*1;
     0 0 0 x(2) y(2) 1 -x(2)*1 -y(2)*1;
     0 0 0 x(3) y(3) 1 -x(3)*600 -y(3)*600;
     0 0 0 x(4) y(4) 1 -x(4)*600 -y(4)*600;
    ];

% z = [-1;-1;-450;-1;-450;-600;-1;-600];
z = [1; 450; 450; 1; 1; 1; 600; 600];
H = m\z;
H = H';

%  H = [A\z ;1];
%  H_reshape = reshape(H,3,3);
%  H_reshape = H_reshape';
%  H_plum = inv(H_reshape);
 for i = 1:4
     a = (H(1)*x(i) + H(2)*y(i) + H(3))/(H(7)*x(i) + H(8)*y(i) + 1);
     b = (H(4)*x(i) + H(5)*y(i) + H(6))/(H(7)*x(i) + H(8)*y(i) + 1);
     fprintf('x y : %f %f\n',a,b );
 end
 A = H(1) - H(7)*450;
 B = H(2) - H(8)*450;
 C = 450 - H(3);
 D = H(4) - H(7)*600;
 E = H(5) - H(8)*600;
 F = 600 - H(6);
a = ((C*E)-(B*F))/((A*E)-(B*D)); 
b = ((C*D)-(A*F))/((B*D)-(A*E)); 
fprintf('x y : %f %f\n',a,b );
 
 for i = 1:600
     for j = 1:450
         A = H(1) - H(7)*j;
         B = H(2) - H(8)*j;
         C = j - H(3);
         D = H(4) - H(7)*i;
         E = H(5) - H(8)*i;
         F = i - H(6);
         a = ((C*E)-(B*F))/((A*E)-(B*D)); 
         b = ((C*D)-(A*F))/((B*D)-(A*E)); 
         resultImg(i,j,:) = originalImg(round(b), round(a), :);
     end
 end 


%  for i = 1:450
%      for j = 1:450
%          p = H_plum * [i; j; 1];
%          resultImg(i,j,:) = originalImg(round(p(1)), round(p(2)), :);
%      end
%  end
%  
 imshow(resultImg);