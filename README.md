# Quasi-Interpolation based Trajectory Optimization 
 
## Introduction

This is a private repository which includes codes and documents related to the **Quasi-Interpolation based Trajectory Optimization (QuITO)**. The package is built on MATLAB and can be used for constrained trajectory optimization.

QuITO is a numerical software package for solving optimal control problems directly which can handle path-wise/mixed inequality/equality, and boundary constraints. The base-algorithm for the software package is a direct multiple shooting technique. 

## Contributors

1) [Nakul Randad](https://nakulrandad.github.io/)
2) [Siddhartha Ganguly](https://sites.google.com/view/siddhartha-ganguly)
3) [Rihan Aaron D'Silva](https://www.linkedin.com/in/rihan-aaron-d-silva/)
4) [Debasish Chatterjee](https://www.sc.iitb.ac.in/~chatterjee/master/homepage/index.html)
5) [Ravi Banavar](https://www.sc.iitb.ac.in/~banavar/)
---

## How to install?

The solver uses CasADi, which is an open-source framework for nonlinear optimization, for its optmization routine. CasADi can be downloaded from here: https://web.casadi.org/get/. Install CasADi by downloading the source code and adding it to MATLAB’s path.<br>


Next, unzip the package source files into the desired folder, and add the included ‘src’ folder and its all subfolders to MATLAB's path directory. It can be done in the following ways:
- Access through the Set Path button on Home ribbon and add the subfolders or,
- Open the package folder on MATLAB (which can be verified from the address field on the top). You can run `pwd` command on the MATLAB terminal to check whether the package directory is currently open. Then run the following command on the MATLAB terminal `addpath(genpath(fullfile(pwd, ‘src’)))` to add the ‘src’ folder and its subfolders to MATLAB’s path.

## How to use?

A template to the numerical solver is specified in the template folder and multiple examples have been solved in the examples folder. <br> 

The examples contains the following files: <br>

* example.m : contains system specifications, constraint profile etc., specific to an example;
* options.m : contains integration schemes, solver options, etc.
* postProcess.m : contains options for plotting the state-action trajectories
* main.m : the main/primary file that the user need to run by specifying number of steps (consequently h>0) and D>0.

The Ipopt (Interior Point Optimizer) solver is recommended for Non-linear Optimization and is already available within CasADI. For details visit : https://coin-or.github.io/Ipopt/
