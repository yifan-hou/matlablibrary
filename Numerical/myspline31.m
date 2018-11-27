% use x1, xd1, xdd1 at t1,
% and x2 at t2, to compute value at t
function [x,xd,xdd] = myspline31(t,t1,t2,x1,x2,xd1,xdd1)
% f(t) = at^3 + bt^2 + ct + d
% t1, t2 must be scalar

a = (xdd1*t1^2 - 2*xdd1*t1*t2 - 2*xd1*t1 + xdd1*t2^2 + 2*xd1*t2 + 2*x1 - 2*x2)/(2*(t1 - t2)^3);
b = -(6*t1*x1 - 6*t1*x2 - 6*t1^2*xd1 + 2*t1^3*xdd1 + t2^3*xdd1 - 3*t1^2*t2*xdd1 + 6*t1*t2*xd1)/(2*(t1 - t2)^3);
c = (6*t1^2*x1 - 6*t1^2*x2 - 4*t1^3*xd1 - 2*t2^3*xd1 + t1^4*xdd1 + 6*t1*t2^2*xd1 + 2*t1*t2^3*xdd1 - 3*t1^2*t2^2*xdd1)/(2*(t1 - t2)^3);
d = (- xdd1*t1^4*t2 + 2*xdd1*t1^3*t2^2 + 4*xd1*t1^3*t2 + 2*x2*t1^3 - xdd1*t1^2*t2^3 - 6*xd1*t1^2*t2^2 - 6*x1*t1^2*t2 + 2*xd1*t1*t2^3 + 6*x1*t1*t2^2 - 2*x1*t2^3)/(2*(t1 - t2)^3);

 
x   = a.*(t.^3) + b.*(t.^2) + c.*t + d;
xd  = 3*a.*(t.^2) + 2*b.*t + c;
xdd = 6*a.*t + 2*b;

end