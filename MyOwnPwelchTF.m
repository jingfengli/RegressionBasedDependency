function [TF,TFinTime,Res,Tres]= MyOwnPwelchTF(x,y,swindow,noverlap,nfft,Switch,MTM)
%% MyOwnPwelchTF
%   1. Use p-welch method to compute the transfer function from x to y
%   2. Transfer function is then used to computed the prediction of y based on x
%   3. Compute the residual y, after regressing out the prediction.
% Switch is not used now. With optional multitaper methods.
% 
% Example:
%   Setting up trouble shooting scrips.
%   x = randn(10000,1); % generate random signal
%   z = randn(10000,1) + x*0.2;
% 
%   gaussFilter = gausswin(100); % the ground truth transfer function
%   xFilter = gaussFilter / norm(gaussFilter); % Normalize.
%   xFilter = [zeros(100,1);xFilter];
%   xy = conv(x,xFilter(1:end));
%   xy = xy(1:length(x)); % truancate the Y to be the same length as X
% 
%   zFilter = [zeros(1,100) sin([0:99]/99*2*pi)];
%   zFilter = zFilter/norm(zFilter);
%   zy = conv(z,zFilter(1:end));
%   zy = zy(1:length(z)); % truancate the Y to be the same length as X
% 
%   Ratio = 0;
%   Noise = randn(10000,1);
% 
%   y = xy + zy +Noise *Ratio;
%   [TF,TFinTime,Res,Tres]= MyOwnPwelchTF(x,y,1024)
% Output:
%   'TF' is the transfer function in fequency domain, which is the same as gaussFilter
%   'TFinTime' is the transfer function in time domain
%   'Res' is the residual y, computed using substrating the prediction
%   'Tres' is the residual y, computed using regression

if nargin == 3
    noverlap = swindow/2;
    nfft = swindow;
    Switch = 1;
    MTM = 0;
end
if length(MTM) == 1 && MTM == 1
    MTM = [3 5];
end

y = y(:);

if size(x,2) == size(y,1)
    x = x.';
end
if size(x,1) ~= size(y,1)
    error('ErrorTests:convertTest', 'Input dimension does not match! \n');
end

% compute PSD and CSD
window = hamming(swindow);
n = length(x);		% Number of data points
nwind = length(window); % length of window
if n < nwind    % zero-pad x , y if length is less than the window length
    x(nwind,end)=0;
    y(nwind)=0;  
    n=nwind;
end

k = fix((n-noverlap)/(nwind-noverlap));	% Number of windows
					% (k = fix(n/nwind) for noverlap=0)

index = 1:nwind;

if length(MTM) ==1 && MTM == 0
    Px = zeros(nfft,size(x,2),k);
    % size(Px)
    Py = zeros(nfft,k);
    for tk=1:k 
        tindex = index + (nwind - noverlap) * (tk -1);    
    
        xw = repmat(window,1,size(x,2)).*x(tindex,:);
        yw = window.*y(tindex);
    
        Xx = fft(xw,nfft);
        Yy = fft(yw,nfft);  

        Px(:,:,tk) = Xx; 
        Py(:,tk) = Yy;
    
    end
else
    tapers=dpsschk(MTM,nwind,1); % check tapers
    xw = zeros(nfft,size(x,2),MTM(2),k);
    yw = zeros(nfft,MTM(2),k);
    
    for tk = 1:k
        tindex = index + (nwind - noverlap) * (tk -1); 
        xw(:,:,:,tk)=permute(mtfftc(x(tindex,:),tapers,nfft,1),[1 3 2]);
        yw(:,:,tk)=mtfftc(y(tindex),tapers,nfft,1);
    end    
    Px = reshape(xw,[nfft, size(x,2), k*MTM(2)]);
    Py = reshape(yw,[nfft, k*MTM(2)]);
end
    
% Set things beyond the range (befault is 0.01~0.1Hz) as zeros
if Switch == 1
    Fs = 5; lpass = 0.1; hpass = 0.01;
else
    Fs = Switch(1); lpass = Switch(2); hpass = Switch(3);
end

f =  Fs/2*linspace(0,1,ceil(nfft/2+0.5));

if mod(nfft,2) == 0
    fq = [f f(end-1:-1:2)];
else
    fq = [f f(end:-1:2)];
end

TF = zeros(size(Py,1),size(Px,2));

% TF is estimated by first estimating cross spectrum by averaging across
% time window, then do the division, this is SIMILAR to do a multi-linear  
% regression. THOUGH regression may be better.

for i = find(fq >= hpass & fq <= lpass)
    tmp= squeeze(Px(i,:,:)).';
% If there is only one input, it will mess with the structure. 
    if size(tmp,1) == 1
        tmp = tmp.';
    end
    TF(i,:) =  regress(Py(i,:).',tmp);
end

TFinTime = ifft(TF);

% Tres is calculated based on regression. Res is calculated based on
% subtraction.

Convd = ConvMyTF(TFinTime,x);
Res = y - sum(Convd,2);

[b,bint,Tres] = mvregress(Convd,y);

if (nargout == 0)      
    figure; hold on
    plot(TFinTime)
    title('TF in time')
    figure; hold on
    plot(Res,'r')
    plot(Tres,'c')
    plot(y,'k')
    title('Before and after removing X from Y')
    legend({'Res' 'Reg-Res' 'Y'})
end

end


 
