steps = [0.1 0.15 0.2 0.25 0.3];
inputs = zeros(1, 6);
inputs(1) = 3;
responses = zeros(1, 6);
responses(1) = 0.9;
U0 = 3;
U = zeros(1, 300);
Y = zeros(1, 300);
U(1:11) = U0;
Y(1:11) = 0.9;
N = 300;

marks(1:5) = string();

figure;
for i=1:5
    inputs(i + 1) = U0 + steps(i);
    U(12:N) = U0 + steps(i);
    for k=12:N
        Y(k) = symulacja_obiektu10Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
    end
    stairs(Y);
    marks(i) = sprintf('Skok U z %f do %f', U0, U0 + steps(i));
    responses(i + 1) = Y(N);
    hold on;
end

ylim([0.8 1.5]);
title('Odpowiedzi skokowe');
legend(marks,'Location', 'Best');
set(gcf,'Units','centimeters','Position', [ 1 1 15 10]);
print('zad2.png','-dpng','-r400');
matlab2tikz('wykres_odp_skokowe.tex');

figure;
plot(inputs, responses);
title('Charakterystyka statyczna y(u)');
set(gcf,'Units','centimeters','Position', [ 1 1 15 15]);
print('zad2_char_stat.png','-dpng','-r400');
matlab2tikz('wykres_char_stat.tex');

K_stat=(responses(6) - responses(1))/(inputs(6) - inputs(1))