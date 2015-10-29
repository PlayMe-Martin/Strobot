
///////////////////////////////////////////////////////////
//   Graphical effects to be laid on top of animations   //
///////////////////////////////////////////////////////////


//Effects parameters
float glitcherEffect_noiseFactor = 40;
float glitcherEffect_noiseSpeed = 0.5;
color glitcherEffect_black = color(0);

int randomStripesEffect_minWidth = 4;
int randomStripesEffect_maxWidth = 20;
int randomStripesEffect_numberOfStripes = int(NUMBER_OF_PANELS*3/2.0);
int randomLinesEffect_minWidth = 4;
int randomLinesEffect_maxWidth = 12;
int randomLinesEffect_numberOfLines = NUMBER_OF_PANELS;

int flutterEffect_slices = 16;
float flutterEffect_unit = 64/flutterEffect_slices;
float flutterEffect_theta = 0;

int fadeout_counter = 0;
int fadein_counter = 0;
int fadeout_speed = 1;
int whiteout_speed = 8;

float blackWaveCircle_counter = 0;
float blackWaveCircle_speed = 16;

float windmill_randAngle = 0;
int windmill_intensity = 0;
int windmill_growthSpeed = 10;

int whiteflash_cpt = 0;
int redflash_cpt = 0;

//General effect switcher
void draw_effects() {
  if (effectToBeDrawn == true) {
    switch(currentEffectNumber) {   
      case 1:   draw_classicglitcherEffect();break;
      case 2:   draw_rgbGlitcherEffect();break;
      case 3:   draw_180RotateEffect();break;
      case 4:   draw_redocalypseEffect();break;
      case 5:   draw_flickerEffect();break;
      case 6:   draw_randomWhiteStripesEffect();break;
      case 7:   draw_randomRedStripesEffect();break;
      case 8:   draw_randomBlueStripesEffect();break;
      case 9:   draw_randomWhiteLinesEffect();break;
      case 10:  draw_randomRedLinesEffect();break;
      case 11:  draw_randomBlueLinesEffect();break;
      case 12:  draw_flickerSinglePanelEffect(0);break;
      case 13:  draw_flickerSinglePanelEffect(1);break;
      case 14:  draw_flickerSinglePanelEffect(2);break;
      case 15:  draw_flickerSinglePanelEffect(3);break;
      case 16:  draw_flickerSinglePanelEffect(4);break;
      case 17:  draw_flutterEffect();break;
      case 18:  draw_monochromeFilterEffect();break;
      case 19:  draw_invertFilterEffect();break;
      case 20:  draw_onlyLeftEffect();break;
      case 21:  draw_onlyRightEffect();break;
      case 22:  draw_randomPanelFlicker();break;
      case 23:  draw_rainbowColor();break;
      case 24:  draw_additionalfadeout();break;
      case 25:  draw_additionalfadein();break;
      case 26:  draw_additionalfadeout_red();break;
      case 27:  draw_additionalfadein_red();break;
      case 28:  draw_additionalwhiteout();break;
      case 29:  draw_additionalredout();break;
      case 30:  draw_blackWaveCircle();break;
      case 31:  draw_windmill();break;
      case 32:  draw_whiteflash();break;
      case 33:  draw_redflash();break;
      case 34:  draw_randomRedPanelFlicker();break;
      default: break;
    }
  }
}

void initSpecificEffectParams() {
  switch(currentEffectNumber) {
    case 24: fadeout_counter         = 0; break;
    case 25: fadein_counter          = 0; break;
    case 26: fadeout_counter         = 0; break;
    case 27: fadein_counter          = 0; break;
    case 28: fadeout_counter         = 0; break;
    case 29: fadeout_counter         = 0; break;
    case 30: blackWaveCircle_counter = 0; break;
    case 31: windmill_randAngle     += 0.3*PI; windmill_intensity = 0; break;
    case 32: whiteflash_cpt          = 0; break;
    case 33: redflash_cpt            = 0; break;
    default: break;
  }
}

