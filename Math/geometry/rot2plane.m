% rotate vector v about n, until v is parallel to ground, close to x. (v(3)=0)
% input:
% 	v: 3x1
%   n: 3x1
%   x: 3x1 
% output:
% 	theta
function theta = rot2plane(v, n, x)
	v = v/norm(v);
	n = n/norm(n);
	x = x/norm(x);
	N = crossMat(n);

	% acos + bsin + c = 0
	a = -N*N*v; 
	b = N*v; 
	c = v - a;
	a = a(3);
	b = b(3);
	c = c(3);

	phi = atan2(a,b);
	k   = sqrt(a^2 + b^2);
    if k < 1e-9
        theta = [];
        return;
    end

	temp = asin(-c/k);
	if temp > 0
		temp = [temp, pi - temp];
	else
		temp = [pi - temp, temp + 2*pi];
	end
	% temp: [0, 2*pi]
	theta = temp - phi;

	% make sure outputs are positive
	if theta(1) < 0
		theta(1) = theta(1) + 2*pi;
	end
	if theta(2) < 0
		theta(2) = theta(2) + 2*pi;
	end
	
	% pick the one closer to x
	v_r1 = aaOnVec(v, theta(1), n);
	v_r2 = aaOnVec(v, theta(2), n);
	if x'*v_r1 < x'*v_r2
        theta = theta(2); 
	else
		theta =  theta(1);
	end
		
end