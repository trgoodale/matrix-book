function run_matlab_scripts(folder)
%RUN_MATLAB_SCRIPTS  Run every MATLAB script in code/matlab and report failures.
%
%   Run it from the book's root folder:
%
%       addpath(fullfile(pwd, 'tools')); run_matlab_scripts
%
%   Each script runs in its own workspace, with figures hidden, and its
%   printed output is kept quiet unless it fails. At the end, an error
%   lists any scripts that failed. The GitHub workflow check-code.yml runs
%   this on every push.

if nargin < 1
    folder = fullfile(pwd, 'code', 'matlab');
end
files = dir(fullfile(folder, '*.m'));
start = pwd;
restore = onCleanup(@() cd(start));        % return to the root folder however we leave
set(groot, 'DefaultFigureVisible', 'off');
inGithub = strcmp(getenv('GITHUB_ACTIONS'), 'true');

failed = {};
for k = 1:numel(files)
    name = files(k).name;
    cd(folder);                            % the scripts find ../../data from here
    tic;
    try
        evalc('runScript(name)');          % evalc keeps the script's output quiet
        fprintf('ok      %s  (%.0f s)\n', name, toc);
    catch err
        failed{end+1} = name; %#ok<AGROW>
        fprintf('FAILED  %s\n%s\n\n', name, err.message);
        if inGithub                        % show the error on the GitHub summary page
            line = scriptLine(err, name);
            fprintf('::error file=code/matlab/%s,line=%d::%s\n', name, line, ...
                    strrep(err.message, newline, ' '));
        end
    end
    close all force;
    cd(start);
end

fprintf('\n%d of %d scripts ran without errors.\n', numel(files) - numel(failed), numel(files));
if ~isempty(failed)
    error('These scripts failed: %s', strjoin(failed, ', '));
end
end


function runScript(name)
% Run one script in this function's workspace, so its variables (and any
% "clear") cannot touch the loop above.
run(name);
end


function line = scriptLine(err, name)
% The line of the script where the error happened, or 1 if it is not known.
line = 1;
[~, base] = fileparts(name);
for s = err.stack'
    [~, f] = fileparts(s.file);
    if strcmp(f, base)
        line = s.line;
        return
    end
end
end
