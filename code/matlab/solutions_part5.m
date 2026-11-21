%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part V: Numerical methods: solutions to the code exercises
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Worked solutions to the code exercises from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/appendices/solutions-5.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Try each exercise yourself first. Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

% --------------------------------------------------------------------------
% Chapter 24: Floating point and conditioning
% --------------------------------------------------------------------------

%% Chapter 24, exercise 7
% For the Hilbert matrices with n = 2, 3, ..., 14, compute κ_2(H_n) and the
% error in solving H_nx = H_n1. Plot both on a logarithmic scale against n,
% and check the rule of thumb. Roughly how fast does κ grow with n?

ns = 2:14;
conds = zeros(size(ns));
errors = zeros(size(ns));
for k = 1:numel(ns)
    n = ns(k);
    H = hilb(n);
    xhat = H \ (H * ones(n, 1));
    conds(k) = cond(H);
    errors(k) = max(abs(xhat - 1));
end
semilogy(ns, conds, 'o-', ns, errors, 's-', ns, conds * 1.1e-16, '--')
xlabel('n'), legend('condition number', 'error in solution', 'condition number \times \epsilon/2')

% The error follows the line κvarepsilon/2 closely, as the rule of thumb
% predicts, until κ passes 10^16 and the solution has no correct digits. The
% condition number grows by a factor of about 30 each time n increases by 1,
% so roughly like 10^1.5n. (Beyond n ≈ 13, the computed condition number
% itself is no longer accurate, which is why it stops growing.)

% --------------------------------------------------------------------------
% Chapter 25: Pivoting
% --------------------------------------------------------------------------

%% Chapter 25, exercise 7
% Build Wilkinson's matrix for n = 10, 30 and 60, choose a random x, set b =
% Wx, and solve with np.linalg.solve or backslash. Compare the relative
% error with the condition number of W, and with the largest entry of U.
% What do you conclude?

for n = [10 30 60]
    W = eye(n) - tril(ones(n), -1);
    W(:, end) = 1;
    x = randn(n, 1);
    xhat = W \ (W * x);
    [L, U, P] = lu(W);
    fprintf('n = %d: cond = %.1f, largest entry of U = %.1e, relative error = %.1e\n', ...
            n, cond(W), max(abs(U(:))), norm(xhat - x, inf) / norm(x, inf));
end

% The condition number stays small (about 27 for n = 60), so the problem is
% well conditioned, yet the error grows from about 10^-14 to tens of percent
% as the largest entry of U grows like 2^n-1, to about 6 × 10^17. Partial
% pivoting is not backward stable for this matrix: the growth factor
% magnifies rounding errors exactly as large multipliers do without
% pivoting. Such matrices are extremely rare in practice, but they show that
% the guarantee is not absolute.

% --------------------------------------------------------------------------
% Chapter 26: Cost, banded and sparse systems
% --------------------------------------------------------------------------

%% Chapter 26, exercise 7
% Time the solution of the tridiagonal system in the code above for n = 500,
% 1000, 2000 and 4000, using (a) a dense matrix and np.linalg.solve or
% backslash on a full matrix, (b) the sparse solver. On a log–log plot,
% estimate the power of n that each time grows like.

ns = [500 1000 2000 4000];
tdense = zeros(size(ns)); tsparse = zeros(size(ns));
for k = 1:numel(ns)
    n = ns(k);
    e = ones(n, 1);
    A = spdiags([-e 2*e -e], -1:1, n, n);
    Ad = full(A);
    b = ones(n, 1);
    tic; x = Ad \ b; tdense(k) = toc;
    tic; x = A \ b; tsparse(k) = toc;
end
pd = polyfit(log(ns), log(tdense), 1);
ps = polyfit(log(ns), log(tsparse), 1);
fprintf('dense grows like n^%.1f, sparse like n^%.1f\n', pd(1), ps(1));

% Timings vary from run to run and between computers, especially for small,
% fast cases, but the dense times grow roughly like n^3 (often a little less
% for these sizes, because fast libraries run faster on larger matrices).
% The sparse times are so small, around a millisecond, that fixed overheads
% dominate; trying n up to 10^6 shows them growing like n. MATLAB's
% backslash notices that a full matrix is tridiagonal and uses a banded
% solver even on Ad, so its dense times may grow much more slowly; NumPy's
% solve always does dense elimination.

% --------------------------------------------------------------------------
% Chapter 27: Iterative methods
% --------------------------------------------------------------------------

