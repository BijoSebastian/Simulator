function [ wgt ] = Gaussian(x,sigma)
%Function to calculate the probability of x 
%for 1-dim Gaussian with mean 0 and var. sigma
        
 wgt = exp(-(x^2)/(2.0*(sigma^2)));
 wgt = wgt/sqrt(2.0*pi*(sigma^2));
 
end

