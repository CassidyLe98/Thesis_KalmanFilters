# Albers
We provide the MATLAB code for implementing the unscented Kalman filter (UKF) on a biological model, specifically a type 2 diabetes model used by [Albers et al](https://www.researchgate.net/publication/328266432_Mechanistic_machine_learning_How_data_assimilation_leverages_physiologic_knowledge_using_Bayesian_inference_to_forecast_the_future_infer_the_present_and_phenotype) and originally proposed by [Sturis et al](https://www.deepdyve.com/lp/the-american-physiological-society/computer-model-for-mechanisms-underlying-ultradian-oscillations-of-mtFTaWd2v1). The code files rely on MATLAB's built-in `unscentedKalmanFilter` function. For details on this function, please see [MATLAB's documentation](https://www.mathworks.com/help/control/ref/unscentedkalmanfilter.html) for it. A thorough explanation of this implementation is detailed in **Chapter 7.3** of the corresponding [thesis paper](https://sites.google.com/g.hmc.edu/cle/thesis).

For these files, the MATLAB version used was R2016b, though any version after R2016b should also work.

## MATLAB Prerequisites
If you do not have MATLAB installed to your computer, please download MATLAB through [this link](https://www.mathworks.com/downloads/).

If you are unfamiliar with MATLAB, please [MATLAB's documentation for getting started](https://www.mathworks.com/help/matlab/getting-started-with-matlab.html).

## Installation
Once you have MATLAB downloaded and you are familiar with MATLAb syntax, download the repo
  ```
  git clone https://github.com/CassidyLe98/Thesis_KalmanFilters
  ```
Then, access this folder in your directory under `../Thesis_KalmanFilters/Unscented_KFs/Albers/`

## Contents
`AlbersMeasFcn.m` - defines which state variable we will create simulated measurement values for
`AlbersNoiseFcn_Add.m` - defines the measurement function used in the UKF algorithm where noise is additive
`AlbersNoiseFcn_NonAdd.m` - defines the measurement function used in the UKF algorithm where noise is not additive
`AlbersODE.m` - defines the system in state space form
`AlbersParamVals.m` - defines all the parameter values in the system
`AlbersStateFcn.m` - solves the system using MATLAB's ODE solver `ode45`
`AlbersStateFcnEuler.m` - solves the system in state space form using Euler's method
`Albers_UKF.m` - main file that implements UKF on the system and graphs the results
`Icon` - file used to sync with Google Drive File Stream

## Getting Started
Run the file `Albers_UKF.m`, which is the UKF implementation for the type 2 diabetes model. This file should produce two graphs, one of which displays the results of the UKF estimation while the other displays the residuals of the UKF estimations.

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
