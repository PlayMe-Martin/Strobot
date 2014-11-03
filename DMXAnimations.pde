
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
    
    default:  dmxAnim_blackout();                  break;
  }
}

// Must be called whenever dmxAnimationNumber is modified
void setupDMXAnimation() {
  switch(dmxAnimationNumber) {
    case 1:  break;
    default: break;
  } 
}


/////////////////////////////////////////////////////////////////////////////////////
// Each individual functions is a single animation using the registered DMX devices

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
void dmxAnim_fullStrobe(int speed) {
  for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
    stroboscope.startDMX(speed,255);
  }
  for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
    stroboscope.startDMX(speed,255);
  }
  for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
    stroboscope.startDMX(speed,255);
  }
}

void dmxAnim_fullStrobeVerySlow() {
  dmxAnim_fullStrobe(80);
}

void dmxAnim_fullStrobeSlow() {
  dmxAnim_fullStrobe(125);
}

void dmxAnim_fullStrobeMedium() {
  dmxAnim_fullStrobe(170);
}

void dmxAnim_fullStrobeFast() {
  dmxAnim_fullStrobe(215);
}

void dmxAnim_fullStrobeVeryFast() {
  dmxAnim_fullStrobe(255);
}

// Switch the left stroboscopes on
void dmxAnim_leftStrobe(int speed) {
  for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
    stroboscope.startDMX(speed,255);
  }
  for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
    stroboscope.stopDMX();
  }
  for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
    stroboscope.stopDMX();
  }
}

void dmxAnim_leftStrobeVerySlow() {
  dmxAnim_leftStrobe(80);
}

void dmxAnim_leftStrobeSlow() {
  dmxAnim_leftStrobe(125);
}

void dmxAnim_leftStrobeMedium() {
  dmxAnim_leftStrobe(170);
}

void dmxAnim_leftStrobeFast() {
  dmxAnim_leftStrobe(215);
}

void dmxAnim_leftStrobeVeryFast() {
  dmxAnim_leftStrobe(255);
}

// Switch the right stroboscopes on
void dmxAnim_rightStrobe(int speed) {
  for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
    stroboscope.stopDMX();
  }
  for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
    stroboscope.startDMX(speed,255);
  }
  for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
    stroboscope.stopDMX();
  }
}

void dmxAnim_rightStrobeVerySlow() {
  dmxAnim_rightStrobe(80);
}

void dmxAnim_rightStrobeSlow() {
  dmxAnim_rightStrobe(125);
}

void dmxAnim_rightStrobeMedium() {
  dmxAnim_rightStrobe(170);
}

void dmxAnim_rightStrobeFast() {
  dmxAnim_rightStrobe(215);
}

void dmxAnim_rightStrobeVeryFast() {
  dmxAnim_rightStrobe(255);
}

// Switch the back stroboscopes on
void dmxAnim_backStrobe(int speed) {
  for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
    stroboscope.stopDMX();
  }
  for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
    stroboscope.stopDMX();
  }
  for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
    stroboscope.startDMX(speed,255);
  }
}

void dmxAnim_backStrobeVerySlow() {
  dmxAnim_backStrobe(80);
}

void dmxAnim_backStrobeSlow() {
  dmxAnim_backStrobe(125);
}

void dmxAnim_backStrobeMedium() {
  dmxAnim_backStrobe(170);
}

void dmxAnim_backStrobeFast() {
  dmxAnim_backStrobe(215);
}

void dmxAnim_backStrobeVeryFast() {
  dmxAnim_backStrobe(255);
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
// Rhythmic stroboscopes
/////////////////////////////////////////////////////////////////////////////////

