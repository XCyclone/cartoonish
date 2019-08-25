% ��ȡPC��Ϣ
imaqhwinfo
obj = videoinput('winvideo');
set(obj, 'FramesPerTrigger', 1);
set(obj, 'TriggerRepeat', Inf);

% �����ؽ���
hf = figure('Units', 'Normalized', 'Menubar', 'None','NumberTitle', 'off', 'Name', '����ϵͳ');
ha = axes('Parent', hf, 'Units', 'Normalized', 'Position', [0.05 0.2 0.85 0.7]);
axis off

% ��ʾ����ͷ�������
objRes = get(obj, 'VideoResolution');
nBands = get(obj, 'NumberOfBands');
hImage = image(zeros(objRes(2), objRes(1), nBands));
preview(obj, hImage);

% �������㰴ť
hb = uicontrol('Parent', hf, 'Units', 'Normalized','Position', [0.4 0.05 0.2 0.1], 'String', '����', 'Callback', 'imwrite(getsnapshot(obj), ''demo.png'';)');
