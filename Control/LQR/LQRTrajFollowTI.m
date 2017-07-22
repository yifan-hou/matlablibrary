function [K_, u_ext_] = LQRTrajFollowTI(F_,G_,H,R,Q2,y_star,x0,N)
%LQRTrajFollow Run discrete-time LQR to solve trajectory follow problem
%   F,G: x(t+1) = F*x(t) + G*u(t) t=0~N-1
%   H: y(t) = H'x(t)               t=1~N
%   R,Q2,y_star: V = sum{ u'(t-1)R(t)u(t-1) +
%       [y(t)-y*(t)]'Q2(t)[y(t)-y*(t)] },t=1~N
%   y_star: ny by N
%   x0: initial value,t=0
%   N:  length of horizon
%
%         Yifan Hou, 2016/8/3
%


% dimension of the problem
n = size(F_,1);
nu = size(R,1);
ny = size(H,2);
I = eye(n);
%----------------------------------------
%   Transform to traj follow on x traj:
%       V = sum{ u'(t-1)R(t)u(t-1) + [x(t)-x*(t)]'Q(t)[x(t)-x*(t)] }
%----------------------------------------

% intialize
x_star = x0*ones(1,N); 
Q = zeros(n,n,N);
for i = 1 : N
    L = H * ( H' * H )^-1;
    %H_bar = ( I - L * H(:,:,i)' )';
    x_star(:,i) = L * y_star(:,i);
    Q(:,:,i) = H * Q2(:,:,i) * H';
end
% disp('R:(should be positive definite)');
% disp(R);
% disp('Q:(should be nonegative definite)');
% disp(Q);
%----------------------------------------
%   Calculate the optimal control.
%       V = sum{ u'(t-1)R(t)u(t-1) + [x(t)-x*(t)]'Q(t)[x(t)-x*(t)] }\
%       u*(t)=K'(t)x(t) + uext(t);
%----------------------------------------

%calculate S(t) 1~N
S = Q; %S(N)=Q(N)
GSGRG_ = zeros(nu,n,N);%0 ~ N-1
GSGRG_SF = zeros(nu,n,N);
for j = 1:N-1
    t = N - j; %1~N-1
    SG_ = S(:,:,t+1) * G_;
    GSGRG_(:,:,t+1) = ( G_' * SG_ + R(:,:,t+1) )^-1*G_';
    GSGRG_SF(:,:,t+1)= GSGRG_(:,:,t+1)* S(:,:,t+1)* F_;
    temp2= S(:,:,t+1)* F_ - SG_ * GSGRG_SF(:,:,t+1); 
    S(:,:,t) = F_'* temp2 + Q(:,:,t);
end
GSGRG_(:,:,1) = ( G_' * S(:,:,1) * G_ + R(:,:,1) )^-1*G_';
GSGRG_SF(:,:,1)= GSGRG_(:,:,1)* S(:,:,1)* F_;

% %calculate P(t)
% P = S - Q;

%calculate K(t) K(0 ~ N-1) K(t=0)=K(1),K(t=T-1)=K(N)
K_ = zeros( n, nu, N );
for t = 0:N-1
    %t=i-1
   temp2 = - GSGRG_SF(:,:,t+1);
   K_(:,:,t+1) = temp2';
end

%calculate b(t)   1~N
b = zeros(size(Q,1),N); %b(N)=0
for j = 1:N-1
    t = N - j;%1~N-1
    temp = F_' + K_(:,:,t+1) * G_';
    b(:,t) = temp * b(:,t+1) - Q(:,:,t) * x_star(:,t);
end

%calculate u_ext(t)  0~N-1
u_ext_ = zeros(nu,N);
for t = 0 : N-1
    u_ext_(:,t+1) = - GSGRG_(:,:,t+1) * b(:,t+1);
end

end

