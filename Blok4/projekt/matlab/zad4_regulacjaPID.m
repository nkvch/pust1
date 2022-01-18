yzad = zeros(3, N);
u = zeros(4, N);
y = zeros(3, N);
e = zeros(3, N);

% pierwsze wyjscie
yzad(1, 50:N) = 2;
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
    0.1, 0.01, 0.01
];
Ti = [
    10, 3, 10
];
Td = [
    5, 1, 1
];

for k = 5:N
    u(1, k) = 0;
    u(2, k) = PID(K(1), Ti(1), Td(1), e(3, k), e(3, k-1), e(3, k-2), u(2, k-1));
    u(3, k) = PID(K(2), Ti(2), Td(2), e(1, k), e(1, k-1), e(1, k-2), u(3, k-1));
    u(4, k) = PID(K(3), Ti(3), Td(3), e(3, k), e(2, k-1), e(2, k-2), u(4, k-1));

    [y1, y2, y3] = symulacja_obiektu10_p4(...
        u(1, k-1), u(1, k-2), u(1, k-3), u(1, k-4),...
        u(2, k-1), u(2, k-2), u(2, k-3), u(2, k-4),...
        u(3, k-1), u(3, k-2), u(3, k-3), u(3, k-4),...
        u(4, k-1), u(4, k-2), u(4, k-3), u(4, k-4),...
        y(1, k-1), y(1, k-2), y(1, k-3), y(1, k-4),...
        y(2, k-1), y(2, k-2), y(2, k-3), y(2, k-4),...
        y(3, k-1), y(3, k-2), y(3, k-3), y(3, k-4)...
    );

    y(:, k) = [y1; y2; y3]
    e = yzad - y;
end

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
