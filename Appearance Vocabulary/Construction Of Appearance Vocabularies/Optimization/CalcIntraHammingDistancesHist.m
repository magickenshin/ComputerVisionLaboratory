function [ distances ] = ...
    CalcIntraHammingDistancesHist(basePath,personId2Descriptor,personId)%(basePath,imagesPath,personId,...
                                     %histogramsPath,generateVectorMethod, z, M, P, sigma)

% get all the current other person's images
k = 1;
personDir = strcat(basePath,personId);
% personImageDir = strcat(imagesPath,personId);
personLandmarkFiles = dir(strcat(personDir,'/*.mat'));
% personImages = dir(strcat(personImageDir,'/*.jpg'));

personRepresentors = values(personId2Descriptor,{personId});
personRepresentors = personRepresentors{1};
for i=1:length(personLandmarkFiles)
    if (~strcmp(personLandmarkFiles(i).name,'.') && ...
        ~strcmp(personLandmarkFiles(i).name,'..'))
        
%         personLandmarkFilePath1 = strcat(personDir,'/',personLandmarkFiles(i).name);
%         personImagePath = strcat(personImageDir,'/',personImages(i).name);
%         image = rgb2gray(imread(personImagePath));
        
        currPersonRepresentor = values(personRepresentors,{personLandmarkFiles(i).name});
        personRepresentor1 = currPersonRepresentor{1};
            %generateVectorMethod(histogramsPath, image, personLandmarkFilePath1, z, M, P, sigma);
        
        for j=i+1:length(personLandmarkFiles)
            
%             personLandmarkFilePath2 = strcat(personDir,'/',personLandmarkFiles(j).name);
%             personImagePath2 = strcat(personImageDir,'/',personImages(j).name);
%             image2 = rgb2gray(imread(personImagePath2));
        

            currPersonRepresentor2 = values(personRepresentors,{personLandmarkFiles(j).name});
            personRepresentor2 = currPersonRepresentor2{1};
%                 generateVectorMethod(histogramsPath, image2, personLandmarkFilePath2, z, M, P, sigma);
            
            % calculate hamming distance
            distances(k) = ...
                CalcHammingDistance(personRepresentor1,personRepresentor2);
            k = k+1;
        end
    end
end

