# FlowField
Code written to illustrate flow fields in two dimensions, in Processing.
# Summary
This code either randomly chooses dx/dt and dy/dt as linear combinations of x and y, or a preprogrammed circular field, based on user input. It then makes many randomized Movable objects, which are the points that follow the flow field. It shows the formulas for dx/dt and dy/dt in the top right for the duration of that iteration. It then applies the derivatives as determined by the flow field with a small delta (.005 seconds) for 300 frames, and then resets, choosing a new dx/dt and dy/dt if in the random state, deletes the old Movables, makes new ones, and runs again.
# How to use
Press "r" or "R" at any time to have the computer choose a random flow field for the next iterations, press "c" or "C" at any time to generate a circular flow field for the next iterations. (It's a little buggy when going from circle to random, may hae to spam c and r a bit.)
# Background
This code was initally written to visualize stability of specific flow fields by placing dots randomly on the screen and letting them follow the flow lines. It looked pretty so I made it into a screensaver-esque program that randomly chooses dx/dt and dy/dt as linear combinations of x and y.  
# Screenshots
![screenshot](https://github.com/zgurwitz/FlowField/blob/main/Images/Screenshot%20(183).png)
![screenshot](https://github.com/zgurwitz/FlowField/blob/main/Images/Screenshot%20(186).png)
![screenshot](https://github.com/zgurwitz/FlowField/blob/main/Images/Screenshot%20(187).png)
