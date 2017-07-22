function [x,xd,xdd] = PIDfilter(x_demand,PGain, IGain, DGain,timestep,delta_d,delta_dd,x0,xd0)
% PIDfilter
% [x xd] = PIDfilter(x_demand,PGain, IGain, DGain,timestep,x0 = 0,xd0 = 0,delta_d=0,delta_dd=0)
% Imput Arguments:
% 	x_demand          : Nx1 vector. demanded value for x
% 	PGain,IGain,DGain : as normal
% 	timestep          : in (ms)
% 	delta_d,delta_dd  : limit the amplitude of xd, xdd. 
% 	                  : zero means no limit.
% 	                  : default to zero
% 	x0, xd0           : initial value for x,xd.
% 	                  : default to zero
% Output arguments:
% 
% Author Info:
%  	 Yifan Hou,<houyf11@gmail.com> 
% Last Updated: 
%  	 2016-02-20 13:25 

if isempty(delta_d)
    delta_d = 0;
end

if isempty(delta_dd)
    delta_dd = 0;
end


if isempty(x0)
    x0 = 0;
end


if isempty(xd0)
    xd0 = 0;
end



N = size(x_demand,1);
% states
x    = zeros(1,N);
xd   = zeros(1,N);
xdd  = zeros(1,N);

x(1)      = x0;
xd(1)     = xd0;
xdd(1)     = 0;

Iterm     = 0;
pre_error = 0;

for t = 1:N-1
	err = x_demand(t) - x(t);

	pterm = PGain * err;
	dterm = DGain * (err-pre_error)/timestep;
	Iterm = Iterm + IGain * err * timestep;

	pre_error = err;

	output = pterm + Iterm + dterm;

	if delta_dd > 0
		if output > delta_dd
			output = delta_dd;
		elseif output < -delta_dd
			output = -delta_dd;
		end
    end
    if output - xdd(t) > 5
        xdd(t+1) = xdd(t)+5;
    elseif xdd(t) - output > 5
        xdd(t+1) = xdd(t)-5;
    else
        xdd(t+1)=output;
    end
	% integration
	ndivide = 50;
	dt      = timestep/ndivide;
	xd1     = xd(t);
	x1      = x(t);
    for i = 1:ndivide
		xd1 = xd1 + output*dt;
		x1 = x1 + (xd1 - output*dt/2) * dt;
	end
	xd(t+1) = xd1;
	x(t+1) = x1;
    % if delta_d > 0
	% 	if xd(t+1) > delta_d
	% 		xd(t+1) = delta_d;
	% 	elseif xd(t+1) < -delta_d
	% 		xd(t+1) = -delta_d;
	% 	end
	% end
	   	% xd(t+1) = xd(t) + output*timestep;
		% x(t+1) = x(t) + (xd(t+1) - output*timestep/2) * timestep;

end
