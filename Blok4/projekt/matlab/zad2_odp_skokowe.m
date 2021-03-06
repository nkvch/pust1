N_iter = 300;
nu = 4;
ny = 3;

s_mn = zeros(nu, ny, N_iter - 5);

y = zeros(ny, N_iter);
u = zeros(nu, N_iter);

% figure;

for m = 1:nu
    u(m, 5:N_iter) = 1;
    for n = 1:ny
        % subplot(ny, nu, (n - 1)*nu + m );
        for k=5:N_iter
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
        % stairs(y(n, :));
        % title(['Tor u' num2str(m) ' - y' num2str(n)']);
        % ylim([0 2]);
        s_mn(m, n, :) = y(n, 6:N_iter);
        y(n, :) = 0;
    end
    u(m, :) = 0;
end

% set(gcf,'Units','centimeters','Position', [ 1 1 25 20]);
% matlab2tikz('../images/odp_skok_tory.tex');