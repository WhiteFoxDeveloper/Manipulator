function [point2,angle1,angle2] = manipulator1(point1, point3, r1, r2, refAngle1, refAngle2)
vector1 = [point3(1)-point1(1) point3(2)-point1(2)];
r3 = sqrt(vector1(1).^2+vector1(2).^2);
r4 = abs(r1-r2);
r5 = r1+r2;
if r3 > r5 || r3 < r4
    disp('Ошибка');
    return;
end
angle3 = acos((r1.^2+r3.^2-r2.^2)./(2.*r1.*r3));
angle4 = acos(vector1(1)./r3);
if point3(2)<point1(2)
    angle4 = -angle4;
end
angle1 = angle3 + angle4;
vector2 = [r1.*cos(angle1) r1.*sin(angle1)];
point2 = [vector2(1)+point1(1) vector2(2)+point1(2)];
vector3 = [point3(1)-point2(1) point3(2)-point2(2)];
angle2 = acos((vector3(1).*vector2(1)+vector3(2).*vector2(2))./(r1.*r2));
if (vector1(1) * vector2(2) - vector1(2) * vector2(1)) > 0
    angle2 = -angle2;
end
angle1 = angle1 - refAngle1;
angle2 = angle2 - refAngle2;
end