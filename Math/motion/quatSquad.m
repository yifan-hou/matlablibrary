% Squad: Spherical Spline Quaternion interpolation:
% Ref:
% 	http://web.mit.edu/2.998/www/QuaternionReport1.pdf
% 
% Inputs
% 	x: 1xN 
% 	q: 4xN unit quaternion.
% 	t: 1xM,
% Outputs
% 	qi: 4xM unit quaternions
function qi = quatSquad(x, q, t)
	N = size(q, 2);
	M = length(t);

	s = q;
	q1_inv  = quatInv(q(:,1));
	temp1   = quatLog(quatMTimes(q1_inv, q(:,2)));
	temp2   = quatLog(quatMTimes(q1_inv, q(:,1)));
	s(:, 1) = quatMTimes(q(:,1), quatExp(-(temp1 + temp2)/4));
	for i = 2:N-1
		qi_inv  = quatInv(q(:,i));
		temp1   = quatLog(quatMTimes(qi_inv, q(:,i+1)));
		temp2   = quatLog(quatMTimes(qi_inv, q(:,i-1)));
		s(:, i) = quatMTimes(q(:,i), quatExp(-(temp1 + temp2)/4));
	end
	qn_inv    = quatInv(q(:,end));
	temp1     = quatLog(quatMTimes(qn_inv, q(:,end)));
	temp2     = quatLog(quatMTimes(qn_inv, q(:,end)));
	s(:, end) = quatMTimes(q(:,end), quatExp(-(temp1 + temp2)/4));

	% get indices
	%  obtain the row vector xs equivalent to XX
	lx = numel(t); xs = reshape(t,1,lx);

	% for each evaluation site, compute its breakpoint interval
	[~,index] = histc(xs,[-inf,x(2:end-1),inf]);

	qi = zeros(4, M);
	for i = 1:N-1
	    idx = (index == i);
	    h = (xs(idx) - x(i))/(x(i+1)-x(i)); % [0, 1]
	    assert(~any(h>1+1e-8));
	    assert(~any(h<-1e-8));
	    temp1 = quatSlerp(q(:,i), q(:, i+1), h);
	    temp2 = quatSlerp(s(:,i), s(:, i+1), h);
	    id = find(idx);
        for j = 1:size(temp1,2)
            qi(:, id(j)) = quatSlerp(temp1(:,j), temp2(:,j), 2*h(j)*(1-h(j)));
        end
	end


end