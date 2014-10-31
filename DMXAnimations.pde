
///////////////////////////////////////////////////////////////
//   DMX animations - Sequences used by the automatic mode   //
///////////////////////////////////////////////////////////////


void playDMXAnimation(int dmxAnimationNumber) {
  switch(dmxAnimationNumber) {
    case 1: dmxAnim_blackout(); break;
    case 2:
    default: break;
  }
}

void setupDMXAnimation(int dmxAnimationNumber) {
  switch(dmxAnimationNumber) {
    case 1:  break;
    default: break;
  } 
}


/////////////////////////////////////////////////////////////////////////////////////
// Each individual functions is a single animation using the registered DMX devices

// Stop all devices 
void dmxAnim_blackout() {
  
}

// Switch all stroboscopes on
void dmxAnim_fullStrobe() {
  
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
