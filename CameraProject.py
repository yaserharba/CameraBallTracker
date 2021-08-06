# -*- coding: utf-8 -*-
"""
Created on Fri Jun  4 09:53:18 2021

@author: YaserHarba
"""
import os
import threading
import cv2 as cv
import numpy as np
import serial
from PID import PID


def setFlag(flagNum, val):
    try:
        f = open("Flag" + str(flagNum) + ".txt", "w")
        f.write(str(val))
        f.close()
    except:
        pass


def getFlag(flagNum):
    try:
        f = open("Flag" + str(flagNum) + ".txt", "r")
        read = int(f.read())
        f.close()
        return read
    except:
        return False


def readRun(run):
    try:
        if getFlag(1):
            f = open("run.txt", "r")
            read = f.read()
            f.close()
            setFlag(1, 0)
            return read.find('1') != -1
        else:
            return run
    except:
        return run


def readErrors(errors):
    try:
        if getFlag(4):
            f = open("Errors.txt", "r")
            readStrings = f.read().split("\n")
            ret = [float(readStrings[0]), float(readStrings[1])]
            f.close()
            setFlag(4, 0)
            return ret
        else:
            return errors
    except:
        return errors


def writeRun(run):
    try:
        f = open("run.txt", "w")
        writeString = str(run)
        f.write(writeString)
        f.close()
        setFlag(1, 0)
    except:
        pass


def readPID_Constants(PID_Constants):
    try:
        if getFlag(2):
            f = open("PID.txt", "r")
            readStrings = f.read().split("\n")
            ret = [float(readStrings[0]), float(readStrings[1]), float(readStrings[2])]
            f.close()
            setFlag(2, 0)
            return ret
        else:
            return PID_Constants
    except:
        return PID_Constants


def readBallColor(ballColor):
    try:
        if getFlag(3):
            f = open("ballColor.txt", "r")
            readString = f.read()
            f.close()
            setFlag(3, 0)
            return readString
        else:
            return ballColor
    except:
        return ballColor


def writeErrors(errors):
    try:
        if getFlag(4):
            f = open("data.txt", "w")
            writeString = ""
            writeString += str(errors[0])
            writeString += "\n"
            writeString += str(errors[1])
            writeString += "\n"
            f.write(writeString)
            f.close()
            setFlag(4, 0)
    except:
        pass


def sendData(errors, run, PID_Constants, ballColor):
    writeErrors(errors)
    run = readRun(run)
    PID_Constants = readPID_Constants(PID_Constants)
    ballColor = readBallColor(ballColor)
    return run, PID_Constants, ballColor


def greenSkin(frame):
    min_HSV = np.array([40, 140, 0], dtype="uint8")
    max_HSV = np.array([100, 255, 255], dtype="uint8")
    imageHSV = cv.cvtColor(frame, cv.COLOR_BGR2HSV)
    skinRegionHSV = cv.inRange(imageHSV, min_HSV, max_HSV)
    return skinRegionHSV


def redSkin(frame):
    min_YCrCb = np.array([0, 160, 0], dtype="uint8")
    max_YCrCb = np.array([255, 255, 255], dtype="uint8")
    imageYCrCb = cv.cvtColor(frame, cv.COLOR_BGR2YCrCb)
    skinRegionYCrCb = cv.inRange(imageYCrCb, min_YCrCb, max_YCrCb)
    return skinRegionYCrCb


def cyanSkin(frame):
    min_YCrCb = np.array([0, 100, 100], dtype="uint8")
    max_YCrCb = np.array([255, 124, 255], dtype="uint8")
    imageYCrCb = cv.cvtColor(frame, cv.COLOR_BGR2YCrCb)
    skinRegionYCrCb = cv.inRange(imageYCrCb, min_YCrCb, max_YCrCb)
    return skinRegionYCrCb


def purpleSkin(frame):
    min_YCrCb = np.array([0, 130, 140], dtype="uint8")
    max_YCrCb = np.array([255, 170, 255], dtype="uint8")
    imageYCrCb = cv.cvtColor(frame, cv.COLOR_BGR2YCrCb)
    skinRegionYCrCb = cv.inRange(imageYCrCb, min_YCrCb, max_YCrCb)
    return skinRegionYCrCb


def makeSkin(frame, ballColor):
    if ballColor == "Red":
        return redSkin(frame)
    elif ballColor == "Purple":
        return purpleSkin(frame)
    elif ballColor == "Cyan":
        return cyanSkin(frame)
    elif ballColor == "Green":
        return greenSkin(frame)
    else:
        return []


def processImage(frame, ballColor):
    skinRegion = makeSkin(frame, ballColor)
    erosion = cv.erode(skinRegion, np.ones((3, 3), np.uint8), iterations=1)
    closing = cv.morphologyEx(erosion, cv.MORPH_CLOSE, np.ones((11, 11), np.uint8))
    return closing


def ballCatch(frame, ballColor):
    processedImage = processImage(frame, ballColor)
    contours, hierarchy = cv.findContours(processedImage, cv.RETR_TREE, cv.CHAIN_APPROX_SIMPLE)
    contoursList = []
    for cnt in contours:
        (x, y), radius = cv.minEnclosingCircle(cnt)
        center = (int(x), int(y))
        radius = int(radius)
        if radius > 40:
            contoursList.append([radius, center])
    contoursList.sort()
    if len(contoursList) > 0:
        return contoursList[len(contoursList) - 1]
    else:
        return []


def show(frame, ballInfo):
    if len(ballInfo) > 0:
        cv.circle(frame, ballInfo[1], ballInfo[0], (255, 0, 0), 3)
        cv.line(frame, (320, 240), ballInfo[1], (0, 255, 0), thickness=3)
    cv.line(frame, (0, 240), (640, 240), (0, 0, 255), thickness=2)
    cv.line(frame, (320, 0), (320, 480), (0, 0, 255), thickness=2)
    frame = cv.flip(frame, 0)
    cv.imshow('Camera', frame)


def imTake(cap):
    ret, frame = cap.read()
    ballInfo = ballCatch(frame, ballColor)
    show(frame, ballInfo)
    if len(ballInfo) > 0:
        return [ballInfo[1][0] - 320, ballInfo[1][1] - 240]
    else:
        return [0, 0]


def arduinoWrite(arduino, speed):
    arduino.write(bytes("s{}es{}e".format(speed[1], speed[0]), 'utf-8'))


class PlotterThread(threading.Thread):
    def run(self):
        os.system("java -jar plotter.jar")


if __name__ == '__main__':
    ballColor = "Green"
    run = 1
    PID_Constants = [0, 0, 0]
    pid = PID()
    cap = cv.VideoCapture(1)
    arduino = serial.Serial(port='COM10', baudrate=9600, timeout=.001)
    try:
        thread = PlotterThread()
        thread.daemon = True
        thread.start()
        while run == 1:
            errors = imTake(cap)
            run, PID_Constants, ballColor = sendData(errors, run, PID_Constants, ballColor)
            pid.setPID_Constants(PID_Constants)
            speed = pid.compute(errors)
            arduinoWrite(arduino, speed)
            if cv.waitKey(1) == ord('q'):
                break
    except Exception as e:
        print("ERROR : " + str(e))

    # Close All things
    writeRun(0)
    arduino.close()
    cap.release()
    cv.destroyAllWindows()
    print("END")
