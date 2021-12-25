%% 附件3 数据及验证结果
data6 = [5100 2220 4970 800 ]';
data7 = [2900 3210 3140 2890]';
data8 = [2380 3530 2320 3760]';
data9 = [2150 3220 3140 3640]';
data10= [1620 3950 2580 4440]';
alldata = [data6 data7 data8 data9 data10];

%% 加载权重矩阵
load B600Neg.mat
load IW600Neg.mat
load LW600Neg.mat
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
text(predict(1,1), predict(2,1), predict(3,1), '   data6');
text(predict(1,2), predict(2,2), predict(3,2), '   data7');
text(predict(1,3), predict(2,3), predict(3,3), '   data8');
text(predict(1,4), predict(2,4), predict(3,4), '   data9');
text(predict(1,5), predict(2,5), predict(3,5), '   data10');
line([A0(1),A1(1)], [A0(2),A1(2)], [A0(3),A1(3)]);	% 绘制线段
line([A0(1),A2(1)], [A0(2),A2(2)], [A0(3),A2(3)]);
line([A2(1),A3(1)], [A2(2),A3(2)], [A2(3),A3(3)]);
line([A3(1),A1(1)], [A3(2),A1(2)], [A3(3),A1(3)]);

xlabel('X/mm');
ylabel('Y/mm');
zlabel('Z/mm');
title('附件3有信号干扰时模型定位图');







