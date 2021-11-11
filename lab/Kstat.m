U=[25 35 45 55];
formatSpec = '%f';
fileID1 = fopen('z2.txt', 'r');
fileID2 = fopen('z2_2.txt', 'r');
fileID3 = fopen('z2_3.txt', 'r');
Yskok1 = fscanf(fileID1,formatSpec);
Yskok2 = fscanf(fileID2,formatSpec);
Yskok3 = fscanf(fileID3,formatSpec);
fclose(fileID1);
fclose(fileID2);
fclose(fileID3);
Y=[28.5 Yskok1(350) Yskok2(350) Yskok3(350)];

plot(U,Y);
xlabel('u');
ylabel('y');

kstat=(Yskok3(350)-34.5)/(55-25);