////////////////////////////////////////////////////////////
// Effects implementation
/////////


void draw_classicglitcherEffect() {
  loadPixels();
  int[] newPixels = new int[width*height];
  for (int i=0; i<newPixels.length; i++) {
    newPixels[i] = pixels[i];
  }
  int randomiserX = int(glitcherEffect_noiseFactor*(noise(glitcherEffect_noiseSpeed*frameCount)-0.5));
  int randomiserY = int(glitcherEffect_noiseFactor*(noise(glitcherEffect_noiseSpeed*(frameCount + 1000))-0.5));
  for (int i = 0; i<height; i++) {
    for (int j = 0; j<width; j++) {
      if ((i+randomiserX)*width + (j+randomiserY) < pixels.length && (i+randomiserX)*width + (j+randomiserY) >= 0) {
        newPixels[i*width + j] = pixels[(i+randomiserX)*width + (j+randomiserY)];
      }
      else {
        newPixels[i*width + j] = glitcherEffect_black; 
      }
    } 
  }
  for (int i=0; i<newPixels.length; i++) {
    pixels[i] = newPixels[i];
  }
  updatePixels();
}

void draw_rgbGlitcherEffect() {
  loadPixels();
  int[] newPixelsRed = new int[width*height];
  int[] newPixelsGreen = new int[width*height];
  int[] newPixelsBlue = new int[width*height];
  for (int i=0; i<newPixelsRed.length; i++) {
    newPixelsRed[i] = pixels[i];
    newPixelsGreen[i] = pixels[i];
    newPixelsBlue[i] = pixels[i];
  }
  int randomiserXRed   = int(glitcherEffect_noiseFactor*(noise(glitcherEffect_noiseSpeed*frameCount)-0.5));
  int randomiserYRed   = int(glitcherEffect_noiseFactor*(noise(glitcherEffect_noiseSpeed*(frameCount + 1000))-0.5));
  int randomiserXGreen = int(glitcherEffect_noiseFactor*(noise(glitcherEffect_noiseSpeed*(frameCount + 2000))-0.5));
  int randomiserYGreen = int(glitcherEffect_noiseFactor*(noise(glitcherEffect_noiseSpeed*(frameCount + 3000))-0.5));
  int randomiserXBlue  = int(glitcherEffect_noiseFactor*(noise(glitcherEffect_noiseSpeed*(frameCount + 4000))-0.5));
  int randomiserYBlue  = int(glitcherEffect_noiseFactor*(noise(glitcherEffect_noiseSpeed*(frameCount + 5000))-0.5));
  for (int i = 0; i<height; i++) {
    for (int j = 0; j<width; j++) {
      if ((i+randomiserXRed)*width + (j+randomiserYRed) < pixels.length && (i+randomiserXRed)*width + (j+randomiserYRed) >= 0) {
        newPixelsRed[i*width + j] = pixels[(i+randomiserXRed)*width + (j+randomiserYRed)];
      }
      else {
        newPixelsRed[i*width + j] = glitcherEffect_black; 
      }
      
      if ((i+randomiserXGreen)*width + (j+randomiserYGreen) < pixels.length && (i+randomiserXGreen)*width + (j+randomiserYGreen) >= 0) {
        newPixelsGreen[i*width + j] = pixels[(i+randomiserXGreen)*width + (j+randomiserYGreen)];
      }
      else {
        newPixelsGreen[i*width + j] = glitcherEffect_black; 
      }
      
      if ((i+randomiserXBlue)*width + (j+randomiserYBlue) < pixels.length && (i+randomiserXBlue)*width + (j+randomiserYBlue) >= 0) {
        newPixelsBlue[i*width + j] = pixels[(i+randomiserXBlue)*width + (j+randomiserYBlue)];
      }
      else {
        newPixelsBlue[i*width + j] = glitcherEffect_black; 
      }
      
    } 
  }
  
  for (int i=0; i<pixels.length; i++) {
    pixels[i] = 255 << 24 | newPixelsRed[i] << 16 | newPixelsGreen[i] << 8 | newPixelsBlue[i];
  }
  updatePixels();
}

