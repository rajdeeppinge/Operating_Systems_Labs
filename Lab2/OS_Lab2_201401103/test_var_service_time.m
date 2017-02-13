%
% Test program for simple queue simulation
%
% Service rate = 0.1 per time interval 
% Arrival rate - from 5% to 95% of service rate
%
% Note - time interval is arbitrary ( 1 ms, 1 s, 1 min, 1 day .... ?)
%

clear;
close all;

task_mat = [8 1; 2 1; 3 1; 1 2];

task_mat = sortrows(task_mat);   
    
depart_time = var_service_firstcfs(task_mat);