function [ result ] = u_check(x,dim,min,max)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i=1:dim
    if x(i) < min
        result = -1;
        return;
    end
    if x(i) > max
        result = -1;
        return;
    end 
end
result = 1;

end

