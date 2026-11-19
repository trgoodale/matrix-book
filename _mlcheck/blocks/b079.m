K = [3 3; 2 5];
c = hill(K, 'HELP')
Kinv = inv26(K)
p = hill(Kinv, c)

% Known-plaintext attack (Example 3)
P = [7 11; 4 15]; C = [7 0; 8 19];
Kfound = mod(C * inv26(P), 26)

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
