# Simple Linear Model
We provide the MATLAB code for implementing the joint extended Kalman filter (EKF) on a simple linear model, specifically an example (Example 7) proposed by Erik Bolviken, Nils Christophersen, and Geir Storvik in [their textbook](https://www.mn.uio.no/math/tjenester/kunnskap/kompendier/komp_kalman.pdf). This implementation produces estimates for two states (x and z) and one parameter (a). A thorough explanation of this implementation is detailed in **Chapter 9.1** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis).

The code files are based on source code from a [textbook](https://www.mn.uio.no/math/tjenester/kunnskap/kompendier/komp_kalman.pdf) written by Bolviken, Christophersen, and Storvik. The source code can be found in **Appendix A.5** (under "Extended Kalman filtering on Example 5").

For these files, the MATLAB version used was R2016b, though any version after R2016b should also work.

## MATLAB Prerequisites
If you do not have MATLAB installed to your computer, please download MATLAB through [this link](https://www.mathworks.com/downloads/).

If you are unfamiliar with MATLAB, please [MATLAB's documentation for getting started](https://www.mathworks.com/help/matlab/getting-started-with-matlab.html).

## Installation
Once you have MATLAB downloaded and you are familiar with MATLAb syntax, download the repo
  ```
  git clone https://github.com/CassidyLe98/Thesis_KalmanFilters
  ```
Then, access this folder in your directory under `../Thesis_KalmanFilters/Extended_KFs/Joint_Estimation/Bolviken_Ex7/`

## Contents 
`ekf_gss7.m` - main file that implements joint EKF on the system and graphs the results  
`sim_gss7.m` - produces simulated true and measured (Gaussian) data for the state variables and parameter of the system  
`sim_gss7param_meas.csv` - csv file that contains simulated measured data for state variables and parameter of the system  
`sim_gss7param_true.csv` - csv file that contains simulated true data for state variables and parameter of the system  
`Icon` - file used to sync with Google Drive File Stream

## Getting Started
Run the file `ekf_gss7.m`, which is a EKF implementation that manually estimates the states of the system at each time step. This file should produce 1 graph that consists of 3 subplots. These subplots display the results of the EKF estimation for each state, of which there are 2 (x and z), and one parameter (a).

## About the Model
For more information on the model, please read the beginning of **Chapter 9.1** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis). To learn more about this model, see "Example 7" in **Chapter 11.4** in the [Bolviken, Christophersen, and Storvik textbook](https://www.mn.uio.no/math/tjenester/kunnskap/kompendier/komp_kalman.pdf).

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
