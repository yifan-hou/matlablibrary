% sample N+1 points evenly between [a, b]
% first sample = a, last sample = b.
function samples = fixStepSample(a, b, N)
	step = (b-a)/N;
	samples = a + (0:N)*step;
end
