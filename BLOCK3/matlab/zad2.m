clear all;
close all;
%punkt pracy
Upp = 0;
Ypp = 0;
n = 300; %d³ugosc symulacji

inputs = zeros(1, 6);
inputs(1) = 0;
responses = zeros(1, 6);
responses(1) = 0;

U(1:n) = 0;
Y(1:n) = 0;

marks(1:5) = string();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tor wejœcie-wyjœcie skok sygnalu w chwili k=10
for i=1:5
    inputs(i + 1) = i;
    U(10:n) = i;
    for k = 10:n
        Y(k) = symulacja_obiektu10y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2)); %symulacja obiektu;
    end
    stairs(Y);
    marks(i) = sprintf('Skok U z %.2f do %.2f', 0, i);
    responses(i + 1) = Y(n);
    hold on;
end

xlabel('k');
ylabel('Y(k)');
legend(marks,'Location', 'southeast');
set(gcf,'Units','centimeters','Position', [ 1 1 15 10]);
matlab2tikz('../sprawozdanie/rysunki/skokowe_wejscie_wyjscie.tex');

%charakterystyka statyczna
figure;
plot(inputs, responses);
set(gcf,'Units','centimeters','Position', [ 1 1 15 15]);
matlab2tikz('../sprawozdanie/rysunki/wykres_char_stat_uy.tex');

K_stat1=(responses(6) - responses(1))/(inputs(6) - inputs(1))


