% Brain Machine Interfaces - Neural Decoder
% TEAM Prime_Mates
% Authors: Leopold Hebert
% Imperial College London 2022 

% kNN trajectory training 


function modelParameters = trainkNN2(training_data, modelParameters)

    trainsumpos = zeros([98 70 8]);

    for k = 1:8
        for n = 1:size(training_data)
            for i = 1:98
               trainsumpos(i,n,k) = trainsumpos(i,n,k) + sum(training_data(n,k).spikes(i,:),2);
               modelParameters.knn2position(i,n,k) = trainsumpos(i,n,k);%sum of the spikes for each neurones of each training trial across the different times steps
            end
        end
    end



    for k = 1:8
        for n = 1:size(training_data)
           for d = 1:2
               for t = 1:size(training_data(n,k).handPos,2)
                    modelParameters.knn2handPos(d,t,n,k) = training_data(n,k).handPos(d,t);
               end
           end
        end
    end
end



