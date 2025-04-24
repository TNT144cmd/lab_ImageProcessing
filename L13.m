% Read and convert to HSV
img = imread('3_1.jpg');
%img = imread('3_2.jpg');  % or '3_2.jpg''
img_hsv = rgb2hsv(img);
V = img_hsv(:,:,3);

% Original Histogram & CDF
[counts_orig] = imhist(V, 256);
pdf_orig = counts_orig / sum(counts_orig);
cdf_orig = cumsum(pdf_orig);

% Create Gaussian Target Histogram
x = linspace(0, 1, 256);              
mu = 0.5; sigma = 0.2;

pdf_target = normpdf(x, mu, sigma);  % Normal distribution
pdf_target = pdf_target / sum(pdf_target);  % Normalize to sum=1
cdf_target = cumsum(pdf_target);     % CDF of target

% Mapping function from original CDF to target CDF
mapping = zeros(1, 256);
for i = 1:256
    [~, idx] = min(abs(cdf_orig(i) - cdf_target));
    mapping(i) = x(idx);             
end

% Apply mapping
V_uint8 = uint8(V * 255);
V_mapped = mapping(V_uint8 + 1);
V_new = reshape(V_mapped, size(V));

% Convert back to RGB
img_hsv(:,:,3) = V_new;
img_specified = hsv2rgb(img_hsv);

% Compute histogram & CDF of specified V
[counts_new] = imhist(V_new, 256);
pdf_new = counts_new / sum(counts_new);
cdf_new = cumsum(pdf_new);

% Plot all results
figure('Name', 'LAB1_TRANPHUOCDIEN&NGUYENTHENHAN', 'NumberTitle', 'off');

% Images
subplot(3,3,1); imshow(img); title('Original Image');
subplot(3,3,2); bar(0:255, counts_orig); xlim([0 255]); title('Original V Histogram-NTN-TPD');
subplot(3,3,3); plot(0:255, cdf_orig, 'b'); xlim([0 255]); title('Original V CDF-NTN-TPD');


subplot(3,3,4); imshow(img_specified); title('Histogram Specified Image-NTN-TPD');
subplot(3,3,5); bar(0:255, counts_new); xlim([0 255]); title('Specified V Histogram-NTN-TPD');
subplot(3,3,6); plot(0:255, cdf_new, 'r'); xlim([0 255]); title('Specified V CDF-NTN-TPD');
% Histograms
subplot(3,3,8); bar(0:255, pdf_target); xlim([0 255]); title('Target (Gaussian) Histogram-NTN-TPD');
subplot(3,3,9); plot(0:255, cdf_target, 'g'); xlim([0 255]); title('Target (Gaussian) CDF-NTN-TPD');


% CDFs



% Target histogram & CDF (converted to 0–255 scale for display)
