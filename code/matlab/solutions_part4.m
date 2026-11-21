%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part IV: Eigenvalues and matrix calculus: solutions to the code exercises
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Worked solutions to the code exercises from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/appendices/solutions-4.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Try each exercise yourself first. Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

% --------------------------------------------------------------------------
% Chapter 18: Eigenvalues and eigenvectors
% --------------------------------------------------------------------------

%% Chapter 18, exercise 7
% Three equal masses are joined in a line by four equal springs, with the
% outer springs fixed to walls. Their vibrations are governed by the matrix
% K = [2 -1 0; -1 2 -1; 0 -1 2]: the natural frequencies are proportional to
% the square roots of its eigenvalues, and the eigenvectors are the mode
% shapes, the patterns in which the masses move together. Find the
% eigenvalues and eigenvectors, and describe each mode shape in words.

K = [2 -1 0; -1 2 -1; 0 -1 2];
[V, D] = eig(K)

% The eigenvalues are 2 - sqrt(2) ≈ 0.586, 2 and 2 + sqrt(2) ≈ 3.414, with
% eigenvectors proportional to (1, sqrt(2), 1), (-1, 0, 1) and (1, -sqrt(2),
% 1) (software may flip their signs).
%
% - Lowest frequency: all three masses move the same way together, the
%   middle one furthest.
% - Middle frequency: the outer masses move in opposite directions and the
%   middle one stays still.
% - Highest frequency: the outer masses move together and the middle one
%   moves the opposite way, by more.
%
% The more the neighbouring masses move against each other, the more the
% springs between them stretch, and the higher the frequency.

% --------------------------------------------------------------------------
% Chapter 19: Diagonalisation and matrix powers
% --------------------------------------------------------------------------

%% Chapter 19, exercise 7
% A Leslie matrix models a population divided into age groups. For a species
% with three age groups (young, adult, old), suppose each adult has 1.5
% young per year and each old animal 1, 60% of the young survive to become
% adults, and 70% of adults survive to become old:
% L = [0 1.5 1; 0.6 0 0; 0 0.7 0].
% Find the dominant eigenvalue and its eigenvector. What is the long-run
% growth rate of the population, and what fraction of the animals is in each
% age group in the long run? Check by applying L 50 times to a starting
% population.

L = [0 1.5 1; 0.6 0 0; 0 0.7 0];
[V, D] = eig(L);
[lam, i] = max(real(diag(D)));
lam
v = V(:, i) / sum(V(:, i))

x = [100; 0; 0];
for k = 1:50
    x = L * x;
end
x / sum(x)

% The dominant eigenvalue is about 1.128, so in the long run the population
% grows by about 12.8% a year. The other two eigenvalues are complex, with
% absolute value about 0.61, so their modes die away. In the long run about
% 53.7% of the animals are young, 28.6% adult and 17.7% old, and 50 steps
% from a starting population of young animals only has already reached this
% distribution.

% --------------------------------------------------------------------------
% Chapter 20: Symmetric and positive definite matrices
% --------------------------------------------------------------------------

%% Chapter 20, exercise 7
% At a point inside a machine part, the stress matrix in MPa is
% σ = [80 20 0; 20 40 -10; 0 -10 -30].
% Find the principal stresses and the direction of the largest one. Check
% that the principal directions are perpendicular.

sigma = [80 20 0; 20 40 -10; 0 -10 -30];
[Q, D] = eig(sigma);
diag(D)                    % principal stresses, smallest first
Q(:, 3)                    % direction of the largest
Q' * Q                     % the identity, so Q is orthogonal

% The principal stresses are about 88.4 MPa (tension), 33.1 MPa (tension)
% and -31.5 MPa (compression). The largest acts along  ± (0.921, 0.387,
% -0.033), mostly along the x axis, tilted towards y. Q^T Q = I, up to
% rounding, confirms that the principal directions are perpendicular.

% --------------------------------------------------------------------------
% Chapter 21: The singular value decomposition and PCA
% --------------------------------------------------------------------------

%% Chapter 21, exercise 7
% Generate data for 200 people with two closely related measurements, for
% example with rng = np.random.default_rng(1), h = rng.normal(170, 10, 200)
% (heights in cm) and s = h + rng.normal(0, 4, 200) (arm spans in cm). Find
% the principal components and the fraction of the variance explained by
% each, and interpret the first component.

% The book gives this solution in Python. Here is a MATLAB version.

rng(1);
h = 170 + 10 * randn(200, 1);          % heights in cm
s = h + 4 * randn(200, 1);             % arm spans in cm
X = [h, s];
Xc = X - mean(X);
[~, S, V] = svd(Xc, 'econ');
V                                      % columns are the principal components
diag(S).^2 / sum(diag(S).^2)           % fraction of variance explained

