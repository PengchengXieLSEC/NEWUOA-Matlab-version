function [] = NEWUOAStep5()
%NEWUOAStep5 ��ӦNEWUOA�㷨�ĵ��岽
% ����ǰ��ļ�����²�ֵ�ڵ�
global m n d MOVE Krho D3 QF3 NORMD Xn Fn opt x0 Qnew Fnew c g Gamma gamma H w Hw beta
%%
%���㲽��14�Ĳα���
K=mod(Krho,3)+1;
D3(K)=NORMD;
QF3(K)=abs(Qnew-Fnew);
%%
t=MOVE;
if t>0
%%
%�ж��Ƿ�øı�x0
XX=Xn-x0;
% s=Xn(:,opt)-x0;
s=XX(:,opt);
NS2=s'*s;
xnew=Xn(:,opt)+d;
if (NORMD*NORMD<=(0.001*NS2 ))
    %��ʱ�滻x0Ϊxopt
    %�ɴˣ���Ҫ�޸ĵĻ��� H��c,g,Gamma,gamma,w,Hw ,beta
    xav=0.5*(x0+Xn(:,opt));
    %s=Xn(:,opt)-x0;
%     [HE1,W1,Hreal1] = HError();
%     [E1,en1] = InterpolationError();
    %%
    %�޸�H
%     T=1:m+n+1;
%     T(m+1)=[];
%     Thetaold=H(T,T);
%     Y=zeros(n,m);
%     for j=1:m
%         dxxav=Xn(:,j)-xav;
%         Y(:,j)=(s'*dxxav)*dxxav+0.25*NS2*s;
%     end
%     L=eye(n+m,n+m);
%     R=L;
%     L(m+1:n+m,1:m)=Y;
%     R(1:m,m+1:m+n)=Y';
%     Thetanew=L*Thetaold*R;
%     H(T,T)=Thetanew;
    %%
    Y=XX-0.5*s;
    Z=zeros(n,m);
    for i=1:m
       Z(:,i)=(s'*Y(:,i))* Y(:,i);
    end
    Z=Z+0.25*(NS2)*s;
    G1=eye(m+n+1);
    G2=eye(m+n+1);
    G1(m+1,m+2:m+n+1)=0.5*s;
    G2(m+2:m+n+1,1:m)=Z;
    H=G1*G2*G1*H*G1'*G2'*G1';
    %%
    %�޸���������
    x0=Xn(:,opt);
    v=zeros(n,1);
    for i=1:m
        v=v+gamma(i)*(Xn(:,i)-xav);
    end
    vs=v*s';
    Gamma=Gamma+vs+vs';
    XX=Xn-x0;
    eta=gamma.*(XX'*s);
    DDQs=Gamma*s;
for i=1:m
    DDQs=DDQs+eta(i)*XX(:,i);
end
    g=g+DDQs;
    c=Fn(opt);
%     [HE,W,Hreal] = HError();
%     HE
%     [E,en] = InterpolationError();
%     E
    %%
    %�¼���w,Hw�Լ�beta
    w=zeros(m+n+1,1);
    dxx0=xnew-x0;
    for i=1:m
    w(i)=0.5*(((Xn(:,i)-x0)'*(dxx0))^2);
    end
    w(m+1)=1;
    w(m+2:m+n+1)=dxx0;
    Hw=H*w;
    beta=0.5*((dxx0'*dxx0)^2)-w'*Hw;

else
    %%
    %���޸�x0������ֱ�ӵ���H,w,Hw,beta,
end
%%
%��ʼ����ģ��
alpha=H(t,t);
tau=Hw(t);
% sigma=max([0,alpha])*max([0,beta])+tau^2;
sigma=alpha*beta+tau^2;
et=zeros(n+m+1,1);
et(t)=1;
eHw=et-Hw;
H=H+(    alpha*(eHw*eHw')-beta*H(:,t)*H(t,:) +tau*(H(:,t)*eHw'+eHw*H(t,:) ) )/sigma;
C=Fnew-Qnew;
Lcg=C*H(:,t);
lambda=Lcg(1:m);
dc=Lcg(m+1);
dg=Lcg(m+2:m+n+1);
%%
c=c+dc;
g=g+dg;
Gamma=Gamma+gamma(t)*XX(:,t)*XX(:,t)';
for i=1:m
    if i~=t
        gamma(i)=gamma(i)+lambda(i);
    else
        gamma(i)=lambda(i);
    end
end

if Fnew<Fn(opt)
    opt=t;%�������ŵ�λ�ã������²�ֵ��
    Fn(t)=Fnew;
    Xn(:,t)=xnew;
else
    %ֻ���µ�
    Fn(t)=Fnew;
    Xn(:,t)=xnew;
end











else
    %ģ�Ͳ���
end


% [E,en] = InterpolationError();
% E
% [HE,W,Hreal] = HError();
% HE
%%
% global RATIO delta rho F_times
% F_times
% RATIO
% delta
% rho
% x0
% xopt=Xn(:,opt)
% Fopt=Fn(opt)

NEWUOAStep6();%To Setp6




end