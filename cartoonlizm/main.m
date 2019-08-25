% ����ͼ�� Ĭ��demoΪ֮ǰ����ͼƬ
image = imread('demo.png');
 [filename, pathname] = uigetfile( ...
    {'*.jpg;*.bmp;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '��ѡ��ͼƬ', ...
    'MultiSelect', 'off');
image=imread( [pathname,filename]);
img_copy = image;
img_res = image;

% ����Ƿ��������
FDetect = vision.CascadeObjectDetector;  
face_dtect = step(FDetect,image); 

if isempty(face_dtect)
    % ������������
    saturation = 2;                                     % ���ñ��ͶȲ���
    edge_thresh = 0.05;  edge_operator = 'sobel';       % ���ñ�Ե������
    radius=10; sigma=[3, 0.1];                          % ����˫���˲����˲�����
else 
    % ����������
    saturation = 0.8;                                   % ���ñ��ͶȲ���
    edge_thresh = 0.002;    edge_operator = 'log';      % ���ñ�Ե������
    radius=20; sigma=[5, 0.1];                         % ����˫���˲����˲�����
end

% �������Ͷ�
img_sa = adj_sat(image, saturation);

% �������һ��0~1
img_f = (double(img_sa)) ./ 255;

% ˫���˲����˲�

img_f = bfilter2(img_f,10,sigma);
img_gray = rgb2gray(img_f);

% w = fspecial('gaussian',[5,5],1);
% w = fspecial('average',3);
% img_f = imfilter(img_sa,w,'replicate');
% img_f = (double(img_sa)) ./ 255;
% img_gray = rgb2gray(img_f); 

% ��Ե���
edge_mask = uint8(edge(img_gray, edge_operator, edge_thresh));  

% ������������Ӵֱ�Ե����
if ~isempty(face_dtect)
    se = strel('line',3,0);
    edge_mask = imdilate(edge_mask,se);
    for i=2:5
        img_f = bfilter2(img_f,radius,sigma);
    end
end
% ��˫ɫͼ��ת��Ϊuint8��ͼ����ͻ����ʾ��Ե
img_blur = uint8(img_f*255);

% �Ժ�ɫͻ����ʾ��Ե
img_res(:,:,1) = img_blur(:,:,1) - img_blur(:,:,1) .* edge_mask;
img_res(:,:,2) = img_blur(:,:,2) - img_blur(:,:,2) .* edge_mask;
img_res(:,:,3) = img_blur(:,:,3) - img_blur(:,:,3) .* edge_mask;

% ��ʾͼ��
figure;
subplot(121);
imshow(image);
subplot(122);
imshow(img_res);
