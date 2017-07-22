% X: nx by N, data
% Y: ny by N, data
function [k,kw] = LWR_PARA_TUNING_GLOBAL(X,Y,k0,kw0,krange,kwrange)

[N1,~] = size(X);
[N2,~] = size(Y);

if (N1~=N2)
	error('Wrong dimension.');
end

N = N1;

Indices = crossvalind('Kfold', N, 10); 

prange  = [krange; kwrange];
UB      = prange(:,2);
LB      = prange(:,1);

if any(LB > UB)
	error('Wrong bounds');
end

p0 = [k0;kw0];

options = optimset('Display','iter');
p = fminsearch(@(p)Gross_error(X,Y,Indices,LB,UB,p),p0,options);

k  = p(1)
kw = p(2:end)/norm(p(2:end))

end


function cost = Gross_error(X, Y, Indices, LB, UB, p)
    % disp('Calculating Gross Error');
    for i = 1:length(p)
    	if p(i) > UB(i)
    		p(i) = UB(i);
    	elseif p(i) < LB(i)
    		p(i) = LB(i);
    	end
    end
	k = p(1);
	kw = p(2:end);

	cost = 0;
	for iter = 1:2
		test = (Indices == iter); train = ~test;
		c = LWR_VALIDATION(X(train,:),Y(train,:),X(test,:),Y(test,:),k,kw);
		cost = cost + c;
	end

end
