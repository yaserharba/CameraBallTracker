#include <DynamixelSDK.h>
#include <DynamixelSDK.h>
#define ADDR_AX_CW_ANGLE_LIMIT          6
#define ADDR_AX_CCW_ANGLE_LIMIT         8
#define ADDR_AX_TORQUE_ENABLE           24
#define ADDR_AX_TORQUE_ENABLE           24
#define ADDR_AX_GOAL_POSITION           30
#define ADDR_AX_MOVING_SPEED            32
#define ADDR_AX_PRESENT_POSITION        36
#define ADDR_AX_PRESENT_SPEED           38
#define PROTOCOL_VERSION                1.0
#define BAUDRATE                        1000000
#define DEVICENAME                      "3"
#define DXL_MOVING_STATUS_THRESHOLD     20
dynamixel::PortHandler *portHandler;
dynamixel::PacketHandler *packetHandler;
uint8_t dxl_error = 0;
int myID[] = {13, 16};
int mySpeed[] = {0, 0};
void setup() {
  Serial.begin(9600);
  Serial.setTimeout(10);
  initiateAX();
  setWheelModeAX(myID[0]);
  setWheelModeAX(myID[1]);
  torqueStateAX(myID[0], 1);
  torqueStateAX(myID[1], 1);
  pinMode(16, INPUT);
  pinMode(17, INPUT);
  pinMode(18, OUTPUT);
}

void loop() {
  while (!Serial.available());
  String readStr = Serial.readString();
  int i = 0;
  for (int j = 0; j < readStr.length(); j++) {
    char c = readStr[j];
    if (c == 's') {
      mySpeed[i] = readInt(readStr, j+1, mySpeed[i]);
      i++;
    }
    if (i > 1)
      break;
  }
  Serial.print(printInt(currentPosAX(myID[0])));
  Serial.print(",");
  Serial.print(printInt(currentPosAX(myID[1])));
  Serial.print(",");
  Serial.print(printInt(mySpeed[0]));
  Serial.print(",");
  Serial.println(printInt(mySpeed[1]));
  if (currentPosAX(myID[0]) > 512) {
    //mySpeed[1] = -mySpeed[1];
    digitalWrite(18, 0);
  } else {
    digitalWrite(18, 1);
  }
  mySpeed[0] = (mySpeed[0] >= 0) ? mySpeed[0] : (1024 - mySpeed[0]);
  mySpeed[1] = (mySpeed[1] >= 0) ? mySpeed[1] : (1024 - mySpeed[1]);
  setSpeedAX(myID[0], mySpeed[0]);
  setSpeedAX(myID[1], mySpeed[1]);
}
String printInt(int pr) {
  String ret;
  if (pr < 10)
    ret += "00";
  else if (pr < 100)
    ret += "0";
  ret += String(pr);
  return ret;
}
int readInt(String str, int j, int last) {
  int ret = 0;
  bool ne = 0;
  while (j<str.length()) {
    char c = str[j];
    j++;
    if (c == '-')
      ne = 1;
    else if (c == 'e') {
      //Serial.println();
      return ne ? -ret : ret;
    } else {
      //Serial.print(c);
      ret *= 10;
      ret += (c - '0');
    }
  }
  return last;
}
int currentPosAX(int id) { // to Read present position from dxl motor with ID id
  int dxl_present_position = 0;
  int dxl_comm_result = packetHandler->read2ByteTxRx(portHandler, id, ADDR_AX_PRESENT_POSITION, (uint16_t*)&dxl_present_position, &dxl_error);
  if (dxl_comm_result != COMM_SUCCESS)
  {
    packetHandler->getTxRxResult(dxl_comm_result);
  }
  else if (dxl_error != 0)
  {
    packetHandler->getRxPacketError(dxl_error);
  }
  return dxl_present_position;
}
int currentSpeedAX(int id) { // to Read present speed from dxl motor with ID id
  int dxl_present_speed = 0;
  int dxl_comm_result = packetHandler->read2ByteTxRx(portHandler, id, ADDR_AX_PRESENT_SPEED, (uint16_t*)&dxl_present_speed, &dxl_error);
  if (dxl_comm_result != COMM_SUCCESS)
  {
    packetHandler->getTxRxResult(dxl_comm_result);
  }
  else if (dxl_error != 0)
  {
    packetHandler->getRxPacketError(dxl_error);
  }
  return dxl_present_speed;
}
void goToPosAX(int id, int pos) { // to Write a goal position to dxl motor with ID id
  int dxl_comm_result = packetHandler->write2ByteTxRx(portHandler, id, ADDR_AX_GOAL_POSITION, pos, &dxl_error);
  if (dxl_comm_result != COMM_SUCCESS)
  {
    packetHandler->getTxRxResult(dxl_comm_result);
  }
  else if (dxl_error != 0)
  {
    packetHandler->getRxPacketError(dxl_error);
  }
}
void setSpeedAX(int id, int s) { // to Set Moving Speed to dxl motor with ID id
  int dxl_comm_result = packetHandler->write2ByteTxRx(portHandler, id, ADDR_AX_MOVING_SPEED, s, &dxl_error);
  if (dxl_comm_result != COMM_SUCCESS)
  {
    packetHandler->getTxRxResult(dxl_comm_result);
  }
  else if (dxl_error != 0)
  {
    packetHandler->getRxPacketError(dxl_error);
  }
}
void setWheelModeAX(int id) { // to Set Wheel Mode to dxl motor with ID id
  int dxl_comm_result = packetHandler->write2ByteTxRx(portHandler, id, ADDR_AX_CW_ANGLE_LIMIT, 0, &dxl_error);
  if (dxl_comm_result != COMM_SUCCESS)
  {
    packetHandler->getTxRxResult(dxl_comm_result);
  }
  else if (dxl_error != 0)
  {
    packetHandler->getRxPacketError(dxl_error);
  }
  dxl_comm_result = packetHandler->write2ByteTxRx(portHandler, id, ADDR_AX_CCW_ANGLE_LIMIT, 0, &dxl_error);
  if (dxl_comm_result != COMM_SUCCESS)
  {
    packetHandler->getTxRxResult(dxl_comm_result);
  }
  else if (dxl_error != 0)
  {
    packetHandler->getRxPacketError(dxl_error);
  }
}
void torqueStateAX(int id, bool state) { // to set the state of torque of dxl motor with ID id
  int dxl_comm_result = packetHandler->write1ByteTxRx(portHandler, id, ADDR_AX_TORQUE_ENABLE, state, &dxl_error);
  if (dxl_comm_result != COMM_SUCCESS)
  {
    packetHandler->getTxRxResult(dxl_comm_result);
  }
  else if (dxl_error != 0)
  {
    packetHandler->getRxPacketError(dxl_error);
  }
}
void initiateAX() { // to initiate the communication
  portHandler = dynamixel::PortHandler::getPortHandler(DEVICENAME);
  packetHandler = dynamixel::PacketHandler::getPacketHandler(PROTOCOL_VERSION);
  portHandler->openPort();
  portHandler->setBaudRate(BAUDRATE);
  //  if (portHandler->openPort())
  //    Serial.print("Succeeded to open the port!\n");
  //  else
  //  {
  //    Serial.print("Failed to open the port!\n");
  //    Serial.print("Press any key to terminate...\n");
  //    return;
  //  }
  //  if (portHandler->setBaudRate(BAUDRATE))
  //    Serial.print("Succeeded to change the baudrate!\n");
  //  else
  //  {
  //    Serial.print("Failed to change the baudrate!\n");
  //    Serial.print("Press any key to terminate...\n");
  //    return;
  //  }
}
