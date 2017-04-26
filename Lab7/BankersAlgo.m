% Author - Rajdeep Pinge
% Date - 27-02-2017

% Code Implementing Banker's Algorithm

function process = BankersAlgo(total_resources, allocation, maximum)
    need = maximum - allocation

    alloc_resources = sum(allocation);
    
    rem_resources = total_resources - alloc_resources;
    
    [numProc, numResources] = size(need)
    
    currProc = [1:numProc];
    
    process = [];
    j = 1;
    
    oldSize = numProc;
    
    while numProc > 0
        notEnough = false;
        if j > numProc
            j = mod(j, numProc);
        end
        for i = 1:numResources
            if rem_resources(i) < need(j, i)
                notEnough = true;
                break;
            end
        end
        
        if notEnough
            if j == oldSize
                process = 'deadlock';
                break;
            end
            j = j + 1;
        else
            rem_resources = rem_resources + allocation(j, :)
            process = [process currProc(j)];
            allocation = [allocation(1:j-1, :); allocation(j+1:end, :)];
            maximum = [maximum(1:j-1, :); maximum(j+1:end, :)];
            need = [need(1:j-1, :); need(j+1:end, :)];
            currProc = [currProc(1:j-1) currProc(j+1:end)];
            numProc = numProc - 1;
            oldSize = j-1;
            if oldSize == 0
                oldSize = numProc;
            end
        end
        
    end
end