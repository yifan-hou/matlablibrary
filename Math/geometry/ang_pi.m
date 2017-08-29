% project the angle to [-pi, pi]
function a = ang_pi(a)
a = mod(a+pi, 2*pi) - pi;
end