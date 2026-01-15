 %==========================================================================
% main.m
%
% Entry point for spectral profile extraction from the anonymized cervix
% hyperspectral dataset.
%
% This script calls the function extractSpectralSignatures.
%
% Usage:
%   1. Set the datasetPath variable below
%   2. Run this script
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
%   Author(s), "Title of the paper", N 
%   Journal / Conference, Year.
%   DOI: 10.XXXX/XXXXXXX

%==========================================================================

clear; clc;

%% Path to the dataset (EDIT THIS)
datasetPath = '..\data';

%% Run extraction
extractSpectralSignatures(datasetPath);

disp('Main execution finished.');
