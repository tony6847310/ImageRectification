clear all; close all; clc;

originalImg = im2double(imread('sample2.jpg'));
[h, w, c] = size(originalImg);
resultImg = originalImg;
imshow(originalImg);

%% Mouse input
xlabel ('Select 8 points along the outline', 'FontName', '·L³n¥¿¶ÂÅé', 'FontSize', 14);
[ x, y ] = ginput(8);
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
m = [x(1) y(1) 1 0 0 0 -x(1)*x(5) -y(1)*x(5);
     x(2) y(2) 1 0 0 0 -x(2)*x(6) -y(2)*x(6);
     x(3) y(3) 1 0 0 0 -x(3)*x(7) -y(3)*x(7);
     x(4) y(4) 1 0 0 0 -x(4)*x(8) -y(4)*x(8);
     0 0 0 x(1) y(1) 1 -x(1)*y(5) -y(1)*y(5);
     0 0 0 x(2) y(2) 1 -x(2)*y(6) -y(2)*y(6);
     0 0 0 x(3) y(3) 1 -x(3)*y(7) -y(3)*y(7);
     0 0 0 x(4) y(4) 1 -x(4)*y(8) -y(4)*y(8);
    ];

% z = [-1;-1;-450;-1;-450;-600;-1;-600];
z = [x(5); x(6); x(7); x(8); y(5); y(6); y(7); y(8)];
H = m\z;
H = H';

%  H = [A\z ;1];
%  H_reshape = reshape(H,3,3);
%  H_reshape = H_reshape';
%  H_plum = inv(H_reshape);
%  for i = 1:4
%      a = (H(1)*x(i) + H(2)*y(i) + H(3))/(H(7)*x(i) + H(8)*y(i) + 1);
%      b = (H(4)*x(i) + H(5)*y(i) + H(6))/(H(7)*x(i) + H(8)*y(i) + 1);
%      fprintf('x y : %f %f\n',a,b );
%  end
%  A = H(1) - H(7)*450;
%  B = H(2) - H(8)*450;
%  C = 450 - H(3);
%  D = H(4) - H(7)*600;
%  E = H(5) - H(8)*600;
%  F = 600 - H(6);
% a = ((C*E)-(B*F))/((A*E)-(B*D)); 
% b = ((C*D)-(A*F))/((B*D)-(A*E)); 
% fprintf('x y : %f %f\n',a,b );
%  
%  for i = 1:600
%      for j = 1:450
%          A = H(1) - H(7)*j;
%          B = H(2) - H(8)*j;
%          C = j - H(3);
%          D = H(4) - H(7)*i;
%          E = H(5) - H(8)*i;
%          F = i - H(6);
%          a = ((C*E)-(B*F))/((A*E)-(B*D)); 
%          b = ((C*D)-(A*F))/((B*D)-(A*E)); 
%          resultImg(i,j,:) = originalImg(round(b), round(a), :);
%      end
%  end 

m = (y(5) - y(6)) / (x(5) - x(6));
c = y(5) - m*x(5);
top = [m c];

m = (y(6) - y(7)) / (x(6) - x(7));
c = y(6) - m*x(6);
right = [m c];

m = (y(7) - y(8)) / (x(7) - x(8));
c = y(7) - m*x(7);
down = [m c];

m = (y(8) - y(5)) / (x(8) - x(5));
c = y(5) - m*x(5);
left = [m c];

max_x = max(x(5:8));
min_x = min(x(5:8));
max_y = max(y(5:8));
min_y = min(y(5:8));

for i = min_y:max_y
    for j = min_x:max_x
        if i-j*top(1) >= top(2) && i-j*down(1) < down(2)
            if (left(1) > 0 && i-j*left(1) < left(2)) || (left(1) < 0 && i-j*left(1) >= left(2))
                if (right(1) > 0 && i-j*right(1) >= right(2)) || (right(1) < 0 && i-j*right(1) < right(2))
                    %fprintf('doooo\n');
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
        end
    end
end

imshow(resultImg);
 