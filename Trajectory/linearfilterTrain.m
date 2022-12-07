% Brain Machine Interfaces - Neural Decoder
% TEAM Prime_Mates
% Authors: Manuela Giraud
% Imperial College London 2022

function modelParameters = linearfilterTrain(trainingData, modelParameters)
    
    % training model

        % Initializing vectors
        xx = zeros(1000,size(trainingData,1));
        yy = zeros(1000,size(trainingData,1));
        coeffsx = zeros (1000,2,8); %time, coeffs,angle
        coeffsy = zeros (1000,2,8); %time, coeffs,angle
        spk_train = zeros(1000,size(trainingData,1),8);
        maxneurons = zeros(1,8);
    
        for angle = 1:8

            %selecting the one neuron which induces the more spikes for a specific angle 
            %the spikes from this neuron will be used to find the linear
            %model
            [neurons,means] = tunningCurves(angle);
            maxneuron = neurons(find(means == max(means)));  
            maxneurons(angle) = maxneuron;

            for trialNum = 1:size(trainingData,1)

                        spk_train(1:length(trainingData(trialNum, angle).spikes(maxneuron,:)),trialNum,angle) = trainingData(trialNum, angle).spikes(maxneuron,:);
                        spk_train(:,trialNum,angle) = smoothdata(spk_train(:,trialNum,angle)); % rate of spiking over time for each trial and angle
                        xx(1:length(trainingData(trialNum, angle).handPos(1,:)),trialNum) = trainingData(trialNum, angle).handPos(1,:);
                        yy(1:length(trainingData(trialNum, angle).handPos(2,:)),trialNum) = trainingData(trialNum, angle).handPos(2,:);
            end
            
                for t = 1:length(trainingData(trialNum, angle).spikes)

                        % creating linear models for each time t and angle
                        mdlx = fitlm(squeeze(spk_train(t,:,angle)),xx(t,:),'linear');%linear model of x vs rate at time t
                        mdly = fitlm(squeeze(spk_train(t,:,angle)),yy(t,:),'linear');%linear model of y vs rate at time t

                        coeffsx(t,1,angle) = table2array(mdlx.Coefficients(1,1));%first coeff of linear model of x
                        coeffsx(t,2,angle) = table2array(mdlx.Coefficients(2,1));%second coeff of linear model of x
                        coeffsy(t,1,angle) = table2array(mdly.Coefficients(1,1));%first coeff of linear model of y
                        coeffsy(t,2,angle) = table2array(mdly.Coefficients(2,1));%second coeff of linear model of y
    
                end
    
        end
        modelParameters.cx = coeffsx;
        modelParameters.cy = coeffsy;
        modelParameters.maxneurons = maxneurons;
    
end


    
