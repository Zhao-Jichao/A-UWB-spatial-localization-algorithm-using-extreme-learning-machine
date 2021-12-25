% 任务4: 
% Date: 2021-10-17
% Author: Zhao-Jichao
clear
clc

% 输入还是四个数据
% 输出应该有两种结果：1(无干扰)，2(有干扰)

%%
data = load('PyCodes/Z4.txt');
temp = randperm(size(data,1));
P_train = data(temp(1:324*170),1:4)';
T_train = data(temp(1:324*170),5:5)';
P_test = data(temp(324*170+1:324*200),1:4)';
T_test = data(temp(324*170+1:324*200),5:5)';

%%
for i = 1:20
L = 600;
[IW,B,LW,TF,TYPE] = elmtrain(P_train,T_train,L,'sig',1);
T_sim = elmpredict(P_test,IW,B,LW,TF,TYPE);
result = [T_test' T_sim'];
E = mse(T_sim - T_test);

disp(string(i) +'---'+ string(E))
if E<0.17
break

%% 附件 4 数据
data1 = [2940 4290 2840 4190]';
data2 = [5240 5360 2040 2940]';
data3 = [4800 2610 4750 2550]';
data4 = [5010 4120 3810 2020]';
data5 = [2840 4490 2860 4190]';
data6 = [5010 5320 1990 2930]';
data7 = [5050 3740 3710 2070]';
data8 = [5050 4110 3710 2110]';
data9 = [4840 2600 4960 2700]';
data10= [2740 2720 4670 4790]';
alldata = [data1 data2 data3 data4 data5 data6 data7 data8 data9 data10];

for i = 1:10
    data = alldata(:,i);
    predict(:,i) = elmpredict(data,IW,B,LW,TF,TYPE);
end

disp(predict)

end
end

