%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 38: Physics: rotations, inertia and quantum states
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/38-physics.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% The code finds the principal axes of four point masses in an L shape, and
% applies a quantum time evolution.

% Inertia tensor of four 1 kg masses in an L shape, about their centre of mass
r = [0 0 0; 1 0 0; 2 0 0; 0 1 0];
m = [1 1 1 1];
c = m * r / sum(m);                       % centre of mass
I = zeros(3);
for k = 1:numel(m)
    p = r(k, :) - c;
    I = I + m(k) * ((p * p') * eye(3) - p' * p);
end
I
[V, D] = eig(I)                           % principal axes and moments

% Spin up, evolving under sigma_x for omega t = pi/2
sx = [0 1; 1 0];
psi = expm(-1i * sx * pi/4) * [1; 0];
abs(psi).^2                               % probabilities of up and down along z

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-physics

%% Exercise 6
% A quantum computer applies the Hadamard gate H = (1/sqrt(2))[1 1; 1 -1] to
% a qubit. Check that H is symmetric and orthogonal, and that H^2 = I.
% Starting from (1, 0)^T, apply H, then a phase gate [1 0; 0 e^iφ], then H
% again, and plot the probability of measuring (1, 0)^T as φ runs from 0 to
% 2π. (This is the core of a quantum interferometer.)

% Your code here
