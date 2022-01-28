clear all;
close all;
%skok wartoúci na wejúciu u1 skok w chwili 12 deltau = 250
load('skokoweU1.mat')
skok1_u1 = u1;
skok1_u2 = u2;
y1_u1 = y1;
y2_u1 = y2;
yz1_u1 = YZ1;
yz2_u1 = YZ2;

% figure; plot(skok1_u1); hold on; plot(skok1_u2);
% 
% figure; plot(y1_u1); title('Wyjúcie 1: skok wejúcie 1')
% 
% figure; plot(y2_u1) title('Wyjúcie 2: skok wejúcie 1')

for k=14:length(y1_u1)
    s11(k-13)=(y1_u1(k)-y1_u1(1))/250;
    s21(k-13)=(y2_u1(k)-y2_u1(1))/250;
end


%skok wartoúci na wejúciu u2 w chwili k=11 dektau=200
load('skokoweU2.mat')
skok2_u1 = u1;
skok2_u2 = u2;
y1_u2 = y1;
y2_u2 = y2;
yz1_u2 = YZ1;
yz2_u2 = YZ2;

figure; plot(skok2_u1); hold on; plot(skok2_u2);

figure; plot(y1_u2); title('Wyjúcie 1: skok wejúcie 2')

figure; plot(y2_u2); title('Wyjúcie 2: skok wejúcie 2')


for k=12:length(y1_u1)
    s12(k-11)=(y1_u2(k)-y1_u2(1))/200;
    s22(k-11)=(y2_u2(k)-y2_u2(1))/200;
end

s12 = s12(1:length(s11));
s22 = s22(1:length(s11));

figure;
subplot(2,2,1);
plot(s11);
xlim([0 450]);
title('S11 wyj≈õcie 1 wej≈õcie 1');
subplot(2,2,4);
plot(s22);
xlim([0 450]);
title('S22 wyj≈õcie 2 wej≈õcie 2');
subplot(2,2,2);
plot(s12);
xlim([0 450])
title('S12 wyj≈õcie 1 wej≈õcie 2');
subplot(2,2,3);
plot(s21);
xlim([0 450]);
title('S21 wyj≈õcie 2 wej≈õcie 1');
matlab2tikz('sprawozdanie/rysunki/odpowiedzi_skokowe.tex');


save('wspolczynnikis.mat','s11','s12','s21','s22')