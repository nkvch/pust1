load('zad1pow.mat');
u1 = u1(32:end);
u2 = u2(32:end);
y1 = y1(32:end);
y2 = y2(32:end);


figure;
plot(u1./10);
title('Wejścia procesu')
hold on;
plot(u2./10);
xlabel('k');
ylabel('u(k)');
legend('G1','G2');
xlim ([0 470])
ylim ([0 50])

figure;
plot(y1./100);
hold on;
plot(y2./100);
title('Wyjście procesu')
xlabel('k');
ylabel('y(k)');
legend('T1','T3');
xlim ([0 470])
matlab2tikz('sprawozdanie/rysunki/wykres_punkt_pracy.tex');

%Punkt pracy W1=W2=50 (500) G1=25 (250) G2=30 (300)  T1= 29,81 T3=31,43