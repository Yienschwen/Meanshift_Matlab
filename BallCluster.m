function [ Out ] = BallCluster( In, radius )
%BALLCLUSTER Summary of this function goes here
%   Detailed explanation goes here

N = size(In, 2);
Out = zeros(1,N);
index = 0;
for i = 1:N
    if Out(i)
        continue
    end
    index = index + 1;
    Out(i) = index;
    notset = ~Out((i+1):N);
    inball = (VecNorm2Sq(In(:,(i+1):N)-In(:, i)) < radius.^2);
    flag = notset & inball;
    Out((i+1):N) = Out((i+1):N) + flag .* index;
end
end

