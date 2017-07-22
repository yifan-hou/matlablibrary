% descretize a linear system with zero-order-holder input.
% xd = Ax + Bu, 
% y = Cx + D.  C, D don't need to change.
clc;

syms T;

% A=[0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 0 0 0;0 0 0 0 1 0;0 0 0 0 0 1;0 0 0 0 0 0];
% B=[0 0;0 0;1 0;0 0;0 0;0 1];
A = [0 1; 0 0];

syms m real;
B = [0; 1/m];

%As=exp(AT) = I + AT + ... + AT^k/k! +...
% make sure you know which order goes to zero
AT=A*T;  %AT^3=0
e_AT=1*AT^0 + 1*AT^1 + (1/2)*AT^2; 
As=e_AT;
disp('As');
disp(As);


%Bs = integral(exp(AT)*B, dt)
syms x;
Ax=A*x;
e_Ax=1*Ax^0 + 1*Ax^1 + (1/2)*Ax^2;
f=e_Ax*B;

% based on f, determine Bs: 
% f
% [ x^2/2, 0]
% [     x, 0]
% [     1, 0]
% Bs
Bs=[T^3/6,     0;
    T^2/2,     0;
        T,     0;
        0,     T^3/6;
        0,     T^2/2;
        0,     T];
disp('Bs');
disp(Bs);
%Cs,Ds do not change
    
