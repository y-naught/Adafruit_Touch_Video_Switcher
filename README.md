# Adafruit_Touch_Video_Switcher

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
