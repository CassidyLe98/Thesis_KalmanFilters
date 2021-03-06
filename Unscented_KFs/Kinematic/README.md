# Kinematic
We provide the MATLAB code for implementing the unscented Kalman filter (UKF) on a simple linear model, specifically the [kinematic equations](https://www.khanacademy.org/science/physics/one-dimensional-motion/kinematic-formulas/a/what-are-the-kinematic-formulas). This implementation produces estimates for one state (velocity). The code files rely on MATLAB's built-in `unscentedKalmanFilter` function. For details on this function, please see [MATLAB's documentation](https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html) for it. A thorough explanation of this implementation is detailed in **Chapter 7.2** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis).

For these files, the MATLAB version used was R2016b, though any version after R2016b should also work.

## MATLAB Prerequisites
If you do not have MATLAB installed to your computer, please download MATLAB through [this link](https://www.mathworks.com/downloads/).

If you are unfamiliar with MATLAB, please [MATLAB's documentation for getting started](https://www.mathworks.com/help/matlab/getting-started-with-matlab.html).

## Installation
Once you have MATLAB downloaded and you are familiar with MATLAb syntax, download the repo
  ```
  git clone https://github.com/CassidyLe98/Thesis_KalmanFilters
  ```
Then, access this folder in your directory under `../Thesis_KalmanFilters/Unscented_KFs/Kinematic/`

## Contents 
`Kinematic1.m` - defines the system in state space form
`kinematicMeasurementFcn.m` - defines which state variable we will create simulated measurement values for   
`kinematicMeasurementNonAdditiveNoiseFcn.m` - defines the measurement function used in the UKF algorithm where noise is not additive  
`kinematicStateFcn.m` - solves the system in state space form using Euler's method  
`kinematic_UKF.m` - main file that implements UKF on the system and graphs the results  
`Icon` - file used to sync with Google Drive File Stream

## Getting Started
Run the file `kinematic_UKF.m`, which is the UKF implementation for the kinematic equations. This file should produce two graphs, one of which displays the results of the UKF estimation for velocity while the other displays the residuals of these UKF estimations.

## About the Model
For more information on the model, please read the beginning of **Chapter 7.2** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis). A general discussion of this model is also explained thoroughly on [Khan Academy](https://www.khanacademy.org/science/physics/one-dimensional-motion/kinematic-formulas/a/what-are-the-kinematic-formulas). Note that they use the terminology displacement in reference to position.

## Citation
If you use this project for your research, please cite:
```
@inproceedings{Le2020Code,
    author={Cassidy Le},
    title={{}},
    year={2020}
}
```
