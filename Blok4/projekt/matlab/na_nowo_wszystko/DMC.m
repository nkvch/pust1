s = {};

N_iter = 200;
nu = 4;
ny = 3;

u1 = zeros(N_iter, 1);
u2 = zeros(N_iter, 1);
u3 = zeros(N_iter, 1);
u4 = zeros(N_iter, 1);

y1 = zeros(N_iter, 1);
y2 = zeros(N_iter, 1);
y3 = zeros(N_iter, 1);

s_ = zeros(ny, nu, 200);

u = zeros(N_iter, 1);
y = zeros(N_iter, 1);


for i=1:nu
    if i == 1
        u1(5:N_iter) = 1;
    elseif i == 2
        u1(5:N_iter) = 1;
    elseif i == 3
        u3(5:N_iter) = 1;
    elseif i == 4
        u4(5:N_iter) = 1;
    end
    for j = 1:ny
        for k = 5:N_iter
            [y_1, y_2, y_3] = symulacja_obiektu10_p4(...
                u1(k-1), u1(k-2), u1(k-3), u1(k-4),...
                u2(k-1), u2(k-2), u2(k-3), u2(k-4),...
                u3(k-1), u3(k-2), u3(k-3), u3(k-4),...
                u4(k-1), u4(k-2), u4(k-3), u4(k-4),...
                y1(k-1), y1(k-2), y1(k-3), y1(k-4),...
                y2(k-1), y2(k-2), y2(k-3), y2(k-4),...
                y3(k-1), y3(k-2), y3(k-3), y3(k-4)...
            );

            y1(k) = y_1;
            y2(k) = y_2;
            y3(k) = y_3;
        end
        
        y1 = zeros(N_iter, 1);
        y2 = zeros(N_iter, 1);
        y3 = zeros(N_iter, 1);
    end
    u1 = zeros(N_iter, 1);
    u2 = zeros(N_iter, 1);
    u3 = zeros(N_iter, 1);
    u4 = zeros(N_iter, 1);
end

