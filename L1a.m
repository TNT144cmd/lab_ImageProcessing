% Read image
%img = imread('3_1.jpg');
img = imread('3_2.jpg');  % or '3_2.jpg'
img_hsv = rgb2hsv(img);   % Convert RGB to HSV

% Extract V channel
V = img_hsv(:,:,3);

% Linear stretching
v_min = min(V(:));
v_max = max(V(:));
V_stretched = (V - v_min) / (v_max - v_min);

% Replace V channel and convert back to RGB
img_hsv(:,:,3) = V_stretched;
img_stretched = hsv2rgb(img_hsv);

% Histogram and CDF of original V
[counts_orig, bins_orig] = imhist(V);
pdf_orig = counts_orig/ sum(counts_orig);
cdf_orig = cumsum(pdf_orig);

% Histogram and CDF of stretched V
[counts_stretch, bins_stretch] = imhist(V_stretched);
pdf_strecth = counts_stretch/ sum(counts_stretch);
cdf_strecth = cumsum(pdf_strecth);

% Plotting
figure('Name', 'LAB1_TRANPHUOCDIEN&NGUYENTHENHAN', 'NumberTitle', 'off');

subplot(2,3,1); imshow(img); title('Original Image-NTN-TPD');
%subplot(2,3,2); imhist(V); title('Original V Histogram-NTN-TPD');
subplot(2,3,2); bar(0:255, counts_orig); xlim([0 255]); title('Original V Histogram-NTN-TPD');
%subplot(2,3,3); plot(bins_orig, cdf_orig); title('Original V CDF-NTN-TPD');
subplot(2,3,3); plot(0:255, cdf_orig, 'b'); xlim([0 255]); title('Original V CDF-NTN-TPD');

subplot(2,3,4); imshow(img_stretched); title('After Linear Stretching-NTN-TPD');
%subplot(2,3,5); imhist(V_stretched); title('Stretched V Histogram-NTN-TPD');
subplot(2,3,5); bar(0:255, counts_orig); xlim([0 255]); title('Stretched V Histogram-NTN-TPD');
%subplot(2,3,6); plot(bins_stretch, cdf_stretch); title('Stretched V CDF-NTN-TPD');
subplot(2,3,6); plot(0:255, cdf_stretch, 'b'); title('Stretched V CDF-NTN-TPD');
