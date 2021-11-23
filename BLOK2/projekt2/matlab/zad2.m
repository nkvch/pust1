clear all;
close all;
%punkt pracy
Upp = 0;
Zpp = 0;
Ypp = 0;
n = 300; %d³ugosc symulacji

inputs = zeros(1, 6);
inputs(1) = 0;
responses = zeros(1, 6);
responses(1) = 0;

U(1:n) = 0;
Z(1:n) = 0;
Y(1:n) = 0;

marks(1:5) = string();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tor wejœcie-wyjœcie skok sygnalu w chwili k=10
for i=1:5
    inputs(i + 1) = i;
    U(10:n) = i;
    for k = 10:n
        Y(k) = symulacja_obiektu10y_p2(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2)); %symulacja obiektu;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tor zak³ócenie-wyjœcie skok sygnalu w chwili k=10
figure;
for i=1:5
    inputs(i + 1) = i;
    U(10:n) = 0;
    Z(10:n) = i;
    for k = 10:n
        Y(k) = symulacja_obiektu10y_p2(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2)); %symulacja obiektu;
    end
    stairs(Y);
    marks(i) = sprintf('Skok Z z %.2f do %.2f', 0, i);
    responses(i + 1) = Y(n);
    hold on;
end

xlabel('k');
ylabel('Y(k)');
ylim([0 10]);
legend(marks,'Location', 'southeast');
set(gcf,'Units','centimeters','Position', [ 1 1 15 10]);
matlab2tikz('../sprawozdanie/rysunki/skokowe_zaklocenie_wyjscie.tex');

%charakterystyka statyczna
figure;
plot(inputs, responses);
set(gcf,'Units','centimeters','Position', [ 1 1 15 15]);
matlab2tikz('../sprawozdanie/rysunki/wykres_char_stat_zy.tex');

K_stat2=(responses(6) - responses(1))/(inputs(6) - inputs(1))

%charakterystyka statyczna y(u,z)
Y_uz(51:51) = 0;


for i=1:51
    U(10:n) = (i-1)*0.01;
    Z(10:n) = i;
    for j=1:51
    Z(10:n) = (i-1)*0.01;
        for k = 10:n
            Y(k) = symulacja_obiektu10y_p2(U(k-7),U(k-8),Z(k-3),Z(k-4),Y(k-1),Y(k-2)); %symulacja obiektu;
        end
        Y_uz(i,j) = Y(n);
    end
end
[wu,wz] = meshgrid(0:0.02:1);
figure;
surf(wu,wz,Y_uz);
xlabel('U');
ylabel('Z');
zlabel('Y');
matlab2tikz('../sprawozdanie/rysunki/statyczna_y_uz.tex');