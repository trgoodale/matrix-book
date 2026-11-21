for n = [25 50 100 200]
    steps = count_steps(n);
    fprintf('n = %3d: Jacobi %6d, Gauss-Seidel %6d, SOR %4d, CG %3d\n', n, steps);
end
