function [point2,angle1,angle2,angle3] = manipulator2(point1, point3, r1, r2, refAngle1, refAngle2)
vector1 = point3-point1;
r4 = sqrt(sum(vector1(1:2).^2));
r3 = sqrt(vector1(3).^2 + r4.^2);
angle1 = acos(vector1(1)./r4);
if vector1(2) < 0
    angle1 = -angle1;
end
angle2 = acos(vector1(3)./r3)-acos((r1.^2+r3.^2-r2.^2)./(2.*r1.*r3));
angle3 = acos((r1.^2+r2.^2-r3.^2)./(2.*r1.*r2));
vector2 = [r1.*sin(angle2).*cos(angle1) r1.*sin(angle2).*sin(angle1) r1.*cos(angle2)]; 
point2 = vector2 + point1;
end