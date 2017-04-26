% Author - Rajdeep Pinge
% Date - 27-02-2017

% Code to test Banker's Algorithm

clear;
close all;

total_resources = [8 5 9 8];

allocation = [2 0 1 2;
                0 1 2 1;
                4 0 0 3;
                1 2 1 0;
                1 0 3 0];
            
maximum = [3 2 1 4;
            0 2 5 3;
            5 1 0 5;
            1 4 4 0;
            3 0 3 3];
        
process = BankersAlgo(total_resources, allocation, maximum)