%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part I: Matrices and transformations: solutions to the code exercises
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Worked solutions to the code exercises from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/appendices/solutions-1.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Try each exercise yourself first. Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

% --------------------------------------------------------------------------
% Chapter 1: What is a matrix?
% --------------------------------------------------------------------------

%% Chapter 1, exercise 6
% Create the 6 × 6 matrix with entries a_ij = 1/(i + j - 1), and check that
% it is symmetric. (It is called the Hilbert matrix, and it returns in
% Chapter 24 as a famously difficult matrix for computers.) In Python you
% may find np.fromfunction useful; in MATLAB, try hilb(6) and compare.

[J, I] = meshgrid(1:6);       % I(i,j) = i and J(i,j) = j
H = 1 ./ (I + J - 1);
isequal(H, H')
isequal(H, hilb(6))

% --------------------------------------------------------------------------
% Chapter 2: Adding and scaling matrices
% --------------------------------------------------------------------------

%% Chapter 2, exercise 6
% The matrix T from Chapter 1 holds four hourly readings from three
% temperature sensors. Subtract each sensor's average reading from its
% column, using broadcasting, and check that each column of the result adds
% up to zero (up to rounding).

T = [18.2 19.1 17.6; 19.5 20.3 18.4; 21.0 21.8 19.9; 22.4 23.0 21.2];
D = T - mean(T)              % the 1 x 3 row of means is expanded down the rows
sum(D)                       % zero, up to rounding

% The column sums are zero, or tiny values such as 10^-15 caused by
% rounding.

% --------------------------------------------------------------------------
% Chapter 3: Matrix multiplication
% --------------------------------------------------------------------------

%% Chapter 3, exercise 7
% For the road network N of Example 2, compute N^3 and use it to find the
% number of three-step routes from town 1 back to town 1. List them. Why is
% the corresponding entry for town 4 zero?

N = [0 1 1 0; 1 0 1 0; 1 1 0 1; 0 0 1 0];
N^3

% The (1, 1) entry is 2: the routes are 1 → 2 → 3 → 1 and 1 → 3 → 2 → 1,
% round the triangle in each direction. A three-step route that returns to
% its start must go round a triangle of roads. Town 4 has only one road, to
% town 3, so it is not on any triangle, and the (4, 4) entry is 0.

% --------------------------------------------------------------------------
% Chapter 4: Matrices as transformations
% --------------------------------------------------------------------------

%% Chapter 4, exercise 7
% Apply the rotation R(θ) to the F shape (corner coordinates are in the code
% for Figure 4.1) for θ= 0°, 45°, 90°, ..., 315°, and plot all eight images
% on one set of axes.

F = [0 0.5 0.5  1.1  1.1 0.5 0.5  1.3  1.3 0;
     0 0   0.85 0.85 1.3 1.3 1.75 1.75 2.2 2.2];
figure; hold on
for k = 0:7
    R = [cosd(45*k) -sind(45*k); sind(45*k) cosd(45*k)];
    G = R * F;
    fill(G(1,:), G(2,:), rand(1,3), 'FaceAlpha', 0.25)
end
axis equal; grid on

% --------------------------------------------------------------------------
% Chapter 5: Composing transformations
% --------------------------------------------------------------------------

%% Chapter 5, exercise 7
% Pick two random 2 × 2 matrices and check numerically that (AB)^T = B^T
% A^T, but that AB ≠ BA. Then find, by experiment, a non-diagonal matrix
% that commutes with [2 1; 1 2].

A = randn(2); B = randn(2);
norm((A*B)' - B'*A') < 1e-12      % true
norm(A*B - B*A) < 1e-12           % false (almost always)

S = [2 1; 1 2];
M = [1 2; 2 1];                   % a candidate
isequal(S*M, M*S)                 % true

% Any matrix of the form [a b; b a] commutes with [2 1; 1 2]. (These
% matrices all have the same invariant lines, y = x and y = -x, which
% Chapter 19 explains.)

% --------------------------------------------------------------------------
% Chapter 6: Determinants
% --------------------------------------------------------------------------

%% Chapter 6, exercise 8
% Generate random n × n matrices with entries between -1 and 1, and record
% |detA| for n = 2, 5, 10, 20, 50. How does the typical size of the
% determinant change with n? Why is the size of a determinant a poor guide
% to whether a matrix is nearly singular?

for n = [2 5 10 20 50]
    d = zeros(200, 1);
    for k = 1:200
        d(k) = abs(det(2*rand(n) - 1));
    end
    fprintf('n = %2d: median |det| = %.3g\n', n, median(d));
end

% The typical size grows enormously with n, from about 0.3 to about 10^19,
% although the matrices are no closer to or further from being singular. A
% determinant multiplies together n scale factors, so it depends on the size
% of the entries and on n, not just on how close the matrix is to singular.
% The condition number (Chapter 24) measures nearness to singularity
% properly.

% --------------------------------------------------------------------------
% Chapter 7: Inverse matrices
% --------------------------------------------------------------------------

%% Chapter 7, exercise 7
% The Hill cipher is a simple secret code. It turns letters into numbers (A
% = 0, B = 1, ..., Z = 25), multiplies pairs of them by a key matrix, and
% then replaces each result by its remainder after dividing by 26 ("reducing
% modulo 26"), so that it is a letter again. With key K = [3 3; 2 5], the
% message HELP becomes the vectors (7, 4)^T and (11, 15)^T. Encrypt it. Then
% check that K^-1 modulo 26 is [15 17; 20 9], by showing that K times this
% matrix is I modulo 26, and use it to decrypt. (Chapter 39 explains how
% this inverse is found.)

K = [3 3; 2 5];
Kinv = [15 17; 20 9];
P = [7 11; 4 15];          % HELP: one pair per column

C = mod(K * P, 26)         % (7, 8), (0, 19): HIAT
mod(K * Kinv, 26)          % the identity, modulo 26
mod(Kinv * C, 26)          % back to HELP

% The ciphertext is HIAT.

% --------------------------------------------------------------------------
% Chapter 8: Transformations in three dimensions
% --------------------------------------------------------------------------

%% Chapter 8, exercise 6
% Aircraft orientation is often given as three angles: yaw ψ (turning left
% or right, about the vertical z-axis), pitch θ (nose up or down, about y)
% and roll φ (tilting the wings, about x), applied in the aircraft's own
% frame, which gives the matrix R_z(ψ)R_y(θ)R_x(φ). Compute this, R_1, for
% ψ= 30°, θ= 10°, φ= 5°, and compare it with the product in the reverse
% order, R_2. By how many degrees do the two orientations differ? (Hint: the
% rotation angle of an orthogonal matrix M with determinant 1 satisfies
% traceM = 1 + 2cosα, where the trace is the sum of the diagonal entries;
% apply this to M = R_1^T R_2.)

Rx = @(t) [1 0 0; 0 cosd(t) -sind(t); 0 sind(t) cosd(t)];
Ry = @(t) [cosd(t) 0 sind(t); 0 1 0; -sind(t) 0 cosd(t)];
Rz = @(t) [cosd(t) -sind(t) 0; sind(t) cosd(t) 0; 0 0 1];

R1 = Rz(30) * Ry(10) * Rx(5);
R2 = Rx(5) * Ry(10) * Rz(30);
M = R1' * R2;
fprintf('The two orientations differ by %.2f degrees\n', acosd((trace(M) - 1) / 2));

% A difference of almost 6°, from angles of only 5° to 30°, is easily enough
% to matter in navigation.

% --------------------------------------------------------------------------
% Chapter 9: Invariant points and lines
% --------------------------------------------------------------------------

%% Chapter 9, exercise 7
% Use eigenvalues and eigenvectors to find the invariant lines of [1 2; 3
% 2], and the stretch factor along each. Check your answer with
% Equation 9.3, and then with the app. What does the negative stretch factor
% mean for the points on that line?

A = [1 2; 3 2];
[V, D] = eig(A);
lambda = diag(D)'
slopes = V(2, :) ./ V(1, :)

% The invariant lines are y = -x with λ= -1 and y = (3/2)x with λ= 4. By
% hand, b = 2, a - d = -1, c = 3, so Equation 9.3 is 2m^2 - m - 3 = 0, that
% is (2m - 3)(m + 1) = 0, giving the same slopes. The stretch factors are a
% + bm = 1 + 2 × (-1) = -1 and 1 + 2 × (3/2) = 4.
%
% On y = -x, the stretch factor -1 means each point flips to the opposite
% side of the origin, at the same distance: (1, -1)^T → (-1, 1)^T. The line
% lands on itself, but only the origin stays put.

% --------------------------------------------------------------------------
% Part I: Matrices and transformations review
% --------------------------------------------------------------------------

%% Part I, exercise 9
% Make two random 4 × 4 matrices A and B. Check numerically that (AB)^-1 =
% B^-1A^-1, and that this is not the same as A^-1B^-1. Explain the order
% using the idea of undoing two transformations.

% Uses Chapter 7 and Chapter 5.

rng(1)
A = randn(4);  B = randn(4);
fprintf('(AB)^-1 = B^-1 A^-1: %d\n', norm(inv(A*B) - inv(B)*inv(A)) < 1e-10)
fprintf('(AB)^-1 = A^-1 B^-1: %d\n', norm(inv(A*B) - inv(A)*inv(B)) < 1e-10)

% AB applies B first and then A. To undo this, undo the last step first:
% apply A^-1, then B^-1, which is the matrix B^-1A^-1. It's like taking off
% shoes and socks: the shoes, which went on last, come off first.
