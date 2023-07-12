clear;

%Входные данные
point1 = [200 150 623];
point3 = [20 0 0];
r1 = 100;
r2 = 200;

%Работа с графикой
[f, r3, r4] = init_graphs(r1, r2, point1);
n = 1;
for t=0:0.1:(2*pi*2)
    k = 1 - t./(2.*pi.*2);
    r = sqrt(1-k.^2).*r4.*0.5;
    z = k.*r4;
    x = sin(t).*r;
    y = cos(t).*r;
    point3 = [point1(1)+x, point1(2)+y, point1(3)+z];
    [elem] = update_graphs(r1, r2, point1,point3);
    if n ~= 1
        cords = [point3; point4];
        subplot(5,4,1:16); % xyz
        plot3(cords(:, 1), cords(:, 2), cords(:, 3), 'k-', 'LineWidth', 1);
        subplot(5,4,17); % xy
        plot(cords(:, 1), cords(:, 2), 'k-', 'LineWidth', 1);
        subplot(5,4,18); % xz
        plot(cords(:, 1), cords(:, 3), 'k-', 'LineWidth', 1);
        subplot(5,4,19); % yz
        plot(cords(:, 2), cords(:, 3), 'k-', 'LineWidth', 1);
        subplot(5,4,20); % gz
        v1 = point3-point1;
        v2 = point4-point1;
        plot([sqrt(v1(1).^2+v1(2).^2), sqrt(v2(1).^2+v2(2).^2)], cords(:, 3), 'k-', 'LineWidth', 1);
    end
    frames(n) = getframe(f);
    n = n+1;
    point4 = point3;
    delete(elem);
end
create_gif(frames, 'tests/test3d3');

function [] = create_gif(frames, name)
for n = 1:size(frames,2)
    [A,map] = rgb2ind(frame2im(frames(n)),256);
    if n == 1
        imwrite(A,map,[name,'.gif'],'gif','LoopCount',Inf,'DelayTime',0.025);
    else
        imwrite(A,map,[name,'.gif'],'gif','WriteMode','append','DelayTime',0.025);
    end
end
end

function [f, r3, r4] = init_graphs(r1, r2, point1)
%Вычисления
r3 = abs(r1-r2);
r4 = r1+r2;
t = -pi:(pi/32):pi;
a = sin(t);
b = cos(t);
c(1:length(t)) = 0;

%Работа с окном
f = figure(1);
clf(f);
f.Position(3:4) = [1024 1024];

%3D plot (1:16)
subplot(5,4,1:16);
%Внутренний ограничитель
plot3(a.*r3+point1(1), b.*r3+point1(2), c.*r3+point1(3), 'r:'); hold on;
plot3(c.*r3+point1(1), b.*r3+point1(2), a.*r3+point1(3), 'r:');
plot3(a.*r3+point1(1), c.*r3+point1(2), b.*r3+point1(3), 'r:');
%Внешний ограничитель
plot3(a.*r4+point1(1), b.*r4+point1(2), c.*r4+point1(3), 'r:');
plot3(c.*r4+point1(1), b.*r4+point1(2), a.*r4+point1(3), 'r:');
plot3(a.*r4+point1(1), c.*r4+point1(2), b.*r4+point1(3), 'r:');
%Задаем границы графика
axis([-(r4+r2)+point1(1) (r4+r2)+point1(1) -(r4+r2)+point1(2) (r4+r2)+point1(2) -(r4+r2)+point1(3) (r4+r2)+point1(3)]);
xlabel('x'); ylabel('y'); zlabel('z'); grid on;

%2D plot (17)
subplot(5,4,17);
%Внутренний ограничитель
plot(a.*r3+point1(1), b.*r3+point1(2), 'r:'); hold on;
%Внешний ограничитель
plot(a.*r4+point1(1), b.*r4+point1(2), 'r:');
%Задаем границы графика
axis([-(r4+r2)+point1(1) (r4+r2)+point1(1) -(r4+r2)+point1(2) (r4+r2)+point1(2)]);
xlabel('x'); ylabel('y'); grid on;

%2D plot (18)
subplot(5,4,18);
%Внутренний ограничитель
plot(a.*r3+point1(1), b.*r3+point1(3), 'r:'); hold on;
%Внешний ограничитель
plot(a.*r4+point1(1), b.*r4+point1(3), 'r:');
%Задаем границы графика
axis([-(r4+r2)+point1(1) (r4+r2)+point1(1) -(r4+r2)+point1(3) (r4+r2)+point1(3)]);
xlabel('x'); ylabel('z'); grid on;

%2D plot (19)
subplot(5,4,19);
%Внутренний ограничитель
plot(a.*r3+point1(2), b.*r3+point1(3), 'r:'); hold on;
%Внешний ограничитель
plot(a.*r4+point1(2), b.*r4+point1(3), 'r:');
%Задаем границы графика
axis([-(r4+r2)+point1(2) (r4+r2)+point1(2) -(r4+r2)+point1(3) (r4+r2)+point1(3)]);
xlabel('y'); ylabel('z'); grid on;

%2D plot (20)
subplot(5,4,20);
%Внутренний ограничитель
plot(a.*r3, b.*r3+point1(3), 'r:'); hold on;
%Внешний ограничитель
plot(a.*r4, b.*r4+point1(3), 'r:');
%Задаем границы графика
axis([-(r4+r2) (r4+r2) -(r4+r2)+point1(3) (r4+r2)+point1(3)]);
xlabel('g'); ylabel('z'); grid on;
end

function [elem] = update_graphs(r1,r2,point1,point3)
    [point2,angle1,angle2,angle3] = manipulator2(point1, point3, r1, r2, 0, 0);
    cords = [point1; point2; point3];
    %3D plot (1:16)
    subplot(5,4,1:16); % xyz 
    elem(1) = plot3(cords(1:2,1), cords(1:2,2), cords(1:2,3), 'b-', 'LineWidth', 4);
    elem(2) = plot3(cords(2:3,1), cords(2:3,2), cords(2:3,3), 'c-', 'LineWidth', 4);
    %plot (17)
    subplot(5,4,17); % xy
    elem(3) = plot(cords(1:2,1), cords(1:2,2), 'b-', 'LineWidth', 4);
    elem(4) = plot(cords(2:3,1), cords(2:3,2), 'c-', 'LineWidth', 4);
    %plot (18)
    subplot(5,4,18); % xz
    elem(5) = plot(cords(1:2,1), cords(1:2,3), 'b-', 'LineWidth', 4);
    elem(6) = plot(cords(2:3,1), cords(2:3,3), 'c-', 'LineWidth', 4);
    %plot (19)
    subplot(5,4,19); % yz
    elem(7) = plot(cords(1:2,2), cords(1:2,3), 'b-', 'LineWidth', 4);
    elem(8) = plot(cords(2:3,2), cords(2:3,3), 'c-', 'LineWidth', 4);
    %plot (20)
    subplot(5,4,20); % gz  g=sqrt(x.^2+y.^2);
    v1 = point3-point1;
    v2 = point2-point1;
    v3 = v1+v2;
    v1 = sqrt(v1(1).^2+v1(2).^2);
    v2 = sqrt(v2(1).^2+v2(2).^2);
    v3 = sqrt(v3(1).^2+v3(2).^2);
    g = [0, v2, v1];
    if v1 > v3
        g(2) = -g(2);
    end
    elem(9) = plot(g(1:2), cords(1:2,3), 'b-', 'LineWidth', 4);
    elem(10) = plot(g(2:3), cords(2:3,3), 'c-', 'LineWidth', 4);
end