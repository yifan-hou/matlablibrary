function [ num,x_history,f_history ] = GA( fargs,aargs, max, min )
%GA Genetic Algorithm
%   fargs: arguments for func,1:dim,2:type,3:smoothness
%   aargs: arguments for algorithm
%       1:population size
%       2:survivors number
%       3:probability of mutation
%       4:��ֹ����
%   max: maximum value of the objFunc
%   min: minimum value of the objFunc
dim = fargs(1);
Np = aargs(1); %��Ⱥ��С
Ns = aargs(2); %��������Ŀ
Pm = aargs(3); %ͻ�����
stop_iter_n = aargs(4);      %ֹͣ����

x_history = zeros(dim,1);
f_history = 0;
%������ʼ��Ⱥ
P=rand(dim,Np)*9+1;
V=zeros(Np,1);


now_count = 0;
now = objFunc(P(:,1),fargs);
iter = 0;
while now_count<stop_iter_n    %ֹͣ�����ȶ�����
    iter = iter + 1;
    %��һ��������ֵ
    for i = 1:Np
        V(i) = (objFunc(P(:,i),fargs) - min)/(max-min);
    end
    
    %��������,Ns�����ŵ�������Ⱥ��
    %����Np-Ns������滻������Np-Ns��
    offsp = zeros(dim,Np-Ns);
    
    %׼������ѡ
    t_all = ones(1,Np)*V;
    label = zeros(Np,1);
    label(1)=V(1)/t_all;
    for i = 2:Np
        label(i) = label(i-1) + V(i)/t_all;
    end
    for i = 1:(Np-Ns)/2
        %����ѡ
        dice = rand();
        goal = 1;
        for j = 1:Np
            if dice > label(j)
                goal = goal + 1;
            else
                break;
            end
        end
        P1 = P(:,goal);
        dice = rand();
        goal = 1;
        for j = 1:Np
            if dice > label(j)
                goal = goal + 1;
            else
                break;
            end
        end
        P2 = P(:,goal);
        
        %����
        c_point = floor(rand()*dim+1);%����㣬1~dim���������
        beta = rand();
        offsp(:,2*i-1) = P1;
        offsp(:,2*i)   = P2;
        offsp(c_point,2*i-1) = P1(c_point) - beta*(P1(c_point)-P2(c_point));
        offsp(c_point,2*i  ) = P2(c_point) - beta*(P1(c_point)-P2(c_point));
        for jj = c_point + 1:dim
            offsp(jj,2*i-1) = P2(jj);
            offsp(jj,2*i  ) = P1(jj);
        end
        %���ˣ��������������
    end
    %���ˣ�������ȫ��������滻���Ľ�
    [t,I] = sort(V);
    for i = 1:Np-Ns
        P(:,I(i))=offsp(:,i);
    end
    
    %ͻ��,�������������Ķ��и���ͻ��
    Nm = Pm*dim*(Np-1);%���ܷ���ͻ���λ����Ŀ
    for i = 1:Nm
        t1 = floor(rand()*(Np-1)+1);
        t2 = floor(rand()*dim+1);
        P(t2,I(t1)) = rand()*9+1;
    end
    
    %���ˣ����һ���Ĳ�������¼���Ž�
    x_history(:,iter) = P(:,I(Np));
    value0 = objFunc(P(:,I(Np)),fargs);
    f_history(iter) = value0;
    
    %�ж�ֹͣ����
    if abs(value0 - now) < 1e-6
        now_count = now_count+1;
    else
        now_count = 0;
    end
    now = value0;
end
num = iter;
end