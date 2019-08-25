% 获取PC信息
imaqhwinfo
obj = videoinput('winvideo');
set(obj, 'FramesPerTrigger', 1);
set(obj, 'TriggerRepeat', Inf);

% 定义监控界面
hf = figure('Units', 'Normalized', 'Menubar', 'None','NumberTitle', 'off', 'Name', '拍照系统');
ha = axes('Parent', hf, 'Units', 'Normalized', 'Position', [0.05 0.2 0.85 0.7]);
axis off

% 显示摄像头拍摄界面
objRes = get(obj, 'VideoResolution');
nBands = get(obj, 'NumberOfBands');
hImage = image(zeros(objRes(2), objRes(1), nBands));
preview(obj, hImage);

% 定义拍摄按钮
hb = uicontrol('Parent', hf, 'Units', 'Normalized','Position', [0.4 0.05 0.2 0.1], 'String', '拍照', 'Callback', 'imwrite(getsnapshot(obj), ''demo.png'';)');
