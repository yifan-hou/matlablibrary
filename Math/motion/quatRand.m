function q  = quatRand()
q = 2*rand(4,1)-1;
n = norm(q);
while (n>1) || (n<1e-3)
	q = 2*rand(4,1)-1;
	n = norm(q);
end
q = q/n;

end