figure;
plot(u1);
title('Wejścia procesu')
hold on;
plot(u2);
xlabel('k');
ylabel('u(k)');
legend('u1','u2');


figure;
plot(y1);
hold on;
plot(y2);
plot(yz1);
plot(yz2);
title('Wyjście procesu')
xlabel('k');
ylabel('y(k)');
legend('y1','y2');
