function [] = NEWUOAStep4()
%NEWUOAStep4 ��ӦNEWUOA�㷨�ĵ��Ĳ�
% �������ϵ��RATIO���Դ���Ϊ����delta�����ݡ�
% ��MOVE����Ϊ��Ҫ���滻�ĵ�
global m n RATIO Fn Xn F F_times delta opt d NORMD rho MOVE Qnew H x0 w Hw beta Fnew Krho
Fopt=Fn(opt);
xopt=Xn(:,opt);
xnew=xopt+d;%�����ɵĵ�
Fnew=F(xnew);
F_times=F_times+1;
Krho=Krho+1;
%%
%����RATIO
dQ=Fopt-Qnew;
dF=Fopt-Fnew;
if dQ<=0 %%����ģ��û���½�
    if dF>0 %����ʵ��ֵ���½���
        RATIO=0;%ȥ�޸�ģ��
    else%ʵ��ֵҲû���½�
        RATIO=-1;
    end
else
    RATIO=dF/dQ;
end
%%
%����delta
if RATIO<=0.1
    deltaint=0.5*NORMD;
else
    if RATIO<=0.7
        deltaint=max([NORMD,0.5*delta]);
    else
        deltaint=max([2*NORMD,0.5*delta]);
    end
end
if deltaint>1.5*rho
    delta=deltaint;
else
    delta=rho;
end
%%
%��ѡ��������ĵ�
    T=1:m;%����ѡ�ĵ� 
if dF>0
    Case=1;
    xstar=xopt+d;%֮�������ֵ��
else
    xstar=xopt;%֮�������ֵ��
    T(opt)=[];
    Case=-1;
end
w=zeros(m+n+1,1);
dxx0=xnew-x0;
for i=1:m
    w(i)=0.5*(((Xn(:,i)-x0)'*(dxx0))^2);
end
w(m+1)=1;
w(m+2:m+n+1)=dxx0;
Hw=H*w;
beta=0.5*((dxx0'*dxx0)^2)-w'*Hw;
Sigma=zeros(m,1);
Weight=zeros(m,1);
M1=max([0.1*delta,rho]);
if Case>0
    for i=1:m
        alpha=H(i,i);
        tau=Hw(i);
        Sigma(i)=alpha*beta+tau*tau;
        Weight(i)=max([1,(norm(Xn(:,i)-xstar)/M1)^6]);
    end
    [~,tstar]=max(Weight.*abs(Sigma));
    MOVE=tstar;
else
    for i=1:m-1
        alpha=H(T(i),T(i));
        tau=Hw(T(i));
        Sigma(T(i))=alpha*beta+tau*tau;
        Weight(T(i))=max([1,(norm(Xn(:,T(i))-xstar)/M1)^6]);
    end
    [M2,tstar]=max(Weight.*abs(Sigma));
    if M2<=1
        MOVE=0;
    else
        MOVE=tstar;
    end
end



%%
 NEWUOAStep5();%To Setp5







end