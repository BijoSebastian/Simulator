function [ err ] = errcal( dsrd,attnd )
%Function to calculate error on given particle
%Error is Euclidean distance between desired and attained

err = sqrt((dsrd(1) - attnd(1))^2 + (dsrd(2) - attnd(2))^2);
end

