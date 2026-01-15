function [] = extractSpectralSignatures(dataset_path)
%
% Description:
%   This script extracts hyperspectral spectral signatures from an
%   annotated cervix dataset and stores them independently per
%   histopathological class.
%
% Input:
%   datasetPath (char | string)
%       Path to the root directory of the dataset containing Patient_* folders
%
% Output:
%   None. Class-specific MAT files are written to disk.
% Classes:
%   100 - Normal / HPV Infected / Ectocervix
%   101 - Normal / HPV Infected / Endocervix
%   102 - Normal / HPV Infected / Outlier
%   103 - Normal / Gold Standard / Ectocervix
%   104 - Normal / Gold Standard / Endocervix
%   105 - Normal / Gold Standard / Outlier
%   200 - Lesion / CIN1
%   201 - Lesion / CIN2
%   202 - Lesion / CIN3
%   300 - Tumour / Invasive Carcinoma
%
% Requirements:
%   - MATLAB R2019b or later
%   - MAT-file version 7.3 (HDF5 support)
%
% Usage:
%   >> extractSpectralSignatures('path')
%
%
% Author:
%   Carlos Vega; Raquel Leon 
%   University of Las Palmas de Gran Canaria
%   cvega@iuma.ulpgc.es
%
% Last revision: 18-Dec-2025
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

%% ======================= INPUT CHECK ===================================

if nargin < 1 || isempty(dataset_path)
    error('Dataset path must be provided.');
end

if ~isfolder(dataset_path)
    error('The provided datasetPath does not exist or is not a folder.');
end

dataset_path = char(dataset_path);

%% ======================= CONFIGURATION ================================
outputPath  = '..\results\SpectralClasses\';

if ~exist(outputPath, 'dir')
    mkdir(outputPath);
end

%% ======================= CLASS DEFINITION ==============================
% Structure defining the classes
sampleClassName = {
    '100','Normal','HPVInfected','Ecto',[0 0 255];
    '101','Normal','HPVInfected','Endo',[0 255 0];
    '102','Normal','HPVInfected','Outlier',[255 255 255];
    '103','Normal','GoldStandard','Ecto',[0 0 255];
    '104','Normal','GoldStandard','Endo',[0 255 0];
    '105','Normal','GoldStandard','Outlier',[255 255 255];
    '200','Lesion','CIN1','CIN1',[255 0 0];
    '201','Lesion','CIN2','CIN2',[255 0 0];
    '202','Lesion','CIN3','CIN3',[255 0 0];
    '300','Tumour','IC','IC',[255 0 255];
    };

for i = 1:size(sampleClassName,1)
    varName = ['class_' sampleClassName{i,1}];
        eval([varName ' = struct(''Label'', sampleClassName{i,1}, ''Lvl1'', sampleClassName{i,2}, ''Lvl2'', sampleClassName{i,3}, ''Lvl3'',sampleClassName{i,4}, ''Color'', sampleClassName{i,5}, ''Spectral'', []);']);
end
    
% Get the Number of patients and classes
n_patient = length(dir(fullfile(dataset_path, 'Patient_*')));
num_classes = size(sampleClassName, 1); 
fprintf('Detected %d patients.\n', n_patient);

%% ======================= LOAD PATIENT LIST =============================
% Iterate trought every sample of the dataset.
for iteration = 1: n_patient

    %%Import the patient and info.
    sample_name = strcat('\Patient_',num2str(iteration));
    cube_path = strcat(dataset_path, sample_name,'\cube.hdr');
    ann_path = strcat(dataset_path, sample_name,'\', sample_name,'_GT.mat');

    fprintf('Processing %s (%d/%d)\n', sample_name(2:end), iteration, n_patient);

    % Load cube and annotations
    cube_cervix = hypercube(cube_path);
    cube_cervix = cube_cervix.DataCube;
    load(ann_path,   'annotation_map');

    clear  cube_path ann_path

    %% Get the pixels for each class

    % Search for each of the classes in the results
    for idx = 1:num_classes

        % Get the class id and name
        classId = str2double(sampleClassName{idx, 1});
       
        % Get the mask of the current className
        maskCurrentClass = (annotation_map == classId);


        % Get the pixels of the current class
        currentClassPixels = cube_cervix .* maskCurrentClass;
        currentClassPixels = reshape(currentClassPixels, [], size(cube_cervix,3));
        mask_vector = currentClassPixels(:,1) > 0;
        currentClassPixels = currentClassPixels(mask_vector,:);

        % Save the pixels
        varName = ['class_' sampleClassName{idx,1}];
        eval([varName '.Spectral = [',varName,'.Spectral; currentClassPixels];']);
      
        clear currentClassPixels  maskCurrentClass
    end
    clear mask_vector cube_cervix cube_cervix annotation_map

end

%% ======================= SAVE CLASSES =============================
% Save the dictionary of all spectral profiles captured.
save([outputPath,'Class_100.mat'], 'class_100','-v7.3', '-nocompression');
save([outputPath,'Class_101.mat'], 'class_101','-v7.3', '-nocompression');
save([outputPath,'Class_102.mat'], 'class_102','-v7.3', '-nocompression');
save([outputPath,'Class_103.mat'], 'class_103','-v7.3', '-nocompression');
save([outputPath,'Class_104.mat'], 'class_104','-v7.3', '-nocompression');
save([outputPath,'Class_105.mat'], 'class_105','-v7.3', '-nocompression');
save([outputPath,'Class_200.mat'], 'class_200','-v7.3', '-nocompression');
save([outputPath,'Class_201.mat'], 'class_201','-v7.3', '-nocompression');
save([outputPath,'Class_202.mat'], 'class_202','-v7.3', '-nocompression');
save([outputPath,'Class_300.mat'], 'class_300','-v7.3', '-nocompression');


disp('Spectral extraction completed successfully.');

end






