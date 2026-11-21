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
