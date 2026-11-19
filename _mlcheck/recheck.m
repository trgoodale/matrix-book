% Re-runs the fixed truss solution and times the CG solution again.
if exist('recheck.txt', 'file'), delete('recheck.txt'); end
diary('recheck.txt');
set(groot, 'defaultFigureVisible', 'off');
recheck_truss
b030
b030
set(groot, 'defaultFigureVisible', 'on');
close all force
diary off
