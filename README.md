
# HiCervix Repository (MATLAB)
Repository providing tools and scripts for processing the HiCervix dataset, which consists of in-vivo hyperspectral (HS) images of the human cervix acquired during routine clinical colposcopic examinations. The goal of this repository is to support research on the non-invasive detection of precancerous and cancerous cervical lesions.

## Overview

-   **Input**: Hyperspectral images (`cube_cervix`) and
    ground-truth maps (`annotation_map`)
-   **Output**: Class-specific spectral signature MAT-files


## Repository Structure

    .
    ├── src/
    │   ├── extractSpectralProfiles_matfile.m
    │   └── main.m
    ├── data/
    │   └── README.md
    ├── results/
    │   └── SpectralClasses/
    ├── README.md
    ├── LICENSE
    └── CITATION.cff

## Dataset

The anonymized cervix hyperspectral dataset used in this work is
available at:

https://doi.org/10.XXXX/zenodo.XXXXXXX

Expected dataset structure:

    Anonymized Dataset/
    └── Patient_*/
        ├── Patient_*_Cube.mat   (variable: cube_cervix)
        └── Patient_*_GT.mat     (variable: annotation_map)

## Usage

1.  Clone the repository:

``` bash
git clone https://github.com/YourUsername/YourRepoName.git
```

2.  Open MATLAB and add the `src/` directory to the MATLAB path.

3.  Edit `main.m` and set the dataset path:

``` matlab
datasetPath = 'path/to/Anonymized Dataset';
```

4.  Run:

``` matlab
main
```

## Output

The pipeline generates one MAT-file per histopathological class:

    SpectralClasses/
    ├── Class_100.mat
    ├── Class_101.mat
    ├── Class_102.mat
    ├── Class_103.mat
    ├── Class_104.mat
    ├── Class_105.mat
    ├── Class_200.mat
    ├── Class_201.mat
    ├── Class_202.mat
    └── Class_300.mat

Each file contains: - `Spectral`: NxB matrix of spectral signatures -

## Citation

If you use this code or dataset, please cite:

Author(s), *Title of the paper*, Journal / Conference, Year.\
DOI: 10.XXXX/XXXXXXX

A `CITATION.cff` file is included for GitHub citation support.

## License

-   **Code**: MIT License
-   **Dataset**: CC BY 4.0 (unless otherwise specified)

## Requirements

-   MATLAB R2019b or later
-   MAT-file version 7.3 (HDF5 support)

## Contact

Carlos Vega; Raquel Leon\
University of Las Palmas de Gran Canaria\
cvega@iuma.ulpgc.es
