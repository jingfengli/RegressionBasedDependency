function [Cor_before_Regression, Cor_afterRegression] = Dependency_main(ox,ele,ad)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Main Function for Dependecy Analysis %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Address whether an electrophysiological signal is coupled to 
% long-range oxygen correlation
% Input: 
%   ox: oxygen signal, which are used to compute correlation
%   ele: electrophysiological signal
%   ad:  sampling frequency
% Assuming both ox and ele have 4 channels (4 columns)

%% Setting up the regression and transfer function computation.
%  Set to between 0.01 and 0.1 Hz, the frequency of interest to 
%  study brain functional organization

hpassfq = 0.01; 
lpassfq = 0.1;

% Time window is currently set at 50*5 s, allowing 2.5 cycles for 0.01 Hz
TFwin = 50*5; TFwin = 2.^ceil(log2(TFwin));

%% Compute the correlation before the regression
Cor_beforeRegression = reordercorrelation(corrcoef(ox));

oxtf = zeros(size(ox));

%% Compute the transfer function, 
%  which is then used to compute the regression and the residual oxygen signal
[TF(:,chi,nele) TFinTime(:,chi,nele) oxtf(:,chi)]= MyOwnPwelchTF(detrend(squeeze(ele(:,chi,nele))),detrend(ox(:,chi)),TFwin);

%% Computer the correlation after the regression
Cor_afterRegression(:,nele) = reordercorrelation(corrcoef(oxtf));

