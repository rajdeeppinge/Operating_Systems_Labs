%
% Function to priority based task service 
% for specified priorities
% non-preemptive algorithm
%

function [depart_time, waiting_time] = var_service_priority(task_mat) % function definition
    [n_rows, ~] = size(task_mat);               % store number of tasks

    depart_time = [];                           % matrix to store depart_time/finish time of task
    waiting_time = [];                          % matrix to store waiting time of task

    task_manager = 2;                   % count of number of tasks that have arrives since t = 0
                                        % i.e. total number of tasks
                                        % arrived till now based on arrival
                                        % time
    
                                        
    arrived_task_mat = task_mat(1, :);  % matrix to store arrived tasks - queue
    
    % store the service time for the first task that is going to be
    % taken up. At start there is only 1 task therefore take it directly
    service_time = arrived_task_mat(1, 2);

    % this is the time at which loop will be stopped
    finish_simulation_time = 100;
    
    % loop over time
    for k = arrived_task_mat(1,1) : finish_simulation_time
        
        % if all tasks have not arrived and a new task arrives
        if task_manager <= n_rows && k == task_mat(task_manager, 1)
            arrived_task_mat = [arrived_task_mat; task_mat(task_manager, :)]; % add new task to arrived list
            task_manager = task_manager + 1;        % increment the count of arrived tasks by 1
        end

        % if the queue of arrived but not finished tasks is not empty then
        % only take a task for servicing
        if ~isempty(arrived_task_mat)
            % reduce service time of highest priority task by 1
            arrived_task_mat(1, 2) = arrived_task_mat(1, 2) - 1;

            % if the remaining service time of a task is 0, the task is
            % completed/serviced. remove it from queue/arrival matrix
            if arrived_task_mat(1, 2) == 0
                arrival_time = arrived_task_mat(1, 1);
                depart_time = [depart_time; [arrival_time k]];
                
                % check how many tasks have been finished before this one
                [dsize, ~] = size(depart_time);
                
                if dsize == 1       % only 1 task complete which is the current one
                    % therefore its 
                   %waiting time = depart time - service time - arrival time
                    waiting_time = [waiting_time; [arrival_time (depart_time(end, 2)-service_time-arrival_time+1)]];
                
                else
                    % otherwise waiting time of i'th task 
                    % = maximum of( depart time of (i-1)th task + 1 i.e.
                    % start time of this task, 
                    % arrival time in case new task arrives at a later time after the (i-1)th task has finished ) 
                    % subtract by its arrival time
                    waiting_time = [waiting_time; [arrival_time (max(depart_time(end-1, 2)+1, arrival_time)-arrival_time)]];
                end
                
                % remove finished task from the arrived but not serviced
                % task matrix
                arrived_task_mat = arrived_task_mat(2:end, :);
                
                % sort the remaining tasks according to priority
                arrived_task_mat = sortrows(arrived_task_mat, 3);
                
                % if tasks are still to be serviced, then store service
                % time of the next task
                if ~isempty(arrived_task_mat)
                    service_time = arrived_task_mat(1, 2);
                end
            end
        end

    end;

end
