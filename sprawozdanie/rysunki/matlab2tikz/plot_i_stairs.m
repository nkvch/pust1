x = 0:.01:0.05;
y = sin(2*x.^2);

set(0,'defaulttextinterpreter','latex');
set(0,'DefaultLineLineWidth',1);
set(0,'DefaultStairLineWidth',1);

plot(x,y);
xlim([min(x) max(x)]);
xlabel('$x$')
ylabel('$y$')
matlab2tikz('plot.tex','width', '\fwidth' ,'height', '\fheight' ,'showInfo', false);

stairs(x,y);
xlim([min(x) max(x)]);
xlabel('$x$')
ylabel('$y$')
matlab2tikz('stairs.tex','width', '\fwidth' ,'height', '\fheight' ,'showInfo', false);

% opcja ,,width'' s�u�y do nadpisania szeroko�ci wykresu -- b�dzie ona
% r�wna tyle co wielko�� \fwidth zdefiniowana w LaTeX-u
% opcja ,,height'' s�u�y do nadpisania wysoko�ci wykresu -- b�dzie ona 
% r�wna tyle co wielko�� \fheight zdefiniowana w LaTeX-u

close all;