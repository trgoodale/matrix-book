V = [1 0 1 2;
     2 1 0 3;
     0 1 1 2];
rank(V)                    % 3 < 4: dependent
c = null(V);
c = c / c(1)               % scaled so that c1 = 1
rank(V(:, 1:3))            % 3: the first three are independent
