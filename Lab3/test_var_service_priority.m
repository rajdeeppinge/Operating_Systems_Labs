%
% Test program for priority wise task service
% non-preemptive algorithm
%
% Priority in the range [1,5]
%
% Note - time interval is arbitrary ( 1 ms, 1 s, 1 min, 1 day .... ?)
%

clear;
close all;

% test matrix - structure => [arrival_time, service_time, priority]
task_mat = [8 1 2; 2 1 2; 3 1 1; 1 3 4; 5 4 3; 6 2 1; 7 3 3; 20 1 1; 25 3 2; 26 4 1; 27 3 1; 35 2 2];

% sort tasks according to arrival time
task_mat = sortrows(task_mat);   

% call function and store depart time and waiting time arrays.
[depart_time, waiting_time] = var_service_priority(task_mat);

%%%% NOTE:
% depart_time has structure [arrival_time, depart_time]
% waiting_time has structure [arrival_time, waiting_time]