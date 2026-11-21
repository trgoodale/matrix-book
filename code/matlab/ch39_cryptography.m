%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 39: Cryptography: the Hill cipher
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code for this chapter from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/part-6/39-cryptography.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% In code
% Python's built-in pow(a, -1, 26) finds an inverse modulo 26 (and raises an
% error if there is none). In MATLAB, [g, u] = gcd(a, 26) gives the greatest
% common divisor g, and when g is 1, u is an inverse of a.

K = [3 3; 2 5];
c = hill(K, 'HELP')
Kinv = inv26(K)
p = hill(Kinv, c)

% Known-plaintext attack (Example 3)
P = [7 11; 4 15]; C = [7 0; 8 19];
Kfound = mod(C * inv26(P), 26)

%% Exercises
% The code exercises from the end of the chapter. Worked solutions are in
% solutions_part6.m, and in the book:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html#sec-solutions-cryptography

%% Exercise 6
% The ciphertext FRFMKCFRJGBF was encrypted with an unknown 2 × 2 Hill key,
% and you know the message begins with ATTA. Find the key and decrypt the
% whole message.

% Your code here

%% Functions
% MATLAB needs the functions used in a script to come at its end.

function out = hill(K, msg)
% Encrypt (or, with the inverse key, decrypt) a message of even length.
v = reshape(double(msg) - 65, 2, []);      % pairs as columns
out = char(mod(K * v, 26) + 65);
out = out(:)';
end

function Kinv = inv26(K)
d = mod(round(det(K)), 26);
[g, u] = gcd(d, 26);
if g ~= 1, error('Key not invertible mod 26'); end
Kinv = mod(mod(u, 26) * [K(2,2) -K(1,2); -K(2,1) K(1,1)], 26);
end
