% 读入图像 默认demo为之前拍摄图片
image = imread('demo.png');
 [filename, pathname] = uigetfile( ...
    {'*.jpg;*.bmp;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '请选择图片', ...
    'MultiSelect', 'off');
image=imread( [pathname,filename]);
img_copy = image;
img_res = image;

% 检测是否存在人脸
FDetect = vision.CascadeObjectDetector;  
face_dtect = step(FDetect,image); 

if isempty(face_dtect)
    % 若不存在人脸
    saturation = 2;                                     % 设置饱和度参数
    edge_thresh = 0.05;  edge_operator = 'sobel';       % 设置边缘检测参数
    radius=10; sigma=[3, 0.1];                          % 设置双边滤波器滤波参数
else 
    % 若存在人脸
    saturation = 0.8;                                   % 设置饱和度参数
    edge_thresh = 0.002;    edge_operator = 'log';      % 设置边缘检测参数
    radius=20; sigma=[5, 0.1];                         % 设置双边滤波器滤波参数
end

% 调整饱和度
img_sa = adj_sat(image, saturation);

% 将矩阵归一到0~1
img_f = (double(img_sa)) ./ 255;

% 双边滤波器滤波

img_f = bfilter2(img_f,10,sigma);
img_gray = rgb2gray(img_f);

% w = fspecial('gaussian',[5,5],1);
% w = fspecial('average',3);
% img_f = imfilter(img_sa,w,'replicate');
% img_f = (double(img_sa)) ./ 255;
% img_gray = rgb2gray(img_f); 

% 边缘检测
edge_mask = uint8(edge(img_gray, edge_operator, edge_thresh));  

% 若存在人脸则加粗边缘线条
if ~isempty(face_dtect)
    se = strel('line',3,0);
    edge_mask = imdilate(edge_mask,se);
    for i=2:5
        img_f = bfilter2(img_f,radius,sigma);
    end
end
% 将双色图像转换为uint8型图像以突出显示边缘
img_blur = uint8(img_f*255);

% 以黑色突出显示边缘
img_res(:,:,1) = img_blur(:,:,1) - img_blur(:,:,1) .* edge_mask;
img_res(:,:,2) = img_blur(:,:,2) - img_blur(:,:,2) .* edge_mask;
img_res(:,:,3) = img_blur(:,:,3) - img_blur(:,:,3) .* edge_mask;

% 显示图像
figure;
subplot(121);
imshow(image);
subplot(122);
imshow(img_res);
