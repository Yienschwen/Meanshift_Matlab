function [ Out ] = VecNorm2Sq(In)
M = size(In, 1);
Out = zeros(1, size(In, 2));
for i = 1:M
    Out = Out + In(i, :).^2;
end
end