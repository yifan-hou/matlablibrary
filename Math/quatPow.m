% Quaternion power
% input:
% 	q: 4x1 unit quaternion
% 	t: 1xN number
% output:
% 	qt: 4xN unit quaternion(s)
function qt = quatPow(q, t)
qt = quatExp(quatLog(q)*t);
end