% run this script to update the parameter list to put in "mod_eqns"
clear all;

%% Set parameters
p = set_params_mammal();
[params, parnames] = pars2vector(p,1);