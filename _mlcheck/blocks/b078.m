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
