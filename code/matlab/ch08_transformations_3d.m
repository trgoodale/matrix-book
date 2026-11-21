%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 8: Transformations in three dimensions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-1/08-transformations-3d.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code

Rx = @(t) [1 0 0; 0 cos(t) -sin(t); 0 sin(t) cos(t)];
Rz = @(t) [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];

q = pi/2;
clean = @(X) round(X * 1e10) / 1e10;   % remove rounding errors
clean(Rz(q) * Rx(q))
clean(Rx(q) * Rz(q))

% Check that a rotation is orthogonal with determinant 1
R = Rz(q) * Rx(q);
disp(norm(R' * R - eye(3)) < 1e-12), disp(det(R))

%%
% clean rounds to 10 decimal places, which removes tiny errors such as
% cos(π/2) ≈ 6 × 10^-17. The check uses norm, which measures the size of a
% matrix, so a tiny value means R^T R is I up to rounding error; 1 means
% true.

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part1.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-1.html#sec-solutions-transformations-3d

%% Exercise 6
% Aircraft orientation is often given as three angles: yaw ψ (turning left
% or right, about the vertical z-axis), pitch θ (nose up or down, about y)
% and roll φ (tilting the wings, about x), applied in the aircraft's own
% frame, which gives the matrix R_z(ψ)R_y(θ)R_x(φ). Compute this, R_1, for
% ψ= 30°, θ= 10°, φ= 5°, and compare it with the product in the reverse
% order, R_2. By how many degrees do the two orientations differ? (Hint: the
% rotation angle of an orthogonal matrix M with determinant 1 satisfies
% traceM = 1 + 2cosα, where the trace is the sum of the diagonal entries;
% apply this to M = R_1^T R_2.)

% Your code here
