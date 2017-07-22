function [ num,x_history,f_history ] = GASA( fargs,aargs, max, min )
%GASA Summary of this function goes here
%   Detailed explanation goes here
dim = fargs(1);

tpt = aargs(1);      %��ʼ�¶�
stop_iter_n = aargs(2);      %ֹͣ����
inner_loop_num = aargs(3); %��ѭ������
gamma = aargs(4);       %ָ���˻�ϵ��
k2 = aargs(5);          %��ѭ����������

Np = aargs(6); %��Ⱥ��С
Ns = aargs(7); %��������Ŀ
Pm = aargs(8); %ͻ�����

%������ʼ��Ⱥ
P=rand(dim,Np)*9+1;
V=zeros(Np,1);

f_history = 0;   %ÿ�ε�����ĺ���ֵ 
x_history = zeros(dim,1);                     %ÿ�ε�����Ľ�

now_count = 0;
now = 0;
iter = 0;
while now_count<stop_iter_n    %ֹͣ�����ȶ�����
    iter = iter + 1;
    
    %
    %    GA
    %
    
    %��һ��������ֵ
    for i = 1:Np
        V(i) = (objFunc(P(:,i),fargs) - min)/(max-min);
    end
    
    
    %GA������ѡ�񽻲����
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
    
    %
    %   ��¼
    %
    
    %���ˣ����һ���Ĳ���
    x_history(:,iter) = P(:,I(Np));
    f_history(iter) = objFunc(P(:,I(Np)),fargs);
    
    %�ж�����׼�������
    value0=f_history(iter);
    if abs(value0 - now) < 1e-6
        now_count = now_count+1;
    else
        now_count = 0;
    end
    now = value0;
    
    %
    %   SA
    %
   
    for e = 1:Np
        x=P(:,e);
        value0=objFunc(x,fargs);         %evaluate old solution
        for i=1:inner_loop_num     %��ѭ��
            while 1
                %1. ����һ������ֵ���¶�Խ�����ֵԽ��
                dist = 3;%sqrt(dim)*sqrt(0.3*tpt);
                %2. �������һ��������ȵ��������ӵ�ԭx��
                x_perturbed = x + (rand(dim,1)-0.5)*dist;
                if u_check(x_perturbed,dim,1,10) > 0
                    break;
                end
            end
            
            value1=objFunc(x_perturbed,fargs);     %evaluate new solution
            %         Metropolis ����
            delta_value=value0-value1;  %������ֵ
            if delta_value<0
                x=x_perturbed;
            else
                if exp(-delta_value/(k2*tpt))>rand() %������������ѡ���Ƿ�����½�
                    x=x_perturbed;
                end
            end
        end%end inner loop
        P(:,e) = x;
    end
    tpt=tpt*gamma;   %ָ���˻�
    
end
num = iter;

end

