%punkt pracy
y1_pp = 0;
y2_pp = 0;
y3_pp = 0;
u1_pp = 0;
u2_pp = 0;
u3_pp = 0;
u4_pp = 0;

n = 300;

y1(1:n) = 0;
y2(1:n) = 0;
y3(1:n) = 0;
u1(1:n) = 0;
u2(1:n) = 0;
u3(1:n) = 0;
u4(1:n) = 0;


for k = 7:n
    [y1(k), y2(k), y3(k)] = symulacja_obiektu10_p4(...
        u1(k-1),u1(k-2),u1(k-3),u1(k-4),...
        u2(k-1),u2(k-2),u2(k-3),u2(k-4),...
        u3(k-1),u3(k-2),u3(k-3),u3(k-4),...
        u4(k-1),u4(k-2),u4(k-3),u4(k-4),...
        y1(k-1),y1(k-2),y1(k-3),y1(k-4),...
        y2(k-1),y2(k-2),y2(k-3),y2(k-4),...
        y3(k-1),y3(k-2),y3(k-3),y3(k-4)...
    );
end

figure('NumberTitle', 'off', 'Name', 'Odpowiedzi skokowe');
title('Odpowiedźi skokowe');
subplot(3, 1, 1);
stairs(y1, 'g');
ylabel('y1');
subplot(3, 1, 2);
stairs(y2, 'r');
ylabel('y2');
subplot(3, 1, 3);
stairs(y3);
ylabel('y3');

% ylim([-0.1 0.2]);
xlabel('k');

set(gcf,'Units','centimeters','Position', [ 1 1 15 15]);
%print('zad1.png','-dpng','-r400');
matlab2tikz('../images/sprawdzenie_punktu_pracy.tex');