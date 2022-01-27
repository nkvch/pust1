N_iter = 300;
yzad = zeros(3, N_iter);
u = zeros(4, N_iter);
y = zeros(3, N_iter);
e = zeros(3, N_iter);

% pierwsze wyjscie
yzad(1, 50:N_iter) = 1.5;
yzad(1, 150:N_iter) = 1.2;
yzad(1, 200:N_iter) = 0.5;

% drugie wyjscie
yzad(2, 70:N_iter) = 0.4;
yzad(2, 200:N_iter) = 1.5;
yzad(2, 250:N_iter) = 0.2;

% trzecie wyjscie
yzad(3, 20:N_iter) = 1.4;
yzad(3, 100:N_iter) = 0.7;
yzad(3, 170:N_iter) = 1;
 
% optymal
% powiazania_u_y = containers.Map({ 'u1', 'u2', 'u3', 'u4' }, [2, 3, NaN, 1]);
% K = [
%     0.1191   -2.2861   -0.6893
% ];
% Ti = [
%     2.7240   -0.7111   -0.5518
% ];
% Td = [
%     -9.3602   -6.9339   -2.2346
% ];

% stala = 0.3201;


powiazania_u_y = containers.Map({ 'u1', 'u2', 'u3', 'u4' }, [2, 3, NaN, 1]);

K = [
    0.1191   -2.2861   -0.6893
];
Ti = [
    2.7240   -0.7111   -0.5518
];
Td = [
    -9.3602   -6.9339   -2.2346
];

stala = 0.3201;


for k = 5:N_iter
    e(:, k) = yzad(:, k) - y(:, k - 1);
    for m=1:4
        n = powiazania_u_y(sprintf('u%d', m));
        if isnan(n)
            u(m, k) = stala;
        else
            u(m, k) = PID(K(n), Ti(n), Td(n), e(n, k), e(n, k-1), e(n, k-2), u(m, k-1));
        end
    end

    [y1, y2, y3] = symulacja_obiektu10_p4(...
        u(1, k-1), u(1, k-2), u(1, k-3), u(1, k-4),...
        u(2, k-1), u(2, k-2), u(2, k-3), u(2, k-4),...
        u(3, k-1), u(3, k-2), u(3, k-3), u(3, k-4),...
        u(4, k-1), u(4, k-2), u(4, k-3), u(4, k-4),...
        y(1, k-1), y(1, k-2), y(1, k-3), y(1, k-4),...
        y(2, k-1), y(2, k-2), y(2, k-3), y(2, k-4),...
        y(3, k-1), y(3, k-2), y(3, k-3), y(3, k-4)...
    );

    y(:, k) = [y1; y2; y3];
end

E = sum(sum(e.^2));

y_titles = cell(3);

for i=1:4
    n = powiazania_u_y(sprintf('u%d', i));
    if ~isnan(n)
        y_titles{n} = sprintf('y%d , sterowane przez u%d', n, i);
    end
end

figure;
subplot(4, 1, 1);
stairs(y(1,:));
ylim([-0.5 2]);
hold on;
stairs(yzad(1,:));
title(y_titles{1});

subplot(4, 1, 2);
stairs(y(2,:));
ylim([-0.5 2]);
hold on;
stairs(yzad(2,:));
title(y_titles{2});

subplot(4, 1, 3);
stairs(y(3,:));
ylim([-0.5 2]);
hold on;
stairs(yzad(3,:));
title(y_titles{3});

subplot(4, 1, 4);
stairs(u(1,:));
hold on;
stairs(u(2,:));
stairs(u(3,:));
stairs(u(4,:));
legend('u1', 'u2', 'u3', 'u4');

powiazania = '';

for i=1:4
    curr_u = sprintf('u%d', i);
    if ~isnan(powiazania_u_y(curr_u))
        curr_y = sprintf('y%d', powiazania_u_y(curr_u));
        powiazania = strcat(powiazania, '_', curr_u, '_to_', curr_y);
    else
        powiazania = strcat(powiazania, '_', curr_u, sprintf('_is_%.2f', stala));
    end
end


parametry = '';

for i=1:3
    parametry = strcat(parametry, sprintf('_K%d_is_%.2f', i, K(i)), sprintf('_Ti%d_is_%.2f', i, Ti(i)), sprintf('_Td%d_is_%.2f', i, Td(i)));
end

blad = sprintf('_E_is_%.4f', E);

name = strcat('newPID', powiazania, parametry, blad);

set(gcf,'Units','centimeters','Position', [ 1 1 20 25]);
matlab2tikz(strcat('../images/', name,'.tex'));