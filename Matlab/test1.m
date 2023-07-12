clear;

refDegAngle1 = 27;
refDegAngle2 = 69;
refAngle1 = refDegAngle1.*pi./180;
refAngle2 = refDegAngle2.*pi./180;
r1 = 256;
r2 = 256;
point1 = [0 0];
point3 = [0 0];


r3 = abs(r1-r2);
r4 = r1+r2;
f = figure(1);
f.Position(1:4) = [0 0 512 512];
clf(f);
axis([-(r4+r2)+point1(1) (r4+r2)+point1(1) -(r4+r2)+point1(2) (r4+r2)+point1(2)]);
grid on;
viscircles(point1, r3, 'Color', 'r', 'LineStyle', '-', 'LineWidth', 1);
viscircles(point1, r4, 'Color', 'r', 'LineStyle', '-', 'LineWidth', 1);
viscircles(point1, r1, 'Color', 'c', 'LineStyle', ':', 'LineWidth', 1);

point3 = [r3+point1(2) point1(1)];
n = 1;
for k=0:256
    point4 = point3;
    r = r4-(mod(k, 16)./16).*128;
    j = 2.*pi.*(k./256);
    point3 = [r.*cos(j)+point1(1) r.*sin(j)+point1(2)];
    [point2, angle1, angle2] = manipulator(point1, point3, r1, r2, refAngle1, refAngle2);
    elem(1) = viscircles(point3, r2, 'Color', 'c', 'LineStyle', ':', 'LineWidth', 1);
    elem(2) = line([point1(1) point2(1) point3(1)], [point1(2) point2(2) point3(2)], 'Color', 'b', 'LineWidth', 3);
    line([point3(1) point4(1)], [point3(2) point4(2)], 'Color', 'g', 'LineWidth', 2);
    frames(n) = getframe;
    %pause(0.1);
    delete(elem);
    n = n + 1;
end
%return;
for n = 1:size(frames,2)
    [A,map] = rgb2ind(frame2im(frames(n)),256);
    if n == 1
        imwrite(A,map,'test.gif','gif','LoopCount',Inf,'DelayTime',0.025);
    else
        imwrite(A,map,'test.gif','gif','WriteMode','append','DelayTime',0.025);
    end
end
