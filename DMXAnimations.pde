
///////////////////////////////////////////////////////////////
//   DMX animations - Sequences used by the automatic mode   //
///////////////////////////////////////////////////////////////


// Play the DMX animations
void playDMXAnimation() {
  switch(dmxAnimationNumber) {
    case 1:   dmxAnim_blackout(); break;
    case 2:
    default:  dmxAnim_blackout(); break;
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
void dmxAnim_leftStrobe() {
  
}

// Switch the right stroboscopes on
void dmxAnim_rightStrobe() {
  
}

// Switch the side stroboscopes intermittently on and off
void dmxAnim_alternateStrobe() {
  
}
