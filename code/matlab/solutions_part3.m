%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part III: Vector spaces: solutions to the code exercises
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Worked solutions to the code exercises from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/appendices/solutions-3.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Try each exercise yourself first. Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

% --------------------------------------------------------------------------
% Chapter 14: Span and linear independence
% --------------------------------------------------------------------------

%% Chapter 14, exercise 7
% Show that the four vectors (1, 2, 0)^T, (0, 1, 1)^T, (1, 0, 1)^T and (2,
% 3, 2)^T are dependent, and find a dependence relation. Are the first three
% independent?

V = [1 0 1 2;
     2 1 0 3;
     0 1 1 2];
rank(V)                    % 3 < 4: dependent
c = null(V);
c = c / c(1)               % scaled so that c1 = 1
rank(V(:, 1:3))            % 3: the first three are independent

% Four vectors in R^3 must be dependent. The relation is v_1 + v_2 + v_3 -
% v_4 = 0: the fourth vector is the sum of the other three. The first three
% have rank 3, so they are independent.

% --------------------------------------------------------------------------
% Chapter 15: Basis, dimension and change of basis
% --------------------------------------------------------------------------

%% Chapter 15, exercise 7
% In the chapter you found that C = [0 0 1; 1 0 0; 0 1 0] is the rotation by
% 120° about the line through (1, 1, 1). Build it the other way, by a change
% of basis. Use p = (1/sqrt(2))(1, -1, 0)^T, q = (1/sqrt(6))(1, 1, -2)^T and
% u = (1/sqrt(3))(1, 1, 1)^T as the columns of P, so that the axis u plays
% the part of the z-axis. Compute P R_z(120°) P^-1 and compare it with C.
% (These three vectors are perpendicular unit vectors, so P is orthogonal
% and P^-1 = P^T.)

p = [1; -1; 0] / sqrt(2);
q = [1; 1; -2] / sqrt(6);
u = [1; 1; 1] / sqrt(3);
P = [p q u];

Rz = [cosd(120) -sind(120) 0;
      sind(120)  cosd(120) 0;
      0 0 1];
round(P * Rz * P', 10)

% The result is exactly C. In the basis p, q, u, the rotation is the simple
% R_z(120°); the change of basis carries it over to the usual coordinates.

% --------------------------------------------------------------------------
% Chapter 16: Column space, null space and rank–nullity
% --------------------------------------------------------------------------

%% Chapter 16, exercise 7
% Make a random 5 × 8 matrix of rank 3 as the product of a random 5 × 3 and
% a random 3 × 8 matrix. Check numerically that the dimensions of its four
% subspaces are as the table predicts, and that every null space vector is
% perpendicular to every row.

A = randn(5, 3) * randn(3, 8);
r = rank(A)
dims = [size(orth(A), 2), size(null(A), 2), size(orth(A'), 2), size(null(A'), 2)]
max(abs(A * null(A)), [], 'all')     % tiny: rows are perpendicular to the null space

% The dimensions are r = 3, n - r = 5, r = 3 and m - r = 2, as the table
% predicts, and every row dotted with every null space vector gives zero, up
% to rounding error of about 10^-15.

% --------------------------------------------------------------------------
% Chapter 17: Orthogonality and least squares
% --------------------------------------------------------------------------

%% Chapter 17, exercise 7
% A ball is thrown upwards, and its height h in metres is measured at times
% t = 0, 0.5, 1, 1.5, 2, 2.5 seconds as 2.1, 7.6, 11.3, 11.8, 10.5, 6.2. Fit
% the model h = c_0 + c_1t + c_2t^2 by least squares. Since h = h_0 + ut -
% (1/2)gt^2 for a ball thrown up with speed u, use your fit to estimate g,
% the acceleration due to gravity.

t = [0; 0.5; 1; 1.5; 2; 2.5];
h = [2.1; 7.6; 11.3; 11.8; 10.5; 6.2];
A = [ones(6, 1), t, t.^2];
c = A \ h
g = -2 * c(3)

% The fit is h ≈ 2.02 + 14.02t - 4.93t^2. Comparing with h_0 + ut -
% (1/2)gt^2 gives (1/2)g ≈ 4.93, so g ≈ 9.86 m/s², close to the true value
% of about 9.81.

% --------------------------------------------------------------------------
% Part III: Vector spaces review
% --------------------------------------------------------------------------

%% Part III, exercise 8
% Write a Gram–Schmidt function that takes a matrix and returns a matrix Q
% with orthonormal columns spanning the same space. Apply it to the columns
% (1, 1, 0)^T, (1, 0, 1)^T, (0, 1, 1)^T, check that Q^T Q = I, and compare Q
% with the built-in QR factorisation.

% Uses the chapter.

% Save the function as gram_schmidt.m:

% Then:

A = [1 1 0; 1 0 1; 0 1 1];
Q = gram_schmidt(A)
fprintf('Q''*Q = I: %d\n', norm(Q'*Q - eye(3)) < 1e-12)
[Q2, R2] = qr(A);
fprintf('Same columns up to sign: %d\n', norm(abs(Q2) - abs(Q)) < 1e-12)

% The built-in QR may choose the opposite sign for some columns. Either sign
% gives an orthonormal basis for the same space.

%% Functions
% MATLAB needs the functions used in a script to come at its end.

function Q = gram_schmidt(A)
    Q = zeros(size(A));
    for j = 1:size(A, 2)
        v = A(:, j) - Q(:, 1:j-1) * (Q(:, 1:j-1)' * A(:, j));   % remove projections
        Q(:, j) = v / norm(v);
    end
end
