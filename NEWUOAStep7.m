function [] = NEWUOAStep7()
%NEWUOAStep7 ��ӦNEWUOA�㷨�ĵ��߲�

global DIST MOVE opt Xn m
DIST=0;
for i=1:m
    if norm(Xn(:,i)-Xn(:,opt),2)>DIST
        DIST=norm(Xn(:,i)-Xn(:,opt),2);
        MOVE=i;
    end
end
NEWUOAStep8();%To Setp8

end