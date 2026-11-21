cipher = 'FRFMKCFRJGBF';
P = reshape(double('ATTA') - 65, 2, 2);          % known plaintext pairs as columns
C = reshape(double(cipher(1:4)) - 65, 2, 2);
K = mod(C * inv26(P), 26)
message = hill(inv26(K), cipher)
