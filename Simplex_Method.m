%Simplex Method
clc
clear
%format rat
%Equations 
A = [3 -1 2; -2 4 0; -4 3 8];                                
B = [7; 12; 10];
%Objective function
C=[1 -3 2];
%Finding Basic Feasible Solutions
m = size(A,1); %No of equations
n = size(A,2); %No of Variables
%Standard Form
S = eye(size(A,1));
CZ = zeros(size(A,1)+1);
C = [C CZ(1,:)];
A = [A S B];
Basic_var = (n + 1) : size(A,2)-1; %Basic variable position
LPPTable = array2table(A,'variableNames',{'x1','x2','x3','s1','s2','s3','B'})
ZjCj = C(Basic_var)*A - C;
%Finding Optimal Table for Maximization
while(any(ZjCj < 0))
    [minVal, PvtCol] = min(ZjCj);
    for i = 1: size(A,1)
       if A(i,PvtCol) > 0
          ratio(i) =  A(i,size(A,2))/A(i,PvtCol);
       else
           ratio(i) = inf;
       end
    end
    [minratio, PvtRow] = min(ratio);
    PvtElement = A(PvtRow, PvtCol);
    A(PvtRow,:) = A(PvtRow,:) / PvtElement;
    for i = 1:size(A,1)
       if i ~= PvtRow
          A(i,:) = A(i,:) - A(i,PvtCol)*A(PvtRow,:);  
       end
    end
    ZjCj = ZjCj - ZjCj(PvtCol)*A(PvtRow,:);
end
OptimalTable = array2table(A,'variableNames',{'x1','x2','x3','s1','s2','s3','B'})
fprintf("Solution: %d\n",ZjCj(size(ZjCj,2)));