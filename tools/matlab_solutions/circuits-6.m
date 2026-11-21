R = 1e3; C = 1e-6;
gain = @(w) abs([0 1] * ([2/R + 1i*w*C, -1/R; -1/R, 1/R + 1i*w*C] \ [1/R; 0]));
w3 = fzero(@(w) gain(w) - 1/sqrt(2), [1 1e4])
f3 = w3 / (2*pi)                       % in Hz
