function [ num,x_history,f_history ] = SA( fargs,aargs )
%SA Simulated Anealling
%   fargs: arguments for func,1:dim,2:type,3:smoothness
%   aargs: arguments for algorithm
%       1:initial temperature
%       2:stop steps
%       3:inner loop number
%       4:annealing factor
%       5:outter loop accept factor
dim = fargs(1);

tpt = aargs(1);      %��ʼ�¶�
stop_iter_n = aargs(2);      %ֹͣ����
inner_loop_num = aargs(3); %��ѭ������
gamma = aargs(4);       %ָ���˻�ϵ��
k2 = aargs(5);          %��ѭ����������

x=rand(dim,1)*9+1;  %��ʼ��

num=1; %ͳ�Ƶ�������
f_history(num)=objFunc(x,fargs);   %ÿ�ε�����ĺ���ֵ 
x_history = x;                     %ÿ�ε�����Ľ�

now_count = 0;
now = objFunc(x,fargs);
while now_count<stop_iter_n    %ֹͣ�����ȶ�����
    value0=objFunc(x,fargs);         %evaluate old solution
    
    if abs(value0 - now) < 1e-6
        now_count = now_count+1;
    else
        now_count = 0;
    end
    now = value0;
    
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
        f_history(num+1)=value0;
        if delta_value<0
            x=x_perturbed;
            f_history(num+1)=value1;
        else
            if exp(-delta_value/(k2*tpt))>rand() %������������ѡ���Ƿ�����½�
                x=x_perturbed;
                f_history(num+1)=value1;
            end
        end        
    end
    num=num+1;
    x_history(:,num)=x;
     
    tpt=tpt*gamma;   %ָ���˻�
end%while

end

