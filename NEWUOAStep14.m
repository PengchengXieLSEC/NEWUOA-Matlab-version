function [] = NEWUOAStep14()
%NEWUOAStep14 ��ӦNEWUOA�㷨�ĵ�ʮ�Ĳ�

global CRVMIN D3 QF3 rho Krho

if Krho>=3

TEMP=0.125*CRVMIN*rho*rho;
if max(QF3)<=TEMP&&max(D3)<=rho
    NEWUOAStep15();%To Setp15
else
    NEWUOAStep11();%To Setp11
end
else
    NEWUOAStep15();%To Setp15
end

end