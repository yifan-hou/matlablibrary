% project the angle to [0, 2*pi]
function a = ang02pi(a)
a = mod(a, 2*pi);
end