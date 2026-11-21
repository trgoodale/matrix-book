%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part VI: Applications: solutions to the code exercises
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Worked solutions to the code exercises from Matrices in Practice, by Tom Goodale:
% https://trgoodale.github.io/matrix-book/appendices/solutions-6.html
%
% Run the script a section at a time (Run Section, or Ctrl+Enter, in
% MATLAB), from the top: later sections use variables set in earlier ones.
% Try each exercise yourself first. Change the numbers and run them again to see what happens.
%
% Code licensed under the MIT licence: https://trgoodale.github.io/matrix-book/LICENSE.md

%% Data
% The data files are in the book's repository. Use the local copy if there is
% one, otherwise read them from GitHub.
if isfile(fullfile('..', '..', 'data', 'iris.csv'))
    DATA = fullfile('..', '..', 'data');
else
    DATA = 'https://raw.githubusercontent.com/trgoodale/matrix-book/main/data';
end

% --------------------------------------------------------------------------
% Chapter 31: Structures: pin-jointed trusses
% --------------------------------------------------------------------------

%% Chapter 31, exercise 7
% For the Pratt bridge, move a 20 kN load to each of the three interior
% joints of the bottom chord in turn. For each member, find the largest
% tension and the largest compression it ever carries. Which members must be
% designed for both?

P = [0 0; 4 0; 8 0; 12 0; 16 0; 4 4; 8 4; 12 4];
members = [1 2; 2 3; 3 4; 4 5; 6 7; 7 8; 2 6; 3 7; 4 8; 1 6; 5 8; 6 3; 8 3];
supports = [1 2; 5 1];
F = zeros(3, size(members, 1));
for k = 1:3
    [A, b] = truss(P, members, supports, [k+1 0 -20]);
    f = A \ b;
    F(k, :) = f(1:size(members, 1))';
end
[max(F, [], 1); min(F, [], 1)]'      % largest and smallest force in each member

% The function truss from the chapter, repeated so that this script runs on its own

% Over the three load positions, the bottom chord carries 5 to 15 kN of
% tension, the top chord 10 to 20 kN of compression, and the end posts 7.07
% to 21.21 kN of compression. The two interior diagonals are the only
% members that change sign: each carries 14.14 kN of tension when the load
% is in the middle, or under it, but 7.07 kN of compression when the load is
% on the far side. They must be designed for both, which for a slender
% member in compression means guarding against buckling. The verticals at
% joints 1 and 3 carry 20 kN of tension when the load is directly on them,
% and the middle vertical never carries anything for these loads.

% --------------------------------------------------------------------------
% Chapter 32: Electrical circuits
% --------------------------------------------------------------------------

%% Chapter 32, exercise 6
% For the filter of Example 3, find the angular frequency at which
% |V_2/V_in| = 1/sqrt(2), by solving the complex system at many frequencies
% or with a root finder.

% The book gives this solution in Python. Here is a MATLAB version.

R = 1e3; C = 1e-6;
gain = @(w) abs([0 1] * ([2/R + 1i*w*C, -1/R; -1/R, 1/R + 1i*w*C] \ [1/R; 0]));
w3 = fzero(@(w) gain(w) - 1/sqrt(2), [1 1e4])
f3 = w3 / (2*pi)                       % in Hz

% In MATLAB, fzero(@(w) gain(w) - 1/sqrt(2), [1 1e4]) does the same, with
% gain defined as a function that builds and solves the same complex system.
% The output falls to 1/sqrt(2) of the input (the cut-off or -3 dB point) at
% ω ≈ 374 rad/s, about 60 Hz: well below 1/(RC) = 1000 rad/s, because the
% second stage loads the first.

% --------------------------------------------------------------------------
% Chapter 33: Heat flow and finite differences
% --------------------------------------------------------------------------

%% Chapter 33, exercise 6
% Solve the plate problem with the top at 100 °C and the other edges at 0 °C
% for n = 10, 20, 40, 80, with a sparse direct solver and with CG. Record
% the time taken and the number of CG steps. How does the number of CG steps
% grow with n? Plot the temperature along the vertical centre line for n =
% 80.

for n = [10 20 40 80]
    e = ones(n, 1);
    T = spdiags([-e 2*e -e], -1:1, n, n);
    A = kron(speye(n), T) + kron(T, speye(n));
    b = zeros(n); b(1, :) = 100;
    tic; u = A \ b(:); td = toc;
    tic; [x, flag, relres, iters] = pcg(A, b(:), 1e-8, 1000); tc = toc;
    fprintf('n = %3d: direct %.4f s, CG %.4f s in %d steps\n', n, td, tc, iters);
