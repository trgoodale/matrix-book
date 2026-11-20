function run_new_checks()
% Runs each new block in its own workspace and saves output to new_results\<name>.txt
here = fileparts(mfilename('fullpath'));
cd(here); addpath(here);
if ~exist('new_results', 'dir'), mkdir('new_results'); end
names = {'nb01', 'nb02', 'nb03', 'nb04', 'nb05', 'nb06', 'nb07', 'nb08', 'nb09', 'nb11', 'nb12', 'nb13'};
for ii = 1:numel(names)
    txt = run_one(fullfile(here, [names{ii} '.m']));
    fid = fopen(fullfile(here, 'new_results', [names{ii} '.txt']), 'w');
    fwrite(fid, txt); fclose(fid);
    close all
end
disp('new checks done')
end

function txt__ = run_one(file__)
try
    txt__ = evalc('run(file__)');
catch err__
    txt__ = ['ERROR: ' err__.message];
end
end
