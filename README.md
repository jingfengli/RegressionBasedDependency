# RegressionBasedDependency
MATLAB code for regression based dependency analysis
Work in progress.

The goal is to address whether one process drives the correlation between two other signals. Ideally, one should extract just the shared (correlated) component, and then using causality analysis (e.g., Granger causality analysis or transfer entropy) to determine whether the process of interest drives that correlated component. Our method will 

+++++++++++++++++++++++

Under situations extraction


Methods extracting the correlated component require a large number of correlated signals as input to operate properly.  With only four signals, as in our case, the extracted component will necessarily include a substantial amount of non-correlated signal, regardless of the precise method used (see Supplemental Text and Figure S1). Thus, rather than operating on just the correlated component, we instead analyzed causal relationships involving the entire resting-state oxygen signal and electrophysiological signals. To our knowledge this has not been done. In fact, causality analysis has not even been attempted for the easier case of relating spikes and LFP to task-evoked oxygen or BOLD, although there have been tests of the necessity of spikes from pyramidal neurons for evoking task-evoked BOLD modulations (e.g., (20, 21)). 

Dependency analysis determines whether the shared variance between oxygen signals is the same as the shared variance between oxygen and multi-unit activity [MUA] (or between oxygen and any other electrophysiological signal). We estimate the extent to which regressing out a particular electrophysiological signal can diminish interregional oxygen correlation. If regressing out MUA activity (or any other electrophysiological signal) from oxygen completely abolishes interregional oxygen correlation, then interregional oxygen correlation completely depends on MUA activity. In other words, MUA activity accounts for 100% of interregional oxygen correlation. If there is no effect of the regression, then correlation does not depend at all on MUA activity. Intermediate effects indicate partial dependence.


To address which electrophysiological signal(s) are most tightly coupled to long-range oxygen correlation, we developed a regression-based dependency analysis.  It quantifies the extent to which the variance shared between a local electrophysiological signal and the local oxygen signal is the same shared variance that underlies the oxygen correlation (see Fig. 2 and Methods). The analysis reveals that, of all the electrophysiological signals, slow LFP is the most tightly coupled with oxygen correlation. 

Regression-based dependency analysis. Regression-based dependency analysis estimates the extent to which regressing out a particular electrophysiological signal can diminish interregional oxygen correlation. If regressing out gamma power (or any other electrophysiological signal) from oxygen completely abolishes interregional oxygen correlation, then interregional oxygen correlation completely depends on gamma power, or gamma power accounts for 100% of the interregional oxygen correlation. If there is no effect of the regression, then correlation does not depend at all on gamma power. Intermediate effects indicate partial dependence. 
Intuitively, regression-based dependency analysis computes the amount of the covariance underlying oxygen correlation that is the same as the covariance between oxygen and electrophysiological signals. We referred to it as the amount of covariance being accounted by electrophysiological signals. The accounted covariance is defined as,
 	Accounted covariance (%)=                                                     (〖(Covariance〗_(Before regression)- 〖Covariance〗_(After regression)))/〖Covariance〗_(Before regression) ×100%

The regression between electrophysiological and oxygen signals can be performed on the raw signals. However, this is very likely to underestimate the effect, because previous studies have argued that a transfer function needs to be applied before the regression to reflect the neuro-hemodynamic coupling. The transform function was computed using Welch’s method with a window size of 5 mins. Electrophysiological signals after convolving with the transfer function were regressed out of the oxygen signal. 
We performed the regression-based dependency on both within-network and across-network correlations.

