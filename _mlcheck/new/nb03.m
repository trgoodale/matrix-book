A = [0.10 0.05 0.02; 0.20 0.35 0.10; 0.10 0.20 0.25];
d = [20; 150; 300];
L = inv(eye(3) - A);                 % the Leontief inverse
disp(round(L * 1000) / 1000)
multipliers = sum(L, 1)
x = (eye(3) - A) \ d                 % output for demand d: no inverse needed

e = [1.0 0.6 0.1];                   % direct emissions, kg CO2 per pound of output
f = e * L                            % footprints
total = e * x