%% Chapter 27, exercise 7
% Modify the code above to compare Jacobi, Gauss–Seidel, best SOR and CG for
% n = 25, 50, 100 and 200. How does the number of steps grow with n for each
% method? Plot the residual against the step number for n = 100 on a
% logarithmic scale.

% The book gives this solution in Python. Here is a MATLAB version.

for n = [25 50 100 200]
    steps = count_steps(n);
    fprintf('n = %3d: Jacobi %6d, Gauss-Seidel %6d, SOR %4d, CG %3d\n', n, steps);
end

% Each doubling of n roughly multiplies the Jacobi and Gauss–Seidel counts
% by 4, so they grow like n^2, because 1 - ρ(T_J) = 1 - cos(π/(n+1)) ≈
% π^2/(2(n + 1)^2). (For n = 200, Jacobi would need about 110 000 steps and
% Gauss–Seidel half as many, so the code skips them.) Best SOR and CG grow
% like n: SOR needs about 3n steps here, and CG exactly n/2. That is because
% b is symmetric about the middle of the rod, so it is a combination of only
% half of the eigenvectors of A, and in exact arithmetic CG needs at most
% one step for each eigenvector involved. The MATLAB version follows the
% chapter's code in the same way, with pcg for CG. Plotting the residual
% against the step number on a log scale shows straight lines for the
% stationary methods, whose slopes are log_10ρ, and a curve that drops away
% steeply for CG.

% --------------------------------------------------------------------------
% Chapter 28: Newton's method for nonlinear systems
% --------------------------------------------------------------------------

%% Chapter 28, exercise 7
% Write a Newton solver that approximates the Jacobian by finite
% differences, and use it to find all the intersections of x^2 + 4y^2 = 4
% and y = sin(2x). Try several starting points, and compare the number of
% steps needed with the exact-Jacobian version.

