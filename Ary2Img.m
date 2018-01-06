function [ Out ] = Ary2Img( Ary, Size )
%ARY2IMG Summary of this function goes here
%   Detailed explanation goes here
    Out = reshape(Ary', Size);
end

