%
% Function to simulate simple queue 
% for specified arrival and service rates
%
function mean_len = simple_queue( arrival_rate, service_rate, plot_number, balking_limit )
% 
N = 10000;                 % Number of time intervals
q_len = 0;                  % Initial queue length
q_len_log = zeros( 1, N );  % Array to store log of successive queue lengths 


total_arrived = 0;          % Number of service requests coming in
total_discard = 0;

colors = 'rgbkm';           % Colors for plot - if needed
%
for k = 1:N
    arrive = eprob(arrival_rate);   % Does an arrival occur?
    
    depart = eprob(service_rate);   % Does a departure occur?
    %
    
    if balking_limit ~= 0 && balking_limit <= q_len
        total_discard = total_discard + arrive;
        arrive = 0;
    end
    
    total_arrived = total_arrived + arrive;
    
    q_len = max( [ 0 q_len+arrive-depart ] );   % Update queue length
    q_len_log(k) = q_len;                       % and log of queue lengths
end;
mean_len = mean(q_len_log) ;        % Return mean queue length
%
if plot_number
    if balking_limit ~= 0
        figure;
        windowSize = 1000;
        filtered_log = filter(ones(1,windowSize)/windowSize,1,q_len_log);
        plot( filtered_log, colors(mod(plot_number,5)+1) );
    else
        hold on;
        windowSize = 1000;
        filtered_log = filter(ones(1,windowSize)/windowSize,1,q_len_log);
        plot( filtered_log, colors(mod(plot_number+1,5)+1) );
    end
end;

disp( [ total_arrived total_discard ] )

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

