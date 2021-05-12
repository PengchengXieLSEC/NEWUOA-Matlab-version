function [Fopt,xopt] = NEWUOAMethod(Fobj,M,N,xbeg,rhobeg,rhoend,Max)
%NEWUOAMETHOD NEWUOA�㷨�ĺ���
%   F��ʾĿ�꺯��,m�ǲ�ֵ�����,n������ά��,rho_beg�ǳ�ʼ��rho,rho_end����ֹ��rho,Max�ǵ�����������
global Xn Fn n m F_times rho_beg rho_end x0 opt xb c g Gamma gamma H F rho delta Krho D3 QF3 CRVMIN d NORMD Qnew 
global RATIO MOVE w Hw beta Fnew DIST XXopt NXX 
F=Fobj;
m=M;
n=N;
xb=xbeg;
rho_beg=rhobeg;
rho_end=rhoend;

NEWUOAStep1();
Fopt=Fn(opt);
xopt=Xn(:,opt);
end

