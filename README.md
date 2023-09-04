# Camera Ball Tracker

This project was developed for the "Automatic Control Systems" laboratory at Damascus University.

**Objective:**
The primary objective of this project was to implement a ball tracking system using a PID (Proportional-Integral-Derivative) controller and computer vision techniques to keep a ball within the center of the camera's field of view.

**Components:**

**Hardware:**
- **OpenCM Microcontroller**: We employed an OpenCM microcontroller as the central processing unit for the system.
- **Ax-12 Dynamixel Servos**: These servos were utilized to create a pan-tilt mechanism. The mechanism enabled the camera to track a ball with a specific color and adjust its orientation to maintain the ball at the center of the camera's view. This adjustment was achieved through the PID algorithm.

**Software:**
- **Python and OpenCV**: Image processing was performed using Python and the OpenCV library to detect and track the ball.
- **Matlab**: A Matlab figure was utilized to either specify the ball's color or fine-tune the PID controller's constants.
- **Java Processing Program (Plotter.jar)**: A simple Java Processing program, known as Plotter.jar, was employed to visualize the system's error state over time.
- **Communication**: To facilitate communication between Java, Python, and Matlab, data files and flag files were stored in the same directory.

**Video Demonstration:**

A video demonstrating the operation of this project can be found [here](https://youtu.be/6jPBWti7ggk).
