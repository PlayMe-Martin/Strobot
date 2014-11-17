
///////////////////////////////////////////////////////////////
//   DMX animations - Sequences used by the automatic mode   //
///////////////////////////////////////////////////////////////


// Play the DMX animations
void playDMXAnimation() {
  switch(dmxAnimationNumber) {
    case 1:   dmxAnim_blackout();                  break;         // 1 -   Full Blackout
    
    case 2:   dmxAnim_fullStrobeVerySlow();        break;         // 2 -   Full Strobe - Very Slow
    case 3:   dmxAnim_fullStrobeSlow();            break;         // 3 -   Full Strobe - Slow
    case 4:   dmxAnim_fullStrobeMedium();          break;         // 4 -   Full Strobe - Medium
    case 5:   dmxAnim_fullStrobeFast();            break;         // 5 -   Full Strobe - Fast
    case 6:   dmxAnim_fullStrobeVeryFast();        break;         // 6 -   Full Strobe - Very Fast
    case 7:   dmxAnim_leftStrobeVerySlow();        break;         // 7 -   Left Strobe - Very Slow
    case 8:   dmxAnim_leftStrobeSlow();            break;         // 8 -   Left Strobe - Slow     
    case 9:   dmxAnim_leftStrobeMedium();          break;         // 9 -   Left Strobe - Medium   
    case 10:  dmxAnim_leftStrobeFast();            break;         // 10 -  Left Strobe - Fast     
    case 11:  dmxAnim_leftStrobeVeryFast();        break;         // 11 -  Left Strobe - Very Fast
    case 12:  dmxAnim_rightStrobeVerySlow();       break;         // 12 -  Right Strobe - Very Slow
    case 13:  dmxAnim_rightStrobeSlow();           break;         // 13 -  Right Strobe - Slow     
    case 14:  dmxAnim_rightStrobeMedium();         break;         // 14 -  Right Strobe - Medium   
    case 15:  dmxAnim_rightStrobeFast();           break;         // 15 -  Right Strobe - Fast     
    case 16:  dmxAnim_rightStrobeVeryFast();       break;         // 16 -  Right Strobe - Very Fast
    
    case 17:  dmxAnim_alternateStrobe2();          break;         // 17 -  Alternate Strobe - 2/4
    case 18:  dmxAnim_alternateStrobe4();          break;         // 18 -  Alternate Strobe - 1/4
    case 19:  dmxAnim_alternateStrobe8();          break;         // 19 -  Alternate Strobe - 1/8
    case 20:  dmxAnim_alternateStrobe16();         break;         // 20 -  Alternate Strobe - 1/16
    
    case 21:  dmxAnim_growingFullStrobe();         break;         // 21 -  Growing Strobe - Full
    case 22:  dmxAnim_growingLeftStrobe();         break;         // 22 -  Growing Strobe - Left
    case 23:  dmxAnim_growingRightStrobe();        break;         // 23 -  Growing Strobe - Right
    case 24:  dmxAnim_growingAlternateStrobe2();   break;         // 24 -  Growing Strobe - Alternate Left/Right - 2/4
    case 25:  dmxAnim_growingAlternateStrobe4();   break;         // 25 -  Growing Strobe - Alternate Left/Right - 1/4
    case 26:  dmxAnim_growingAlternateStrobe8();   break;         // 26 -  Growing Strobe - Alternate Left/Right - 1/8
    default:  dmxAnim_blackout();                  break;
  }
}

// Must be called whenever dmxAnimationNumber is modified
void setupDMXAnimation() {
  switch(dmxAnimationNumber) {
    case 1:   break;
    case 21:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 22:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 23:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 24:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 25:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 26:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    default:  break;
  } 
}


/////////////////////////////////////////////////////////////////////////////////////
// Each individual function is a single animation using the registered DMX devices

// Note :
// The animations here do not need to be coded using the impractical intensity tables declared in DMX
// They are only needed because multiple parameters of the strobes or the PARs need to be controled by a single MIDI intensity value
// These animations can use every device registered inside DMXList_FrontLeftStroboscopes, DMXList_FrontRightStroboscopes, etc.
// and call startDMX with the desired values
// When implementing these animations, be careful to stay modular : everything needs to be scalable, and look good whether the front
// left stroboscopes group contains one, or ten devices.

// Stop all devices, create a complete blackout
void dmxAnim_blackout() {
  for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
    stroboscope.stopDMX();
  }
  for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
    stroboscope.stopDMX();
  }
  for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
    stroboscope.stopDMX();
  }
  for (DMX_PAR par: DMXList_PARs) {
    par.stopDMX();
  }
}

/////////////////////////////////////////////////////////////////////////////////
// Generic continuous stroboscopes
/////////////////////////////////////////////////////////////////////////////////

// Switch all stroboscopes on
void dmxAnim_fullStrobe(int speed, int intensity) {
  for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
    stroboscope.startDMX(speed,intensity);
  }
  for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
    stroboscope.startDMX(speed,intensity);
  }
  for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
    stroboscope.startDMX(speed,intensity);
  }
}

void dmxAnim_fullStrobeVerySlow() {
  dmxAnim_fullStrobe(80,255);
}

void dmxAnim_fullStrobeSlow() {
  dmxAnim_fullStrobe(125,255);
}

