function [ num,x_history,f_history ] = PSO(aargs,objFunc,verbose)
%PSO Particle Swarm Optimization
% [ num,x_history,f_history ] = PSO(aargs,objFunc)
% 
% velocity update based on
%   V = wV + phi_p*rp*(p-x) + phi_g*rg*(g-x)
% rp,rg are rand(). w, phi_p, phi_g are weights. p is the historical best position of x. g is the group historical best position.
% 
%  aargs:  dim         : dimension of x       
%          range       : range of x. size(range) = [dim, 2]
%          group_size  : size of group
%          stop_iter_n : stop if the optimal does not change for this number of iterations
%          omega       : weight of inertia term
%          phi_p       : self perception. small value leads to faster convergence and overfitting
%          phi_g       : ability to use social global info. small value make it hard to converge
%  objFunc: handle of cost function
% 
%  return:
%  num: number of iterations
%  x_history
%  f_history
if isempty(verbose)
    verbose = false;
end

dim         = aargs.dim;
range       = aargs.range;
S           = aargs.group_size;
stop_iter_n = aargs.stop_iter_n;
omega       = aargs.omega;  
phi_p       = aargs.phi_p;
phi_g       = aargs.phi_g;

%
%   Initialization
%

% initial group obeys uniform distribution
range1 = (range(:,2)-range(:,1))*ones(1,S);
range2 = range(:,1)*ones(1,S);
X = rand(dim,S).*range1 + range2; 

P  = X;    % historical best solution
PV = zeros(S,1);% historical best value
for i = 1:S
    PV(i) = objFunc(P(:,i));
end
g  = X(:,1);% historical best solution of whole group
gv = objFunc(g);% historical best value of whole group
for i = 1:S
   if objFunc(X(:,i)) < gv
       g = X(:,i);
       gv = objFunc(X(:,i));
   end
end

V = rand(dim,S).*range1 - 0.5*range1;%initial velocity
%
%   Begin iteration
%

iter = 0;
now_count = 0;
now = gv;
while now_count<stop_iter_n    %stop at certain number of iteration
        
    for i = 1:S
        rp = rand();
        rg = rand();
        % update velocity
        V(:,i) = omega * V(:,i) + ...
            phi_p * rp * (P(:,i) - X(:,i)) + ...
            phi_g * rg * (g      - X(:,i));
        X(:,i) = X(:,i)+V(:,i);
        xv = objFunc(X(:,i));
        if xv < PV(i)
            PV(i) = xv;
            P(:,i)=X(:,i);
            if xv < gv
                gv = xv;
                g  = X(:,i);
            end
        end
    end
    
    if abs(gv - now) < 1e-6
        now_count = now_count+1;
    else
        now_count = 0;
    end
    now = gv;
    
    iter = iter + 1;
    x_history(:,iter) = g;
    f_history(iter) = gv;

    if verbose
        disp(['Iter ' num2str(iter) 'value ' num2str(gv)]);
        disp(g);
    end
    
end
num = iter;



end

