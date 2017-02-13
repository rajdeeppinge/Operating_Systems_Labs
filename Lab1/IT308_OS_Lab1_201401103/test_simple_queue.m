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

service_rate1 = 0.5;
for k = 1 : 5
    arrival_rate = (k/4)*service_rate;
    lambda = arrival_rate/service_rate;
    %
    % Call the quwuw simulate function
    %
    plot_flag = k ; % Uncomment if plot is needed
    %
    mean_q_len = simple_queue( arrival_rate, service_rate1, plot_flag );
    %
    % Theoretical average queue length = lambda/(1-lambda)
    %
    disp( [ lambda mean_q_len  lambda/(1-lambda) ] );
    %
end;

