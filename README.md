# Quasi-Interpolation based Trajectory Optimization 
 
QuITO is a numerical software package for solving constrained nonlinear optimal control problems via direct optimization. The package is built on MATLAB and can be used for constrained trajectory optimization. The base algorithm for QuITO is a novel direct multiple shooting technique which employs a special kind of quasi-interpolation technique to approximate the control trajectory. Currently QuITO can handle the following problem specifications: 

* Dynmaics (ODEs) : linear, nonlinear;
* Constriant: state, control, mixed (which can be a nonlinear function of states and control);
* Boundary specification: boundary values, constraints of terminal states.

## How to cite?
In case you're using QuITO, consider citing the article: 
Constrained trajectory synthesis via quasi-interpolation (https://ieeexplore.ieee.org/abstract/document/9992892)

## Contributors

1) [Nakul Randad](https://nakulrandad.github.io/)
2) [Siddhartha Ganguly](https://sites.google.com/view/siddhartha-ganguly)
3) [Rihan Aaron D'Silva](https://www.linkedin.com/in/rihan-aaron-d-silva/)
4) [Mukesh Raj S](https://www.linkedin.com/in/mukesh-raj-s-658117221/)
5) [Debasish Chatterjee](https://www.sc.iitb.ac.in/~chatterjee/master/homepage/index.html)
---

## How to install?

QuITO uses CasADi, which is an open-source framework for nonlinear optimization, for its optmization routine. CasADi can be downloaded from here: https://web.casadi.org/get. Install CasADi by downloading the source code and adding it to MATLAB’s path.<br>


Next, unzip the package source files into the desired folder, and add the included [src](./src/) folder and its all subfolders to MATLAB's path directory. It can be done in the following ways:
- Access through the Set Path button on Home ribbon and add the subfolders or,
- Open the package folder on MATLAB (which can be verified from the address field on the top). You can run `pwd` command on the MATLAB terminal to check whether the package directory is currently open. Then run the following command on the MATLAB terminal `addpath(genpath(fullfile(pwd, ‘src’)))` to add the [src](./src) folder and its subfolders to MATLAB’s path.

## How to use?

A template to the numerical solver is specified in the template folder and multiple examples have been solved in the examples folder. <br> 

The examples contains the following files: <br>

* example.m : contains system specifications, constraint profile etc., specific to an example;
* options.m : contains integration schemes, solver options, etc.
* postProcess.m : contains options for plotting the state-action trajectories
* main.m : the main/primary file that the user needs to run by specifying number of steps (consequently h>0) and D>0.

The IPOPT (Interior Point Optimization) solver is recommended for nonlinear optimization problems and is already available within CasADI. For details visit: https://coin-or.github.io/Ipopt

---

## Graphical User Interface

### Installation
The QuITO toolbox is packaged in form a MATLAB app with a Graphical Interface to ease the process of making use of the toolbox. To install the GUI, navigate to the [Graphical Interface](./Graphical%20Interface/) directory, and in that directory, find the installation file, [QuITO.mlappinstall](./Graphical%20Interface/QuITO.mlappinstall). Click on [QuITO.mlappinstall](./Graphical%20Interface/QuITO.mlappinstall), on which MATLAB prompts the user asking to install the application. Once the app is installed, the user can find it in the **APPS** section on MATLAB's toolbar on the top. 

### Instructions to Use
1) Before starting the app, make sure CasADI is installed and is properly imported onto MATLAB's path. The same can be verified using the commands `path` and `ver` on the Command Window.
2) Once verified, navigate to the base directory of QuITO, and open the MATLAB app named **QuITO** from the **APPS** section on MATLAB's toolbar at the top of the window.
3) Here, the user can select his preferred Example Problem or even the User-Defined Template Problem from the dropdown, input values for _Number of Steps (N)_ and _Shape Parameter (D)_, and simply click on the _Run_ button.
4) The user must ensure the current working directory on MATLAB is always the base directory of QuITO toolbox.
