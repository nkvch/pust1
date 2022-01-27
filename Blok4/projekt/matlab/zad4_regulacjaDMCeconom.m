N_iter = 300;
economDMC_offline;
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
    e(:, k) = yzad(:, k) - y(:, k);

    duk = DMC(dUp, y(:, k), yzad(:, k));
    dUp = circshift(dUp, nu);
    dUp(1:nu) = duk;

    u(:, k) = u(:, k-1) + duk;
end

E = sum(sum(e.^2));

figure;
subplot(4, 1, 1);
stairs(y(1,:));
ylim([-0.5 2]);
hold on;
stairs(yzad(1,:));

subplot(4, 1, 2);
stairs(y(2,:));
ylim([-0.5 2]);
hold on;
stairs(yzad(2,:));

subplot(4, 1, 3);
stairs(y(3,:));
ylim([-0.5 2]);
hold on;
stairs(yzad(3,:));

subplot(4, 1, 4);
stairs(u(1,:));
hold on;
stairs(u(2,:));
stairs(u(3,:));
stairs(u(4,:));
legend('u1', 'u2', 'u3', 'u4');

name = sprintf('economDMC_N_%d_Nu_%d_mu1_%.2f_mu2_%.2f_mu3_%.2f_la1_%.2f_la2_%.2f_la3_%.2f_la4_%.2f_E_%.4f', N, Nu, mu(1), mu(2), mu(3), lambda(1), lambda(2), lambda(3), lambda(4), E);

set(gcf,'Units','centimeters','Position', [ 1 1 20 25]);
matlab2tikz(strcat('../images/', name,'.tex'));
