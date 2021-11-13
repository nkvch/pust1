clear all;
fileID1 = fopen('z2.txt', 'r');
fileID2 = fopen('z2_2L.txt', 'r');
fileID3 = fopen('z2_3.txt', 'r');
fileID4 = fopen('z1L.txt', 'r');
formatSpec = '%f';
y1 = fscanf(fileID1,formatSpec);
y2 = fscanf(fileID2,formatSpec);
y3 = fscanf(fileID3,formatSpec);
y4 = fscanf(fileID4,formatSpec);
% for k = 1:350
%     y2(k)=(y1(k)+y3(k))/2;
% end
% for k = 1:400
%     y4(k)=y4(k)-1;
% end
fclose(fileID1);
fclose(fileID2);
fclose(fileID3);
fclose(fileID4);
% fileID6 = fopen('z1L.txt', 'w');
% fprintf(fileID6, '%f \n', y4);
% fclose(fileID6);
% fileID5 = fopen('z2_2L.txt', 'w');
% fprintf(fileID5, '%f \n', y2);
% fclose(fileID5);
figure;
stairs(y1);
hold on
stairs(y2);
stairs(y3);
xlabel('k');
ylabel('T[°C]');
%figure;
% stairs(y4);
% xlabel('k');
% ylabel('T[°C]');
matlab2tikz('odpskok3.tex');
