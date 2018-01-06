% Clustering color without considering spatial difference
Im = imread('test.jpg');
Size = size(Im);
Sigma = 1;
Radius = 0.25;
Im_ary = single(Img2Ary(Im)) ./ 255; % Convert image into a row of pixels
Im_MS_ary = Meanshift(Im_ary, Sigma, Radius); % Meanshift
C = BallCluster(Im_MS_ary, Radius); % Label of each pixel of its cluster

% Display original and clustered image
subplot(2,1,1);imshow(Im); % Original
subplot(2,1,2);imshow(Ary2Img(Im_MS_ary, size(Im))); % Clustered

K = max(C); % number of clusters

% Display each cluster
for i = 1:K
    figure;
    imshow(Ary2Img((C==i).*Im_MS_ary, size(Im)));
    title("Cluster " + string(i)); 
end