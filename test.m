function [ output_args ] = test(  )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    x = [1, 2];
    dbl(1, 10);
    x
end

function dbl(chucubucu,y)
A=inputname(1);
B=2*y;
assignin('caller',A,B)
end
