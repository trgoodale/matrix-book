T = [18.2 19.1 17.6; 19.5 20.3 18.4; 21.0 21.8 19.9; 22.4 23.0 21.2];
D = T - mean(T)              % the 1 x 3 row of means is expanded down the rows
sum(D)                       % zero, up to rounding
