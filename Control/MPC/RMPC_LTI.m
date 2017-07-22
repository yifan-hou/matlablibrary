% LTI stabilization
% Q1, R: diagonal matrix
function [F] = RMPC_LTI(CoA,CoB,x0,Q1,R)
[dim,dimU,m] = size(CoB); %size of problem. m is number of edges in convex hull

Ix = eye(dim);
Iu = eye(dimU);
Q1_2 = sqrt(Q1);
R_2  = sqrt(R);

% -----------------------------------------------------
% 			LMI constraints
% -----------------------------------------------------
setlmis([])

% variables
gama = lmivar(1,[1 0]); % variable gama, scalar
Q = lmivar(1,[dim 1]); % variable Q, full symmetric
Y = lmivar(2,[dimU,dim]); % variable Y, rectangular

% constraint one
lmiterm([-1 1 1 0],1); %1  
lmiterm([-1 1 2 0],x0'); %x^T
lmiterm([-1 2 2 Q],1,1); %Q
 
% upper bound constraints
for j = 1:m
	% diagonal terms
	lmiterm([-j-1 1 1 Q],1,1); %Q
	lmiterm([-j-1 1+1 1+1 Q],1,1); %Q
	lmiterm([-j-1 1+2 1+2 gama],1,Ix); %gama I
	lmiterm([-j-1 1+3 1+3 gama],1,Iu); %gama I
	% 1-diagonal terms
	lmiterm([-j-1 1+1 1 Q],CoA(:,:,j),1); %AjQ
	lmiterm([-j-1 1+1 1 Y],CoB(:,:,j),1); %BjY
	% 2-diagonal terms
	lmiterm([-j-1 1+2 1 Q],Q1_2,1);
	% 3-diagonal terms
	lmiterm([-j-1 1+3 1 Y],R_2,1);
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

Qopt = dec2mat(LMIs,xopt,Q);
Yopt = dec2mat(LMIs,xopt,Y);

F = Yopt*(Qopt^-1);

end