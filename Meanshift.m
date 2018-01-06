function [ Out ] = Meanshift( In, sigma, radius, error)
%MEANSHIFT Meanshift a row of data into clustered positions.
%   In:     Input data row, in the form like [p1, p2, ..., p_n]
%   sigma:  Standard deriviation used in Guassian kernel
%   radius: Radius of the modes used the judge if the data point belongs to
%           it, in l-2 norm.
%   error:  Max tolerable error that mode shifting may be considered
%           stopped. Default value set to 1e-5.

%% Initialization
% set DEBUG to `true` to see time each iteration takes.
DEBUG = false;

if nargin < 4
    error = 0.00001;
end

%% Meanshift
BefShift = In;
max_dist = Inf;

% You may set up your own Neighbor function and Kernel function

% Neighbor function, judging if each data point in x has less distance to
% the origin than `radius` in l-2 norm.
Neighbor = @(x) (BallNeighbor(x, radius, 0));

% Kernel function, assigning weight to each value within the mode to
%   calculate the "center of mass" of the mode.
% Using Gaussian kernel here.
Kernel = @(x) (GaussKernel(x, sigma, 0));

i = 0; % Iteration count

% Stop iteration if max movement is within the error
while sqrt(max_dist) > error 
    if DEBUG
        tic;
    end
    % Shift each point to the center of its mode
    AftShift = Shift_Meanshift(BefShift, Neighbor, Kernel);
    % Calculate the distance each point moves, and picks out the maximum
    dist = VecNorm2Sq(AftShift - BefShift);
    max_dist = max(dist);
    % Iterate on moved data points
    BefShift = AftShift;
    i = i + 1;
    if DEBUG
        fprintf("Iteration\t%d at cost\t%f\t", i, max_dist);
        toc
    end
end
Out = AftShift;

end

function [ Out ] = Shift_Meanshift(In, Neighbor, Kernel)
% In = [p1, p2, ..., pN]
% data point as column vectors, arranged in a row in In
N = size(In, 2); 
Out = zeros(size(In));

% Flag of each data point of whether being moved
filled = zeros(1,N, 'logical'); 
for i = 1:N % For each data point
    if filled(i)
        continue % Skip if already moved
    end
    filled(i) = 1;
    %p'_i = sum(k(x)*x, x in Neighbor(x)) 
    %       / sum(k(x), x in Neighbor(x))
    Ni = Neighbor(In - In(:,i)); % Entries within the mode
    k = sum(Ni);                % Count # of entries
    Ni = Ni .* (1:N);           % Assign indexies in the array
    Ni( :, ~any(Ni,1) ) = [];   % Remove zero columns
    NNi = In(:, Ni);            % Find out the neighbor set
    Diff = (NNi - In(:,i));     % Difference to the current data point
    KernDiff = Kernel(Diff);    % Calculate their weight in the mode
    % Sum up their mass
    SumMass = sum(KernDiff .* NNi, 2); % MxN -> Mx1
    % Sum up the weight
    SumKern = sum(KernDiff); % 1xN -> 1x1    
    NewPos = SumMass ./ SumKern; % New center
    % Set position of all points within the mode to the center of the mode
    Out(:,Ni) = repmat(NewPos, 1, k); 
    % Mark all inliers as "moved"
    filled(Ni) = 1;
end
end

function [ Out ] = BallNeighbor(In, dist, x0)
Out = VecNorm2Sq(In - x0) < dist.^2;
end

function [ Out ] = GaussKernel(In, sigma, x0)
x = VecNorm2Sq(In-x0);
Out = exp(-x./(2.*sigma.^2));
end