K = [3 3; 2 5];
Kinv = [15 17; 20 9];
P = [7 11; 4 15];          % HELP: one pair per column

C = mod(K * P, 26)         % (7, 8), (0, 19): HIAT
mod(K * Kinv, 26)          % the identity, modulo 26
mod(Kinv * C, 26)          % back to HELP
