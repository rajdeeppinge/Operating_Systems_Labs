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

service_rate = 0.1;
plot_flag = 0;

%
for k = 1 : 5
    arrival_rate = (k/5)*service_rate;
    lambda = arrival_rate/service_rate;
    %
    % Call the quwuw simulate function
    %
    plot_flag = k ; % Uncomment if plot is needed
    %
    
    % balking limit
    balking_limit = 5;
    
    mean_q_len = simple_queue( arrival_rate, service_rate, plot_flag, balking_limit );
    
    
    % balking limit
    balking_limit = 0;
    
    mean_q_len_t2= simple_queue( arrival_rate, service_rate, plot_flag, balking_limit );
    
    %
    % Theoretical average queue length = lambda/(1-lambda)
    %
    disp( [ lambda mean_q_len  lambda/(1-lambda) ] );
    %
end;

