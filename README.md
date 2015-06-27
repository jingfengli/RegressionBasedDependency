# RegressionBasedDependency
MATLAB code for regression based dependency 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Results are published in 'Li J, Bentley W, Snyder L. Neural Correlates of Functional Connectivity. Organization for Human Brain Mapping, 2015.'
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

The goal is to address whether one process drives the correlation between two other signals. Ideally, one should extract just the shared (correlated) component, and then using causality analysis (e.g., Granger causality analysis or transfer entropy) to determine whether the process of interest drives that correlated component. Methods extracting the correlated component require a large number of correlated signals as input to operate properly. With small amount of correlated signals, the extracted component will necessarily include a substantial amount of non-correlated signal, regardless of the precise method used. Regression based dependency analysis circumvents the need of extracting the correlated component. It estimates the extent to which regressing out the signal can diminish the correlation. 

![My image](https://github.com/jingfengli/images/blob/master/Dependency.png)


Specifically, in our case, we want to address which electrophysiological signal(s) are most tightly coupled to long-range oxygen correlation. Dependency analysis determines whether the shared variance between oxygen signals is the same as the shared variance between oxygen and multi-unit activity (MUA) (or between oxygen and any other electrophysiological signal). It estimates the extent to which regressing out a particular electrophysiological signal can diminish interregional oxygen correlation. If regressing out MUA activity (or any other electrophysiological signal) from oxygen completely abolishes interregional oxygen correlation, then interregional oxygen correlation completely depends on MUA activity. In other words, MUA activity accounts for 100% of interregional oxygen correlation. If there is no effect of the regression, then correlation does not depend at all on MUA activity. Intermediate effects indicate partial dependence. 

The regression between electrophysiological and oxygen signals can be performed on the raw signals. However, this is very likely to underestimate the effect, because previous studies have argued that a transfer function needs to be applied before the regression to reflect the neuro-hemodynamic coupling. The transform function was computed using Welch’s method with a window size of 5 mins. Electrophysiological signals after convolving with the transfer function were regressed out of the oxygen signal. 

