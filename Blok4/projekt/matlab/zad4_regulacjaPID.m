N = 300;
yzad = zeros(3, N);
u = zeros(4, N);
y = zeros(3, N);
e = zeros(3, N);

% pierwsze wyjscie
yzad(1, 50:N) = 1.5;
yzad(1, 150:N) = 1.2;
yzad(1, 200:N) = 0.5;

% drugie wyjscie
yzad(2, 70:N) = 0.4;
yzad(2, 200:N) = 1.5;
yzad(2, 250:N) = 0.2;

% trzecie wyjscie
yzad(20:3, N) = 1.4;
yzad(3, 100:N) = 0.7;
yzad(3, 170:N) = 1;



K = [
    0.1 0.1 0.03
];
Ti = [
    0.3 0.2 0.02
];
Td = [
    0 1 30
];

stala = 0;

powiazania_u_y = containers.Map({ 'u1', 'u2', 'u3', 'u4' }, [NaN, 3, 1, 2]);

for k = 5:N
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

figure;
subplot(2, 3, 1)
stairs(y(1,:));
hold on;
stairs(yzad(1,:));

subplot(2, 3, 2)
stairs(y(2,:));
hold on;
stairs(yzad(2,:));

subplot(2, 3, 3)
stairs(y(3,:));
hold on;
stairs(yzad(3,:));

subplot(2, 3, 4)
stairs(u(3,:));

subplot(2, 3, 5)
stairs(u(4,:));

subplot(2, 3, 6)
stairs(u(2,:));

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

name = strcat('PID', powiazania, parametry, blad);

set(gcf,'Units','centimeters','Position', [ 1 1 20 10]);
matlab2tikz(strcat('../images/', name,'.tex'));