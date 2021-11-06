N = 300;
U0 = 3;
U = zeros(1, N);
Y = zeros(1, N);
U(1:11) = U0;
Y(1:11) = 0.9;
U(12:N) = U0 + 0.3;
s(1:N)=0;
%dla k=175 wartoœæ odpowiedzi skokowej siê stabilizuje
%skok w chwili k=12


for k=12:N
    Y(k) = symulacja_obiektu10Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
end
subplot(2,1,1);
stairs(U);
ylim([2.9 3.4]);
xlabel('k');
ylabel('U(k)');
title('Wartoœæ sterowania');
subplot(2,1,2);
stairs(Y);
xlabel('k');
ylabel('Y(k)');
title('OdpowiedŸ skokowa');
%matlab2tikz('../sprawozdanie/rysunki/podpunkt3_przeksztalcana.tex');

%D=175- gdy¿ wartoœæ odpowiedzi skokowej dla k=175 siê stabilizuje
for k=13:N
    s(k-12)=(Y(k)-0.9)/0.3; %przesuniêcie wspo³czynników bo odpowiedŸ skokowa jest w chwili k=12
end
figure;
stairs(s(1:250));
xlabel('k');
ylabel('Y(k)');
title('OdpowiedŸ skokowa');
%matlab2tikz('../sprawozdanie/rysunki/podpunkt3_odpowiedzSkokowa.tex');



