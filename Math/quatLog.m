% Quaternion Logarithm
% Inputs
% 	q: 4x1 quaternion.
% Outputs
% 	logq: 4x1 pure quaternion, not necessarily unit
function logq = quatLog(q)
n = q(2:4);
s = norm(n); % sin(theta/2)
c = q(1); % cos(theta/2)

n = n/s;
theta_2 = atan2(s,c);
logq = [0; theta_2*n];

end