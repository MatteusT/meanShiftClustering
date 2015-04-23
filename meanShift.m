function [centers,allMembers] = meanShift(inputData,h)
% input:   inputData --> This can be data of any dimension
%          h --> This is the bandwith of the gaussian kernel
% output:  centers --> The centers of each cluster (Nclusters,Ndimensions)
%          allMembers --> members of each cluster {Nclusters}
y_new = [];
centers = [];
numPts = length(inputData);
totPts = numPts;
dataSpace = inputData;
visited = zeros(1,totPts);
ic = 1;
while prod(visited) == 0
%inititaion
start = ceil((numPts-1e-6)*rand);
y_j = dataSpace(start,:);
dataSpace = inputData(visited == 0,:);
numPts = size(dataSpace,1);
mean_shift = h;
cMembers = [];
while mean_shift > h*1e-3
L2Dist =  sqrt(sum((y_j(ones(size(inputData,1),1),:) - inputData).^2,2)); 
inPts = find(L2Dist < h^2+1e-6);
X = inputData(inPts,:);
visited(inPts) = 1;
cMembers = [cMembers X'];
k_x = gaussKernelL2(X,h);
y_new = sum(X.*k_x(:,ones(size(X,2),1)),1)/sum(k_x);
mean_shift = norm(y_new - y_j);
disp(num2str(y_new));
y_j = y_new;
end
if ic == 1
   mergers = 0; 
else
clustDist = sqrt(sum((y_new(ones(size(centers,1),1),:)-centers).^2,2));
mergers = find(clustDist < h/2);
end
if mergers
    for imerg = mergers
        allMembers{imerg} = unique([allMembers{imerg};cMembers'],'rows');
    end
else 
    allMembers{ic} = cMembers';
    centers(ic,:) = y_new;
    ic = ic + 1;
end

end

end
function res = gaussKernelL2(X,h)
Xm = sum(X,1)./size(X,1);
L2diff = sqrt(sum((Xm(ones(size(X,1),1),:)-X).^2,2));
res = exp(((-(L2diff)).^2)/h^2);
end