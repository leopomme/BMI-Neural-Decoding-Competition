% Brain Machine Interfaces - Neural Decoder
% TEAM Prime_Mates
% Authors: Manuela Giraud
% Imperial College London 2022

function [neurs, means] = tunningCurves(angle)

    load('monkeydata_training.mat');
    
    neurs = [];
    means = [];
    prefDir = zeros(98,2);

    for i = 1:98
        avFR = zeros(100,8);
        for k = 1:8
            for n = 1:100
                avFR(n,k) = sum(trial(n,k).spikes(i,1:320));
            end
        end
    
        S = std(avFR);
        M = mean(avFR);
        
        [~, prefDir(i,1)] = max(M);
         if ((prefDir(i,1)) == angle)
             neurs = [neurs, i];
             means = [means, max(M)];
         end
    
    end
end
