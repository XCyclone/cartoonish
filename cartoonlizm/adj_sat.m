function img = adj_sat(img, saturation)

    img_double = double(img);
    img_gray = double(rgb2gray(img));
    img_template = img_double;
    
    % 使用原始图像的灰度版本作为模板来完成插值和外推
    img_template(:,:,1) = img_gray;
    img_template(:,:,2) = img_gray;
    img_template(:,:,3) = img_gray;
    
    % 实现插值和外推
    img = (1-saturation).*img_template + saturation.*img_double;
    
    img = uint8(img);
end