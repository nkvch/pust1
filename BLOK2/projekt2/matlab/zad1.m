%punkt pracy
Upp = 0;
Zpp = 0;
Ypp = 0;
n = 300; %d³ugosc symulacji

U(1:n) = 0;
Z(1:n) = 0;
Y(1:n) = 0;


for k = 9:n
    Y(k) = symulacja_obiektu10y_p2(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2)); %symulacja obiektu;
end

stairs(Y);
ylim([-0.1 1]);
xlabel('k');
ylabel('Y(k)');
%set(gcf,'Units','centimeters','Position', [ 1 1 15 10]);
%print('zad1.png','-dpng','-r400');
matlab2tikz('../sprawozdanie/rysunki/punkt_pracy.tex');