img = imread('3_2.jpg'); % Read imgage
 % img=imgread('3_2.jpg');
 subplot(221);
 imshow(img),title('Original imgage');  % Display the imgage
 hsv= rgb2hsv(img);       
% Convert the imgage from RGB colormap to HSV colormap
 V= hsv(:,:,3);          
 
% Assign the intensity of the HSV imgage to V
 subplot(222),imhist(V),title('Histogram of the Intensity');
 
 V= uint8(255*(V-min(V(:)))/(max(V(:))-min(V(:)))); % Algorithm and scale 
% the Intensity from [0 1] to [0 255]
 V=double(V)/255; % Rescale the Intensity back to [0 1]
 hsv(:,:,3)=V;   
% Reassign V into
 newimg= hsv2rgb(hsv); % Convert the imgage back to RGB colormap
 subplot(223);
 imshow(newimg),title('Stretched image');
 subplot(224),imhist(V),title('Histogram of new image Intensity')