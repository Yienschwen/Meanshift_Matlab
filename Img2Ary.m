function [ Out ] = Img2Ary( Im )
%IMG2ARY Summary of this function goes here
%   Detailed explanation goes here
S = size(Im);
tmp = reshape(Im, [S(1) * S(2), S(3)]);
Out = tmp';
end

