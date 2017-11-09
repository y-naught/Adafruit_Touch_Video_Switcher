/*
-----------------------------------------------------------------------------------
ADAFRUIT MPR121 TOUCH CAPACITIVE VIDEO SWITCHER
Version 1.0.0
Written by Greg King

-----------------------------------------------------------------------------------
Free for use contingent on attribution
-----------------------------------------------------------------------------------

*****Run this sketch on the Raspberry Pi with the hardware*****

To use this program you will need to also have a Raspberry Pi 2 Model A or B
along with the MPR121 HAT by Adafruit.

-----------------------------------------------------------------------------------
URL: https://www.adafruit.com/product/2340
-----------------------------------------------------------------------------------

This part of the program is specifically for handling the data from the hardware attached
to the Raspberry Pi. To import yourr own videos into this sketch, you need to first encode your
videos in a wrapper tha the Processing Video library works with (I find using a
Quicktime wrapper with an H.264 codec at about 50% on the quality setting works well).
Then drag and drop the video files into the processing text editor window while this
file is open (the gray bar above the console will say "(x) files saved to sketch" if 
it worked). Then simply go down to the setup thread and type the name of your file
(including the file extension) into where the videos are initialized. I have also 
found it is best to start the sketch on the computer handling the video first to 
ensure the Raspberry Pi connects to the server. You will also need to set a static 
IP address on your server computer and plug in that IP address to the sketch that runs
on the Raspberry PI. Instructions for setting a static IP are easily googlable.
You will need an ethernet cable to run between both computers for this to work because
the Raspberry Pi 2 does not have wifi capability.


------------------------------------------------------------------------------------
***NOTE***
Before you start this program on the Raspberry Pi you will need to run the test function
that Adafruit provides as a python script in the terminal of your Pi. For instructions 
on how to do this go to the URL below. Future versions of this software will not require
this before running the program.
------------------------------------------------------------------------------------
https://learn.adafruit.com/mpr121-capacitive-touch-sensor-on-raspberry-pi-and-beaglebone-black/software
------------------------------------------------------------------------------------
*/
//add these libraries on the PI
import processing.net.*;
import processing.io.*;

I2C i2c;
Client c;

//how many sensors you are using
int numSensors = 12;

//initialize swtich arrays
boolean[] sw = new boolean[numSensors];
boolean[] prevSw = new boolean[numSensors];

int threshold = 0;

void setup(){
  size(100,100);
  //printArray(I2C.list());
  i2c = new I2C(I2C.list()[0]);
  
  //plug in the IP and port value you chose from the server computer here
  c = new Client(this, "195.105.105.10", 5050);
  frameRate(10);
  
  //initialize switches all to false
  for(int i = 0; i < numSensors; i++){
    sw[i] = false;
    prevSw[i] = false;
  }
}

void draw(){
  //read in the data from the device
  i2c.beginTransmission(0x5a);
  i2c.write(0xff);
  //read and store the data from the device
  byte[] data = i2c.read(30);
  
  //checks if the signal is above the touch threshold
  for(int i = 5; i < 29; i+=2){
   if(data[i+1] == 0 && data[i] > threshold){
     sw[(i - 5) /2] = true;
     println("switch" + (i - 5) / 2 + "on");
   }
   else{
    sw[(i - 5) / 2] = false; 
   }
  }
  
  //setup for only writing the data for the switch once
  for(int i = 0; i < numSensors; i++){
   if(sw[i] == true && prevSw[i] == false){
    String st = "" + i + "";
    c.write(st);
   }
   prevSw[i] = prevSw[i];
  }
}