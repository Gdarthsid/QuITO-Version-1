# Quasi-Interpolation based Trajectory Optimization 
 
## Introduction

This is a private repository which includes codes and documents related to the **Quasi-Interpolation based Trajectory Optimization (QuITO)**. The package is built on MATLAB and can be used for constrained trajectory optimization.

## Contributors

1) [Nakul Randad](https://nakulrandad.github.io/)
2) [Siddhartha Ganguly](https://sites.google.com/view/siddhartha-ganguly)
3) [Rihan Aaron D'Silva](https://www.linkedin.com/in/rihan-aaron-d-silva/)
4) [Debasish Chatterjee](https://www.sc.iitb.ac.in/~chatterjee/master/homepage/index.html)
5) [Ravi Banavar](https://www.sc.iitb.ac.in/~banavar/)
---

## How to install?

First, you need to download CasADi which is an open-source tool for nonlinear optimization. This uses interior point based solver IPOPT for solving the nonlinear problems. Install CasADi by downloading the source code and adding it to MATLAB’s path.<br>
For details visit: https://web.casadi.org/get/

Next, unzip the package source files into the desired folder, and add the included ‘src’ folder and its all subfolders to MATLAB's path directory. It can be done in the following ways:
- Access through the Set Path button on Home ribbon and add the subfolders or,
- Open the package folder on MATLAB (which can be verified from the address field on the top). You can run `pwd` command on the MATLAB terminal to check whether the package directory is currently open. Then run the following command on the MATLAB terminal `addpath(genpath(fullfile(pwd, ‘src’)))` to add the ‘src’ folder and its subfolders to MATLAB’s path.

## How to use?

Have a look at the problems in the examples folder.