% In MATLAB, the same steps are X = [h, s]; Xc = X - mean(X); [~, S, V] =
% svd(Xc, 'econ'); diag(S).^2 / sum(diag(S).^2). MATLAB's random numbers
% differ from NumPy's, so the results differ slightly.
%
% The first principal component is about  ± (0.67, 0.74) and explains about
% 97% of the variance: it is overall body size, with height and arm span
% increasing together. The second, perpendicular to it, explains the
% remaining 3%; it measures how much longer or shorter a person's arm span
% is than you would expect from their height. One number per person, the
% score along the first component, captures almost all the information in
% the two measurements.

% --------------------------------------------------------------------------
% Chapter 22: Derivatives with vectors and matrices
% --------------------------------------------------------------------------

%% Chapter 22, exercise 7
% Use gradient descent to minimise f(x) = (1/2)x^T Ax with A = [10 0; 0 1],
% starting from (1, 1), with step sizes α= 0.1, 0.18 and 0.21. For each,
% count the steps until ||x|| < 10^-6, or report that it fails. Explain the
% results using the eigenvalues of A.

A = [10 0; 0 1];
for alpha = [0.1 0.18 0.21]
    x = [1; 1];
    k = 0;
    while norm(x) >= 1e-6 && k < 1000
        x = x - alpha * (A * x);
        k = k + 1;
    end
    fprintf('alpha = %.2f: %d steps, |x| = %.3g\n', alpha, k, norm(x));
end

% The eigenvalues of A are 10 and 1, and each step multiplies the two
% components of x by 1 - 10α and 1 - α.
%
% - α= 0.1: the factors are 0 and 0.9. The first component vanishes at once,
%   but the second shrinks slowly, and 0.9^k < 10^-6 needs k = 132.
% - α= 0.18: the factors are -0.8 and 0.82, both well inside (-1, 1), so
%   about 70 steps. This is close to the best possible, α= 2/(10 + 1) ≈
%   0.182, which makes both factors  ± 9/11.
% - α= 0.21: the factor 1 - 2.1 = -1.1 has size greater than 1, so the first
%   component flips sign and grows at every step, and the method diverges.
%
% Convergence needs α< 2/λ_max = 0.2, and even the best step leaves a factor
% of (κ- 1)/(κ+ 1) per step, where κ= 10 is the condition number.

% --------------------------------------------------------------------------
% Chapter 23: Linear ODE systems and the matrix exponential
% --------------------------------------------------------------------------

%% Chapter 23, exercise 7
% A dose of 100 mg of a drug is swallowed. The amount x_1 in the gut and x_2
% in the blood obey
% dotx_1 = -0.5x_1,
%
% dotx_2 = 0.5x_1 - 0.2x_2,
% with time in hours. Use the matrix exponential to compute x(t) for 0 ≤ t ≤
% 20, plot both amounts, and find when the amount in the blood is greatest
% and what it is. Check against the exact answer from the eigenvalues.

A = [-0.5 0; 0.5 -0.2];
t = linspace(0, 20, 2001);
X = zeros(2, numel(t));
for j = 1:numel(t)
    X(:, j) = expm(A * t(j)) * [100; 0];
end
[peak, j] = max(X(2, :));
[t(j), peak]               % time and amount of the peak
plot(t, X)
xlabel('time (hours)'), ylabel('amount (mg)'), legend('gut', 'blood')

% The matrix is triangular, so the eigenvalues are -0.5 and -0.2. Solving
% directly, x_1 = 100e^-0.5t, and
% x_2(t) = ((100 × 0.5)/(0.5 - 0.2))e^-0.2t - e^-0.5t = (500/3)e^-0.2t -
% e^-0.5t.
% This is greatest when dotx_2 = 0, that is 0.2e^-0.2t = 0.5e^-0.5t, so
% e^0.3t = 2.5 and t = ln2.5/0.3 ≈ 3.05 hours, when x_2 ≈ 54.3 mg. The
% computed peak agrees, to the resolution of the time grid.

% --------------------------------------------------------------------------
% Part IV: Eigenvalues and matrix calculus review
% --------------------------------------------------------------------------

%% Part IV, exercise 11
% For the system in exercise 5, compute x(1) in two ways: with the built-in
% matrix exponential, and with Ve^ΛtV^-1x(0) using the eigenvalues and
% eigenvectors. Compare both with your formula.

% Uses Chapter 23 and Chapter 19.

A = [-2 1; 1 -2];  x0 = [1; 0];  t = 1;
x_expm = expm(A*t) * x0;
[V, D] = eig(A);
x_eig = V * diag(exp(diag(D)*t)) / V * x0;
x_formula = 0.5*exp(-t)*[1; 1] + 0.5*exp(-3*t)*[1; -1];
fprintf('%.6f %.6f\n', [x_expm, x_eig, x_formula])

% All three agree. expm doesn't need the eigenvectors, so it also works for
% matrices that can't be diagonalised.
