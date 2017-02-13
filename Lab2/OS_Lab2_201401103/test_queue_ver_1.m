%
% Test program for simple queue simulation
%
% Service rate = 0.1 per time interval (fixed) 
% Arrival rate  - specified fraction of service rate
% preempt_limit - when do we preempt head of queue
% balk_limit    - length of queue to make a customer turn back
%
% Note - time interval is arbitrary ( 1 ms, 1 s, 1 min, 1 day .... ?)
%

clear;
close all;

service_rate = 0.1;
plot_flag = 0;
%
for k = 1 : 2 : 9
    arrival_rate = (k/10)*service_rate;
    lambda = arrival_rate/service_rate;
    %
    % Call the queue simulate function
    % Note: Theoretical average queue length = lambda/(1-lambda)
    %
    plot_flag = k ;             % Choose color if plot is needed
    %
    preempt_limit = 0;
    balk_limit = 0;
    mean_q_len = queue_ver_1( arrival_rate, service_rate, plot_flag, preempt_limit, balk_limit );
    disp( [ lambda mean_q_len  lambda/(1-lambda) ] );
    %
    preempt_limit = 0;
    balk_limit = 5;
    mean_q_len = queue_ver_1( arrival_rate, service_rate, plot_flag, preempt_limit, balk_limit );
    disp( [ lambda mean_q_len  lambda/(1-lambda) ] );
    disp( ' ' );
    %
end;

