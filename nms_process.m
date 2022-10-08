function nms_process( data_dir )
addpath('src/piotr_edges');
addpath('src/piotr_toolbox/');

tic;
disp('NMS process...')
img_dir = fullfile(data_dir, 'img');
if ~exist(img_dir, 'dir')
    error('%s not exist', data_dir);
end
nms_dir = fullfile(data_dir, 'nms');
if ~exist(nms_dir, 'dir')
    mkdir(nms_dir)
end

files = dir(fullfile(img_dir, '*.png'));
parfor i = 1:size(files, 1)
    x = double(imread(fullfile(img_dir, files(i).name))) / 255.0; 
    E = convTri(single(x),1);
    [Ox, Oy] = gradient2(convTri(E,4));
    [Oxx, ~] = gradient2(Ox); 
    [Oxy, Oyy] = gradient2(Oy);
    O = mod(atan(Oyy.*sign(-Oxy)./(Oxx+1e-5)),pi);
    E = edgesNmsMex(E,O,4,5,1.01,4);
    imwrite(uint8(E*255), fullfile(nms_dir, files(i).name))
end

toc;
end
