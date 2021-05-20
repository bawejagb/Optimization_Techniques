%Finding Basic Feasible Solutions
clc
clear
format rat
%Equations 
A = [1 2 1; 2 1 5];                                
B = [4; 5];
%Objective function
C=[1 2 1 3 6];
%Finding Basic Feasible Solutions
m = size(A,1); %No of equations
n = size(A,2); %No of Variables
LPPTable = array2table([A B],'variableNames',{'x1','x2','x3','B'})
if(n>m)
    nCm = nchoosek(n,m);
    pair = nchoosek(1:n,m);
    bfs = [];
    for i=1:nCm
        sol = zeros(n,1);
        X = A(:,pair(i,:))\B;
        if(X>=0 & X~=-inf & X~=inf)
            sol(pair(i,:)) = X;
            bfs = [bfs sol];
        end
    end
else
    fprintf("Solution doesn't exist!\n");
end
bfsTable = array2table(bfs','variableNames',{'x1','x2','x3'})
%Finding Optimal Solution
Z=C*bfs;
[Zmin,Zindex] = min(Z);
opt_bfs = bfs(:,Zindex);
optimal_value=[opt_bfs' , Zmin];
Optimal_solution = array2table(optimal_value,'variableNames',{'x1','x2','x3' 'Min Value'})
   