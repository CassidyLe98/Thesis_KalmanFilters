# Thesis_KalmanFilters

## About
Kalman filtering is a type of Data Assimilation algorithm that can be used to estimate states and parameters of different models. Recently, researchers have been exploring the use of Kalman filters in bioinformatics. Here, we explore how Kalman filtering, particularly extended Kalman filter (EKF) and unscented Kalman filter (UKF), can be applied to bioinformatics in order to accurately estimate states and parameters of a model given a dataset.

This work is associated with a senior capstone project (thesis research), of whcih the paper can be found through this [Google site page ](https://sites.google.com/g.hmc.edu/cle/thesis).

The repository includes MATLAB implementation of both EKF and UKF on various models. If you use this project for your research, please cite:
```
@inproceedings{Le2020Code,
    author={Cassidy Le},
    title={{}},
    year={2020},
    organization={Harvey Mudd College}
}
```

## Download
The repository contains code with documentation and can be downloaded from <https://github.com/CassidyLe98/Thesis_KalmanFilters>.

## Getting Started
1. Download the most recently updated source code from the [GitHub repository](https://github.com/CassidyLe98/Thesis_KalmanFilters).
2. Find the implementations of each algorithm in the designated folders. EKF implementations are located in [`/Extended_KFs/`](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs). UKF implementations are located in [`/Unscented_KFs/`](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs).
3. Please read each `README.md` in each folder in order to better understand how to navigate the various implementations.

## Implementations
In this repository, there are two different algorithms that are implemented: extended Kalman filter (EKF) and unscented Kalman filter (UKF). Each of these algorithms were applied to both linear and nonlinear models to estimate states as well as parameters. In order to estimate states, we use the standard EKF and UKF. To estimate both states and parameters, we use joint estimation in conjunction with EKF and UKF.

More details can be found in the README.md files in each folder. Below, I outline the different implementations that were used.
1. [extended Kalman filter implementations](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs)
    1. State estimation for a simple linear model ([Bolviken paper example 7](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs/Bolviken_Ex7))
    2. State estimation for a nonlinear model ([Bolviken paper example 5](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs/Bolviken_Ex5))
    3. State and parameter estimation for a linear model ([Bolviken paper example 7](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs/Joint_Estimation/Bolviken_Ex7))
    4. State and parameter estimation for a nonlinear model ([type 2 diabetes system](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Extended_KFs/Joint_Estimation/Albers))
2. [unscented Kalman filter implementations](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs)
    1. State estimation for a simple linear model ([kinematic equation](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/Kinematic))
    2. State estimation for a nonlinear model ([Van der Pol Oscillator](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/MatLab_vdp_Example))
    3. State estimation for a biological model ([type 2 diabetes system](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/Albers))
    4. State and parameter estimation for a biological model ([type 2 diabetes system](https://github.com/CassidyLe98/Thesis_KalmanFilters/tree/master/Unscented_KFs/Albers/Joint_Estimation))

## Acknowledgements
The work done in this research is heavily supported and guided by Harvey Mudd College's Professor Lisette de Pillis, PhD, as well as Pomona College's Professor Blerta Shtylla, PhD.

Additionally, this research was in collaboration with Lindsey Tam, who worked on her own implementations of EKF and UKF as well. Her implementations can be found in her [GitHub repository](https://github.com/lindseytam/LT_thesis/tree/master/code).
