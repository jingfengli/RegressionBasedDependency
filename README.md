# RegressionBasedDependency
MATLAB code for regression based dependency 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Results are published in 'Li J, Bentley W, Snyder L. Neural Correlates of Functional Connectivity. Organization for Human Brain Mapping, 2015.'
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
The goal is to address whether one process drives the correlation between two other signals. Ideally, one should extract just the shared (correlated) component, and then using causality analysis (e.g., Granger causality analysis or transfer entropy) to determine whether the process of interest drives that correlated component. Methods extracting the correlated component require a large number of correlated signals as input to operate properly. With small amount of correlated signals, the extracted component will necessarily include a substantial amount of non-correlated signal, regardless of the precise method used.

Regression based dependency analysis circumvents the need of extracting the correlated component. It estimates the extent to which regressing out the signal can diminish the correlation.  

Distinction to partial regression. 


If regressing out A completely abolishes the correlation, then the correlation completely depends on A, or gamma power accounts for 100% of the interregional oxygen correlation. If there is no effect of the regression, then correlation does not depend at all on gamma power. Intermediate effects indicate partial dependence. 
Intuitively, regression-based dependency analysis computes the amount of the covariance underlying oxygen correlation that is the same as the covariance between oxygen and electrophysiological signals. We referred to it as the amount of covariance being accounted by electrophysiological signals. The accounted covariance is defined as,
 	Accounted covariance (%)=                                                     (〖(Covariance〗_(Before regression)- 〖Covariance〗_(After regression)))/〖Covariance〗_(Before regression) ×100%

The regression between electrophysiological and oxygen signals can be performed on the raw signals. However, this is very likely to underestimate the effect, because previous studies have argued that a transfer function needs to be applied before the regression to reflect the neuro-hemodynamic coupling. The transform function was computed using Welch’s method with a window size of 5 mins. Electrophysiological signals after convolving with the transfer function were regressed out of the oxygen signal. 
We performed the regression-based dependency on both within-network and across-network correlations.