end
U = reshape(u, n, n);
plot(linspace(0, 1, n), U(:, round(n/2)))    % temperature down the centre line

% The number of CG steps roughly doubles each time n doubles, so it grows
% like n, the square root of the condition number (which grows like n^2).
% Timings vary between computers, but at these small sizes the direct solver
% is as fast as CG or faster (in some versions of MATLAB, pcg is much slower
% than backslash at n = 80). CG pulls ahead only for much larger problems,
% especially three-dimensional ones, where direct elimination fills in
% badly. Along the centre line, the temperature falls from 100 °C at the hot
% edge to 0 at the opposite edge, steeply near the hot edge and gently
% further away: by the middle of the plate it is already down to 25 °C, as
% Example 3 showed.

% --------------------------------------------------------------------------
% Chapter 34: Computer graphics and robotics
% --------------------------------------------------------------------------

%% Chapter 34, exercise 6
% For the two-link arm of Example 4, plot the hand's position as θ_1 runs
% from 0° to 360° with θ_2 fixed at 60°, and again for θ_2 = 120°. Then plot
% the region reached when both angles vary, and compare with the annulus
% drawn in the app.

% The book gives this solution in Python. Here is a MATLAB version.

L1 = 1.5; L2 = 1.0;
t1 = 0:360;
figure; hold on
for t2 = [60 120]
    x = L1 * cosd(t1) + L2 * cosd(t1 + t2);
    y = L1 * sind(t1) + L2 * sind(t1 + t2);
    plot(x, y, 'DisplayName', sprintf('theta_2 = %d', t2))
end
[T1, T2] = meshgrid(0:4:360);
scatter(L1*cosd(T1(:)) + L2*cosd(T1(:) + T2(:)), L1*sind(T1(:)) + L2*sind(T1(:) + T2(:)), 1, [0.7 0.7 0.7], ...
        'DisplayName', 'reachable')
axis equal; legend show; hold off

% With θ_2 fixed, the hand moves on a circle about the base, of radius
% sqrt(L_1^2 + L_2^2 + 2L_1L_2cosθ_2): about 2.18 for 60° and 1.32 for 120°.
% Letting both angles vary fills the annulus between radii L_1 - L_2 = 0.5
% and L_1 + L_2 = 2.5, as drawn in the app. MATLAB code follows the same
% steps, with cosd and sind.

% --------------------------------------------------------------------------
% Chapter 35: Markov chains and PageRank
% --------------------------------------------------------------------------

%% Chapter 35, exercise 6
% Write a PageRank function that handles dead ends, by treating a page with
% no links as linking to every page. Apply it to the Dead end web of the app
% (A links to B and C; B to C; C to nothing; D to A and C; E to D and F; F
% to D and E), and check your results against the app.

links = {[2 3], 3, [], [1 3], [4 6], [4 5]};   % 1-based page numbers
n = numel(links); d = 0.85;
x = ones(n, 1) / n;
for step = 1:200
    y = (1 - d) / n * ones(n, 1);
    for j = 1:n
        if isempty(links{j})
            y = y + d * x(j) / n;           % dead end: jump anywhere
        else
            y(links{j}) = y(links{j}) + d * x(j) / numel(links{j});
        end
    end
    x = y;
