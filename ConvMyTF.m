function [Convd]= ConvMyTF(TFinTime,x,StartTime)
%% ConvMyTF
% Default also wrap the transfer function in time.
% This method will recover the non-causal component in the transfer function. 

if nargin == 2 
    StartTime = 1;
end

if size(TFinTime,1) < size(TFinTime,2)
    TFinTime = TFinTime.';
end

if size(x,1) < size(x,2)
    x = x.';
end
    
Convd =[];
swindow = size(TFinTime,1);

for i = 1:size(TFinTime,2)
    NN = mod(ceil(swindow/2) + StartTime - 1,swindow);
    Tmp = conv([x(:,i) ; x(:,i) ; x(:,i)],TFinTime([NN:end 1:NN-1],i));
    Convd(:,i)  = Tmp(swindow-ceil(swindow/2)+2+length(x):swindow-ceil(swindow/2)+2*size(x,1)+1);

end

