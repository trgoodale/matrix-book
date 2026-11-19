% Example 1: nodal analysis
G = [0.3 -0.2 0; -0.2 0.5 -0.2; 0 -0.2 0.3];
v = G \ [3; 0; 0]

% Example 2: modified nodal analysis with a 12 V source at node 1
M = [G, [1; 0; 0]; 1 0 0 0];
x = M \ [0; 0; 0; 12]                 % V1, V2, V3, Is

% Example 3: a complex system for the AC filter
R = 1e3; C = 1e-6; w = 1000;
Y = [2/R + 1i*w*C, -1/R; -1/R, 1/R + 1i*w*C];
V = Y \ [1/R; 0]
[abs(V), rad2deg(angle(V))]           % amplitudes and phases
