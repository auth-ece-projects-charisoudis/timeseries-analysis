function phi_y = partial_autocorrelation_with_limits(y, maxtau, title_, alpha)
%PARTIAL_AUTOCORRELATION_WITH_LIMITS Plots the partial autocorrelation of 
%a discrete timeseries and the (1-`alpha`)*100% confidence limits.
%Source: tmp.m
%Author: Prof. Dimitris Kugiumtzis
%INPUTS:
%   y           : the timeseries as an array of scalars
%   maxtau      : maximum lag of partial autocorrelation
%OUTPUTS:
%   phi_y       : the autocorrelation values at lags 0,...,`maxtau`
if nargin == 2
    alpha = 0.05;   % 95% confidence
    title_ = '(Sample) Autocorrelation of Y';
elseif nargin == 3
    alpha = 0.05;
end

% Zero-mean timeseries before computing partial autocorrelation
y = y - mean(y);

% Compute autocorrelation and partial autocorrelation
n = length(y);
r_y = autocorrelation(y, maxtau);
phi_y = parautocor(y, maxtau);

% Plot partial autocorrelation
figure('Position', 1.0e+03*[0.662428571428571   0.361000000000000   1.288571428571428   0.725714285714286]), clf, grid on, hold on
set(gca, 'FontName', 'JetBrains Mono')
set(gcf, 'Color', [1 1 1])
for ii=1:maxtau
    plot(r_y(ii+1,1)*[1 1],[0 phi_y(ii)],'b','linewidth',1.5)
end

% Compute importance limits (from confidence)
zalpha = norminv(1-alpha/2);
autlim = zalpha/sqrt(n);

% Plot limits
plot([0 maxtau+1],[0 0],'k','linewidth',1.5)
plot([0 maxtau+1],autlim*[1 1],'--c','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--c','linewidth',1.5)

xlabel('lag (\tau)'), ylabel('\phi(\tau,\tau)')
title(title_, 'FontName', 'JetBrains Mono', 'FontSize', 14)
hold off
end

