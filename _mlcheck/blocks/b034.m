% Temperature readings: rows are times, columns are sensors
T = [18.2 19.1 17.6;
     19.5 20.3 18.4;
     21.0 21.8 19.9;
     22.4 23.0 21.2];

size(T)        % rows, columns
T(2,3)         % row 2, column 3
T(:,1)         % all of column 1: sensor 1
T'             % the transpose
