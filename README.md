# MPC-Vehicle-Bicycle-Model
Linear and Non-Linear MPC controllers for path tracking of the vehicle bicycle model


- Excited the system with various signals and collected data to apply machine learning techniques to model the system dynamics (3DOF Vehicle Bicycle Model with Force Input in MATLAB)

- Linearized the model using the ARX function and developed a linear MPC controller with constraints
  
- Designed a nonlinear MPC controller with and without incorporating the NARX model and considering constraints to perform trajectory tracking with minimum change in the vehicle yaw rate


The LMPC file is for the Linear MPC controller. The LMPC.m file can be used to run the Linear MPC code and its Simulink model. Similarly, the NMPC file is for the Non-Linear MPC controller. The NMPC.m file can be used to run the Non-Linear MPC code and its Simulink model. 