void dmxAnim_fullStrobeMedium() {
  dmxAnim_fullStrobe(170,255);
}

void dmxAnim_fullStrobeFast() {
  dmxAnim_fullStrobe(215,255);
}

void dmxAnim_fullStrobeVeryFast() {
  dmxAnim_fullStrobe(255,255);
}

// Switch the left stroboscopes on
void dmxAnim_leftStrobe(int speed, int intensity) {
  for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
    stroboscope.startDMX(speed,intensity);
  }
  for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
    stroboscope.stopDMX();
  }
  for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
    stroboscope.stopDMX();
  }
}

void dmxAnim_leftStrobeVerySlow() {
  dmxAnim_leftStrobe(80,255);
}

void dmxAnim_leftStrobeSlow() {
  dmxAnim_leftStrobe(125,255);
}

void dmxAnim_leftStrobeMedium() {
  dmxAnim_leftStrobe(170,255);
}

void dmxAnim_leftStrobeFast() {
  dmxAnim_leftStrobe(215,255);
}

void dmxAnim_leftStrobeVeryFast() {
  dmxAnim_leftStrobe(255,255);
}

// Switch the right stroboscopes on
void dmxAnim_rightStrobe(int speed, int intensity) {
  for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
    stroboscope.stopDMX();
  }
  for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
    stroboscope.startDMX(speed,intensity);
  }
  for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
    stroboscope.stopDMX();
  }
}

void dmxAnim_rightStrobeVerySlow() {
  dmxAnim_rightStrobe(80,255);
}

void dmxAnim_rightStrobeSlow() {
  dmxAnim_rightStrobe(125,255);
}

void dmxAnim_rightStrobeMedium() {
  dmxAnim_rightStrobe(170,255);
}

void dmxAnim_rightStrobeFast() {
  dmxAnim_rightStrobe(215,255);
}

void dmxAnim_rightStrobeVeryFast() {
  dmxAnim_rightStrobe(255,255);
}

// Switch the back stroboscopes on
void dmxAnim_backStrobe(int speed, int intensity) {
  for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
    stroboscope.stopDMX();
  }
  for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
    stroboscope.stopDMX();
  }
  for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
    stroboscope.startDMX(speed,intensity);
  }
}

void dmxAnim_backStrobeVerySlow() {
  dmxAnim_backStrobe(80,255);
}

void dmxAnim_backStrobeSlow() {
  dmxAnim_backStrobe(125,255);
}

void dmxAnim_backStrobeMedium() {
  dmxAnim_backStrobe(170,255);
}

void dmxAnim_backStrobeFast() {
  dmxAnim_backStrobe(215,255);
}

void dmxAnim_backStrobeVeryFast() {
  dmxAnim_backStrobe(255,255);
}

/////////////////////////////////////////////////////////////////////////////////
// Alternate continuous stroboscopes
/////////////////////////////////////////////////////////////////////////////////

// Switch the side stroboscopes intermittently on and off
void dmxAnim_alternateStrobe(float factor) {
  if ((int)(automaticSequencer.currentPosition * factor) % 2 == 0) {
    dmxAnim_rightStrobeVeryFast();
  }
  else {
    dmxAnim_leftStrobeVeryFast();
  }
}

void dmxAnim_alternateStrobe2() {
  dmxAnim_alternateStrobe(0.5);
}

void dmxAnim_alternateStrobe4() {
  dmxAnim_alternateStrobe(1.0);
}

void dmxAnim_alternateStrobe8() {
  dmxAnim_alternateStrobe(2.0);
}

void dmxAnim_alternateStrobe16() {
  dmxAnim_alternateStrobe(4.0);
}

/////////////////////////////////////////////////////////////////////////////////
// Growing stroboscopes
/////////////////////////////////////////////////////////////////////////////////

int growingStrobe_speed     = 255;
int growingStrobe_intensity = 0;
int growingStrobe_increment = 3;

void dmxAnim_growingFullStrobe() {
  dmxAnim_fullStrobe(growingStrobe_speed, min(growingStrobe_intensity, 255));
  growingStrobe_intensity += growingStrobe_increment;
}

void dmxAnim_growingLeftStrobe() {
  dmxAnim_leftStrobe(growingStrobe_speed, min(growingStrobe_intensity, 255));
  growingStrobe_intensity += growingStrobe_increment;
}

void dmxAnim_growingRightStrobe() {
  dmxAnim_rightStrobe(growingStrobe_speed, min(growingStrobe_intensity, 255));
  growingStrobe_intensity += growingStrobe_increment;
}

// Switch the side stroboscopes intermittently on and off
void dmxAnim_growingAlternateStrobe(float factor) {
  if ((int)(automaticSequencer.currentPosition * factor) % 2 == 0) {
    dmxAnim_growingRightStrobe();
  }
  else {
    dmxAnim_growingLeftStrobe();
  }
}

void dmxAnim_growingAlternateStrobe2() {
  dmxAnim_growingAlternateStrobe(0.5);
}

void dmxAnim_growingAlternateStrobe4() {
  dmxAnim_growingAlternateStrobe(1.0);
}

void dmxAnim_growingAlternateStrobe8() {
  dmxAnim_growingAlternateStrobe(2.0);
}
