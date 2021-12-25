% 任务5: 绘制动态位置数据
% Date: 2021-10-18
% Author: Zhao-Jichao

%%
data = load('C附件5.txt');

x = zeros(1,1);
y = zeros(1,1);
z = zeros(1,1);

for i=1:size(data,1)
    load BZ4.mat;   load IWZ4.mat;  load LWZ4.mat;  TF = 'sig'; TYPE = 1;
    T_sim = elmpredict(data(i,:)',IW,B,LW,TF,TYPE);
    
    if T_sim == 1
        load B600.mat;   load IW600.mat;  load LW600.mat;  TF = 'sig'; TYPE = 0;
    else
        load B600Neg.mat;   load IW600Neg.mat;  load LW600Neg.mat;  TF = 'sig'; TYPE = 0;
    end
    
    T_sim = elmpredict(data(i,:)',IW,B,LW,TF,TYPE);
    x(i,:) = T_sim(1);
    y(i,:) = T_sim(2);
    z(i,:) = T_sim(3);
end

for i=1:1:size(x,1)
    subplot(2,2,1)
    scatter3(x(1:i,:), y(1:i,:), z(1:i,:), 30); hold on; grid on;
    axis([0 5000   0 5000   0 2500]);
    xlabel('X/mm'); ylabel('Y/mm'); zlabel('Z/mm');
    
    subplot(2,2,2)
    scatter(x(1:i,:), y(1:i,:), 300); hold on; grid on;
    axis([0 5000   0 5000]);
    xlabel('X/mm'); ylabel('Y/mm');
    
    subplot(2,2,3)
    scatter(x(1:i,:), z(1:i,:), 300); hold on; grid on;
    axis([0 5000   0 2500]);
    xlabel('X/mm'); ylabel('Z/mm');
    
    subplot(2,2,4)
    scatter(y(1:i,:), z(1:i,:), 300); hold on; grid on;
    axis([0 5000   0 2500]);
    xlabel('Y/mm'); ylabel('Z/mm');
    
    pause(0.1)
end

 
%     subplot(2,2,1)
%     scatter3(x, y, z, 30); hold on; grid on;
%     axis([0 5000   0 5000   0 2500]);
%     xlabel('X/mm'); ylabel('Y/mm'); zlabel('Z/mm');
%     
%     subplot(2,2,2)
%     scatter(x, y, 300); hold on; grid on;
%     axis([0 5000   0 5000]);
%     xlabel('X/mm'); ylabel('Y/mm');
%     
%     subplot(2,2,3)
%     scatter(x, z, 300); hold on; grid on;
%     axis([0 5000   0 2500]);
%     xlabel('X/mm'); ylabel('Z/mm');
%     
%     subplot(2,2,4)
%     scatter(y, z, 300); hold on; grid on;
%     axis([0 5000   0 2500]);
%     xlabel('Y/mm'); ylabel('Z/mm');
