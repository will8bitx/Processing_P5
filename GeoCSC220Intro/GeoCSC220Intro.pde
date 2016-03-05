/************************************************************
/* Author: Dr. Parson
/* Creation Date: 11/22/2015, 2/17/2016
/* Due Date: Friday, 3/4/2016
/* Course: CSC220 Object Oriented Multimedia Programming
/* Professor Name: Dr. Parson
/* Assignment: 1.
/* Sketch name: GeoCSC220Intro
/* Purpose: Add novel 3D capabilities to this sketch.
 *********************************************************/
// STUDENT: Support full screen, frozen mode, & demo mode per handout.
boolean isfrozen = false ;
boolean isdemo = false ;
// These are the objects to plot.
GeometricDealy [] dealy = new GeometricDealy [3];
GeometricDealy demodealy = null ;  // null means there is no object there yet.

int restartInterval = 60 ;  // seconds between restarting the dealies.
int restartCounter = 0 ;

void setup() {
  // CSC220 STUDENT: We will use P3D to enable 3D shapes.
  // Make sure to test both full-screen and fixed-size-screen modes.
  // This screen size business is different for Processing 3.x.
  // UNCOMMENT MAKE THE NEXT LINE FIRST FOR FULL SCREEN
  //fullScreen(P2D);
  // OR UNCOMMENT MAKE THE NEXT LINE FIRST FOR fixed size
  size(1500, 1000, P3D); //3D Mode enabled
  background(0);
  frameRate(30);
  // We need to construct dealies to populate the array.
  for (int i = 0 ; i < dealy.length ; i++ ) {
    dealy[i] = new GeometricDealy((int)random(0,width), (int)random(0, height), (int)random(0, height/width),
      (int)random(1, width/4), (int)random(1, height/4),(int)random(1, height/8),
      (int)random(0,256), (int)random(0,256), (int)random(0,256));
  }
}

void draw() {
  // We need to support frozen mode.
  if (isfrozen) {
    return;
  }
  // We need to support the erase option.
  if (keyPressed && key == 'e') {
    background(0);
  }
  // We need to support demo mode for your basic geometric shape.
  if (isdemo) {
    if (demodealy == null) {
      demodealy =  new GeometricDealy(width/2,height/2,1,
        width/4, height/4, 1, 128, 128, 128);
    }
    demodealy.displayDemo();
    return ;
  }
  // STUDENT: fill a rectangle with an alpha < 255 in your background
  // color to get partial erase instead of full erase. The background
  // applies only in setup (to set initial background color) and in erase mode.
  demodealy = null ;  
  fill(0,0,0,10);
  rectMode(CENTER);
  //rect(width/2, height/2, width, height);
  
  // This restart stuff is optional. I like restarting new dealies periodically.
  restartCounter += 1 ;
  if (restartCounter >= (restartInterval * frameRate)) {
    restartCounter = 0 ;
    rect(width/2, height/2, width, height);
  }
  for (int i = 0 ; i < dealy.length ; i++ ) {
    dealy[i].display();
  }
}

// We must implement the frozen and demo commands
// using these keys. You must also implement the erase command,
// which shows up in draw(). Any others are optional, and if you add any key
// or mouse responses, make sure to document them in comments at the top
// of this file so I see them when I run your program.
void keyPressed() {
  if (key == 'f') {
    isfrozen = ! isfrozen ;
    println("Frozen? " + isfrozen);
  }
  if (key == 'd' && ! isfrozen) {
    isdemo = ! isdemo ;
    println("Demo? " + isdemo);
  }
  if (key == 'r' && !(isdemo || isfrozen)) {
    for (int i = 0 ; i < dealy.length ; i++) {
      dealy[i] = new GeometricDealy((int)random(0,width), (int)random(0, height), (int)random(0,width/4),
        (int)random(1, width/4), (int)random(1, height/4), (int)random(0,width/8),
        (int)random(0,256), (int)random(0,256), (int)random(0,256));

    }
  }
}