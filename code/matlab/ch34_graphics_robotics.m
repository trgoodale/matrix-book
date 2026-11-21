%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 34: Computer graphics and robotics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/34-graphics-robotics.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code

M = trans(2, 1) * rot(90) * trans(-2, -1)
M * [3; 1; 1]

% Forward kinematics of Example 4
T = rot(30) * trans(1.5, 0) * rot(60) * trans(1, 0);
hand = T(1:2, 3)

% Apply M to every corner of a house at once: corners as columns
house = [2 4 4 3 2 2; 1 1 3 4 3 1; 1 1 1 1 1 1];
moved = M * house;
plot(house(1,:), house(2,:), moved(1,:), moved(2,:)), axis equal

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-graphics-robotics

%% Exercise 6
% For the two-link arm of Example 4, plot the hand's position as θ_1 runs
% from 0° to 360° with θ_2 fixed at 60°, and again for θ_2 = 120°. Then plot
% the region reached when both angles vary, and compare with the annulus
% drawn in the app.

% Your code here

%% Functions
% MATLAB needs the functions used in a script to come at its end.

function M = trans(a, b)
M = [1 0 a; 0 1 b; 0 0 1];
end

function M = rot(deg)
M = [cosd(deg) -sind(deg) 0; sind(deg) cosd(deg) 0; 0 0 1];
end
