function E = PID_E(X)
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
        X(1), X(2), X(3)
    ];
    Ti = [
        X(4), X(5), X(6)
    ];
    Td = [
        X(7), X(8), X(9)
    ];

    powiazania_u_y = containers.Map({ 'u1', 'u2', 'u3', 'u4' }, [2, 3, NaN, 1]);

    for k = 5:N
        e(:, k) = yzad(:, k) - y(:, k - 1);
        for m=1:4
            n = powiazania_u_y(sprintf('u%d', m));
            if isnan(n)
                u(m, k) = 0;
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
end