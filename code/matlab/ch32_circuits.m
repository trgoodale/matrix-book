%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 32: Electrical circuits
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/32-circuits.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code

% Example 1: nodal analysis
G = [0.3 -0.2 0; -0.2 0.5 -0.2; 0 -0.2 0.3];
v = G \ [3; 0; 0]

% Example 2: modified nodal analysis with a 12 V source at node 1
M = [G, [1; 0; 0]; 1 0 0 0];
x = M \ [0; 0; 0; 12]                 % V1, V2, V3, Is

% Example 3: a complex system for the AC filter
R = 1e3; C = 1e-6; w = 1000;
Y = [2/R + 1i*w*C, -1/R; -1/R, 1/R + 1i*w*C];
V = Y \ [1/R; 0]
[abs(V), rad2deg(angle(V))]           % amplitudes and phases

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-circuits

%% Exercise 6
% For the filter of Example 3, find the angular frequency at which
% |V_2/V_in| = 1/sqrt(2), by solving the complex system at many frequencies
% or with a root finder.

% Your code here
