
%==========================================================================
% decompressDataset.m
%
% Script to decompress the dataset. The data is compressed patient by
% patient
%
%
% Author:
%   Carlos Vega; Raquel Leon 
%   University of Las Palmas de Gran Canaria
%   cvega@iuma.ulpgc.es
%
% Last revision: 10-Jan-2026
%
% Dataset:
%   The dataset used by this script is publicly available at:
%   https://doi.org/10.XXXX/zenodo.XXXXXXX
%
% Citation:
%   If you use this code or dataset, please cite:
%
%   Author(s), "Title of the paper",
%   Journal / Conference, Year.
%   DOI: 10.XXXX/XXXXXXX

%==========================================================================

% -------- USER SETTINGS --------
parentPath = 'C:\Users\cvega\Nextcloud2\Pruebas\Cervix\HyCervix_Compressed';   
% --------------------------------

savingPath = '..\data';

if ~exist(savingPath, 'dir') 
    mkdir(savingPath);
end

% Find all zip files in the directory
zipFiles = dir(fullfile(parentPath, '*.zip'));

for k = 1:length(zipFiles)
    zipName = zipFiles(k).name;
    zipFullPath = fullfile(parentPath, zipName);

    outputFolder = savingPath;

    fprintf('Uncompressing: %s\n', zipName);

    % Create output folder if it does not exist
    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end

    % Unzip
    unzip(zipFullPath, outputFolder);
end

disp('All folders uncompressed successfully.');
