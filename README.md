# Camera Ball Tracker

A project was made for the "Automatic Control Systems" lab at Damascus University.

The project aimed to keep the ball within the center of the vision range using the PID controller and computer vision as feedback.

It consists of:

* Hardware:
- OpenCM as a Microcontroller was used.
- Ax-12 Dynamixel servos for building a pan-tilt mechanism. This mechanism held a camera to track a ball with a specific color and tried to move it to the middle of the plate using the PID algorithm.

* Software:
- Python and OpenCV library were used for image processing.
- Matlab figure to specify the ball color or to tune PID constants.
- A simple Java Processing program (Plotter.jar) to visual the errors state over time.
- To communicate between Java, Python, and Matlab. Data files and flag files were in the same path.

The Video is here:

[![IMAGE ALT TEXT HERE](https://www.iconfinder.com/icons/4102578/download/png/48)](https://youtu.be/6jPBWti7ggk)
