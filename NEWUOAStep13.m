function [] = NEWUOAStep13()
%NEWUOAStep13 ��ӦNEWUOA�㷨�ĵ�ʮ����

global d D3 rho Xn opt Fnew
if D3(1)<0.5*rho
    xopt=Xn(:,opt);
    Fnew=F(xopt+d);
end
end