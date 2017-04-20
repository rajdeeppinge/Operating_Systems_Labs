%
% Function to simulate simple queue 
% for specified arrival and service rates
%
function depart_time = var_service_firstcfs(task_mat)
[n_rows,~] = size(task_mat);

depart_time = zeros(n_rows, 1);

for i = 1:n_rows
    if i == 1
        depart_time(i) = task_mat(i,1) + task_mat(i,2);
    else
        depart_time(i) = max(task_mat(i,1), depart_time(i-1)) + task_mat(i,2);
    end
    
end;

end
