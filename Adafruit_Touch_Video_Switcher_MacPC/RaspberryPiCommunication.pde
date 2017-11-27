/*
-----------------------------------------------------------------------------------
ADAFRUIT MPR121 TOUCH CAPACITIVE VIDEO SWITCHER
Version 1.0.0
Written by Greg King

-----------------------------------------------------------------------------------
Free for use contingent on attribution
-----------------------------------------------------------------------------------

To use this program you will need to also have a Raspberry Pi 2 Model A or B
along with the MPR121 HAT by Adafruit.

-----------------------------------------------------------------------------------
URL: https://www.adafruit.com/product/2340
-----------------------------------------------------------------------------------

This part of the program is specifically handling the video switching part of this
program. To import yourr own videos into this sketch, you need to first encode your
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

------------------------------------------------------------------------------------
***NOTE***
Before you start this program on the Raspberry Pi you will need to run the test function
that Adafruit provides as a python script in the terminal of your Pi. For instructions 
on how to do this go to the URL: 
------------------------------------------------------------------------------------
https://learn.adafruit.com/mpr121-capacitive-touch-sensor-on-raspberry-pi-and-beaglebone-black/software
------------------------------------------------------------------------------------
*/

import processing.net.*;
import processing.video.*;

//How many videos you are utilizing
int numVideos = 7;

//array of videos, rendered frames, and the data for the switch system
Movie[] videos = new Movie[numVideos];
boolean[] sw = new boolean[numVideos];
PImage[] images = new PImage[numVideos];


//Server variables
Server s;
Client c;
String input;

//part of the switch system for reliability
int curVideo;
int prevCurVideo;

void setup(){
  //fullScreen(P2D, 2);
  size(1024, 768, P2D);
  
  //the second argument is a port assignment 
  s = new Server(this, 5050);
  
  //place your videos here
  videos[0] = new Movie(this, "applyForceProjection_1.mov");
  videos[1] = new Movie(this, "Balloons.mov");
  videos[2] = new Movie(this, "ConnectedPts_1.mov");
  videos[3] = new Movie(this, "Flowfield_1.mov");
  videos[4] = new Movie(this, "drag_1.mov");
  videos[5] = new Movie(this, "OscilationPattern_1.mov");
  videos[6] = new Movie(this, "Spiral_1.mov");
  
  for(int i = 0; i < numVideos; i++){
    //if(i != 0){
     sw[i] = false;
    //}else{
     //sw[i] = true; 
    //}
    images[i] = createImage(width, height, RGB);
    //videos[i].loop();
  }
}

void draw(){
  background(0);
  
  //read the data from the server and iterate through all the switches
  c = s.available();
  if(c != null){
   input = c.readString();
   //println(input);
   curVideo = int(input);
   for(int i = 0; i < numVideos; i++){
    if(i != curVideo){
     sw[i] = false;
     videos[i].pause();
    }else{
     //println(i);
     sw[i] = true;
     videos[i].play(); 
    }
   }
   //println(input);
  }
  
  //update the variables that tell us if the switch has changed this last frame
  //if(curVideo != prevCurVideo){
  //  prevCurVideo = curVideo;
  //  println("switch!");
  //}
  //iterate through the switches and draw the image that is switched on
  for(int i = 0; i < numVideos; i++){
   if(sw[i] == true){
     //println(sw[i]);
     image(images[i], 0, 0);
   }
  }
}

//Thread that handles the incoming data from your videos
void movieEvent(Movie v){
 for(int i = 0; i < numVideos; i++){
  if(v == videos[i]){
   videos[i].read();
   images[i] = videos[i];
  }
 }
}

//void keyPressed(){
 //if(key == '1'){
 // videos[0].loop(); 
 // sw[0] = true;
 //}
 //if(key == '2'){
 // videos[1].loop(); 
 // sw[1] = true;
 //}
//}