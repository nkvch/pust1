load('zad1pow.mat');
u1 = u1;
u2 = u2;
y1 = y1;
y2 = y2;


figure;
plot(u1);
title('Wejœcia procesu')
hold on;
plot(u2);
xlabel('k');
ylabel('u(k)');
legend('u1','u2');


figure;
plot(y1);
hold on;
plot(y2);
title('Wyjœcie procesu')
xlabel('k');
ylabel('y(k)');
legend('y1','y2');


%Punkt pracy W1=W2=50 (500) G1=25 (250) G2=30 (300)  T1= 29,81 T3=31,43