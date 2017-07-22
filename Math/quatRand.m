function q  = quatRand()
q = rand(4,1);
n = norm(q);
while (n>1) || (n<1e-3)
	q = rand(4,1);
	n = norm(q);
end
q = q/n;

end