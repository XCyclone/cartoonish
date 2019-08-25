function img = adj_sat(img, saturation)

    img_double = double(img);
    img_gray = double(rgb2gray(img));
    img_template = img_double;
    
    % ʹ��ԭʼͼ��ĻҶȰ汾��Ϊģ������ɲ�ֵ������
    img_template(:,:,1) = img_gray;
    img_template(:,:,2) = img_gray;
    img_template(:,:,3) = img_gray;
    
    % ʵ�ֲ�ֵ������
    img = (1-saturation).*img_template + saturation.*img_double;
    
    img = uint8(img);
end