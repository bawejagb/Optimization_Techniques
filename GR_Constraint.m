%Graphical Representation
%Filtering points on the basis of below constraints
function out = GR_Constraint(X)
%Graphical_Representation
eq1 = @(x1,x2) (6.*x1+4.*x2-24);
eq2 = @(x1,x2) (x1+2.*x2-6);
eq3 = @(x1,x2) (-x1+x2-1);
eq4 = @(x1,x2) (0.*x1+x2-2);
eqs = {eq1 eq2 eq3 eq4};
sign = [0 0 0 0]; %Less/Greater : 0/1
for i=1:length(eqs)
    eq = eqs{i};             
    x1 = X(:,1);
    x2 = X(:,2);
    sol = (eq(x1,x2));
    if(sign(i) == 0)
        np = find(sol>0); %For less than constraint(>)
    else
        np = find(sol<0); %For Greater than constraint(<)
    end
    X(np,:) = [];
end
out = X;
end