void draw_180RotateEffect() {
  loadPixels();
  int[] newPixels = new int[width*height];
  for (int i=0; i<newPixels.length; i++) {
    newPixels[i] = pixels[newPixels.length - 1 - i];
  }
  for (int i=0; i<newPixels.length; i++) {
    pixels[i] = newPixels[i];
  }
  updatePixels();
}

void draw_redocalypseEffect() {
  loadPixels();
  for (int i=0; i<pixels.length; i++) {
    pixels[i] = pixels[i]<<16;
  }
  updatePixels();
}

void draw_flickerEffect() {
  if (random(1) > 0.6) {
    loadPixels();
    for (int i=0; i<pixels.length; i++) {
      pixels[i] = glitcherEffect_black;
    }
    updatePixels();
  }
}


void draw_randomWhiteStripesEffect() {
  pushStyle();
  noStroke();
  fill(255);
  for (int i = 0; i < randomStripesEffect_numberOfStripes; i++) {
    rect(random(width),0,random(randomStripesEffect_minWidth,randomStripesEffect_maxWidth),height);
  }
  popStyle();
}

void draw_randomRedStripesEffect() {
  pushStyle();
  noStroke();
  colorMode(RGB);
  fill(255,0,0);
  for (int i = 0; i < randomStripesEffect_numberOfStripes; i++) {
    rect(random(width),0,random(randomStripesEffect_minWidth,randomStripesEffect_maxWidth),height);
  }
  popStyle();
}

void draw_randomBlueStripesEffect() {
  pushStyle();
  noStroke();
  colorMode(RGB);
  for (int i = 0; i < randomStripesEffect_numberOfStripes; i++) {
    int randomcol = (int) spotsmulticolor_colorselection[floor(random(spotsmulticolor_colorselection.length))];
    fill(randomcol);
    rect(random(width),0,random(randomStripesEffect_minWidth,randomStripesEffect_maxWidth),height);
  }
  popStyle();
}

void draw_randomWhiteLinesEffect() {
  pushStyle();
  noStroke();
  fill(255);
  for (int i = 0; i < randomLinesEffect_numberOfLines; i++) {
    rect(0,random(height),width,random(randomLinesEffect_minWidth,randomLinesEffect_maxWidth));
  }
  popStyle();
}

void draw_randomRedLinesEffect() {
  pushStyle();
  colorMode(RGB);
  noStroke();
  fill(255,0,0);
  for (int i = 0; i < randomLinesEffect_numberOfLines; i++) {
    rect(0,random(height),width,random(randomLinesEffect_minWidth,randomLinesEffect_maxWidth));
  }
  popStyle();
}

void draw_randomBlueLinesEffect() {
  pushStyle();
  colorMode(RGB);
  noStroke();
  for (int i = 0; i < randomLinesEffect_numberOfLines; i++) {
    int randomcol = (int) spotsmulticolor_colorselection[floor(random(spotsmulticolor_colorselection.length))];
    fill(randomcol);
    rect(0,random(height),width,random(randomLinesEffect_minWidth,randomLinesEffect_maxWidth));
  }
  popStyle();
}

