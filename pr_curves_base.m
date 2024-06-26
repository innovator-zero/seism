addpath(genpath('src/'))

% Write results in format to use latex code?
writePR = 0;

% Precision-recall measures
measures = {'fb',...  % Precision-recall for boundaries
    'fop'};   % Precision-recall for Object Proposals

% Define all methods to be compared
methods  = [];
gt_set   = 'val';
%%% TODO: Add your own method to be tested
methods(end).io_func = @read_one_png;
methods(end).type = 'contour';

% Colors to display
colors = {'b','g','r','k','m','c','y','b','g','r','k','m','c','y','k','g','b','g','r'};

tic;
% % Evaluate using the correct reading function
for ii=1:length(measures)
    for jj=1:length(methods)
        % Contours only in 'fb'
        is_cont = strcmp(methods(jj).type,'contour');
        if strcmp(measures{ii},'fb') || ~is_cont
            if exist('cat_id','var')
                eval_method_all_params(methods(jj).name, methods(jj).dir, measures{ii}, methods(jj).io_func, database, gt_set, is_cont, cat_id);
            else
                eval_method_all_params(methods(jj).name, methods(jj).dir, measures{ii}, methods(jj).io_func, database, gt_set, is_cont);
            end
        end
    end
end

for kk=1:length(measures)
    % Plot methods
    for ii=1:length(methods)
        if strcmp(measures{kk},'fb') || strcmp(methods(ii).type,'segmentation')
            fprintf([methods(ii).name ': ' repmat(' ',[1,15-length(methods(ii).name)])]);

            if strcmp(methods(ii).type,'contour'),style='--';else, style='-';end

            params = get_method_parameters(methods(ii).name);
            curr_meas = gather_measure(methods(ii).name,params,measures{kk},database,gt_set);
            
            curr_ods  = general_ods(curr_meas);
            curr_ois  = general_ois(curr_meas);
            curr_ap   = general_ap(curr_meas);
            %%% TODO filename_format = output file path
            disp(filename)
    	    fileID = fopen(filename, 'w');
    	    fprintf(fileID, ['odsF:' sprintf('%0.4f',curr_ods.mean_value) '\n' 'oisF:' sprintf('%0.4f',curr_ois.mean_value) '\n' 'AP:' sprintf('%0.4f',curr_ap) '\n']);
    	    fclose(fileID);
        end
    end
end
toc;
