%punkt pracy
Upp = 0;
Zpp = 0;
Ypp = 0;
n = 300; %d³ugosc symulacji

U(1:n) = 0;
Z(1:n) = 0;
Y(1:n) = 0;

U(10:n) = 1;
s(1:n)=0;
sz(1:n)=0;

%skok w chwili k=10
%tor wejœcie-wyjœcie
for k=10:n
    Y(k) = symulacja_obiektu10y_p2(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
end

subplot(2,1,1);
stairs(U);
hold on;
stairs(Z);
ylim([0 2]);
xlabel('k');
legend('U(k)','Z(k)');
title('Wartoœæ sterowania');
subplot(2,1,2);
stairs(Y);
xlabel('k');
ylabel('Y(k)');
title('OdpowiedŸ skokowa');
%matlab2tikz('../sprawozdanie/rysunki/podpunkt3_przeksztalcana.tex');


for k=11:n
    s(k-10)=(Y(k)-0)/1; %przesuniêcie wspo³czynników bo odpowiedŸ skokowa jest w chwili k=12
end
s(n-10:n)=s(n-10);

figure;
stairs(s);
xlabel('k');
ylabel('Y(k)');
matlab2tikz('../sprawozdanie/rysunki/podpunkt3_wejsciewyjscie.tex');


%tor zak³ócenie-wyjœcie
U(1:n) = 0;
Z(1:n) = 0;
Y(1:n) = 0;
Z(10:n) = 1;

for k=10:n
    Y(k) = symulacja_obiektu10y_p2(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2));
end

% 
% subplot(2,1,1);
% stairs(U);
% hold on;
% stairs(Z);
% ylim([0 2]);
% xlabel('k');
% legend('U(k)','Z(k)');
% title('Wartoœæ sterowania');
% subplot(2,1,2);
% stairs(Y);
% xlabel('k');
% ylabel('Y(k)');
% title('OdpowiedŸ skokowa');
% matlab2tikz('../sprawozdanie/rysunki/podpunkt3_przeksztalcana.tex');


for k=11:n
    sz(k-10)=(Y(k)-0)/1; %przesuniêcie wspo³czynników bo odpowiedŸ skokowa jest w chwili k=12
end
sz(n-10:n)=sz(n-10);

figure;
stairs(sz);
xlabel('k');
ylabel('Y(k)');
matlab2tikz('../sprawozdanie/rysunki/podpunkt3_zakloceniewyjscie.tex');


