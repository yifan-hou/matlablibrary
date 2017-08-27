% Calculate a(range), where a is an array of length N.
% if range is beyond 1:N, it get wrapped into 1:N.
% e.g.
% 	N = 10, then a(-3:4) will return [a(7:10) a(1:4)]
function samples = circQuery(a, range)
	N = length(a);
	id = range < 1;
	while any(id)
		range(id) = range(id) + N;
		id = range < 1;
	end

	id = range > N;
	while any(id)
		range(id) = range(id) - N;
		id = range > N;
	end

	samples = a(range);
end