f = @(v) [v(1)^2 + 4*v(2)^2 - 4; v(2) - sin(2*v(1))];
starts = [-2 0.5; -1 -1; -0.5 -1; 0.5 1; 1 1; 2 -0.5];
for i = 1:size(starts, 1)
    [root, steps] = newton_fd(f, starts(i, :)');
    fprintf('(%5.2f, %5.2f) -> (%9.6f, %9.6f) in %d steps\n', starts(i, :), root, steps);
end

% There are six intersections, at about ( ± 0.626, ± 0.950), ( ± 1.067, ±
% 0.846) and ( ∓ 1.798, ± 0.438) (taking the signs together, since the
% curves are symmetric under (x, y) → (-x, -y)). From these starts, the
% finite-difference version needs 5 or 6 steps, exactly the same as with the
% exact Jacobian: the small errors in the approximate Jacobian hardly slow
% convergence. Starting at (0, 0) fails, because the Jacobian [2x 8y;
% -2cos2x 1] is singular there.

% --------------------------------------------------------------------------
% Chapter 29: Eigenvalue algorithms
% --------------------------------------------------------------------------

%% Chapter 29, exercise 7
% Build the n × n matrix with 2 on the diagonal and -1 beside it, for n =
% 1000, as a sparse matrix. Use eigsh (Python) or eigs (MATLAB) to find its
% 5 smallest eigenvalues, and compare them with the exact values 2 -
% 2cos(kπ/(n + 1)), k = 1, ..., 5. Then try the power method on it: how many
% steps would it need to separate the two largest eigenvalues?

n = 1000;
e = ones(n, 1);
T = spdiags([-e 2*e -e], -1:1, n, n);
values = sort(eigs(T, 5, 'smallestabs'))
exact = 2 - 2 * cos((1:5)' * pi / (n + 1))

% The five computed eigenvalues agree with the formula to about 12
% significant digits. For the power method, the two largest eigenvalues are
% about 3.99999015 and 3.99996060, with ratio 0.9999926, so each digit would
% need about 311 000 steps: hopeless. The shift-and-invert Lanczos method
% behind eigsh and eigs needs only a few dozen steps.

% --------------------------------------------------------------------------
% Chapter 30: QR factorisation and stable least squares
% --------------------------------------------------------------------------

%% Chapter 30, exercise 7
% Implement classical and modified Gram–Schmidt. For the matrices with
% columns 1, t, ..., t^n-1 at 50 points in [0, 1], with n = 4, 6, 8, 10, 12,
% compute ||Q^T Q - I|| for both versions and for np.linalg.qr or qr, and
% plot the results against κ(A) on log scales. What do you see?

t = linspace(0, 1, 50)';
ns = [4 6 8 10 12];
conds = zeros(size(ns)); loss = zeros(3, numel(ns));
for k = 1:numel(ns)
    n = ns(k);
    A = t .^ (0:n-1);
    conds(k) = cond(A);
    [Qh, ~] = qr(A, 0);
    Qs = {classical_gs(A), modified_gs(A), Qh};
    for m = 1:3
        loss(m, k) = norm(Qs{m}' * Qs{m} - eye(n));
    end
end
loglog(conds, loss, 'o-')
xlabel('condition number of A'), ylabel('||Q^TQ - I||')
legend('classical', 'modified', 'Householder')

% Householder's Q stays orthogonal to about 10^-15 whatever the
% conditioning. Modified Gram–Schmidt loses orthogonality in proportion to
% κ(A)varepsilon, and classical Gram–Schmidt in proportion to
% κ(A)^2varepsilon, so on log scales they are straight lines of slopes 1 and
% 2, until classical reaches order 1 and its "Q" is useless.

% --------------------------------------------------------------------------
% Part V: Numerical methods review
% --------------------------------------------------------------------------

%% Part V, exercise 9
% Run the Jacobi method on Ax = b, with A from exercise 4 and b = (6, 12)^T,
% starting from 0. Print the ratio of successive errors ||x_k+1 - x|| /
% ||x_k - x||, and compare it with the spectral radius. Repeat with
% Gauss–Seidel.

% Uses Chapter 27.

A = [4 1; 2 5];  b = [6; 12];  x_true = A \ b;
D = diag(diag(A));  L = tril(A, -1);
names = {'Jacobi', 'Gauss-Seidel'};
splits = {D, D + L};                 % the matrix M in A = M - N
for m = 1:2
    M = splits{m};  N = M - A;       % iterate M*x_new = N*x + b
    x = [0; 0];  err = norm(x - x_true);
    fprintf('%s, spectral radius %.4f\n', names{m}, max(abs(eig(M \ N))))
    for k = 1:6
        x = M \ (N*x + b);
        new_err = norm(x - x_true);
        fprintf('  step %d: error %.2e, ratio %.4f\n', k, new_err, new_err/err)
        err = new_err;
    end
end

% The solution is x = (1, 2). For Gauss–Seidel the ratio settles at exactly
% ρ= 0.1. For Jacobi it alternates between about 0.29 and 0.35, because its
% two eigenvalues,  ± 0.316, have the same size; over two steps the error
% shrinks by exactly 0.316^2 = 0.1, so on average by ρ per step.

%% Functions
% MATLAB needs the functions used in a script to come at its end.

function steps = count_steps(n)
% Steps each method needs to reduce the residual by a factor of 10^6.
% Jacobi and Gauss-Seidel are skipped (NaN) for n > 100: too slow.
e = ones(n, 1);
A = spdiags([-e 2*e -e], -1:1, n, n);
b = e / (n + 1)^2;
D = diag(diag(A)); L = tril(A, -1); U = triu(A, 1);
rho = cos(pi / (n + 1));
w = 2 / (1 + sqrt(1 - rho^2));
Ms = {D, D + L, D / w + L};
Ns = {L + U, U, U + (1 - 1/w) * D};
steps = nan(1, 4);
for m = 1:3
    if m < 3 && n > 100, continue, end
    x = zeros(n, 1); k = 0;
    while norm(b - A*x) >= 1e-6 * norm(b)
        x = Ms{m} \ (b - Ns{m} * x);    % Ms{m} is triangular, so this is cheap
        k = k + 1;
    end
    steps(m) = k;
end
[~, ~, ~, steps(4)] = pcg(A, b, 1e-6, n);
end

function [x, k] = newton_fd(f, x)
for k = 1:50
    fx = f(x);
    J = zeros(numel(fx), numel(x));
    for j = 1:numel(x)
        h = 1e-7 * max(1, abs(x(j)));
        e = zeros(size(x)); e(j) = h;
        J(:, j) = (f(x + e) - fx) / h;
    end
    dx = -J \ fx;
    x = x + dx;
    if norm(dx) < 1e-12, return, end
end
end

function Q = classical_gs(A)
Q = zeros(size(A));
for j = 1:size(A, 2)
    v = A(:, j) - Q(:, 1:j-1) * (Q(:, 1:j-1)' * A(:, j));
    Q(:, j) = v / norm(v);
end
end

function Q = modified_gs(A)
Q = A;
for j = 1:size(A, 2)
    Q(:, j) = Q(:, j) / norm(Q(:, j));
    for k = j+1:size(A, 2)
        Q(:, k) = Q(:, k) - (Q(:, j)' * Q(:, k)) * Q(:, j);
    end
end
end
