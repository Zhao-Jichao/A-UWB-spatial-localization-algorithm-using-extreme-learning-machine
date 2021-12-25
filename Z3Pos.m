%% 附件3 数据及验证结果
data1 = [4220 2580 3730 1450]';
data2 = [4500 1940 4420 1460]';
data3 = [3550 2510 3410 2140]';
data4 = [3300 3130 2900 2790]';
data5 = [ 720 4520 3050 5380]';
alldata = [data1 data2 data3 data4 data5];

%% 加载权重矩阵
load B600.mat
load IW600.mat
load LW600.mat
TF = 'sig';
TYPE = 0;

for i = 1:5
    data = alldata(:,i);
    predict(:,i) = elmpredict(data,IW,B,LW,TF,TYPE);
end

%%
A0 = [   0,    0, 1200];
A1 = [5000,    0, 1600];
A2 = [   0, 3000, 1600];
A3 = [5000, 3000, 1200];
figure(2)
scatter3(A0(1),A0(2),A0(3), 300, 'p', 'linewidth', 1.5); hold on;   % Anchor A0
scatter3(A1(1),A1(2),A1(3), 300, 'p', 'linewidth', 1.5);	% Anchor A1
scatter3(A2(1),A2(2),A2(3), 300, 'p', 'linewidth', 1.5);	% Anchor A2
scatter3(A3(1),A3(2),A3(3), 300, 'p', 'linewidth', 1.5);	% Anchor A3
scatter3(predict(1,1), predict(2,1), predict(3,1), 200, 'linewidth', 1.5); hold on;   % data1
scatter3(predict(1,2), predict(2,2), predict(3,2), 200, 'linewidth', 1.5); hold on;   % data2
scatter3(predict(1,3), predict(2,3), predict(3,3), 200, 'linewidth', 1.5); hold on;   % data3
scatter3(predict(1,4), predict(2,4), predict(3,4), 200, 'linewidth', 1.5); hold on;   % data4
scatter3(predict(1,5), predict(2,5), predict(3,5), 200, 'linewidth', 1.5); hold on;   % data5
axis([-3000 7000   -3000 7000   -2000 4000]);                   % 设置图显示范围
text(A0(1),A0(2),A0(3), '   A0');	% 添加文字标识
text(A1(1),A1(2),A1(3), '   A1');
text(A2(1),A2(2),A2(3), '   A2');
text(A3(1),A3(2),A3(3), '   A3');
text(predict(1,1), predict(2,1), predict(3,1), '   data1');
text(predict(1,2), predict(2,2), predict(3,2), '   data2');
text(predict(1,3), predict(2,3), predict(3,3), '   data3');
text(predict(1,4), predict(2,4), predict(3,4), '   data4');
text(predict(1,5), predict(2,5), predict(3,5), '   data5');
line([A0(1),A1(1)], [A0(2),A1(2)], [A0(3),A1(3)]);	% 绘制线段
line([A0(1),A2(1)], [A0(2),A2(2)], [A0(3),A2(3)]);
line([A2(1),A3(1)], [A2(2),A3(2)], [A2(3),A3(3)]);
line([A3(1),A1(1)], [A3(2),A1(2)], [A3(3),A1(3)]);

xlabel('X/mm');
ylabel('Y/mm');
zlabel('Z/mm');
title('附件3无信号干扰时模型定位图');

