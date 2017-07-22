function [y,yd,ydd] = myspline22(t,t1,t2,y1,y2,yd1,yd2)
% f(t) = at^3 + bt^2 + ct + d
% t1, t2 must be scalar
t = t - t1;
t2 = t2 - t1;

c = yd1;
d = y1;

temp1 = 2*(y2-yd1*t2-y1)/t2^2;
temp2 = (yd2-yd1)/t2;

a = (temp2 - temp1)/t2;
b = 1.5*temp1-temp2;

y   = a.*(t.^3) + b.*(t.^2) + c.*t + d;
yd  = 3*a.*(t.^2) + 2*b.*t + c;
ydd = 6*a.*t + 2*b;

end