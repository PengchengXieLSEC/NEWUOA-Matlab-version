function [] = NEWUOAStep11()
%NEWUOAStep11 ��ӦNEWUOA�㷨�ĵ�ʮһ��

global rho rho_end
if rho==rho_end
    NEWUOAStep13();%To NEWUOAStep13
else
    NEWUOAStep12();%To NEWUOAStep12
end

end