%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 28: Newton's method for nonlinear systems
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-5/28-newton-systems.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code

f = @(v) [v(1)^2 + v(2)^2 - 4; v(1)*v(2) - 1];
J = @(v) [2*v(1), 2*v(2); v(2), v(1)];

x = [2; 0.5];
for k = 0:4
    fprintf('%d  %.12f  %.12f  %.1e\n', k, x(1), x(2), norm(f(x)));
    x = x - J(x) \ f(x);                      % solve, don't invert
end

% Library solver: fsolve is in the Optimization Toolbox (and built into Octave)
if exist('fsolve', 'file')
    x = fsolve(f, [2; 0.5], optimset('Display', 'off'))
else
    disp('fsolve needs the Optimization Toolbox, which is not installed.')
end

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part5.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-5.html#sec-solutions-newton-systems

%% Exercise 7
% Write a Newton solver that approximates the Jacobian by finite
% differences, and use it to find all the intersections of x^2 + 4y^2 = 4
% and y = sin(2x). Try several starting points, and compare the number of
% steps needed with the exact-Jacobian version.

% Your code here
