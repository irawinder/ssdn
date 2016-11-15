/**
 * This is a simple example of how to use the Keystone library.
 *
 * To use this example in the real world, you need a projector
 * and a surface you want to project your Processing sketch onto.
 *
 * Simply drag the corners of the CornerPinSurface so that they
 * match the physical surface's corners. The result will be an
 * undistorted projection, regardless of projector position or 
 * orientation.
 *
 * You can also create more than one Surface object, and project
 * onto multiple flat surfaces using a single projector.
 *
 * This extra flexbility can comes at the sacrifice of more or 
 * less pixel resolution, depending on your projector and how
 * many surfaces you want to map. 
 */

import deadpixel.keystone.*;
import processing.video.*;

Keystone ks;
CornerPinSurface surface;
Movie myMovieWS, myMovieAS, myMoviePS, myMoviePT;
Boolean isFigureN = true;
Boolean isFigureA = false;
Boolean isFigureP = false;
Boolean isFigure1 = false;
Boolean isFigure2 = false;
Boolean isFigure3 = false;
Boolean isFigure4 = false;
Boolean isFigure5 = false;
Boolean isFigureO = false;
Boolean isMovieWS = false;
Boolean isMovieAS = false;
Boolean isMoviePS = false;
Boolean isMoviePT = false;

PGraphics offscreen;

PImage imgN, imgA, imgP, img1, img2, img3, img4, img5, imgO;

void setup() {
  // Keystone will only work with P3D or OPENGL renderers, 
  // since it relies on texture mapping to deform
  size(displayWidth, displayHeight, P3D);

  ks = new Keystone(this);
  //surface = ks.createCornerPinSurface(1920, 1280, 20);
  surface = ks.createCornerPinSurface(967, 897, 20);
  // imgN = loadImage("KSA_network.gif");
  imgN = loadImage("KSA_network_water.gif");
  imgA = loadImage("KSA_network_agri.gif");
  imgP = loadImage("KSA_network_power.gif");
  img1 = loadImage("KSA_result_2030_100-0.gif");
  img2 = loadImage("KSA_result_2030_75-25.gif");
  img3 = loadImage("KSA_result_2030_50-50.gif");
  img4 = loadImage("KSA_result_2030_25-75.gif");
  img5 = loadImage("KSA_result_2030_0-100.gif");
  imgO = loadImage("KSA_result_2030_all.gif");

  // We need an offscreen buffer to draw the surface we
  // want projected
  // note that we're matching the resolution of the
  // CornerPinSurface.
  // (The offscreen buffer can be P2D or P3D)
  offscreen = createGraphics(1920, 1080, P3D);
  
  myMovieWS = new Movie(this, "Result_2030_RP.avi");
  myMovieAS = new Movie(this, "Results_AZ100_30(1).avi");
  myMoviePS = new Movie(this, "Results_PWR_30(1).avi");
  myMoviePT = new Movie(this, "Results_PWR_15-50(5)_Cost100.avi");
  myMovieWS.play();
  myMovieWS.loop();
  myMovieAS.play();
  myMovieAS.loop();
  myMoviePS.play();
  myMoviePS.loop();
  myMoviePT.play();
  myMoviePT.loop();
}

void draw() {
  // Convert the mouse coordinate into surface coordinates
  // this will allow you to use mouse events inside the 
  // surface from your screen. 
  PVector surfaceMouse = surface.getTransformedMouse();

  // Draw the scene, offscreen
  offscreen.beginDraw();
  offscreen.background(255);
  offscreen.fill(0, 255, 0);
  //offscreen.image(img,-800,-150,3300,1600);
  //offscreen.image(img,0,0,1920,1080);
  
  if (isFigureN) {
    offscreen.image(imgN,0,0);
  } else if (isFigureA) {
    offscreen.image(imgA,0,0);
  } else if (isFigureP) {
    offscreen.image(imgP,0,0);
  } else if (isFigure1) {
    offscreen.image(img1,0,0);
  } else if (isFigure2) {
    offscreen.image(img2,0,0);
  } else if (isFigure3) {
    offscreen.image(img3,0,0);
  } else if (isFigure4) {
    offscreen.image(img4,0,0);
  } else if (isFigure5) {
    offscreen.image(img5,0,0);
  } else if (isFigureO) {
    offscreen.image(imgO,0,0);
  } else if (isMovieWS) {
    offscreen.image(myMovieWS,-49,-38,1066,959);
  } else if (isMovieAS) {
    offscreen.image(myMovieAS,-49,-38,1066,959);
  } else if (isMoviePS) {
    offscreen.image(myMoviePS,-49,-38,1066,959);
  } else if (isMoviePT) {
    offscreen.image(myMoviePT,-49,-38,1066,959);
  }
  
  offscreen.ellipse(surfaceMouse.x, surfaceMouse.y, 75, 75);
  offscreen.filter(INVERT);
  offscreen.endDraw();

  // most likely, you'll want a black background to minimize
  // bleeding around your projection area
  background(0);
 
  // render the scene, transformed using the corner pin surface
  surface.render(offscreen);
}

