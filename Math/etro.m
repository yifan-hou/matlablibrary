function [ e ] = etro( p,q )
% etro: calculate entropy
%   p,q are integers >= 0
% 
% Author Info:
%  	 Yifan Hou,<houyf11@gmail.com> 
% Last Updated: 
%  	 2016-02-20 13:16 

n=p+q;
e=0;
if p>0.1 
    e = e  -p/n * log2(p/n);
end
if q > 0.1
    e = e -q/n*log2(q/n);
end

end

