% project the angle to [-180, 180]
function a = ang_180(a)
a = mod(a+180, 360) - 180;
end