## Formulate the Aly Chanproblem in QuITO 
In problem definition file **AlyChan.m**
First we provide the function handles for system dynamics with,
```matlab
% Set system dynamics
problem.dynamicsFunc = @dynamics;
```
