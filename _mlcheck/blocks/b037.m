A = [1 2 3; 4 5 6];
B = [7 8; 9 10; 11 12];
A * B                    % matrix product

P = [3 1; 2 4];
Q = [1 2; 0 1];
P * Q
Q * P                    % different: order matters
P .* Q                   % entry by entry: NOT the matrix product
