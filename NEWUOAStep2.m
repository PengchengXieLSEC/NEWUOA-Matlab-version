function [] = NEWUOAStep2()
%NEWUOAStep2 ��ӦNEWUOA�㷨�ĵڶ���
%   ��ֵ����ʽΪQ(x)=c+g'*(x-x0)+0.5*(x-x0)'*G*(x-x0)
%   G=Gamma+sum(lambda(j)(Xn(:,j)-x0)*(Xn(:,j)-x0)');
%   Ŀ�꺯��ΪQ(xopt+d)
%   Լ������Ϊ ||d||<=delta
%   ����Ϊ�ضϹ����ݶȷ�
%   XX=Xn-x0;
global n m g Gamma gamma x0 Xn Fn opt delta CRVMIN d NORMD Qnew
XX=Xn-x0;
CRVMIN=0;%Ĭ������Ϊ0
xopt=Xn(:,opt);
Fopt=Fn(opt);
d=zeros(n,1);
NORMD=0;
S=zeros(n,n);%ÿһ������������
sDDQs=zeros(n,1);%�����Ա�ʹ��
Q0=Fopt;
Qold=Fopt;
u=xopt-x0;
%DQ��x��=g+G(x-x0)=g+DDQ*��x-x0��;
DQ=g+DDQ(u);%DQ��opt��=g+G(opt-x0)=g+DDQ*��opt-x0��;
DQ0=DQ;%DQ(xopt);
k=1;%����Ĳ���
S(:,k)=-DQ;
Ns=norm(S(:,k ));
NDQ0=Ns;%��ʼ�ݶȵķ���
if ( Ns<=10^-8)%xopt�Ѿ���ģ�͵�פ����
 d=zeros(n,1);
 NORMD=0;
 Qnew=Q0;
else % ��ʱ���ܽ��������ĵ���
    a=Ns*Ns;
    b=2*d'*S(:,k);
    c=(NORMD)^2-delta^2;
    alpha=(-b+sqrt(b*b-4*a*c))/(2*a);
    DDQs=DDQ(S(:,k));
    sDDQs(k)=S(:,k)'*DDQs;
    N2DQxd=(NDQ0)^2;%%||DQ(xopt+d_(j-1))||^2
    if (N2DQxd<(alpha*sDDQs(k)))
       alpha= N2DQxd/sDDQs(k);
    end
    %�Ѿ�ȷ����alpha��s
    d=d+alpha*S(:,k);%�µ�d
    NORMD=norm(d);
    Qnew=Qold+alpha*S(:,k)'*DQ+sDDQs(k)*alpha*alpha/2;
    k=k+1;%��һ����ʼ
    NDQold=NDQ0;
    DQ=DQ+alpha*DDQs;%���µ���ǰ����ݶȡ���ǰ����ݶ�����֮ǰ����Ϣ��á�
    NDQnew=norm(DQ);
    %��ʼ����
    while ((k<=n) && (NDQnew>0.01*NDQ0) && ((Qold-Qnew)>0.01*((Q0-Qnew)))  ) %����ѭ������������
        Qold=Qnew;
        beta=(NDQnew/NDQold)^2;
        S(:,k)=-DQ+beta*S(:,k-1);
        Ns=norm(S(:,k));
        if ( Ns<=10^-8 )%��ʱ��sʵ����̫С�ˣ��޷�����������������
        Qnew=Qold;
        k=k+1;
        break;
        else
            a=Ns*Ns;
            b=2*d'*S(:,k);
            c=(NORMD)^2-delta^2;
            alpha=(-b+sqrt(b*b-4*a*c))/(2*a);
            DDQs=DDQ(S(:,k));
            sDDQs(k)=S(:,k)'*DDQs;
            N2DQxd=(NDQnew)^2;%%||DQ(xopt+d_(j-1))||^2
            if (N2DQxd<(alpha*sDDQs(k)))
            alpha= N2DQxd/sDDQs(k);
            end
            %�Ѿ�ȷ����alpha��s
            d=d+alpha*S(:,k);%�µ�d
            NORMD=norm(d);
            Qnew=Qold+alpha*S(:,k)'*DQ+sDDQs(k)*alpha*alpha/2;
            k=k+1;%��һ����ʼ
            NDQold=NDQnew;
            DQ=DQ+alpha*DDQs;%���µ���ǰ����ݶȡ���ǰ����ݶ�����֮ǰ����Ϣ��á�
            NDQnew=norm(DQ); 
        end
    end
    
end

if abs(NORMD-delta)>=0.01*delta
    if k==1
        CRVMIN=0;
    else
    CRV=zeros(k-1,1);
    for i=1:k-1
    CRV(i)=sDDQs(i)/(S(:,i)'*S(:,i));
    end
    CRVMIN=min(CRV);
    end
else
    CRVMIN=0;
    DQd=d'*DQ;
    if (NDQnew>0.01*NDQ0)&&(DQd>-0.99*NDQnew*NORMD)&&(k<=n)%����������������ǣ���Ҫ����ĵ���
%         s=C1*d+C2*DQ;
          theta=zeros(60,1);
          for i=1:60
              theta(i)=2*(i-1)*pi/60;
          end
          Qold=Qnew;
          DQddd=DQd/NORMD/NORMD;
          C2=delta/(sqrt(NDQnew*NDQnew-DQddd*DQd));
          C1=-C2*DQddd;
          s=C1*d+C2*DQ;%����s'*d=0,��||s||=delta
          DDQs=DDQ(s);
          DQDQ0=DQ-DQ0;
          sDDQs(k)=s'*DDQs;
          Qtheta=zeros(60,1);
          for i=1:60
              costheta=cos(theta(i));
              sintheta=sin(theta(i));
              Qtheta(i)=Q0+(costheta*d+sintheta*s)'*DQ0+(0.5*costheta*costheta*d+costheta*sintheta*s)'*DQDQ0+0.5*sintheta*sintheta*sDDQs(k);
          end
          [Qnew,kd]=min(Qtheta);
          d=cos(theta(kd))*d+sin(theta(kd))*s;%�µ�d
          NORMD=norm(d);
          k=k+1;%��һ����ʼ
          NDQold=NDQnew;
          DQ=(1-cos(theta(kd)))*DQ0+cos(theta(kd))*DQ+sin(theta(kd))*DDQs;%���µ���ǰ����ݶȡ���ǰ����ݶ�����֮ǰ����Ϣ��á�
          NDQnew=norm(DQ); 
           while ((k<=n) && ((Qold-Qnew)>0.01*((Q0-Qnew)))  ) 
               Qold=Qnew;
               DQd=d'*DQ;
               DQddd=DQd/NORMD/NORMD;
               C2=delta/(sqrt(NDQnew*NDQnew-DQddd*DQd));
               C1=-C2*DQddd;
               s=C1*d+C2*DQ;%����s'*d=0,��||s||=delta
               DDQs=DDQ(s);
               DQDQ0=DQ-DQ0;
               sDDQs(k)=s'*DDQs;
               Qtheta=zeros(60,1);
               for i=1:60
              costheta=cos(theta(i));
              sintheta=sin(theta(i));
              Qtheta(i)=Q0+(costheta*d+sintheta*s)'*DQ0+(0.5*costheta*costheta*d+costheta*sintheta*s)'*DQDQ0+0.5*sintheta*sintheta*sDDQs(k);
               end
               [Qnew,kd]=min(Qtheta);
               d=cos(theta(kd))*d+sin(theta(kd))*s;%�µ�d
               NORMD=norm(d);
               k=k+1;%��һ����ʼ
               NDQold=NDQnew;
               DQ=(1-cos(theta(kd)))*DQ0+cos(theta(kd))*DQ+sin(theta(kd))*DDQs;%���µ���ǰ����ݶȡ���ǰ����ݶ�����֮ǰ����Ϣ��á�
               NDQnew=norm(DQ); 
           end
    end
end
%%
function [R]=DDQ(u)
%�������G������u�Ŀ����㷨������u��n*1��
eta=gamma.*(XX'*u);
R=Gamma*u;
for ii=1:m
    R=R+eta(ii)*XX(:,ii);
end
end
%%
NEWUOAStep3();
end