end
round(x', 3)

% The result, about (0.143, 0.130, 0.314, 0.172, 0.121, 0.121), matches the
% app. C, the dead end, ranks highest: three pages link to it, and since the
% surfer leaves it by a random jump, its rank is shared out evenly instead
% of being passed to any one page.

% --------------------------------------------------------------------------
% Chapter 36: Population models
% --------------------------------------------------------------------------

%% Chapter 36, exercise 6
% For the loggerhead model, project the population for 100 years from 1000
% eggs and hatchlings and nothing else. Plot the total population on a
% logarithmic scale. After the first few decades, what is its slope, and how
% does it relate to λ? How many years does it take for the proportion in
% each stage to come within 1% of the stable distribution?

% The book gives this solution in Python. Here is a MATLAB version.

A = [0      0      0      0      127    4      80;
     0.6747 0.7370 0      0      0      0      0;
     0      0.0486 0.6610 0      0      0      0;
     0      0      0.0147 0.6907 0      0      0;
     0      0      0      0.0518 0      0      0;
     0      0      0      0      0.8091 0      0;
     0      0      0      0      0      0.8091 0.8089];
[V, E] = eig(A);
[lambda, k] = max(real(diag(E)));
stable = real(V(:, k)) / sum(real(V(:, k)));

x = [1000; 0; 0; 0; 0; 0; 0];
totals = zeros(100, 1); gaps = zeros(100, 1);
for year = 1:100
    x = A * x;
    totals(year) = sum(x);
    gaps(year) = max(abs(x / sum(x) - stable));
end
figure; semilogy(1:100, totals)
xlabel('year'); ylabel('total population')
slope = log(totals(100) / totals(90)) / 10     % compare with log(lambda)
log(lambda)
settled = find(gaps >= 0.01, 1, 'last') + 1    % within 1% from this year on

% After the first two decades the total falls along a straight line on the
% log scale, with slope lnλ= ln0.945 ≈ -0.0565 per year. The proportions
% come within 1% of the stable distribution, and stay there, after 20 years.
% Early on, the total behaves quite differently, because the eggs take years
% to grow into breeders. MATLAB code follows the same steps with semilogy.

% --------------------------------------------------------------------------
% Chapter 37: Data: regression and dimensionality reduction
% --------------------------------------------------------------------------

%% Chapter 37, exercise 6
% Fit sepal length on all three other measurements. Then refit using only
% the 50 setosa flowers. Compare the coefficients and their signs, and the
% condition numbers of the two design matrices. What does this suggest about
% fitting one model to data from several groups?

% The book gives this solution in Python. Here is a MATLAB version.

T = readtable([DATA '/iris.csv']);
X = T{:, 1:4};
setosa = strcmp(T{:, 5}, 'setosa');
groups = {true(150, 1), setosa};
names = {'all flowers', 'setosa only'};
for g = 1:2
    rows = groups{g};
    A = [ones(sum(rows), 1), X(rows, 2:4)];
    beta = A \ X(rows, 1);
    fprintf('%s: %s, cond = %.1f\n', names{g}, mat2str(round(beta', 3)), cond(A));
end

% For all 150 flowers, the coefficient of petal width is negative (-0.556);
% for setosa alone, all three coefficients are positive. The condition
% numbers are similar (about 50), so this is not just collinearity: the
% pooled model mixes three species, and the relationships within each
% species differ from the pattern between species. This is a version of
% Simpson's paradox. Fitting one model to data from distinct groups can give
% coefficients that describe none of them; including the group as a
% variable, or fitting each group separately, is safer.

% --------------------------------------------------------------------------
% Chapter 38: Physics: rotations, inertia and quantum states
% --------------------------------------------------------------------------

%% Chapter 38, exercise 6
% A quantum computer applies the Hadamard gate H = (1/sqrt(2))[1 1; 1 -1] to
% a qubit. Check that H is symmetric and orthogonal, and that H^2 = I.
% Starting from (1, 0)^T, apply H, then a phase gate [1 0; 0 e^iφ], then H
% again, and plot the probability of measuring (1, 0)^T as φ runs from 0 to
% 2π. (This is the core of a quantum interferometer.)

% The book gives this solution in Python. Here is a MATLAB version.

H = [1 1; 1 -1] / sqrt(2);
[isequal(H, H'), norm(H'*H - eye(2)) < 1e-12, norm(H*H - eye(2)) < 1e-12]
phis = linspace(0, 2*pi, 200);
p0 = zeros(size(phis));
for k = 1:numel(phis)
    phase = diag([1, exp(1i * phis(k))]);
    psi = H * phase * H * [1; 0];
    p0(k) = abs(psi(1))^2;
end
figure; plot(phis, p0)
xlabel('\phi'); ylabel('P(measure (1, 0))')

% H is symmetric and orthogonal, and so H^2 = H^T H = I. The probability is
% cos^2(φ/2): 1 when φ= 0 (the two Hadamard gates undo each other), 0 when
% φ= π, and in between in a smooth interference pattern. The first H splits
% the state into an equal combination of the two basis states, the phase
% shifts one relative to the other, and the second H recombines them, so
% that they add or cancel depending on φ, like light in an interferometer.

% --------------------------------------------------------------------------
% Chapter 39: Cryptography: the Hill cipher
% --------------------------------------------------------------------------

%% Chapter 39, exercise 6
% The ciphertext FRFMKCFRJGBF was encrypted with an unknown 2 × 2 Hill key,
% and you know the message begins with ATTA. Find the key and decrypt the
% whole message.

% The book gives this solution in Python. Here is a MATLAB version.

cipher = 'FRFMKCFRJGBF';
P = reshape(double('ATTA') - 65, 2, 2);          % known plaintext pairs as columns
C = reshape(double(cipher(1:4)) - 65, 2, 2);
K = mod(C * inv26(P), 26)
message = hill(inv26(K), cipher)

% The known pairs AT and TA give P = [0 19; 19 0], with determinant -361 ≡
% 3, which is invertible. The key is [3 3; 2 5], and the message is
% ATTACKATDAWN. In MATLAB, the functions hill and inv26 from the chapter do
% the same in three lines.

% --------------------------------------------------------------------------
% Chapter 40: Vibrations and normal modes
% --------------------------------------------------------------------------

%% Chapter 40, exercise 7
% For n equal masses m joined by n + 1 equal springs k between two walls,
% the natural frequencies are
% ω_j = 2sqrt(k/m) sin(jπ/2(n + 1)),
% j = 1, ..., n.
% Check this numerically for n = 10, m = 1 and k = 100. Plot the first three
% mode shapes for n = 30. What shapes are they, and what physical object
% does a long chain of masses and springs approximate?

m = 1; k = 100; n = 10;
K = k * (2*eye(n) - diag(ones(n-1, 1), 1) - diag(ones(n-1, 1), -1));
omega = sqrt(eig(K) / m);                         % M = m*I, so an ordinary eigenproblem
exact = 2*sqrt(k/m) * sin((1:n)' * pi / (2*(n+1)));
fprintf('agree: %d\n', max(abs(omega - exact)) < 1e-12)

n = 30;                                           % mode shapes for a longer chain
K = 2*eye(n) - diag(ones(n-1, 1), 1) - diag(ones(n-1, 1), -1);
[V, ~] = eig(K);
plot(1:n, V(:, 1:3), 'o-')
xlabel('mass number'); ylabel('displacement'); legend('mode 1', 'mode 2', 'mode 3')

% The mode shapes are samples of sine curves: half a wave for mode 1, a
% whole wave for mode 2, one and a half for mode 3, each zero at the walls
% (the signs may be flipped). A long chain of masses and springs
% approximates a stretched string, such as a guitar string, whose modes are
% exactly these sines, with frequencies in the ratio 1 : 2 : 3 for the low
% modes. The matrix is the finite difference matrix of Chapter 33.

% --------------------------------------------------------------------------
% Chapter 41: Networks and graphs
% --------------------------------------------------------------------------

%% Chapter 41, exercise 7
% Make a random network with two hidden communities of 50 nodes each: join
% each pair of nodes in the same community with probability 0.3, and each
% pair in different communities with probability 0.05. Find the Fiedler
% vector, split the nodes by its signs, and count how many nodes end up in
% the right group. Repeat with a between-community probability of 0.15. What
% happens, and why?

rng(1)
n = 100;
group = [zeros(50, 1); ones(50, 1)];
for p_out = [0.05 0.15]
    P = p_out * ones(n);
    P(group == group') = 0.3;                     % same community
    A = triu(rand(n) < P, 1);
    A = double(A + A');                           % each pair joined at most once
    L = diag(sum(A, 2)) - A;
    [V, D] = eig(L);
    guess = V(:, 2) > 0;
    correct = max(sum(guess == group), sum(guess ~= group));  % the labels may be swapped
    fprintf('p_out = %.2f: lambda2 = %.2f, %d of %d correct\n', p_out, D(2, 2), correct, n)
end

% The results depend on the random numbers, so MATLAB's differ from
% Python's. With between-community probability 0.05, the Fiedler vector puts
% all, or almost all, of the 100 nodes in the right group. With 0.15, only
% about 60 to 90 are right, depending on the random network (half would be
% right by pure chance). Each node then has about 15 neighbours in its own
% community and 7.5 in the other, so the communities are much less distinct:
% many nodes have almost as many links across as within, and random
% variation decides which side they fall. As the two probabilities approach
% each other, the hidden communities become impossible to detect by any
% method.

% --------------------------------------------------------------------------
% Chapter 42: Economics: input–output models
% --------------------------------------------------------------------------

%% Chapter 42, exercise 7
% In Example 4, manufacturers cut their direct emissions by 20%. Find the
% new footprints of all three products. Why does the footprint of food fall,
% although farms emit as much as before? Which product's footprint falls by
% the largest fraction?

A = [0.10 0.05 0.02; 0.20 0.35 0.10; 0.10 0.20 0.25];
L = inv(eye(3) - A);
e = [1.0 0.6 0.1];
e_new = e .* [1 0.8 1];                           % manufacturing cuts by 20%
f = e * L;  f_new = e_new * L;
fprintf('%.3f ', f); fprintf('\n')
fprintf('%.3f ', f_new); fprintf('\n')
fprintf('%.1f%% ', 100 * (f - f_new) ./ f); fprintf('lower\n')

% The footprints fall from about (1.40, 1.13, 0.32) to (1.35, 0.93, 0.29) kg
% per £1. Food's footprint falls, although farms emit as much as before,
% because farming buys manufactured goods: 20p of them per £1 of output,
% such as fertiliser and machinery, whose emissions are part of food's
% supply chain. Manufactured goods fall most, by 17%, a little less than 20%
% because part of their footprint comes from their agricultural and service
% inputs. Services fall by 9%, through the manufactured goods they buy.
% Cutting emissions anywhere in a supply chain lowers the footprint of
% everything downstream.

% --------------------------------------------------------------------------
% Part VI: Applications review
% --------------------------------------------------------------------------

%% Part VI, exercise 11
% Five web pages link as follows: A links to B; B links to A and C; C links
% to A; D links to C and E; E links to D. Find the PageRank with damping d =
% 0.85 by the power method, counting the iterations needed, and check it by
% solving a linear system. Explain why D and E rank lowest, even though they
% link to each other.

% Uses Chapter 35, Chapter 29 and Chapter 26.

links = {2, [1 3], 1, [3 5], 4};    % page j links to the pages in links{j}
n = 5;  d = 0.85;
M = zeros(n);
for j = 1:n
    M(links{j}, j) = 1 / numel(links{j});
end
x = ones(n, 1) / n;
for k = 1:1000
    x_new = d*M*x + (1 - d)/n;
    if norm(x_new - x, 1) < 1e-10, break, end
    x = x_new;
end
x = x_new;
fprintf('%d iterations\n', k)
fprintf('%.4f ', x); fprintf('\n')
y = (eye(n) - d*M) \ ((1 - d)/n * ones(n, 1));
fprintf('%.4f ', y); fprintf('\n')

% The ranks, A to E, are 0.333, 0.313, 0.200, 0.087 and 0.067, and the
% linear system agrees. The power method took 43 steps, in line with the
% error shrinking by a factor of about 0.85 per step. D and E rank lowest
% because no page outside the pair links to them: all they receive is the
% random jumps and what they pass to each other, and D leaks half of its
% rank to C.

%% Functions
% MATLAB needs the functions used in a script to come at its end.

function [A, b] = truss(P, members, supports, loads)
% Equilibrium matrix A and right-hand side for a pin-jointed truss.
% Unknowns: member forces (tension positive), then reactions.
nj = size(P, 1); nm = size(members, 1);
reac = [];
for s = 1:size(supports, 1)
    j = supports(s, 1);
    if supports(s, 2) == 2, reac = [reac; j 1; j 2]; else, reac = [reac; j 2]; end
end
A = zeros(2*nj, nm + size(reac, 1));
for k = 1:nm
    i = members(k, 1); j = members(k, 2);
    e = (P(j,:) - P(i,:)) / norm(P(j,:) - P(i,:));
    A(2*i-1:2*i, k) = A(2*i-1:2*i, k) + e';   % member pulls joint i towards j
    A(2*j-1:2*j, k) = A(2*j-1:2*j, k) - e';   % and joint j towards i
end
for r = 1:size(reac, 1)
    A(2*reac(r,1) - 2 + reac(r,2), nm + r) = 1;
end
b = zeros(2*nj, 1);
for l = 1:size(loads, 1)
    b(2*loads(l,1)-1:2*loads(l,1)) = -loads(l, 2:3)';
end
end

function out = hill(K, msg)
% Encrypt (or, with the inverse key, decrypt) a message of even length.
v = reshape(double(msg) - 65, 2, []);      % pairs as columns
out = char(mod(K * v, 26) + 65);
out = out(:)';
end

function Kinv = inv26(K)
% The inverse of a 2 x 2 key modulo 26.
d = mod(round(det(K)), 26);
[g, u] = gcd(d, 26);
if g ~= 1, error('Key not invertible mod 26'); end
Kinv = mod(mod(u, 26) * [K(2,2) -K(1,2); -K(2,1) K(1,1)], 26);
end
