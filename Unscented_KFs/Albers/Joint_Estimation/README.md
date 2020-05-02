# Albers State and Parameter Estimation
We provide the MATLAB code for implementing the joint unscented Kalman filter (UKF) on a biological model, specifically a type 2 diabetes model used by [Albers et al](https://www.researchgate.net/publication/328266432_Mechanistic_machine_learning_How_data_assimilation_leverages_physiologic_knowledge_using_Bayesian_inference_to_forecast_the_future_infer_the_present_and_phenotype) and originally proposed by [Sturis et al](https://www.deepdyve.com/lp/the-american-physiological-society/computer-model-for-mechanisms-underlying-ultradian-oscillations-of-mtFTaWd2v1). The code files rely on MATLAB's built-in `unscentedKalmanFilter` function. For details on this function, please see [MATLAB's documentation](https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html) for it. A thorough explanation of this implementation is detailed in **Chapter 10.1** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis).

For these files, the MATLAB version used was R2016b, though any version after R2016b should also work.

## MATLAB Prerequisites
If you do not have MATLAB installed to your computer, please download MATLAB through [this link](https://www.mathworks.com/downloads/).

If you are unfamiliar with MATLAB, please [MATLAB's documentation for getting started](https://www.mathworks.com/help/matlab/getting-started-with-matlab.html).

## Installation
Once you have MATLAB downloaded and you are familiar with MATLAb syntax, download the repo
  ```
  git clone https://github.com/CassidyLe98/Thesis_KalmanFilters
  ```
Then, access this folder in your directory under `../Thesis_KalmanFilters/Unscented_KFs/Albers/Joint_Estimation/`

## Contents
`AlbersMeasFcn.m` - defines which state variable and parameters we will create simulated measurement values for  
`AlbersNoiseFcn_Add.m` - defines the measurement function used in the UKF algorithm where noise is additive  
`AlbersODE.m` - defines the system in state space form  
`AlbersParamVals.m` - defines all the parameter values in the system  
`AlbersTransFcn.m` - defines the state transition function used in the UKF algorithm by solving the system using MATLAB's ODE solver `ode45`
`Albers_jointUKF.m` - main file that implements joint UKF on the system and graphs the results
`Albers_xTrue` - csv file that contains the simulated true values produced by running the ODE solver `ode45` on the system with a set time interval
`Albers_yMeas` - csv file that contains the simulated measurement values produced by adding noise to each true value in `Albers_xTrue`
`Alebrs_yTrue` - csv file that contains the simulated true values for the one state that the UKF algorithm is estimating (glucose) as well as the three parameters that the algorithm is estimating ($E$, $V_i$, $t_i$)  
`Icon` - file used to sync with Google Drive File Stream

## Getting Started
Run the file `Albers_jointUKF.m`, which is the joint UKF implementation for the type 2 diabetes model to estimate both states and parameters. This file should produce four graphs: one that displays the results for the state for which the algorithm is estimating (glucose) and three others that display the results for the parameters for which the algorithm is estimating ($E$, $V_i$, $t_i$). Each of these four graphs should have two sub-plots: one indicating the UKF estimates and another showing the residuals of those UKF estimates.

## About the Model
For more information on the model, please read the section called **Mechanistic models** or look at the **S2 Appendix** in the following paper:
```
Albers, D. J., Levine, M. E., Stuart, A., Mamykina, L., Gluckman, B., & Hripcsak, G. (2018). Mechanistic machine learning: How data assimilation leverages physiologic knowledge using Bayesian inference to forecast the future, infer the present, and phenotype. Journal of the American Medical Informatics Association, 25(10), 1392-1401. https://doi.org/10.1093/jamia/ocy106
```
The model is further detailed in the Appendix of the following paper:
```
J. Sturis, K.E.A. (1991). Computer model for mechanisms underlying ultradian oscillations of insulin and glucose. AJP - Endocrinology and Metabolism, 260, E801
```

## Citation
If you use this project for your research, please cite:
```
@inproceedings{Le2020Code,
    author={Cassidy Le},
    title={{}},
    year={2020}
}
```
