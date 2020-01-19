/*
  textPixels - This program need to import the "video" library in processing 
  Chia Yang Chang (Andrew)
  2019
*/

/*
  Acknowledgments
  This Template is inspired by:
  11.1: Capture and Live Video - Processing Tutorial:   
  https://youtu.be/WH31daSj4nc
*/

/*
  Im using the video turn into pixels 
  and map the pixesl brightness into the size of the shape 
  moreover the color of the shape.
  
  Press the keyboard will change the filter mode into the ellipse mode.
  Release the key will trun the defult rect mode.
*/

import processing.video.*;
Capture video;

float spacingX,spacingY;
boolean mode;

String text="10101010001010";

void setup(){
  size(720,480);
  frameRate(60);  
  rectMode(CENTER);
  mode=false;
  spacingX=10;
  spacingY=20;
  
  video = new Capture(this,720,480);
  video.start();
}

void draw(){
  //saveFrame("pic_####.png");
  
  background(0);
  // this makes when the processing read the vid wont read over and over and over 
  
   if(video.available()){
    video.read();
  }
  
  video.loadPixels(); // read the pixels in the video
  
  noStroke();
  for(int i=0;i<width;i+=spacingX){
    for(int j=0;j<height;j+=spacingY){
      color c = video.pixels[ j * width + i ];   // count the pixel loc in the image
      float b = brightness(c);
      float rectSize = map(b,0,255,10,40);    // maping the brightness of the image
      float radius = map(b,0,255,3,20);
      pushMatrix();
      translate(i,j+10);   // make i,j into a loc 
      fill(color(c));
      
      if(mode==false){
        
        int indext =int(map(b,0,255,0,text.length()-1));
        char voc = text.charAt(indext);
        float textBig=map(b,0,255,5,35);
        textSize(textBig);
        text(voc,0,0);
        
        //rect(0,0,rectSize,rectSize);
      }else if(mode==true){
        ellipse(0,0,radius,radius);
      }
      popMatrix();
   }

 }
  video.updatePixels();   // keep updating the video data
}



// make the mode change  

void keyPressed(){
  mode=true;
}

void keyReleased(){
 mode=false;
}
