U=[0 10 20 30];
formatSpec = '%f';
fileID1 = fopen('zadanie2_1skokpop.txt', 'r');
fileID2 = fopen('zadanie2_2skokpop.txt', 'r');
fileID3 = fopen('zadanie2_3skokpop.txt', 'r');
Yskok1 = fscanf(fileID1,formatSpec);
Yskok2 = fscanf(fileID2,formatSpec);
Yskok3 = fscanf(fileID3,formatSpec);
fclose(fileID1);
fclose(fileID2);
fclose(fileID3);
Y=[28.2 Yskok1(350) Yskok2(350) Yskok3(350)];

figure;
plot(U,Y);
xlabel('u');
ylabel('y');
% title("Charakterystyka statyczna procesu");

kstat=(Yskok3(350)-28.2)/(30)

matlab2tikz('../sprawozdanie/rysunki/zad2Kstat_lab.tex');