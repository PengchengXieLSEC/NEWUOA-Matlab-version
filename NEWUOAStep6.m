function [] = NEWUOAStep6()
%NEWUOAStep6 ��ӦNEWUOA�㷨�ĵ�����

global RATIO
if RATIO>=0.1
    NEWUOAStep2();%To NEWUOAStep2
else
    NEWUOAStep7();%To NEWUOAStep7
end

end