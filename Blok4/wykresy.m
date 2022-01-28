figure;
plot(u1./10);
title('Wejścia procesu')
hold on;
plot(u2./10);
xlabel('k');
ylabel('u(k)');
legend('G1','G2');
xlim([0 300])
matlab2tikz('sprawozdanie/rysunki/pid_u_2.tex');

figure;
plot(y1./100);
hold on;
plot(y2./100);
plot(yz1./100);
plot(yz2./100);
title('Wyjście procesu')
xlabel('k');
ylabel('y(k)');
legend('T1','T3','T1^{zad}','T3^{zad}');
xlim([0 300])
matlab2tikz('sprawozdanie/rysunki/pid_y_2.tex');