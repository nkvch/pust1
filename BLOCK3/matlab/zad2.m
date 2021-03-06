clear all;
close all;
%punkt pracy
Upp = 0;
Ypp = 0;
n = 300; %d?ugosc symulacji

inputs = zeros(1, 21);
inputs(1) = 0;
responses = zeros(1, 21);
responses(1) = 0;

U(1:n) = 0;
Y(1:n) = 0;

marks(1:21) = string();
figure;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tor wej?cie-wyj?cie skok sygnalu w chwili k=10
nrskoku = 1;
for i=-1:0.1:1
    inputs(nrskoku) = i
    U(10:n) = i;
    for k = 10:n
        Y(k) = symulacja_obiektu10y_p3(U(k-5),U(k-6),Y(k-1),Y(k-2)); %symulacja obiektu;
    end
    stairs(Y);
    marks(nrskoku) = sprintf('Skok U z %.2f do %.2f', 0, i);
    responses(nrskoku) = Y(n);
    hold on;
    nrskoku = nrskoku + 1;
end

xlabel('k');
ylabel('Y(k)');
legend(marks,'Location', 'southeast');
set(gcf,'Units','centimeters','Position', [ 1 1 15 10]);
% matlab2tikz('../sprawozdanie/rysunki/skokowe_zad2_DRAFT.tex');


%charakterystyka statyczna
figure;
plot(inputs, responses);
set(gcf,'Units','centimeters','Position', [ 1 1 15 10]);
xlabel('u');
ylabel('y');
matlab2tikz('../sprawozdanie/rysunki/wykres_char_stat_AAAA.tex');

% K_stat1=(responses(6) - responses(1))/(inputs(6) - inputs(1))

% xlabel('k');
% ylabel('Y(k)');
% ylim([0 10]);
% legend(marks,'Location', 'southeast');
% set(gcf,'Units','centimeters','Position', [ 1 1 15 10]);
% matlab2tikz('../sprawozdanie/rysunki/skokowe_zaklocenie_wyjscie.tex');
% 
% %charakterystyka statyczna
% figure;
% plot(inputs, responses);
% set(gcf,'Units','centimeters','Position', [ 1 1 15 15]);

