# Van der Pol Oscillator
We provide the MATLAB code for implementing the unscented Kalman filter (UKF) on a nonlinear model, specifically the [Van der Pol oscillator](https://www.khanacademy.org/science/physics/one-dimensional-motion/kinematic-formulas/a/what-are-the-kinematic-formulas). This implementation produces estimates for one state variable (velocity). The code files rely on MATLAB's built-in `unscentedKalmanFilter` function. For details on this function, please see [MATLAB's documentation](https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html) for it. This implementation is a provided example by MATLAB and can be found in the [MATLAB's documentation for the `unscentedKalmanFilter`](https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html). Although MATLAB provides a thorough explanation for this implementation, more details can be found in **Chapter 7.1** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis).

For these files, the MATLAB version used was R2016b, though any version after R2016b should also work.

## MATLAB Prerequisites
If you do not have MATLAB installed to your computer, please download MATLAB through [this link](https://www.mathworks.com/downloads/).

If you are unfamiliar with MATLAB, please [MATLAB's documentation for getting started](https://www.mathworks.com/help/matlab/getting-started-with-matlab.html).

## Installation
Once you have MATLAB downloaded and you are familiar with MATLAb syntax, download the repo
  ```
  git clone https://github.com/CassidyLe98/Thesis_KalmanFilters
  ```
Then, access this folder in your directory under `../Thesis_KalmanFilters/Unscented_KFs/MatLab_vdp_Example/`

## Contents 
`vdp1.m` - defines the system in state space form  
`vdpMeasurementNonAdditiveNoiseFcn.m` - defines the measurement function used in the UKF algorithm where noise is not considerd additive by the algorithm but rather manually written in as additive in this file  
`kvdpStateFcn.m` - solves the system in state space form using Euler's method and includes a continuous definition of the system as well under the function `vdpStateContinuous`  
`vdp_UKF.m` - main file that implements UKF on the system and graphs the results  
`Icon` - file used to sync with Google Drive File Stream

## Getting Started
Run the file `vdp_UKF.m`, which is the UKF implementation for the Van der Pol oscillator. This file should produce two graphs, one of which displays the results of the UKF estimation for velocity as well as the true and measured values for acceleration while the other displays the residuals of these UKF estimations.

## About the Model
For more information on the model, please read the beginning of **Chapter 7.1** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis). A general discussion of this model is also explained on [Wikipedia](https://en.wikipedia.org/wiki/Van_der_Pol_oscillator).

## Citation
If you use this project for your research, please cite:
```
@inproceedings{Le2020Code,
    author={Cassidy Le},
    title={{}},
    year={2020}
}
```
