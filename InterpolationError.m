function [E,en] = InterpolationError()
%INTERPOLATIONERROR ��ֵ�����
%   �����ú���
global m Xn F
en=zeros(m,1);
for i=1:m
    en(i)=F(Xn(:,i))-Q(Xn(:,i));
end
E=norm(en);
end

