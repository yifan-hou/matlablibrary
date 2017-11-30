% Quaternion Logarithm
% Inputs
% 	q: 4xN unit quaternion.
% Outputs
% 	logq: 4xN pure quaternion, not necessarily unit
function logq = quatLog(q)
n = q(2:4,:);
s = normByCol(n); % sin(theta)
c = q(1,:); % cos(theta)

% id of non-zeros
logq         = zeros(size(q)); % get size
id_non_zeros = s>1e-6;
if ~any(id_non_zeros)
    return;
end
s            = s(id_non_zeros);
c            = c(id_non_zeros);
n            = n(:, id_non_zeros)./(ones(3,1)*s); % normalize

theta = atan2(s, c);

logq(2:4, id_non_zeros) = (ones(3,1)*theta).*n;

end