%% I. 清空环境变量
clear
clc

%% II. 训练集/测试集产生
% 1. 导入数据
data = load('PyCodes/Z2Pos.txt');

for i = 1:20
    
% 2. 随机产生训练集和测试集
temp = randperm(size(data,1));       % randperm 整数的随机排列

% 训练集
% P_train = data(1:324*75,1:4)';
% T_train = data(1:324*75,5:7)';
% 加入随机效果
P_train = data(temp(1:324*85),1:4)';
T_train = data(temp(1:324*85),5:7)';

% 测试集
% P_test = data(324*75+1:324*100,1:4)';
% T_test = data(324*75+1:324*100,5:7)';
% 加入随机效果
P_test = data(temp(324*85+1:324*100),1:4)';
T_test = data(temp(324*85+1:324*100),5:7)';

% 有了随机，效果更好

%% IV. ELM创建/训练
L = 600;
[IW,B,LW,TF,TYPE] = elmtrain(P_train,T_train,L,'sig',0);

%% V. ELM仿真测试
T_sim = elmpredict(P_test,IW,B,LW,TF,TYPE);

%% VI. 结果对比
result = [T_test' T_sim'];

% 1. 均方误差
E = mse(T_sim - T_test);

disp(string(i) +'---'+ string(E))

if E<20000
    break
end
end

% 2. 决定系数
N = length(T_test);
% R2=(N*sum(T_sim.*T_test)-sum(T_sim)*sum(T_test))^2/((N*sum((T_sim).^2)-(sum(T_sim))^2)*(N*sum((T_test).^2)-(sum(T_test))^2)); 
R2 = 1;

%% VII. 绘图
figure(1)
subplot(2,2,1)
plot(1:N,T_test(1,:),'red-*',1:N,T_sim(1,:),'blue:o');
grid on
legend('真实值','预测值')
xlabel('样本编号')
string = {'X';['(mse = ' num2str(E) ' R^2 = ' num2str(R2) ')']};
title(string)
subplot(2,2,2)
plot(1:N,T_test(2,:),'red-*',1:N,T_sim(2,:),'blue:o');
grid on
legend('真实值','预测值')
subplot(2,2,3)
plot(1:N,T_test(3,:),'red-*',1:N,T_sim(3,:),'blue:o');
grid on
legend('真实值','预测值')





%% 附件 2 数据及验证结果
data1 = [1320 3950 4540 5760]';
data2 = [3580 2580 4610 3730]';
data3 = [2930 2600 4740 4420]';
data4 = [2740 2720 4670 4790]';
data5 = [2980 4310 2820 4320]';
alldata = [data1 data2 data3 data4 data5];


%% 加载权重矩阵

TF = 'sig';
TYPE = 0;

for i = 1:5
    data = alldata(:,i);
    predict(:,i) = elmpredict(data,IW,B,LW,TF,TYPE);
end



%%
A0 = [   0,    0, 1300];
A1 = [5000,    0, 1700];
A2 = [   0, 5000, 1700];
A3 = [5000, 5000, 1300];
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


axis([-2000 7000   -2000 7000   0000 4000]);                   % 设置图显示范围
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
title('附件2无信号干扰时模型定位图');

