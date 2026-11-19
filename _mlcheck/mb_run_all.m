function mb_run_all()
% Runs every MATLAB block from the book and writes results.json next to this file.
% Pass 1 runs the blocks of each page in order, sharing one workspace (as a reader would).
% Pass 2 runs every block on its own, in a fresh workspace, to find hidden dependencies.
here = fileparts(mfilename('fullpath'));
root = fileparts(here);
addpath(fullfile(here, 'blocks'));
oldVis = get(groot, 'defaultFigureVisible');
set(groot, 'defaultFigureVisible', 'off');
cleanup = onCleanup(@() mb_restore(oldVis, here));
M = mb_manifest();
results = struct('name', {}, 'qmd', {}, 'pass', {}, 'ok', {}, 'err', {}, 'out', {}, 'secs', {});
for g = 1:size(M, 1)
    fprintf('Page %d of %d: %s\n', g, size(M, 1), M{g, 1});
    R = mb_run_group(M{g, 3}, fullfile(root, M{g, 2}));
    for k = 1:numel(R)
        R(k).qmd = M{g, 1}; R(k).pass = 'shared';
    end
    results = [results, R]; %#ok<AGROW>
    for k = 1:numel(M{g, 3})
        R1 = mb_run_group(M{g, 3}(k), fullfile(root, M{g, 2}));
        R1.qmd = M{g, 1}; R1.pass = 'fresh';
        results = [results, R1]; %#ok<AGROW>
    end
end
info = struct('version', version, 'release', version('-release'), ...
    'toolboxes', {{ver().Name}}, 'results', results);
fid = fopen(fullfile(here, 'results.json'), 'w', 'n', 'UTF-8');
fwrite(fid, jsonencode(info), 'char');
fclose(fid);
fprintf('Done: %d runs written to results.json\n', numel(results));
end

function mbR__ = mb_run_group(mbFiles__, mbDir__)
% Runs scripts in this function's workspace, from the page's folder.
mbHere__ = pwd;
cd(mbDir__);
mbR__ = struct('name', {}, 'qmd', {}, 'pass', {}, 'ok', {}, 'err', {}, 'out', {}, 'secs', {});
for mbK__ = 1:numel(mbFiles__)
    mbT__ = tic;
    try
        mbOut__ = evalc(mbFiles__{mbK__});
        mbOk__ = true; mbErr__ = '';
    catch mbME__
        mbOut__ = ''; mbOk__ = false;
        mbErr__ = getReport(mbME__, 'extended', 'hyperlinks', 'off');
    end
    mbR__(end + 1) = struct('name', mbFiles__{mbK__}, 'qmd', '', 'pass', '', 'ok', mbOk__, ...
        'err', mbErr__, 'out', mbOut__, 'secs', toc(mbT__)); %#ok<AGROW>
    close all force
end
cd(mbHere__);
end

function mb_restore(oldVis, here)
set(groot, 'defaultFigureVisible', oldVis);
rmpath(fullfile(here, 'blocks'));
end
