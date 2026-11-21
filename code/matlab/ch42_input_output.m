%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 42: Economics: input–output models
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/42-input-output.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code

A = [0.10 0.05 0.02; 0.20 0.35 0.10; 0.10 0.20 0.25];
d = [20; 150; 300];
L = inv(eye(3) - A);                 % the Leontief inverse
disp(round(L * 1000) / 1000)
multipliers = sum(L, 1)
x = (eye(3) - A) \ d                 % output for demand d: no inverse needed

e = [1.0 0.6 0.1];                   % direct emissions, kg CO2 per pound of output
f = e * L                            % footprints
total = e * x

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-input-output

%% Exercise 7
% In Example 4, manufacturers cut their direct emissions by 20%. Find the
% new footprints of all three products. Why does the footprint of food fall,
% although farms emit as much as before? Which product's footprint falls by
% the largest fraction?

% Your code here
