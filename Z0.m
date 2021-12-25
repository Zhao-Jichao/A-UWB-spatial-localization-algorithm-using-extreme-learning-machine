% 华为杯
% Author: Zhao-Jichao
% Date: 2021-10-14
clear
clc

%%
A0 = [   0,    0, 1300];
A1 = [5000,    0, 1700];
A2 = [   0, 5000, 1700];
A3 = [5000, 5000, 1300];
scatter3(A0(1),A0(2),A0(3), 300, 'p', 'linewidth', 1.5); hold on;   % Anchor A0
scatter3(A1(1),A1(2),A1(3), 300, 'p', 'linewidth', 1.5);	% Anchor A1
scatter3(A2(1),A2(2),A2(3), 300, 'p', 'linewidth', 1.5);	% Anchor A2
scatter3(A3(1),A3(2),A3(3), 300, 'p', 'linewidth', 1.5);	% Anchor A3
axis([-1000 6000   -1000 6000   1000 2400]);                   % 设置图显示范围
text(A0(1),A0(2),A0(3), '   A0');	% 添加文字标识
text(A1(1),A1(2),A1(3), '   A1');
text(A2(1),A2(2),A2(3), '   A2');
text(A3(1),A3(2),A3(3), '   A3');
line([A0(1),A1(1)], [A0(2),A1(2)], [A0(3),A1(3)]);	% 绘制线段
line([A0(1),A2(1)], [A0(2),A2(2)], [A0(3),A2(3)]);
line([A2(1),A3(1)], [A2(2),A3(2)], [A2(3),A3(3)]);
line([A3(1),A1(1)], [A3(2),A1(2)], [A3(3),A1(3)]);
xlabel('X/mm');
ylabel('Y/mm');
zlabel('Z/mm');
title('实验场景1锚点(anchor)及324个靶点(Tag)');


%% 实验场景2
A0 = [   0,    0, 1200];
A1 = [5000,    0, 1600];
A2 = [   0, 3000, 1600];
A3 = [5000, 3000, 1200];


%% 解方程组
syms x y z real
syms x0 y0 z0 x1 y1 z1 x2 y2 z2 x3 y3 z3 real
syms R0 R1 R2 R3 real
x0 = A0(1); y0 = A0(2); z0 = A0(3);
x1 = A1(1); y1 = A1(2); z1 = A1(3);
x2 = A2(1); y2 = A2(2); z2 = A2(3);
x3 = A3(1); y3 = A3(2); z3 = A3(3);

% x = 500;
% y = 500;
% z = 880;

R0 = 760;
R1 = 4550;
R2 = 4550;
R3 = 6300;

eqns = [(x-x0)^2+(y-y0)^2+(z-z0)^2==R0^2,...
        (x-x1)^2+(y-y1)^2+(z-z1)^2==R1^2,...
        (x-x2)^2+(y-y2)^2+(z-z2)^2==R2^2,...
        (x-x3)^2+(y-y3)^2+(z-z3)^2==R3^2];

vars = [x y z];
[x, y, z] = solve(eqns,vars);
x = round(x);
y = round(y);
z = round(z);

% vars = [R0 R1 R2 R3];
% [R0, R1, R2, R3] = solve(eqns,vars);
% R0 = round(R0)
% R1 = round(R1)
% R2 = round(R2)
% R3 = round(R3)

%% sg滤波器
% y = sgolayfilt(x,order,framelen)

%%
B = load('Tag坐标信息.txt');
for i=1:1:324
    x = B(i,2)*10;
    y = B(i,3)*10;
    z = B(i,4)*10;
    scatter3(x,y,z, 20, 'linewidth', 1.5);	% Tag
end



