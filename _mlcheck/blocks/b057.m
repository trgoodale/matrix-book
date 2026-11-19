t = [0; 1; 2; 3];
y = [1; 2; 4; 5];
A = [ones(4, 1), t];       % columns: 1 and t

x = A \ y                  % least squares, because A is tall
sum((y - A*x).^2)          % the sum of squared errors
p = polyfit(t, y, 1)       % slope first, then intercept

[Q, R] = qr([1 1; 1 0; 0 1], 0);
Q                          % orthonormal columns (Example 3, up to sign)
