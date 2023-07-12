clear;

r1 = 128;
r2 = 384;
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
%m1 = r.*sin(a)+point1(2);
%m2 = r.*cos(a)+point1(1);
%m3 = r3:(r4-r3)/64:r4;
%plot(m1, m2, m3);

a = 0;
n = 1;
for r=r3:(r4-r3)/256:r4
    point3 = [r.*cos(a)+point1(1) r.*sin(a)+point1(2)];
    [point2, angle1, angle2] = manipulator(point1, point3, r1, r2);
    elem(1) = viscircles(point3, r2, 'Color', 'c', 'LineStyle', ':', 'LineWidth', 1);
    elem(2) = line([point1(1) point2(1) point3(1)], [point1(2) point2(2) point3(2)], 'Color', 'b', 'LineWidth', 3);
    frames(n) = getframe;
    %pause(0.1);
    delete(elem);
    a = a + (4.*pi)./256;
    n = n + 1;
end
for n = 1:size(frames,2)
    [A,map] = rgb2ind(frame2im(frames(n)),256);
    if n == 1
        imwrite(A,map,'test.gif','gif','LoopCount',Inf,'DelayTime',0.025);
    else
        imwrite(A,map,'test.gif','gif','WriteMode','append','DelayTime',0.025);
    end
end





