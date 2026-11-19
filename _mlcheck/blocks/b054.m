v1 = [1; 0; 1]; v2 = [2; 1; 0]; v3 = [0; 1; -2];
A = [v1 v2 v3];            % the vectors as columns
rank(A)                    % 2 < 3, so dependent

c = null(A);               % solutions of A c = 0
c = c / c(3)               % scaled so that c3 = 1

b = [1; 2; 3];             % is b in the span?
[rank(A), rank([A b])]
