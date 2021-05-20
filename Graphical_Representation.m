%Finding Feasible region and solution
clc
clear
%format rat
%Equations 
A = [6,4;1,2;-1,1;0,1];
B = [24;6;1;2];
%Get X-Y coordinates
x1 = 0:1:max(B);
Y = [];
for i=1:size(A,1)
    y = (B(i)-A(i,1).*x1)/A(i,2);
    Y = [Y; max(0,y)];
end
%Get all intersection points
X = [];
for i=1:size(A,1)
    a1 = A(i,:);
    b1 = B(i);
    for j = i+1:size(A,1)
        a2 = A(j,:);
        b2 = B(j);
        An = [a1;a2];
        Bn = [b1;b2];
        x2 = An\Bn;
        X = [X max(0,x2)];
    end
end
%Get all corner points
Cp = [];
for i=1:size(A,1)
    pos = find(Y(i,:)==0);
    Cp = [Cp [x1([1 pos]); Y(i,[1 pos])]];
end 
X = [X Cp [0;0]];
%Feasible Region
X = unique(X','rows');
X = GR_Constraint(X);
bfsTable = array2table(X,'variableNames',{'x1','x2'})
% Objective function
f = @(x1,x2) (5*x1+4*x2); 
res = f(X(:,1),X(:,2));
[obj idx] = max(res);
max_pt = X(idx,:);
optimal_value=[max_pt , obj];
Optimal_solution = array2table(optimal_value,'variableNames',{'x1','x2','Max Value'})
%Plot Graph
for i =1:length(B)
    plot(x1,Y(i,:));
    hold on;
end
%Plot Corner Vertices of Fissible Region
for i = 1:size(X,1)
    plot(X(i,1),X(i,2),'r.', 'MarkerSize', 20);
    hold on;
end
plot(max_pt(1),max_pt(2),'g.', 'MarkerSize', 30);
grid on;
title("X1 vs X2");
xlabel("X1");
ylabel("X2");