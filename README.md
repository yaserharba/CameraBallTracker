# CameraBallTracker
This project is a simple one I made for my university, which is for applying PID controller, some computer vision, and image processing.

For the hardware part, I use OpenCM as a Microcontroller and Ax-12 Dynamixel servos for building a pan-tilt mechanism, this mechanism holds a camera to track a ball with a specific color and make it in the middle of the image using the PID algorithm.

The image processing is being done using Python and OpenCV library.

To specify the ball color or the PID constants, I use Matlab figure which I decide to use because it is easy to build a GUI using it.

I use a simple Java Processing program (Plotter.jar) to visual the errors state over time.

To transmit data between Java, Python, and Matlab, I use data files and flag files and put them in the same path.
