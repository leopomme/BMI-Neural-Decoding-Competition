% Brain Machine Interfaces - Neural Decoder
% TEAM Prime_Mates
% Authors: Cosima Graef
% Imperial College London 2022 

% kNN

function modelParameters = kNN(test_data, modelParameters)
    
    testVect = zeros(modelParameters.numNeurons,1);
    for neuron = 1:modelParameters.numNeurons
        testVect(neuron,1) = sum(test_data.spikes(neuron,1:320));
    end

    [predictedAngle,~,~] = predict(modelParameters.kNNModel,testVect');
    
    modelParameters.K = predictedAngle;
    
end