void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load("keystone.xml");
    break;

  case 's':
    // saves the layout
    ks.save("keystone.xml");
    break;
  
  case 'n':
    //
    isFigureN = true;
    isFigureA = false;
    isFigureP = false;
    isFigure1 = false;
    isFigure2 = false;
    isFigure3 = false;
    isFigure4 = false;
    isFigure5 = false;
    isFigureO = false;
    isMovieWS = false;
    isMovieAS = false;
    isMoviePS = false;
    isMoviePT = false;
    break;
  
  case 'a':
    //
    isFigureN = false;
    isFigureA = true;
    isFigureP = false;
    isFigure1 = false;
    isFigure2 = false;
    isFigure3 = false;
    isFigure4 = false;
    isFigure5 = false;
    isFigureO = false;
    isMovieWS = false;
    isMovieAS = false;
    isMoviePS = false;
    isMoviePT = false;
    break;
  
  case 'p':
    //
    isFigureN = false;
    isFigureA = false;
    isFigureP = true;
    isFigure1 = false;
    isFigure2 = false;
    isFigure3 = false;
    isFigure4 = false;
    isFigure5 = false;
    isFigureO = false;
    isMovieWS = false;
    isMovieAS = false;
    isMoviePS = false;
    isMoviePT = false;
    break;
  
  case '1':
    //
    isFigureN = false;
    isFigureA = false;
    isFigureP = false;
    isFigure1 = true;
    isFigure2 = false;
    isFigure3 = false;
    isFigure4 = false;
    isFigure5 = false;
    isFigureO = false;
    isMovieWS = false;
    isMoviePS = false;
    isMoviePT = false;
    break;
  
  case '2':
    //
    isFigureN = false;
    isFigureA = false;
    isFigureP = false;
    isFigure1 = false;
    isFigure2 = true;
    isFigure3 = false;
    isFigure4 = false;
    isFigure5 = false;
    isFigureO = false;
    isMovieWS = false;
    isMovieAS = false;
    isMoviePS = false;
    isMoviePT = false;
    break;
  
  case '3':
    //
    isFigureN = false;
    isFigureA = false;
    isFigureP = false;
    isFigure1 = false;
    isFigure2 = false;
    isFigure3 = true;
    isFigure4 = false;
    isFigure5 = false;
    isFigureO = false;
    isMovieWS = false;
    isMovieAS = false;
    isMoviePS = false;
    isMoviePT = false;
    break;
  
  case '4':
    //
    isFigureN = false;
    isFigureA = false;
    isFigureP = false;
    isFigure1 = false;
    isFigure2 = false;
    isFigure3 = false;
    isFigure4 = true;
    isFigure5 = false;
    isFigureO = false;
    isMovieWS = false;
    isMovieAS = false;
    isMoviePS = false;
    isMoviePT = false;
    break;
  
  case '5':
    //
    isFigureN = false;
    isFigureA = false;
    isFigureP = false;
    isFigure1 = false;
    isFigure2 = false;
    isFigure3 = false;
    isFigure4 = false;
    isFigure5 = true;
    isFigureO = false;
    isMovieWS = false;
    isMovieAS = false;
    isMoviePS = false;
    isMoviePT = false;
    break;
  
  case 'o':
    //
    isFigureN = false;
    isFigureA = false;
    isFigureP = false;
    isFigure1 = false;
    isFigure2 = false;
    isFigure3 = false;
    isFigure4 = false;
    isFigure5 = false;
    isFigureO = true;
    isMovieWS = false;
    isMovieAS = false;
    isMoviePS = false;
    isMoviePT = false;
    break;
  
  case 'w':
    //
    isFigureN = false;
    isFigureA = false;
    isFigureP = false;
    isFigure1 = false;
    isFigure2 = false;
    isFigure3 = false;
    isFigure4 = false;
    isFigure5 = false;
    isFigureO = false;
    isMovieWS = true;
    isMovieAS = false;
    isMoviePS = false;
    isMoviePT = false;
    break;
  
  case 'e':
    //
    isFigureN = false;
    isFigureA = false;
    isFigureP = false;
    isFigure1 = false;
    isFigure2 = false;
    isFigure3 = false;
    isFigure4 = false;
    isFigure5 = false;
    isFigureO = false;
    isMovieWS = false;
    isMovieAS = true;
    isMoviePS = false;
    isMoviePT = false;
    break;
  
  case '[':
    //
    isFigureN = false;
    isFigureA = false;
    isFigureP = false;
    isFigure1 = false;
    isFigure2 = false;
    isFigure3 = false;
    isFigure4 = false;
    isFigure5 = false;
    isFigureO = false;
    isMovieWS = false;
    isMovieAS = false;
    isMoviePS = true;
    isMoviePT = false;
    break;
  
  case ']':
    //
    isFigureN = false;
    isFigureA = false;
    isFigureP = false;
    isFigure1 = false;
    isFigure2 = false;
    isFigure3 = false;
    isFigure4 = false;
    isFigure5 = false;
    isFigureO = false;
    isMovieWS = false;
    isMovieAS = false;
    isMoviePS = false;
    isMoviePT = true;
    break;
  
  }
}

boolean sketchFullScreen() {
  return true;
}

void movieEvent(Movie m) {
  m.read();
}
