function [resultImg] = swap(originalImg)

[h, w, c] = size(originalImg);
resultImg = originalImg;
imshow(originalImg);

%% Mouse input
xlabel ('Select 8 points to swap the content of two area', 'FontName', '·L³n¥¿¶ÂÅé', 'FontSize', 14);
[ x, y ] = ginput(8);

m = [x(1) y(1) 1 0 0 0 -x(1)*x(5) -y(1)*x(5);
     x(2) y(2) 1 0 0 0 -x(2)*x(6) -y(2)*x(6);
     x(3) y(3) 1 0 0 0 -x(3)*x(7) -y(3)*x(7);
     x(4) y(4) 1 0 0 0 -x(4)*x(8) -y(4)*x(8);
     0 0 0 x(1) y(1) 1 -x(1)*y(5) -y(1)*y(5);
     0 0 0 x(2) y(2) 1 -x(2)*y(6) -y(2)*y(6);
     0 0 0 x(3) y(3) 1 -x(3)*y(7) -y(3)*y(7);
     0 0 0 x(4) y(4) 1 -x(4)*y(8) -y(4)*y(8);
    ];

z = [x(5); x(6); x(7); x(8); y(5); y(6); y(7); y(8)];
H = m\z;
H = H';

%  debug
%  for i = 1:4
%      a = (H(1)*x(i) + H(2)*y(i) + H(3))/(H(7)*x(i) + H(8)*y(i) + 1);
%      b = (H(4)*x(i) + H(5)*y(i) + H(6))/(H(7)*x(i) + H(8)*y(i) + 1);
%      fprintf('x y : %f %f\n',a,b );
%  end

m = (y(5) - y(6)) / (x(5) - x(6));
c = y(5) - m*x(5);
top = [m c];

if(x(6) == x(7))
    m = 10000;
else
    m = (y(6) - y(7)) / (x(6) - x(7));
end
c = y(6) - m*x(6);
right = [m c];

m = (y(7) - y(8)) / (x(7) - x(8));
c = y(7) - m*x(7);
down = [m c];

if(x(8) == x(5))
    m = 10000;
else
    m = (y(8) - y(5)) / (x(8) - x(5));
end
c = y(5) - m*x(5);
left = [m c];

max_x = round(max(x(5:8)));
min_x = round(min(x(5:8)));
max_y = round(max(y(5:8)));
min_y = round(min(y(5:8)));

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
% second part
m = [x(5) y(5) 1 0 0 0 -x(5)*x(1) -y(5)*x(1);
     x(6) y(6) 1 0 0 0 -x(6)*x(2) -y(6)*x(2);
     x(7) y(7) 1 0 0 0 -x(7)*x(3) -y(7)*x(3);
     x(8) y(8) 1 0 0 0 -x(8)*x(4) -y(8)*x(4);
     0 0 0 x(5) y(5) 1 -x(5)*y(1) -y(5)*y(1);
     0 0 0 x(6) y(6) 1 -x(6)*y(2) -y(6)*y(2);
     0 0 0 x(7) y(7) 1 -x(7)*y(3) -y(7)*y(3);
     0 0 0 x(8) y(8) 1 -x(8)*y(4) -y(8)*y(4);
    ];

z = [x(1); x(2); x(3); x(4); y(1); y(2); y(3); y(4)];
H = m\z;
H = H';

% debug
% fprintf('second part');
%  for i = 1:4
%      a = (H(1)*x(i) + H(2)*y(i) + H(3))/(H(7)*x(i) + H(8)*y(i) + 1);
%      b = (H(4)*x(i) + H(5)*y(i) + H(6))/(H(7)*x(i) + H(8)*y(i) + 1);
%      fprintf('x y : %f %f\n',a,b );
%  end


m = (y(1) - y(2)) / (x(1) - x(2));
c = y(1) - m*x(1);
top = [m c];

if(x(2) == x(3))
    m = 10000;
else
    m = (y(2) - y(3)) / (x(2) - x(3));
end
c = y(2) - m*x(2);
right = [m c];

m = (y(3) - y(4)) / (x(3) - x(4));
c = y(3) - m*x(3);
down = [m c];

if(x(4) == x(1))
    m = 10000;
else
    m = (y(4) - y(1)) / (x(4) - x(1));
end
c = y(1) - m*x(1);
left = [m c];

max_x = round(max(x(1:4)));
min_x = round(min(x(1:4)));
max_y = round(max(y(1:4)));
min_y = round(min(y(1:4)));

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
end