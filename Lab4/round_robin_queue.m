% program to implement round robin method of task servicing

clear;
close all;

task_mat = [1 10 4; 2 1 5; 3 2 2; 4 3 1; 5 4 6; 6 6 3; 7 25 6];
task_mat = sortrows(task_mat, 2);
task_mat = [task_mat task_mat(:, 3)];
[tot_task, ~] = size(task_mat);
num_task = tot_task;

% queu which stores the task
task_queue = task_mat(1, :);

time = task_mat(1, 2);

%
task_count = 2;

% arrays storing the desired values
completion_time = [];
turn_around_time = [];
wait_time = [];

% loop till all the tasks are processed
while num_task > 0
    if ~isempty(task_queue)
        % process the tasks
        if task_queue(1, 3) >= 2
            task_queue(1, 3) = task_queue(1, 3) - 2; 
            time = time + 2;
        else
            task_queue(1, 3) = task_queue(1, 3) - 1; 
            time = time + 1;
        end
    else
        % if no tasks,increment time
        time = time + 1;
    end
    
    % add new tasks which have arrived to the queue
    while task_count <= tot_task && time >= task_mat(task_count, 2)
       task_queue = [task_queue; task_mat(task_count, :) ];
       task_count = task_count + 1;
    end
    
    % if tasks are present, check if some tasks have been completed
    if ~isempty(task_queue)
        if task_queue(1, 3) == 0;
            completion_time = [completion_time; [task_queue(1, 1) time]];
            turn_around_time = [turn_around_time; [task_queue(1, 1) time-task_queue(1, 2)]];
            wait_time = [wait_time; [task_queue(1, 1) (turn_around_time(end,2)-task_queue(1,4))] ];
            task_queue = task_queue((2:end), :); 
            num_task = num_task - 1;
        else    % if tasks are not complete put tasks at the end of the queue
            round_task = task_queue(1,:);
            task_queue = task_queue((2:end), :);
            task_queue = [task_queue; round_task];
        end
    end
    
end