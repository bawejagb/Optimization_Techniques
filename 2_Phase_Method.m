%2 Phase Method
clc
clear
%format rat
%Equations 
A = [1 3 1; 2 -1 1; 4 3 -2];                                
B = [5; 2; 5];
%Objective function
C=[3 -1 2];
%Phase 1
c1 = [0 0 0 0 0 -1 0];
S = [A [1 0 0 0; 0 -1 1 0; 0 0 0 1]];
%Identify Basic variable
Idy = eye(size(S,1));
Bv = [];
for i=1:size(S,2)
    for j=1:size(Idy,2)
        if S(:,i)== Idy(:,j)
            Bv = [Bv i];
        end
    end
end
%Finding ZjCj for Table
ZjCj = c1(Bv)*S - c1;
S = [S B];
ZjCj = [ZjCj 0]; % ZjCj with solution
%Finding Optimal table for Maximization problem
while(any(ZjCj < 0))
    [minVal, PvtCol] = min(ZjCj);
    for i = 1: size(S,1)
       if S(i,PvtCol) > 0
          ratio(i) =  S(i,size(S,2))/S(i,PvtCol);
       else
           ratio(i) = inf;
       end
    end
    [minratio, PvtRow] = min(ratio);
    PvtElement = S(PvtRow, PvtCol);
    S(PvtRow,:) = S(PvtRow,:) / PvtElement;
    for i = 1:size(S,1)
       if i ~= PvtRow
          S(i,:) = S(i,:) - S(i,PvtCol)*S(PvtRow,:);  
       end
    end
    ZjCj = ZjCj - ZjCj(PvtCol)*S(PvtRow,:);
end
OptimalTable1 = array2table(S,'variableNames',{'x1','x2','x3','s1','s2','a1','s3','B'})
%fprintf("Solution: %d\n",ZjCj(size(ZjCj,2)));
%Phase 2
CZ = zeros(size(A,1)+1);
c2 = [C CZ(1,:)];
ZjCj = [-c2 0]; % ZjCj with solution
%Finding Optimal table for Maximization problem
while(any(ZjCj < 0))
    [minVal, PvtCol] = min(ZjCj);
    for i = 1: size(S,1)
       if S(i,PvtCol) > 0
          ratio(i) =  S(i,size(S,2))/S(i,PvtCol);
       else
           ratio(i) = inf;
       end
    end
    [minratio, PvtRow] = min(ratio);
    PvtElement = S(PvtRow, PvtCol);
    S(PvtRow,:) = S(PvtRow,:) / PvtElement;
    for i = 1:size(S,1)
       if i ~= PvtRow
          S(i,:) = S(i,:) - S(i,PvtCol)*S(PvtRow,:);  
       end
    end
    ZjCj = ZjCj - ZjCj(PvtCol)*S(PvtRow,:);
end
OptimalTable2 = array2table(S,'variableNames',{'x1','x2','x3','s1','s2','a1','s3','B'})
fprintf("Solution: %d\n",ZjCj(size(ZjCj,2)));