% solve MPC stabilization for affine TI system expressed by linear extended vector.
% for tracking problem, first offset it to a stabilization problem before calling this function
% for affine system, use [x;1] trick to make a linear form
% for [0;1] stabilization problem, last row/column of Q1 must be zero

% state is penalized, input is ball-constrained.
% 	CoA, CoB: convex hull edges for A, B. 
% 			  cell array of vectors in dimension:[nx,nu,number of edges]
% 			  length of cell array is the length of horizon h
% 	X0: initial state vector X. 
% 	Q1: quadratic penality on X. cell array of length h
% 	umax: maximum norm of input vector u

% return:
% 	F0: feedback law for next step
% 	F: feedback law of all steps in horizon, cell array
function [F0, F] = RMPC_LTV(CoA,CoB,X0,Q1,umax)
H = length(CoA); % length of horizon
[nx,nu,~] = size(CoB{1}); %size of problem. 

Ix = eye(nx);
Iu = eye(nu);

% -----------------------------------------------------
% 			LMI constraints
% -----------------------------------------------------
setlmis([])

% variables
gama = lmivar(1,[1 0]); % variable gama, scalar
Q = lmivar(1,[nx 1]); % variable Q, full symmetric
Y = zeros([H,1]);
for h = 1:H
	Y(h) = lmivar(2,[nu,nx]); % variable Y, rectangular
end

% constraint one
ccount = 1; % count of LMIs
lmiterm([-ccount 1 1 0],1); %1  
lmiterm([-ccount 1 2 0],X0'); %x^T
lmiterm([-ccount 2 2 Q],1,1); %Q
ccount = ccount + 1;

% upper bound constraints
for h = 1:H-1
	L = size(CoA{h},3); %number of edges in the polytope
	for j = 1:L
		% diagonal terms
		lmiterm([-ccount 1 1 Q],1,1); %Q
		lmiterm([-ccount 1+1 1+1 Q],1,1); %Q
		lmiterm([-ccount 1+2 1+2 gama],1,Ix); %gama I
		lmiterm([-ccount 1+3 1+3 gama],1,Iu); %gama I

		% 1-diagonal terms
		lmiterm([-ccount 1+1 1 Q],CoA{h}(:,:,j),1); %AjQ
		lmiterm([-ccount 1+1 1 Y(h)],CoB{h}(:,:,j),1); %BjY

		% 2-diagonal terms
		lmiterm([-ccount 1+2 1 Q],sqrt(Q1{h}),1);

		% % 3-diagonal terms
		% lmiterm([-ccount 1+3 1 Y(h)],R_2,1);

		ccount = ccount + 1;
	end
end

% QmQ <= gama I
L = size(CoA{H},3); %number of edges in the polytope
for j = 1:L
	lmiterm([ccount 1 1 Q],Q1{H},1,'s'); %QmQ

	lmiterm([-ccount 1 1 gama],1,2*Ix); %gama I

	ccount = ccount + 1;
end


LMIs = getlmis;

% -----------------------------------------------------
% 			LMI Objective
% -----------------------------------------------------

% objective
n = decnbr(LMIs);
c = zeros(n,1);
c(1) = 1;
% c = zeros(n,1);
% 
% for j=1:n, 
% 	[gamaj,~,~] = defcx(LMIs,j,gama,Q,Y); 
% 	c(j) = gamaj; 
% end

% -----------------------------------------------------
% 			LMI solver
% -----------------------------------------------------
options = [1e-5,0,0,0,1] ;
[~,xopt] = mincx(LMIs,c,options);

gamaOpt = dec2mat(LMIs,xopt,gama);
Qopt = dec2mat(LMIs,xopt,Q);
Yopt = cell([H,1]);
F    = cell([H,1]);
for h = 1:H
	Yopt{h} = dec2mat(LMIs,xopt,Y(h));
	F{h}    = Yopt{h}*(Qopt^-1);
	if nargout <= 1
		break;
	end
end
F0 = F{1};

end