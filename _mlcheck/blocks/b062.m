A = [3 1; 1 2];
b = [5; 5];
f = @(x) 0.5 * x' * A * x - b' * x;
grad = @(x) A * x - b;

% Check the gradient by central differences
x = [-2; -1];
h = 1e-6;
E = eye(2);
fd = zeros(2, 1);
for i = 1:2
    fd(i) = (f(x + h*E(:, i)) - f(x - h*E(:, i))) / (2*h);
end
[grad(x), fd]

% Gradient descent
for k = 1:19
    x = x - 0.4 * grad(x);
end
x                          % close to (1, 2)
