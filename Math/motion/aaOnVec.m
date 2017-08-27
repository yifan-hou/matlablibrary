% rotate vector v by axis-angle
% input:
% 	theta: angle
% 	n: 3x1, axis
% 	v: 3x1, vector
function vr = aaOnVec(v, theta, n)
q = aa2quat(theta, n);
vr = quatOnVec(v, q);
end