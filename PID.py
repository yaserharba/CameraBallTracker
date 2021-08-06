import time
class PID:
    lastErrors = [0, 0]
    integral = [0, 0]
    differential = [0, 0]
    time = 0

    def compute(self, errors):
        newTime = time.time()
        dt = newTime - self.time
        self.time = newTime
        if len(errors) > 0:
            self.integral[0] = self.integral[0] + errors[0]
            self.integral[1] = self.integral[1] + errors[1]
            self.differential[0] = errors[0] - self.lastErrors[0]
            self.differential[1] = errors[1] - self.lastErrors[1]
            self.lastErrors[0] = errors[0]
            self.lastErrors[1] = errors[1]
            speed = [0, 0]
            speed[0] = self.PID_Constants[0] * errors[0] + self.PID_Constants[1] * self.integral[0] * dt + \
                       self.PID_Constants[2] * self.differential[0] / dt
            speed[1] = self.PID_Constants[0] * errors[1] + self.PID_Constants[1] * self.integral[1] * dt + \
                       self.PID_Constants[2] * self.differential[1] / dt
            speed[0] = int(speed[0])
            speed[1] = int(speed[1])
        else:
            self.integral = [0, 0]
            self.differential = [0, 0]
            self.lastErrors = [0, 0]
            speed = [0, 0]
        return speed

    def setPID_Constants(self, PID_Constants):
        self.PID_Constants = PID_Constants
