[J, I] = meshgrid(1:6);       % I(i,j) = i and J(i,j) = j
H = 1 ./ (I + J - 1);
isequal(H, H')
isequal(H, hilb(6))
