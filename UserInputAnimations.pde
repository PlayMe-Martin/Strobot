////////////////////////////////////////////////////////
// Special animations resulting from user interaction //
////////////////////////////////////////////////////////


//////////////////////////////////////////
// Tempo-synced color stroboscope
//////////////////////////////////////////

//StroboAutoPad parameters - special animation which is not to be registered
float registeredTempo;
boolean stroboAutoPadNoteOff = false;

void draw_stroboAutoPad(int colorset, float tempo, int noteSpeed) {
  if (authorizePanelStrobe == true) {
    pushStyle();
    colorMode(HSB);
    noStroke();
    
    //Update the tempo
    frameRate(2 * noteSpeed * tempo/60);
    
    if (frameCount % 2 == 0)
    {
      if (colorset == COLORSET_WHITE) {
        fill(255);
      }
      if (colorset == COLORSET_RED) {
        fill(0,255,255);
      }
      if (colorset == COLORSET_COLORFUL) {
        fill(int(random(0,360)),255,255);
      }
      
      rect(0,0,width,height);
    }
    else
    {
      fill(0);
      rect(0,0,width,height);
    }
    
    popStyle();
    
    if (stroboAutoPadNoteOff == true) {
      tempo = registeredTempo;
      stroboAutoPadNoteOff = false;
    }
  }
  if (authorizeDMXStrobe == true) {
    //DMX
    if (noteSpeed<=1) {
      
    }
    else if (noteSpeed<=2) {
      
    }
    else if (noteSpeed<=4) {
      
    }
    else if (noteSpeed<=8) {
      
    }
  }   
}

//Tempo in argument is supposed to be given in BPM
//Speed : 1 - > one flash per beat, 2 -> 8th, 4 -> 16th, 8 -> 32th, etc.
void setup_stroboAutoPad(int colorset, float tempo, int noteSpeed) {
  registeredTempo = tempo;
  frameRate(2 * noteSpeed * tempo/60);
}

//////////////////////////////////////////
// White-Out
//////////////////////////////////////////

void draw_AutoModeWhiteOut(int whiteout) {
  pushStyle();  // Start a new style
  colorMode(RGB);
  if (random(255) > whiteout) {  //Make the screen glitch when the hipass gets stronger - whiteoutPower is between 0 and 127 
    fill(255, map(whiteout,0,127,0,255));  
  }
  else {
    fill(0);
  } 
  noStroke();
  rect(0,0,width,height);
  popStyle();
}

//////////////////////////////////////////
// BlackOut
//////////////////////////////////////////

void draw_AutoModeBlackOut(int blackout) {
  pushStyle();  // Start a new style
  colorMode(RGB);
  fill(0, map(blackout,0,127,0,255));
  noStroke();
  rect(0,0,width,height);
  popStyle();
}

//////////////////////////////////////////
// Repeat-synced splitter/shredder
//////////////////////////////////////////

void draw_AutoModeShredder(int shredderPower) {
  shiftpixels_speed = shiftpixels_fastspeed;
  if (shredderPower < 30) {
    draw_shiftpixelsup();
  }
  else if (shredderPower < 50) {
    draw_shiftpixelsdown();
  }
  else if (shredderPower < 70) {
    draw_shiftpixelsleft();
  }  
  else if (shredderPower < 90) {
    draw_shiftpixelsright();
  }
  else if (shredderPower < 110) {
    draw_shredpixelsvertical();
  }
  else {
    draw_shredpixelshorizontal();
  }
  
}

//////////////////////////////////////////
// Automatic color tint
//////////////////////////////////////////

int automodecolortint_hue = 0;

void draw_AutoModeColorChange() {
  pushStyle();  
  colorMode(HSB);
  fill(automodecolortint_hue % 360,255,255, 100);
  noStroke();
  rect(0,0,width,height);
  popStyle();
  automodecolortint_hue += 1;
}

//////////////////////////////////////////
// Kill LED Panel
//////////////////////////////////////////

void draw_AutoModeKillLedPanel() {
  pushStyle();  // Start a new style
  fill(0);
  noStroke();
  rect(0,0,width,height);
  popStyle();
}

//////////////////////////////////////////
// WhiteJamaMono
//////////////////////////////////////////

void draw_whiteJamaMono(int whiteJamaMonoPosition_x) {
  pushStyle();
  fill(255);
  noStroke();
  rect((int) (whiteJamaMonoPosition_x * width/127) - width,0,width,height);    //Scale the MIDI value to the screen's width
  popStyle();
}

//////////////////////////////////////////
// KillPanels
//////////////////////////////////////////

void draw_killLedPanels() {
  pushStyle();
  fill(0);
  noStroke();
  rect(0,0,width,height);
  popStyle();
}

//////////////////////////////////////////
// WhiteNoiseEffect
//////////////////////////////////////////

void draw_whiteNoiseEffect(int noiseIntensity) {
  pushStyle();
  noStroke();
  for (int i=0;i<width/4;i++) {
    for (int j=0;j<height/4;j++) {
      fill(random(noiseIntensity));
      rect(i*4,j*4,4,4);
    }
  }
  popStyle();
}
