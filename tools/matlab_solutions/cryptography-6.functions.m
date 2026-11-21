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
