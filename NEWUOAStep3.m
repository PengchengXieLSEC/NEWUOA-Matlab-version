function [] = NEWUOAStep3()
%NEWUOAStep3 ��ӦNEWUOA�㷨�ĵ�����

global NORMD rho
if NORMD>0.5*rho
    NEWUOAStep4();%To NEWUOAStep4
else
    NEWUOAStep14();%To NEWUOAStep14
end

end

