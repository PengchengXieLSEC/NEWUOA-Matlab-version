function [] = NEWUOAStep8()
%NEWUOAStep8 ��ӦNEWUOA�㷨�ĵڰ˲�

global DIST delta
if DIST>=2*delta
    NEWUOAStep9();%To NEWUOAStep9
else
    NEWUOAStep10();%To NEWUOAStep10
end

end