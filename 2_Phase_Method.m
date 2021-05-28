%2 Phase Method
clc
clear
format rat
%Equations 
A = [1 3; 1 1];                                
B = [3; 2];
%Objective function
C=[3 5];
min1_max0 = 1; % Min/Max -> 1/0
if(min1_max0 == 1)
    C = -C;
end
%Phase 1
fprintf("-------------- PHASE 1 --------------\n");
c1 = [0 0 0 0 -1 -1]; %COST
c1 = [c1 0];% with solution
Art_var = find(c1 == -1);
S = [A [-1 0 1 0; 0 -1 0 1] B];
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
%Finding Optimal table for Maximization problem
while(any(ZjCj(1:end-1) < 0))
    [minVal, PvtCol] = min(ZjCj(1:end-1));
    for i = 1: size(S,1)
       if S(i,PvtCol) > 0
          ratio(i) =  S(i,size(S,2))/S(i,PvtCol);
       else
           ratio(i) = inf;
       end
    end
    [minratio, PvtRow] = min(ratio);
    Bv(PvtRow) = PvtCol;
    PvtElement = S(PvtRow, PvtCol);
    S(PvtRow,:) = S(PvtRow,:) / PvtElement;
    for i = 1:size(S,1)
       if i ~= PvtRow
          S(i,:) = S(i,:) - S(i,PvtCol)*S(PvtRow,:);  
       end
    end
    %ZjCj = ZjCj - ZjCj(PvtCol)*S(PvtRow,:)
    ZjCj = c1(Bv)*S - c1;
    
end
OptimalTable1 = array2table(S,'variableNames',{'x1','x2','s1','s2','a1','a2','B'})
ZjCj
%fprintf("Solution: %d\n",ZjCj(end));
feasible_sol_exist = 1;
for i = 1:size(Bv,1)
    if any(Bv(i) == Art_var)
        feasible_sol_exist = 0;
        fprintf("Infeasible Solution\n");
        break;
    end
end
if feasible_sol_exist==1
    %Phase 2
    fprintf("-------------- PHASE 2 --------------\n");
    c2 = [C [0 0 0]];
    S(:,Art_var) = []; % Remove Artificial variable
    ZjCj = c2(Bv)*S - c2; % ZjCj with solution
    %Finding Optimal table for Maximization problem
    while(any(ZjCj(1:end-1) < 0))
        [minVal, PvtCol] = min(ZjCj(1:end-1));
        if all(S(:,PvtCol)<=0)
            error= fprintf('LPP is unbounded\n');
            feasible_sol_exist = 0;
            break;
        end
        for i = 1: size(S,1)
           if S(i,PvtCol) > 0
              ratio(i) =  S(i,size(S,2))/S(i,PvtCol);
           else
               ratio(i) = inf;
           end
        end
        [minratio, PvtRow] = min(ratio);
        Bv(PvtRow) = PvtCol;
        PvtElement = S(PvtRow, PvtCol);
        S(PvtRow,:) = S(PvtRow,:) / PvtElement;
        for i = 1:size(S,1)
           if i ~= PvtRow
              S(i,:) = S(i,:) - S(i,PvtCol)*S(PvtRow,:);  
           end
        end
        %ZjCj = ZjCj - ZjCj(PvtCol)*S(PvtRow,:);
        ZjCj = c2(Bv)*S - c2;
    end
    if (feasible_sol_exist==1)
        OptimalTable2 = array2table(S,'variableNames',{'x1','x2','s1','s2','B'})
        optimal_solution = ZjCj(end);
        if(min1_max0 == 1)
            optimal_solution = -optimal_solution;
        end
        fprintf("Solution: %d\n",optimal_solution);
    end
end
