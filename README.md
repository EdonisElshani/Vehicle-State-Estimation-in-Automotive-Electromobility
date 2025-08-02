# Vehicle State Estimation in Automotive Electromobility

Implementation of a grey-box recursive least squares (RLS) algorithm, which can be used for estimation of key electric vehicle (EV) parameters, such as battery condition and vehicle mass, in real time. The method contains least squares estimation with forgetting factor for faster adaptation to changing conditions

[View the detailed report (PDF)](README.pdf)


## How to Run
To execute the parameter estimation example:

1. Open MATLAB.
2. Navigate to this repository’s folder.
3. Run the script:

```
Parameter_Estimation.m
```
## Adjustable Parameters (Default)
The script Parameter_Estimation.m includes several parameters you can modify to experiment with the recursive least squares estimation:

### Time Steps

Number of simulation steps. Higher values simulate a longer period and provide more data for estimation.
```
N = 200
```

### Forgetting Factors

Control how strongly past data is weighted in the recursive least squares algorithm:

lambda = 1 → No forgetting (equal weight for all data)

lambda < 1 → Older data is gradually “forgotten,” allowing faster adaptation to parameter changes.

```
lambda1 = 1
lambda2 = 0.95
```

###  Real Parameter Value

The true system parameter to be estimated (e.g., vehicle mass factor).

```
theta_true: 0.5
```

### System Input Vector
The simulated input data (e.g., measurements) used to estimate theta. Random Gaussian values are generated using randn.

### Measurement Noise
Simulated noise added to the system output y.

Set noise = 0; for an ideal noise-free simulation.

Use 0.05*randn(1, N) to add Gaussian noise with standard deviation 0.05.
```
noise= 0.05*randn(1, N)
```
