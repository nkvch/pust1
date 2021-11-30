% T1=61.544552; T2=11.315353; K=0.230927;
T1=1.368049; T2=83.975477; K=0.386997;
Td=10;
e(1:350)=0;
Y(1:350)=0;
y(1:350)=0;
u(1:350)=1;
fileID1 = fopen('zadanie2_skokzwykly.txt', 'r');
% fileID1 = fopen('zadanie2_1skokpop.txt', 'r');
formatSpec = '%f';
Yskok = fscanf(fileID1,formatSpec);
fclose(fileID1);
Ypp=ones(350,1)*28.18;
OdpSkok = (Yskok-Ypp)/10;

alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1*alpha2;
b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

for k = Td+3:350
y(k) = b1*u(k - Td -1)+b2*u(k-Td-2)-a1*y(k-1)- a2*y(k-2);
end

e = OdpSkok' - y;
E=(norm(e))^2;
stairs(OdpSkok);
hold on;
stairs(y);
legend({'odpowiedź układu','odpowiedź aproksymowana'},'location', 'northwest');
xlabel('k');
ylabel('s');
% matlab2tikz('../sprawozdanie/rysunki/zad3.tex');