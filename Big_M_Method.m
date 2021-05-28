%Big-M Method
clc
clear
%format rat
%Equations 
M = 1000;
A = [3 1; 4 3; 1 2];                                
B = [3; 6; 3];
%Objective function
C=[-2 -1];
min1_max0 = 0; % Min/Max -> 1/0
if(min1_max0 == 1)
    C = -C;
end
%Standard Form
C = [C 0  -[M M] 0 0];
S = [0 1 0 0; -1 0 1 0; 0 0 0 1];
A = [A S B];
Bv = [];
Idy = eye(size(A,1));
for i=1:size(A,2)
    for j=1:size(Idy,2)
        if A(:,i)== Idy(:,j)
            Bv = [Bv i];
        end
    end
end
LPPTable = array2table(A,'variableNames',{'x1','x2','s2','A1','A2','s3','B'})
ZjCj = C(Bv)*A - C;
%Finding Optimal Table for Maximization
while(any(ZjCj(1:end-1) < 0))
    [minVal, PvtCol] = min(ZjCj(1:end-1));
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
    ZjCj = ZjCj - ZjCj(PvtCol)*A(PvtRow,:)
end
OptimalTable = array2table(A,'variableNames',{'x1','x2','s2','A1','A2','s3','B'})
optimal_solution = ZjCj(end);
if(min1_max0 == 1)
    optimal_solution = -optimal_solution;
end
fprintf("Solution: %d\n",optimal_solution);