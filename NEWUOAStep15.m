function [] = NEWUOAStep15()
%NEWUOAStep15 ��ӦNEWUOA�㷨�ĵ�ʮ�岽

global RATIO delta rho
delta=0.1*delta;
RATIO=-1;
if delta<=1.5*rho
    delta=rho;
end
NEWUOAStep7();%To Setp7
end