%Dual-Simplex Method
clc
clear all
cost = [-2  0 -1 0 0 0];
min1_max0 = 0; % Min/Max -> 1/0
if(min1_max0 == 1)
    cost = -cost;
end
A = [-1 -1 1; -1 2 -4];
B =[-5; -8];
s = eye(size(A,1));
S = [A s B];
bv = [4 5];
ZjCj = cost(bv)*S-cost;
sol = S(:,end);
while any (sol < 0)
    [minval, piv_row] = min(sol);
    row_val = S(piv_row, 1:end-1);
    for i = 1:size(S,2)-1
        if(row_val(i) < 0)
            ratio(i) = abs(ZjCj(i)/row_val(i));
        else
            ratio(i) = inf;
        end
    end
    [ent_val, piv_col] = min(ratio);
    piv_key = S(piv_row, piv_col);
    S(piv_row,:) = S(piv_row,:)/piv_key;
    bv(piv_row) = piv_col;
    for(i = 1:size(S,1))
        if( i~= piv_row)
            S(i,:) = S(i,:) - S(i,piv_col)*S(piv_row,:);
        end
    end
    ZjCj = cost(bv)*S-cost;
    sol = S(:,end);
end
OptimalTable = array2table(S,'variableNames',{'x1','x2','x3','s1','s2''s3','B'})
optimal_solution = ZjCj(end);
if(min1_max0 == 1)
    optimal_solution = -optimal_solution;
end
fprintf("Solution: %d\n",optimal_solution);