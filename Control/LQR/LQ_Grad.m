function [Jd] = LQ_Grad(F_,G_,R,Q,x_star,X0,U0,N)
%LQR_GD Calculate Gradient for discrete-time LQ problem
%   F,G: x(t+1) = F(t)x(t) + G(t)u(t) t = 1~N
%   R,Q,x_star: V = sum{ u'(t)R(t)u(t) +
%       [x(t)-x*(t)]'Q(t)[x(t)-x*(t)] },t=1~N 
%   x_star: nx by N
%   X0: nx by N, current trajectory
%   U0: Nu by N, current control
%   N:  length of horizon
%
%         Yifan Hou, 2016/8/15
%


% dimension of the problem
nx = size(F_, 1);
nu = size(R, 1);
%----------------------------------------
%   Calculate the gradient.
%       V = sum{ u'(t-1)R(t)u(t-1) + [x(t)-x*(t)]'Q(t)[x(t)-x*(t)] }\
%       u*(t)=K'(t)x(t) + uext(t);
% 	Reference: "Differential Dynamic Programming with Temporally Decomposed Dynamics"
%----------------------------------------
omega = zeros(nx,1);
Jd = zeros(nu, N);
for j = 1:N-1
	t = N - j; %N-1 ~ 1
	omega   = F_(:,:,t+1)'*omega + 2*Q(:,:,t+1)*(X0(:,t+1) - x_star(:,t+1));
	Jd(:,t) = G_(:,:,t)'*omega + 2*R(:,:,t)*U0(t,:);
end

end


