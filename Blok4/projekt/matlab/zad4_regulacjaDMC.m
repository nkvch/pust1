N_iter = 300;
DMC_offline;
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

dUp = zeros(nu*(D-1), 1);

for k = 5:N_iter
    e(:, k) = yzad(:, k) - y(:, k - 1);

    duk = DMC(dUp, y(:, k), yzad(:, k))
    dUp = circshift(dUp, nu);
    dUp(1:nu) = duk
    u(:, k) = u(:, k-1) + duk;

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
subplot(3, 1, 1)
stairs(y(1,:));
hold on;
stairs(yzad(1,:));

subplot(3, 1, 2)
stairs(y(2,:));
hold on;
stairs(yzad(2,:));

subplot(3, 1, 3)
stairs(y(3,:));
hold on;
stairs(yzad(3,:));


set(gcf,'Units','centimeters','Position', [ 1 1 20 20]);

figure;
subplot(4, 1, 1)
stairs(u(1,:));

subplot(4, 1, 2)
stairs(u(2,:));

subplot(4, 1, 3)
stairs(u(3,:));

subplot(4, 1, 4)
stairs(u(4,:));

set(gcf,'Units','centimeters','Position', [ 1 1 20 20]);