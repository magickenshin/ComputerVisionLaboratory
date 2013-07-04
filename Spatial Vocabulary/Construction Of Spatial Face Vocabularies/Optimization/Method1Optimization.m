clc
clear all
close all

addpath ../Method1

% optimization per landmark - find the Q and z that give the best score
bestScore = -Inf;
bestQ = -1;
bestz = -1;

% landmarksIndices = [59, 54, 61, 66, 27, 31, 20, 16,...
%     7, 3, 5, 35, 41, 32, 51, 15, 10, 21, 26];

% left side:
% landmarksIndices = [59, 54, 20, 16,...
%      3, 35, 51, 15, 10];

% right side:
% landmarksIndices = [61, 66, 27, 31,...
%      5, 41, 51, 21, 26];
 
% best of right side and left side:
% landmarksIndices = [61, 66, 27, 31,...
%      41, 51, 59  54  16  35  51  10];

landmarksIndices = [2 29 52 42 61];
 
landmarksPowerset = PowerSet(landmarksIndices);

Qs = 40:5:60;%:50:200;
zs = 15:5:40;%:500;
%zs(1) = 1;

alignedImages = false;

scores = zeros(length(Qs), length(zs), 2^length(landmarksIndices)-1);

r = 1;
for i=1:length(landmarksPowerset)
    [rows, ~] = size(landmarksPowerset{i});
    
    for j=1:rows
        P = landmarksPowerset{i}(j, :);
        
        t=1;
        for Q = Qs
            k=1;
            for z = zs
                if (Q > z)
                    % calc score
                    disp(strcat('Q = ', num2str(Q)));
                    disp(strcat('z = ', num2str(z)));
                    disp(strcat('P = ', num2str(P)));
                    score = ParametersScore(Q, z, P, @Method1Train, @Method1GenerateVector, 1, alignedImages)
                    scores(t, k, r) = score;
                    % check if these Q and z have better score
                    if (score > bestScore)
                        bestScore = score;
                        bestQ = Q;
                        bestz = z;
                        bestP = P;
                    end
                end
                k = k + 1;
            end
            t = t+1;
        end
        r = r + 1;
    end
end

disp(strcat('best Q = ', num2str(bestQ)));
disp(strcat('best z = ', num2str(bestz)));
disp(strcat('best P = ', num2str(bestP)));
disp(strcat('best score = ', num2str(bestScore)));
                    
save('Method1ParametersScores', 'scores', 'Qs', 'zs', 'landmarksPowerset');