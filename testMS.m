clear classes

figure(1201)
x(1:50,1) = rand(1,50)+2;
y(1:50,1) = rand(1,50)+1;

x(51:100,1) = rand(1,50)+1;
y(51:100,1) = rand(1,50);
X = [x,y]; % Data
%
plot(x,y,'x')
hold on
h = 0.8; % Bandwith of the cluster range
[clust,membs] = meanShift(X,h);
%


hold on
plot(membs{1}(:,1),membs{1}(:,2),'go')
hold on
plot(membs{2}(:,1),membs{2}(:,2),'bo')