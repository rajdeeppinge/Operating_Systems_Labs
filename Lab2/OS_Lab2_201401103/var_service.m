%
% Function to simulate simple queue 
% for specified arrival and service rates
%
function depart_time = var_service( arrival_rate, service_rate, task_mat)
% 
N = 10000;                 % Number of time intervals

colors = 'rgbkm';           % Colors for plot - if needed

task_manager = 1;

arrived_task_mat = [];
depart_time = [];


for k = 1:N
    if k == task_mat(task_manager, 1)
        arrived_task_mat = [arrived_task_mat; task_mat(task_manager, :)];          %%%%%%%%%%%%%%% make matrix
    end
    
    % reduce min by 1
    [~, I] = min(arrived_task_mat);
    arrived_task_mat(I(2), 2) = arrived_task_mat(I(2), 2) - 1;
    
    if arrived_task_mat(I(2), 2) == 0;
        depart_time = [depart_time; [arrived_task_mat(I(2),1), k] ];
    end
    
end;

end