void draw_flickerSinglePanelEffect(int panel) {
  pushStyle();
  noStroke();
  float rand = random(1);
  if (rand > 0.9) {
    fill(0);
    rect(panel*width/NUMBER_OF_PANELS,0,width/NUMBER_OF_PANELS, height);
  }
  else if (rand > 0.75) {
    fill(255);
    rect(panel*width/NUMBER_OF_PANELS,0,width/NUMBER_OF_PANELS, height);
  }
  else if (rand > 0.65) {
    fill(255);
    rect(panel*width/NUMBER_OF_PANELS,0,width/NUMBER_OF_PANELS, height/2);
  }
  else if (rand > 0.55) {
    fill(255);
    rect(panel*width/NUMBER_OF_PANELS,height/2,width/NUMBER_OF_PANELS, height/2);
  }
  else if (rand > 0.50) {
    fill(255);
    rect(panel*width/NUMBER_OF_PANELS,0,width/(2*NUMBER_OF_PANELS), height);
  }
  else if (rand > 0.45) {
    fill(255);
    rect((2*panel+1)*width/(2*NUMBER_OF_PANELS),0,width/(2*NUMBER_OF_PANELS), height);
  }
  popStyle();
}

void draw_flickerSinglePanelRedEffect(int panel) {
  pushStyle();
  noStroke();
  float rand = random(1);
  if (rand > 0.9) {
//    fill(0);
//    rect(panel*width/NUMBER_OF_PANELS,0,width/NUMBER_OF_PANELS, height);
  }
  else if (rand > 0.75) {
    fill(int(random(150,255)),0,0);
    rect(panel*width/NUMBER_OF_PANELS,0,width/NUMBER_OF_PANELS, height);
  }
  else if (rand > 0.65) {
    fill(int(random(150,255)),0,0);
    rect(panel*width/NUMBER_OF_PANELS,0,width/NUMBER_OF_PANELS, height/2);
  }
  else if (rand > 0.55) {
    fill(int(random(150,255)),0,0);
    rect(panel*width/NUMBER_OF_PANELS,height/2,width/NUMBER_OF_PANELS, height/2);
  }
  else if (rand > 0.50) {
    fill(int(random(150,255)),0,0);
    rect(panel*width/NUMBER_OF_PANELS,0,width/(2*NUMBER_OF_PANELS), height);
  }
  else if (rand > 0.45) {
    fill(int(random(150,255)),0,0);
    rect((2*panel+1)*width/(2*NUMBER_OF_PANELS),0,width/(2*NUMBER_OF_PANELS), height);
  }
  popStyle();
}

void draw_randomPanelFlicker() {
  pushMatrix();
  resetMatrix();
  pushStyle();
  for (int panelNb=0; panelNb < NUMBER_OF_PANELS; panelNb++) {
    if (random(1) > 0.8) {
      draw_flickerSinglePanelEffect(panelNb);
    }
    else if (random(1) > 0.8) {
      fill(0);
      noStroke();
      rect(panelNb*width/NUMBER_OF_PANELS,0,width/NUMBER_OF_PANELS, height);
    }
  }
  popStyle();
  popMatrix();
}

void draw_randomRedPanelFlicker() {
  pushMatrix();
  resetMatrix();
  pushStyle();
  for (int panelNb=0; panelNb < NUMBER_OF_PANELS; panelNb++) {
    if (random(1) > 0.8) {
      draw_flickerSinglePanelRedEffect(panelNb);
    }
    else if (random(1) > 0.8) {
      fill(0);
      noStroke();
      rect(panelNb*width/NUMBER_OF_PANELS,0,width/NUMBER_OF_PANELS, height);
    }
  }
  popStyle();
  popMatrix();
}

void draw_flutterEffect() {
  for (int flutter_i=0; flutter_i<flutterEffect_slices; flutter_i++) {
    float flutter_edgeX = map(sin(flutterEffect_theta+flutter_i*(TWO_PI/flutterEffect_slices)), -1, 1, 0, width*.05);
    float flutter_edgeY = map(sin(flutterEffect_theta+flutter_i*(TWO_PI/flutterEffect_slices)), -1, 1, 0, height*.05);
    int flutter_y = int(flutter_i*flutterEffect_unit);
    blend(0, flutter_y, width, int(flutterEffect_unit), int(-flutter_edgeX), int(flutter_y-flutter_edgeY), int(width+flutter_edgeX), int(flutterEffect_unit+2*flutter_edgeY), SCREEN);
  }
  flutterEffect_theta += TWO_PI/flutterEffect_slices;
}

