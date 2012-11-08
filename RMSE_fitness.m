function ind = RMSE_fitness( ind,params,data,terminals,varsvals )
%RMSE_fitness Measures the fitness of a GPLAB individual
%   RMSE(INDIVIDUAL,PARAMS,DATA,TERMINALS,VARSVALS) returns
%   the fitness of an individual, measured as root mean squared error
%   between the obtained and expected results, and returns this.
%   
%   Input Arugments:
%      INDIVIDUAL - the individual whose fitness is to measure (struct)
%      PARAMS - the current running parameters (struct)
%      DATA - the dataset on which to measure the fitness (struct)
%      TERMINALS - the variables to set with the input dataset (cell array)
%      VARSVALS - the string of the variables of the fitness cases (string)
%
%   Output arguments:
%      INDIVIDUAL - the individual whose fitness was measured (struct)
%
%   Adapted from regfitness.m by Sara Silva (sara@dei.uc.pt)
%   Author: pvendevi@uvm.edu

X=data.example; %PHELAN: x data file
outstr=ind.str; %PHELAN: the string representing the individual being tested

for i=params.numvars:-1:1 %PHELAN: assemble the actual function with real values to test
    outstr=strrep(outstr,strcat('X',num2str(i)),strcat('X(:,',num2str(i),')'));
end

try
    res=eval(outstr); %PHELAN: evaluate the constructed function (representing the tree). Eval is a built in matlab function. Res is the result of evaluating all of the X data using the expression generated
catch
    % because of the "nesting 32" error of matlab
    res=str2num(evaluate_tree(ind.tree,X));
end

% if the individual is just a terminal, res is just a scalar, but we want a vector:
if length(res)<length(data.result)
   res=res*ones(length(data.result),1);
end

%sumdif=sum(abs(res-data.result)); %PHELAN: this is just calculated with the built in matlab function to find the differences between the res variable created by the expression and the actual data we have provided to test against. This is where the actual fitness work happens

sumdif = rmse(data.result, res); %rmse takes in actual data, and then esimate of that data that we made

ind.result=res; %PHELAN: store Res, the result of evaluating all of the X data using the expression generated

% raw fitness:
ind.fitness=sumdif; %lower fitness means better individual
% now limit fitness precision, to eliminate rounding error problem:
ind.fitness=fixdec(ind.fitness,params.precision); %PHELAN: why repeat the fitness assignments? 

end