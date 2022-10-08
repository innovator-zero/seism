% ------------------------------------------------------------------------ 
%  Copyright (C)
%  ETHZ - Computer Vision Lab
% 
%  Jordi Pont-Tuset <jponttuset@vision.ee.ethz.ch>
%  September 2015
% ------------------------------------------------------------------------ 
% This file is part of the BOP package presented in:
%    Pont-Tuset J, Van Gool, Luc,
%    "Boosting Object Proposals: From Pascal to COCO"
%    International Conference on Computer Vision (ICCV) 2015.
% Please consider citing the paper if you use this code.
% ------------------------------------------------------------------------
function db_root_dir = db_root_dir( database )
if strcmp(database, 'PASCALContext')
    db_root_dir = '/data/PASCAL_MT/Context';
elseif strcmp(database, 'NYUD')
    db_root_dir = '/data/NYUDv2/edge_mat';
else
    error(['Unknown database: ' database]);
end

end

