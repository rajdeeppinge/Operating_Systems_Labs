%
% Function to simulate simple queue 
% for specified arrival and service rates.
% Number of time slots = 100000 (fixed).
%
% Other features: 
% Option to preempt request at head of queue
% Moving average with window size = 1000
% Option to plot queue length log
%
% Written by Naresh Jotwani, January 2014
%
function mean_len = queue_ver_1( arrival_rate, service_rate, ...
                    plot_number, preempt_limit, balk_limit )
% 
global q_len_log N
%
N = 10000;                 % Number of time intervals
q_len = 0;                  % Initial queue length
q_len_log = zeros( 1, N );  % Array to store log of successive queue lengths
in_service = 0;             % Time slots taken by head of queue service request
total_arrived = 0;          % Number of service requests coming in
total_served = 0;           % Number of service requests completed
%
colors = 'rgbkmrgbkmrgbkmrgbkm';    % Colors for plot - if needed
%
for k = 1:N
    arrive = eprob(arrival_rate);   % Does an arrival occur?
    %
    % Does an arriving customer balk?
    %
    if balk_limit && ( q_len > balk_limit )
        arrive = 0;
    end;
    total_arrived = total_arrived + arrive;
    %
    depart = eprob(service_rate);   % Does a departure occur?
    %
    if q_len                        % Is there a queue?    
        if depart                   % Head of queue departs 
            in_service = 0;
        else
            in_service = in_service + 1;
            %
            % Should we preempt?
            %
            if preempt_limit && ( in_service == preempt_limit )
                depart = 1;         % Yes -- preempt head of queue
                in_service = 0;
            end;
        end;
    else
        depart = 0;                 % Cannot depart from empty queue 
    end;
    %
    total_served = total_served + depart;
    %
    q_len = q_len + arrive - depart;    % Update queue length
    q_len_log(k) = q_len;               % and log of queue lengths
end;
mean_len = mean(q_len_log) ;            % Mean queue length
%
% stdev_len = std(q_len_log);           % standard deviation -- Not needed at present
%
if plot_number 
    hold on;
    %
    % Get moving average of queue lengths -- for better display
    % See 'help filter' for more information
    %
    windowSize = 1000;
    filtered_log = filter(ones(1,windowSize)/windowSize,1,q_len_log);
    %
    color = colors(plot_number);        % Choose color
    if preempt_limit || balk_limit
        color = [color '--'];           % Dashed plot - for preemption / balk
    end;
    plot( filtered_log, color, 'LineWidth', 2 );
end;
end
%
% Function to generate event 1 with specified probability x
% and event 0 with probability 1-x
%
function y = eprob(x)
t = rand();         % rand() is uniformly distributed between 0 and 1
if t <= x 
    y = 1;
else
    y = 0;
end;
end
%
