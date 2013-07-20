function [ s ] = FindGeneralConfiguration( conf )
%FindGeneralConfiguration - Get a node name and
%returns is data from the generalConfiguration node in the configuration file

% Read the xml file
try
   tree = xmlread('ConfigurationFile.xml');
catch
   error('Failed to read XML file %s.',filename);
end

   %Get the mandatory folders node
   subProjectNode = tree.getElementsByTagName('GeneralConfiguration');
   subProjectNode = subProjectNode.item(0);

   % Get the list of folders that we need to add to path
   configuration = subProjectNode.getElementsByTagName(conf);
   configuration = configuration.item(0);
   
   %Retrive the folder path from the xml node
   s = char(configuration.getFirstChild.getData);  
   
end

