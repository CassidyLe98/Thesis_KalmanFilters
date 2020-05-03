# Unscented_KFs
We provide the MATLAB code for implementing the unscented Kalman filter (UKF) on various linear and nonlinear models to estimate both states and parameters. The code files rely on MATLAB's built-in `unscentedKalmanFilter` function. For details on this function, please see [MATLAB's documentation](https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html) for it.

For these files, the MATLAB version used was R2016b, though any version after R2016b should also work.

## MATLAB Prerequisites
If you do not have MATLAB installed to your computer, please download MATLAB through [this link](https://www.mathworks.com/downloads/).

If you are unfamiliar with MATLAB, please [MATLAB's documentation for getting started](https://www.mathworks.com/help/matlab/getting-started-with-matlab.html).

## Installation
Once you have MATLAB downloaded and you are familiar with MATLAb syntax, download the repo
  ```
  git clone https://github.com/CassidyLe98/Thesis_KalmanFilters
  ```
Then, access this folder in your directory under `../Thesis_KalmanFilters/Unscented_KFs/`

## Contents
The `/Unscented_KFs/` folder consists of different implementations of UKF. This folder is separated by the implementations that are used to estimate just the state variables and the implementations that are used to estimate both state variables and parameters. In either case, the code uses MATLAB's built-in `unscentedKalmanFilter` function to implement UKF.
1. State estimation
    1. Simple linear model ([kinematic equation](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/Kinematic))  
    2. Nonlinear model ([Van der Pol Oscillator](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/MatLab_vdp_Example))
    3. Biological model ([type 2 diabetes system](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/Albers))
2. State and parameter estimation
    1. Biological model ([type 2 diabetes system](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/Albers/Joint_Estimation))


## Getting Started
To start exploring the files in this folder, it may be best to start with the [kinematic equation implementation](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/Kinematic). Since this example is linear, the mathematical rigor should not be as difficult. By this, I mean that manipulating the system in state space form should not be as difficult. For a thorough explanation of how to rewrite the system in state space form, see **Chapter 7.2** in the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis).

After the linear example, one can move on to the nonlinear example, which is the [Van der Pol Oscillator](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/MatLab_vdp_Example). A thorough explanation of this example can be found in **Chapter 7.1** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis).

For a more challenging biological example, see the [type 2 diabetes model](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/Albers). A thorough explanation of this implementation is detailed in **Chapter 7.3** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis).

After understanding how to use UKF to estiamte state variables, one can move on to estimating states and parameters for the [type 2 diabetes model](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/Albers/Joint_Estimation). In this implementation, we use joint UKF. An explanation of joint estimation can be found in **Chapter 8.1** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis).

## Citation
If you use this project for your research, please cite:
```
@inproceedings{Le2020Code,
    author={Cassidy Le},
    title={{}},
    year={2020}
}
```
