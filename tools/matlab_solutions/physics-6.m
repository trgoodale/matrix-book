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
