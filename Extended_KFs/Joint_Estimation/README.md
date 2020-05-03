# Joint_Estimation
We provide the MATLAB code for implementing the joint extended Kalman filter (EKF) on a linear model and a nonlinear model to joint estimate state(s) and parameter(s). The code files rely on source code from a textbook written by Erik Bolviken, Nils Christophersen, and Geir Storvik as well as MATLAB's built-in `extendedKalmanFilter` function.

The source code from the [Bolviken, Christophersen, and Storvik textbook](https://www.mn.uio.no/math/tjenester/kunnskap/kompendier/komp_kalman.pdf) can be found in **Appendix A.5** (under "Extended Kalman filtering on Example 5"). For details on the `extendedKalmanFilter` function, please see [MATLAB's documentation](https://www.mathworks.com/help/control/ref/extendedkalmanfilter.html) for it.

For these files, the MATLAB version used was R2016b, though any version after R2016b should also work.

## MATLAB Prerequisites
If you do not have MATLAB installed to your computer, please download MATLAB through [this link](https://www.mathworks.com/downloads/).

If you are unfamiliar with MATLAB, please [MATLAB's documentation for getting started](https://www.mathworks.com/help/matlab/getting-started-with-matlab.html).

## Installation
Once you have MATLAB downloaded and you are familiar with MATLAb syntax, download the repo
  ```
  git clone https://github.com/CassidyLe98/Thesis_KalmanFilters
  ```
Then, access this folder in your directory under `../Thesis_KalmanFilters/Extended_KFs/`

## Contents
The `/Joint_Estimation/` folder consists of two different implementations of joint EKF. This folder is separated by the two implementations that are used to estimate both state variable(s) and parameter(s). For one of the implementations ([Bolviken_Ex7](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs/Joint_Estimation/Bolviken_Ex7)), the code is based on the source code from the Bolviken, Christophersen, and Storvik textbook. The other implementation (state and parameter estimation for the [type 2 diabetes model](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs/Joint_Estimation/Albers)) uses MATLAB's built-in `extendedKalmanFilter` function to implement EKF.

The two implementations of joint EKF are listed below:
1. Linear model ([Bolviken, Christophersen, and Storvik textbook example 7](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs/Joint_Estimation/Bolviken_Ex7))
2. Biological model ([type 2 diabetes system](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs/Joint_Estimation/Albers))


## Getting Started
To start exploring the files in this folder, it may be best to start with the [simple linear implementation](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs/Joint_Estimation/Bolviken_Ex7). In this implementation, we use joint EKF to estimate both states and parameters. An explanation of joint estimation can be found in **Chapter 8.1** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis). Additionally, a thorough explanation of this example can be found in **Chapter 9.1** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis).

For a more challenging model, you can try the nonlinear biological [type 2 diabetes model](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs/Joint_Estimation/Albers). A thorough explanation of this example can be found in **Chapter 9.2** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis).

## Citation
If you use this project for your research, please cite:
```
@inproceedings{Le2020Code,
    author={Cassidy Le},
    title={{}},
    year={2020}
}
```

## Acknowledgements
The source code for manually executing each step of the EKF aglorithm is taken from **Appendix A.5** (under "Extended Kalman filtering on Example 5") of the following textbook:
```
Bolviken, E., Christophersen, N., & Storvik, G. (1998). Linear dynamical models, Kalman filtering and statistics: Lecture notes to IN-ST 259. University of Oslo. https://www.mn.uio.no/math/tjenester/kunnskap/kompendier/komp_kalman.pdf
```
