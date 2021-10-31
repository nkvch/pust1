Upp = 3;
Ypp = 0.9;
N = 300;
U(1:N) = 3;
Y(1:11) = 0;

for k = 12:N
    Y(k) = symulacja_obiektu10Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
end

stairs(Y);
ylim([0 1]);
xlabel('k');
ylabel('Y(k)');
set(gcf,'Units','centimeters','Position', [ 1 1 15 10]);
print('zad1.png','-dpng','-r400');
matlab2tikz('../sprawozdanie/rysunki/wykres_punkt_pracy.tex');