void draw_monochromeFilterEffect() {
  filter(GRAY);
}

void draw_invertFilterEffect() {
  filter(INVERT);
}

void draw_onlyLeftEffect() {
  pushStyle();
  noStroke();
  fill(0);
  rect(0,0,(NUMBER_OF_PANELS/2 + 1)*width/NUMBER_OF_PANELS,height);
  popStyle();
}

void draw_onlyRightEffect() {
  pushStyle();
  noStroke();
  fill(0);
  rect(width - (NUMBER_OF_PANELS/2 + 1)*width/NUMBER_OF_PANELS,0,(NUMBER_OF_PANELS/2 + 1)*width/NUMBER_OF_PANELS,height);
  popStyle();
}

void draw_rainbowColor() {
  pushStyle();
  noStroke();
  colorMode(HSB);
  fill(frameCount%255, 255, 255, 80);
  rect(0,0,width,height);
  
  popStyle();
}


void draw_additionalfadeout() {
  pushStyle();
  noStroke();
  fill(0, 0, 0, min(255, fadeout_counter));
  rect(0,0,width,height);
  popStyle();
  
  fadeout_counter += fadeout_speed;
}

void draw_additionalfadein() {
  pushStyle();
  noStroke();
  fill(0, 0, 0, max(0, 255 - fadein_counter));
  rect(0,0,width,height);
  popStyle();
  
  fadein_counter += fadeout_speed;
}

void draw_additionalfadeout_red() {
  draw_redocalypseEffect();
  pushStyle();
  noStroke();
  fill(0, 0, 0, min(255, fadeout_counter));
  rect(0,0,width,height);
  popStyle();
  
  fadeout_counter += fadeout_speed;
}

void draw_additionalfadein_red() {
  draw_redocalypseEffect();
  pushStyle();
  noStroke();
  fill(0, 0, 0, max(0, 255 - fadein_counter));
  rect(0,0,width,height);
  popStyle();
  
  fadein_counter += fadeout_speed;
}

void draw_additionalwhiteout() {
  pushStyle();
  noStroke();
  fill(255, 255, 255, min(255, fadeout_counter));
  rect(0,0,width,height);
  popStyle();
  
  fadeout_counter += whiteout_speed;
}

void draw_additionalredout() {
  pushStyle();
  noStroke();
  fill(255, 0, 0, min(255, fadeout_counter));
  rect(0,0,width,height);
  popStyle();
  
  fadeout_counter += whiteout_speed;
}

void draw_blackWaveCircle() {
  pushStyle();
  pushMatrix();
  resetMatrix();
  noFill();
  stroke(0);
  strokeWeight(32);
  ellipse(width/2, height/2, blackWaveCircle_counter, blackWaveCircle_counter);
  popMatrix(); 
  popStyle();
  blackWaveCircle_counter += blackWaveCircle_speed; 
}


void draw_windmill() {
  pushStyle();
  colorMode(RGB);
  fill(windmill_intensity);
  noStroke();
  pushMatrix();
  resetMatrix();
  translate(width*0.5, height*0.5);
  rotate(frameCount / 100.0 + windmill_randAngle);
  star(0, 0, 8, 2000, 3); 
  popMatrix();
  popStyle();
  windmill_intensity = min(windmill_intensity + windmill_growthSpeed, 255);
}

void draw_whiteflash() {
  if (whiteflash_cpt < 3) {
    pushStyle(); 
    pushMatrix();
    fill(255);
    noStroke();
    rect(0,0,width,height);
    resetMatrix();
    popStyle();
    popMatrix();
  }
  whiteflash_cpt += 1;
}

void draw_redflash() {
  if (redflash_cpt < 3) {
    pushStyle(); 
    pushMatrix();
    fill(255,0,0);
    noStroke();
    rect(0,0,width,height);
    resetMatrix();
    popStyle();
    popMatrix();
  }
  redflash_cpt += 1;
}
