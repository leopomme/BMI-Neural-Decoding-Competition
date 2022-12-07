% Brain Machine Interfaces - Neural Decoder
% TEAM Prime_Mates
% Authors: Leopold Hebert
% Imperial College London 2022 

% kNN trajectory 


function [x, y] = kNN2(test_data, modelParameters)

   testsumpos = zeros([98 1]);

    for i = 1:98                     
       testsumpos(i) = testsumpos(i) + sum(test_data(1).spikes(i,:),2); 
    end    
    
    minposdelta = 1000;
    for test = 1:30

        posdelta = sum(abs(modelParameters.knn2position(:,test,modelParameters.K)-testsumpos(:)));

        if posdelta<minposdelta

            minposdelta = posdelta;
            similar_mov = test;

        end        
    end  

    time = length(test_data(1,1).spikes);

    while time>length(modelParameters.knn2handPos(1,:,similar_mov,modelParameters.K))
        time = time-20;
    end
    
    while modelParameters.knn2handPos(1,time,similar_mov,modelParameters.K)==0
        time = time-20;
    end
    

    [x, y] = deal(modelParameters.knn2handPos(1,time,similar_mov,modelParameters.K), modelParameters.knn2handPos(2,time,similar_mov,modelParameters.K));
    
    
end
