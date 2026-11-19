p = [1; -1; 0] / sqrt(2);
q = [1; 1; -2] / sqrt(6);
u = [1; 1; 1] / sqrt(3);
P = [p q u];

Rz = [cosd(120) -sind(120) 0;
      sind(120)  cosd(120) 0;
      0 0 1];
round(P * Rz * P', 10)
