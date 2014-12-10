
///////////////////////////////////////////////////////////////
//   DMX animations - Sequences used by the automatic mode   //
///////////////////////////////////////////////////////////////


final int SINGLEFLASH_INITVAL = 6;

// Play the DMX animations
void playDMXAnimation() {
  switch(dmxAnimationNumber) {
    case 1:   dmxAnim_blackout();                                break;         // 1 -   Full Blackout
                                                                 
    case 2:   dmxAnim_fullStrobeVerySlow();                      break;         // 2 -   Full Strobe - Very Slow
    case 3:   dmxAnim_fullStrobeSlow();                          break;         // 3 -   Full Strobe - Slow
    case 4:   dmxAnim_fullStrobeMedium();                        break;         // 4 -   Full Strobe - Medium
    case 5:   dmxAnim_fullStrobeFast();                          break;         // 5 -   Full Strobe - Fast
    case 6:   dmxAnim_fullStrobeVeryFast();                      break;         // 6 -   Full Strobe - Very Fast
                                                                 
    case 7:   dmxAnim_leftStrobeVerySlow();                      break;         // 7 -   Left Strobe - Very Slow
    case 8:   dmxAnim_leftStrobeSlow();                          break;         // 8 -   Left Strobe - Slow     
    case 9:   dmxAnim_leftStrobeMedium();                        break;         // 9 -   Left Strobe - Medium   
    case 10:  dmxAnim_leftStrobeFast();                          break;         // 10 -  Left Strobe - Fast     
    case 11:  dmxAnim_leftStrobeVeryFast();                      break;         // 11 -  Left Strobe - Very Fast
    case 12:  dmxAnim_rightStrobeVerySlow();                     break;         // 12 -  Right Strobe - Very Slow
    case 13:  dmxAnim_rightStrobeSlow();                         break;         // 13 -  Right Strobe - Slow     
    case 14:  dmxAnim_rightStrobeMedium();                       break;         // 14 -  Right Strobe - Medium   
    case 15:  dmxAnim_rightStrobeFast();                         break;         // 15 -  Right Strobe - Fast     
    case 16:  dmxAnim_rightStrobeVeryFast();                     break;         // 16 -  Right Strobe - Very Fast
    case 17:  dmxAnim_backStrobeVerySlow();                      break;         // 17 -  Back Strobe - Very Slow
    case 18:  dmxAnim_backStrobeSlow();                          break;         // 18 -  Back Strobe - Slow
    case 19:  dmxAnim_backStrobeMedium();                        break;         // 19 -  Back Strobe - Medium
    case 20:  dmxAnim_backStrobeFast();                          break;         // 20 -  Back Strobe - Fast
    case 21:  dmxAnim_backStrobeVeryFast();                      break;         // 21 -  Back Strobe - Very Fast
                                                                 
    case 22:  dmxAnim_leftRightStrobeVerySlow();                 break;         // 22 -  Left/Right Strobe - Very Slow
    case 23:  dmxAnim_leftRightStrobeSlow();                     break;         // 23 -  Left/Right Strobe - Slow     
    case 24:  dmxAnim_leftRightStrobeMedium();                   break;         // 24 -  Left/Right Strobe - Medium   
    case 25:  dmxAnim_leftRightStrobeFast();                     break;         // 25 -  Left/Right Strobe - Fast     
    case 26:  dmxAnim_leftRightStrobeVeryFast();                 break;         // 26 -  Left/Right Strobe - Very Fast    
                                                                 
    case 27:  dmxAnim_alternateStrobe2();                        break;         // 27 -  Alternate Strobe - Left/Right - 2/4
    case 28:  dmxAnim_alternateStrobe4();                        break;         // 28 -  Alternate Strobe - Left/Right - 1/4
    case 29:  dmxAnim_alternateStrobe8();                        break;         // 29 -  Alternate Strobe - Left/Right - 1/8
    case 30:  dmxAnim_alternateStrobe16();                       break;         // 30 -  Alternate Strobe - Left/Right - 1/16
                                                                 
    case 31:  dmxAnim_rotatingStrobe2();                         break;         // 31 -  Rotating Strobe - Left/Center/Right - 2/4
    case 32:  dmxAnim_rotatingStrobe4();                         break;         // 32 -  Rotating Strobe - Left/Center/Right - 1/4
    case 33:  dmxAnim_rotatingStrobe8();                         break;         // 33 -  Rotating Strobe - Left/Center/Right - 1/8
    case 34:  dmxAnim_rotatingStrobe16();                        break;         // 34 -  Rotating Strobe - Left/Center/Right - 1/16
                                                                 
    case 35:  dmxAnim_growingFullStrobe();                       break;         // 35 -  Growing Strobe - Full
    case 36:  dmxAnim_growingLeftStrobe();                       break;         // 36 -  Growing Strobe - Left
    case 37:  dmxAnim_growingRightStrobe();                      break;         // 37 -  Growing Strobe - Right
    case 38:  dmxAnim_growingBackStrobe();                       break;         // 38 -  Growing Strobe - Back
    case 39:  dmxAnim_growingLeftRightStrobe();                  break;         // 39 -  Growing Strobe - Left/Right
                                                                 
    case 40:  dmxAnim_growingAlternateStrobe2();                 break;         // 40 -  Growing Strobe - Alternate Left/Right - 2/4
    case 41:  dmxAnim_growingAlternateStrobe4();                 break;         // 41 -  Growing Strobe - Alternate Left/Right - 1/4
    case 42:  dmxAnim_growingAlternateStrobe8();                 break;         // 42 -  Growing Strobe - Alternate Left/Right - 1/8
    case 43:  dmxAnim_growingAlternateStrobe16();                break;         // 43 -  Growing Strobe - Alternate Left/Right - 1/16
                                                                 
    case 44:  dmxAnim_growingRotatingStrobe2();                  break;         // 44 -  Growing Strobe - Rotating Left/Center/Right - 2/4
    case 45:  dmxAnim_growingRotatingStrobe4();                  break;         // 45 -  Growing Strobe - Rotating Left/Center/Right - 1/4
    case 46:  dmxAnim_growingRotatingStrobe8();                  break;         // 46 -  Growing Strobe - Rotating Left/Center/Right - 1/8
    case 47:  dmxAnim_growingRotatingStrobe16();                 break;         // 47 -  Growing Strobe - Rotating Left/Center/Right - 1/16
                                                                 
    case 48:  dmxAnim_shortSingleFlash();                        break;         // 48 -  Short Single Flash - Atomic 3000
    case 49:  dmxAnim_longSingleFlash();                         break;         // 49 -  Long Single Flash - Atomic 3000
    case 50:  dmxAnim_impulseFlasher_kick();                     break;         // 50 -  Impulse Flasher - Kick    : flash once the Atomic 3000 when an impulse is processed
    case 51:  dmxAnim_impulseFlasher_snare();                    break;         // 51 -  Impulse Flasher - Snare   : flash once the Atomic 3000 when an impulse is processed
    case 52:  dmxAnim_impulseFlasher_cymbals();                  break;         // 52 -  Impulse Flasher - Cymbals : flash once the Atomic 3000 when an impulse is processed
    case 53:  dmxAnim_impulseFlasher_bass();                     break;         // 53 -  Impulse Flasher - Bass    : flash once the Atomic 3000 when an impulse is processed
    case 54:  dmxAnim_impulseFlasher_keys();                     break;         // 54 -  Impulse Flasher - Keys    : flash once the Atomic 3000 when an impulse is processed
    case 55:  dmxAnim_impulseFlasher_guitar();                   break;         // 55 -  Impulse Flasher - Guitar  : flash once the Atomic 3000 when an impulse is processed
                                                                 
    case 56:  dmxAnim_atomicFX_rampUp_SlowFlash();               break;         // 56 -  Atomic 3000 SpecialFX - Ramp up - Slow Flash
    case 57:  dmxAnim_atomicFX_rampUp_MediumFlash();             break;         // 57 -  Atomic 3000 SpecialFX - Ramp up - Medium Flash
    case 58:  dmxAnim_atomicFX_rampUp_FastFlash();               break;         // 58 -  Atomic 3000 SpecialFX - Ramp up - Fast Flash
    case 59:  dmxAnim_atomicFX_rampUp_SlowContinuous();          break;         // 59 -  Atomic 3000 SpecialFX - Ramp up - Slow Continuous
    case 60:  dmxAnim_atomicFX_rampUp_MediumContinuous();        break;         // 60 -  Atomic 3000 SpecialFX - Ramp up - Medium Continuous
    case 61:  dmxAnim_atomicFX_rampUp_FastContinuous();          break;         // 61 -  Atomic 3000 SpecialFX - Ramp up - Fast Continuous
                                                                 
    case 62:  dmxAnim_atomicFX_rampDown_SlowFlash();             break;         // 62 -  Atomic 3000 SpecialFX - Ramp down - Slow Flash
    case 63:  dmxAnim_atomicFX_rampDown_MediumFlash();           break;         // 63 -  Atomic 3000 SpecialFX - Ramp down - Medium Flash
    case 64:  dmxAnim_atomicFX_rampDown_FastFlash();             break;         // 64 -  Atomic 3000 SpecialFX - Ramp down - Fast Flash
    case 65:  dmxAnim_atomicFX_rampDown_SlowContinuous();        break;         // 65 -  Atomic 3000 SpecialFX - Ramp down - Slow Continuous
    case 66:  dmxAnim_atomicFX_rampDown_MediumContinuous();      break;         // 66 -  Atomic 3000 SpecialFX - Ramp down - Medium Continuous
    case 67:  dmxAnim_atomicFX_rampDown_FastContinuous();        break;         // 67 -  Atomic 3000 SpecialFX - Ramp down - Fast Continuous
    
    case 68:  dmxAnim_atomicFX_rampUpDown_SlowFlash();           break;         // 68 -  Atomic 3000 SpecialFX - Ramp up/down - Slow Flash
    case 69:  dmxAnim_atomicFX_rampUpDown_MediumFlash();         break;         // 69 -  Atomic 3000 SpecialFX - Ramp up/down - Medium Flash
    case 70:  dmxAnim_atomicFX_rampUpDown_FastFlash();           break;         // 70 -  Atomic 3000 SpecialFX - Ramp up/down - Fast Flash
    case 71:  dmxAnim_atomicFX_rampUpDown_SlowContinuous();      break;         // 71 -  Atomic 3000 SpecialFX - Ramp up/down - Slow Continuous
    case 72:  dmxAnim_atomicFX_rampUpDown_MediumContinuous();    break;         // 72 -  Atomic 3000 SpecialFX - Ramp up/down - Medium Continuous
    case 73:  dmxAnim_atomicFX_rampUpDown_FastContinuous();      break;         // 73 -  Atomic 3000 SpecialFX - Ramp up/down - Fast Continuous
    
    case 74:  dmxAnim_atomicFX_random();                         break;         // 74 -  Atomic 3000 SpecialFX - Random
    case 75:  dmxAnim_atomicFX_lightning();                      break;         // 75 -  Atomic 3000 SpecialFX - Lightning
    
    case 76:  dmxAnim_atomicFX_slowSpikes();                     break;         // 76 -  Atomic 3000 SpecialFX - Spikes - Slow
    case 77:  dmxAnim_atomicFX_mediumSpikes();                   break;         // 77 -  Atomic 3000 SpecialFX - Spikes - Medium
    case 78:  dmxAnim_atomicFX_fastSpikes();                     break;         // 78 -  Atomic 3000 SpecialFX - Spikes - Fast
    
    case 79:  dmxAnim_atomicFX_Blinder();                        break;         // 79 -  Atomic 3000 SpecialFX - Blinder
    
    // PAR animations must start from 128
    
    default:  dmxAnim_blackout();                  break;
  }
}

// Must be called whenever dmxAnimationNumber is modified
void setupDMXAnimation() {
  switch(dmxAnimationNumber) {
    case 1:   break;
    case 35:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 36:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 37:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 38:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 39:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 40:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 41:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 42:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 43:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 44:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 45:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 46:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 47:  growingStrobe_speed = 255; growingStrobe_intensity = 0; break;
    case 48:  singleFlash_cpt = SINGLEFLASH_INITVAL; simuResetAnimCpt_AtomicStrobe(); break;
    case 49:  singleFlash_cpt = SINGLEFLASH_INITVAL; simuResetAnimCpt_AtomicStrobe(); break;
    case 56:  simuResetAnimCpt_AtomicStrobe(); break;
    case 57:  simuResetAnimCpt_AtomicStrobe(); break;
    case 58:  simuResetAnimCpt_AtomicStrobe(); break;
    case 59:  simuResetAnimCpt_AtomicStrobe(); break;
    case 60:  simuResetAnimCpt_AtomicStrobe(); break;
    case 61:  simuResetAnimCpt_AtomicStrobe(); break;
    case 62:  simuResetAnimCpt_AtomicStrobe(); break;
    case 63:  simuResetAnimCpt_AtomicStrobe(); break;
    case 64:  simuResetAnimCpt_AtomicStrobe(); break;
    case 65:  simuResetAnimCpt_AtomicStrobe(); break;
    case 66:  simuResetAnimCpt_AtomicStrobe(); break;
    case 67:  simuResetAnimCpt_AtomicStrobe(); break;
    case 68:  simuResetAnimCpt_AtomicStrobe(); break;
    case 69:  simuResetAnimCpt_AtomicStrobe(); break;
    case 70:  simuResetAnimCpt_AtomicStrobe(); break;
    case 71:  simuResetAnimCpt_AtomicStrobe(); break;
    case 72:  simuResetAnimCpt_AtomicStrobe(); break;
    case 73:  simuResetAnimCpt_AtomicStrobe(); break;
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

// Switch both the left and the right sides on

void dmxAnim_leftRightStrobeVerySlow() {
  dmxAnim_leftStrobe(80,255);
  dmxAnim_rightStrobe(80,255);
}

void dmxAnim_leftRightStrobeSlow() {
  dmxAnim_leftStrobe(125,255);
  dmxAnim_rightStrobe(125,255);
}

void dmxAnim_leftRightStrobeMedium() {
  dmxAnim_leftStrobe(170,255);
  dmxAnim_rightStrobe(170,255);
}

void dmxAnim_leftRightStrobeFast() {
  dmxAnim_leftStrobe(215,255);
  dmxAnim_rightStrobe(215,255);
}

void dmxAnim_leftRightStrobeVeryFast() {
  dmxAnim_leftStrobe(255,255);
  dmxAnim_rightStrobe(255,255);
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


// Switch all the stroboscopes intermittently on and off, in a left-center-right sequence
void dmxAnim_rotatingStrobe(float factor) {
  int strobeNb = (int)(automaticSequencer.currentPosition * factor) % 3;
  switch(strobeNb) {
    case 0:  dmxAnim_leftStrobeVeryFast();  break;
    case 1:  dmxAnim_backStrobeVeryFast();  break;
    case 2:  dmxAnim_rightStrobeVeryFast(); break;
    default: break;
  }
}

void dmxAnim_rotatingStrobe2() {
  dmxAnim_rotatingStrobe(0.5);
}

void dmxAnim_rotatingStrobe4() {
  dmxAnim_rotatingStrobe(1.0);
}

void dmxAnim_rotatingStrobe8() {
  dmxAnim_rotatingStrobe(2.0);
}

void dmxAnim_rotatingStrobe16() {
  dmxAnim_rotatingStrobe(4.0);
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

void dmxAnim_growingBackStrobe() {
  dmxAnim_backStrobe(growingStrobe_speed, min(growingStrobe_intensity, 255));
  growingStrobe_intensity += growingStrobe_increment;
}

void dmxAnim_growingLeftRightStrobe() {
  dmxAnim_leftStrobe(growingStrobe_speed, min(growingStrobe_intensity, 255));
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

void dmxAnim_growingAlternateStrobe16() {
  dmxAnim_growingAlternateStrobe(4.0);
}


// Switch all the stroboscopes intermittently on and off, in a left-center-right sequence
void dmxAnim_growingRotatingStrobe(float factor) {
  int strobeNb = (int)(automaticSequencer.currentPosition * factor) % 3;
  switch(strobeNb) {
    case 0:  dmxAnim_growingLeftStrobe();  break;
    case 1:  dmxAnim_growingBackStrobe();  break;
    case 2:  dmxAnim_growingRightStrobe(); break;
    default: break;
  }
}

void dmxAnim_growingRotatingStrobe2() {
  dmxAnim_growingRotatingStrobe(0.5);
}

void dmxAnim_growingRotatingStrobe4() {
  dmxAnim_growingRotatingStrobe(1.0);
}

void dmxAnim_growingRotatingStrobe8() {
  dmxAnim_growingRotatingStrobe(2.0);
}

void dmxAnim_growingRotatingStrobe16() {
  dmxAnim_growingRotatingStrobe(4.0);
}


/////////////////////////////////////////////////////////////////////////////////
// Single flashes using the Atomic-3000 type strobes
/////////////////////////////////////////////////////////////////////////////////

// This counter is set to 1 when a single flash is called, the function then sets it to 0 once the flash has been executed
// This is to deal with the single flash protocol used on the Atomic strobes :
// Start by setting the intensity and the flash rate at 0, then set an intensity on channel 1
int singleFlash_cpt = 0;

void dmxAnim_shortSingleFlash() {
  dmxAnim_singleFlash(50);
}

void dmxAnim_longSingleFlash() {
  dmxAnim_singleFlash(250);
}

void dmxAnim_singleFlash(int flashLength) {
  if (singleFlash_cpt > 0) {
    // Do a single flash by setting an intensity on channel 1

    for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
      //This is a function specific to the Martin strobes, which can be set apart using their number of channels
      if (stroboscope.numberOfChannels == 4) {
        stroboscope.startDMX(0, 255, flashLength, 0);    //Speed = 0, Intensity = Max, specialFX = 0 
      }
    }
    for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
      if (stroboscope.numberOfChannels == 4) {
        stroboscope.startDMX(0, 255, flashLength, 0);    //Speed = 0, Intensity = Max, specialFX = 0
      }
    }
    
    for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
      if (stroboscope.numberOfChannels == 4) {
        stroboscope.startDMX(0, 255, flashLength, 0);    //Speed = 0, Intensity = Max, specialFX = 0
      }
    }
    
    // Decrease the counter
    singleFlash_cpt -= 1;
    
  }
  else {
    // Reset the intensity and the flash rate to 0
    for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
      stroboscope.stopDMX();
    }
    for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
      stroboscope.stopDMX();
    }
    for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
      stroboscope.stopDMX();
    }
  }
}

// Impulse flasher : flash the center strobe once, when an impulse is processed
void dmxAnim_impulseFlasher_kick() {
  dmxAnim_impulseFlasher(SIGNAL_ID_KICK);
}

void dmxAnim_impulseFlasher_snare() {
  dmxAnim_impulseFlasher(SIGNAL_ID_SNARE);
}

void dmxAnim_impulseFlasher_cymbals() {
  dmxAnim_impulseFlasher(SIGNAL_ID_CYMBALS);
}

void dmxAnim_impulseFlasher_bass() {
  dmxAnim_impulseFlasher(SIGNAL_ID_BASS);
}

void dmxAnim_impulseFlasher_keys() {
  dmxAnim_impulseFlasher(SIGNAL_ID_KEYS);
}

void dmxAnim_impulseFlasher_guitar() {
  dmxAnim_impulseFlasher(SIGNAL_ID_GUITAR);
}

void dmxAnim_impulseFlasher(int signalID) {

  //Reset old flags according to the current system time
  invalidateOutdatedImpulseFlags();
  
  boolean impulse = false;
  
  if (signalID == SIGNAL_ID_KICK)         { impulse = impulse_Kick;    }
  else if (signalID == SIGNAL_ID_SNARE)   { impulse = impulse_Snare;   }
  else if (signalID == SIGNAL_ID_CYMBALS) { impulse = impulse_Cymbals; }
  else if (signalID == SIGNAL_ID_BASS)    { impulse = impulse_Bass;    }
  else if (signalID == SIGNAL_ID_KEYS)    { impulse = impulse_Keys;    }
  else if (signalID == SIGNAL_ID_GUITAR)  { impulse = impulse_Guitar;  }
  
  if (impulse) {
    singleFlash_cpt = SINGLEFLASH_INITVAL;
    dmxAnim_longSingleFlash();
    simuResetAnimCpt_AtomicStrobe();    // Make the simulator understand the strobe just flashed
  }
  else {
    dmxAnim_blackout();
  }
  
  //Set all the impulse flags to be reset at the end of the cycle, as they have been processed
  impulseMessageProcessed = true;
}


/////////////////////////////////////////////////////////////////////////////////
// Special FX using the Atomic 3000 stroboscopes
/////////////////////////////////////////////////////////////////////////////////

final int ATOMICFX_RAMPUP         = 10;
final int ATOMICFX_RAMPDOWN       = 50;
final int ATOMICFX_RAMPUPDOWN     = 100;
final int ATOMICFX_RANDOM         = 150;
final int ATOMICFX_LIGHTNING      = 200;
final int ATOMICFX_SPIKES         = 250;
///////////////////////////////////////
final int ATOMICFX_SPEED_VERYSLOW = 25;
final int ATOMICFX_SPEED_SLOW     = 60;
final int ATOMICFX_SPEED_MEDIUM   = 160;
final int ATOMICFX_SPEED_FAST     = 250;
final int ATOMICFX_INTENSITY      = 255;
final int ATOMICFX_FLASH          = 150;
final int ATOMICFX_CONTINUOUS     = 255;

////////////////////////////////////////////////////////////

void dmxAnim_atomicFX_rampUp_SlowFlash() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_SLOW, ATOMICFX_RAMPUP);
}

void dmxAnim_atomicFX_rampUp_MediumFlash() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_MEDIUM, ATOMICFX_RAMPUP);
}

void dmxAnim_atomicFX_rampUp_FastFlash() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_FAST, ATOMICFX_RAMPUP);
}

void dmxAnim_atomicFX_rampUp_SlowContinuous() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_CONTINUOUS, ATOMICFX_SPEED_SLOW, ATOMICFX_RAMPUP);
}

void dmxAnim_atomicFX_rampUp_MediumContinuous() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_CONTINUOUS, ATOMICFX_SPEED_MEDIUM, ATOMICFX_RAMPUP);
}

void dmxAnim_atomicFX_rampUp_FastContinuous() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_CONTINUOUS, ATOMICFX_SPEED_FAST, ATOMICFX_RAMPUP);
}

////////////////////////////////////////////////////////////

void dmxAnim_atomicFX_rampDown_SlowFlash() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_SLOW, ATOMICFX_RAMPDOWN);
}

void dmxAnim_atomicFX_rampDown_MediumFlash() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_MEDIUM, ATOMICFX_RAMPDOWN);
}

void dmxAnim_atomicFX_rampDown_FastFlash() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_FAST, ATOMICFX_RAMPDOWN);
}

void dmxAnim_atomicFX_rampDown_SlowContinuous() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_CONTINUOUS, ATOMICFX_SPEED_SLOW, ATOMICFX_RAMPDOWN);
}

void dmxAnim_atomicFX_rampDown_MediumContinuous() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_CONTINUOUS, ATOMICFX_SPEED_MEDIUM, ATOMICFX_RAMPDOWN);
}

void dmxAnim_atomicFX_rampDown_FastContinuous() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_CONTINUOUS, ATOMICFX_SPEED_FAST, ATOMICFX_RAMPDOWN);
}

////////////////////////////////////////////////////////////

void dmxAnim_atomicFX_rampUpDown_SlowFlash() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_SLOW, ATOMICFX_RAMPUPDOWN);
}

void dmxAnim_atomicFX_rampUpDown_MediumFlash() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_MEDIUM, ATOMICFX_RAMPUPDOWN);
}

void dmxAnim_atomicFX_rampUpDown_FastFlash() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_FAST, ATOMICFX_RAMPUPDOWN);
}

void dmxAnim_atomicFX_rampUpDown_SlowContinuous() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_CONTINUOUS, ATOMICFX_SPEED_SLOW, ATOMICFX_RAMPUPDOWN);
}

void dmxAnim_atomicFX_rampUpDown_MediumContinuous() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_CONTINUOUS, ATOMICFX_SPEED_MEDIUM, ATOMICFX_RAMPUPDOWN);
}

void dmxAnim_atomicFX_rampUpDown_FastContinuous() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_CONTINUOUS, ATOMICFX_SPEED_FAST, ATOMICFX_RAMPUPDOWN);
}

////////////////////////////////////////////////////////////

void dmxAnim_atomicFX_random() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_FAST, ATOMICFX_RANDOM);
}

void dmxAnim_atomicFX_lightning() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_FAST, ATOMICFX_LIGHTNING);
}

////////////////////////////////////////////////////////////

void dmxAnim_atomicFX_slowSpikes() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_VERYSLOW, ATOMICFX_SPIKES);
}

void dmxAnim_atomicFX_mediumSpikes() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_SLOW, ATOMICFX_SPIKES);
}

void dmxAnim_atomicFX_fastSpikes() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_FLASH, ATOMICFX_SPEED_MEDIUM, ATOMICFX_SPIKES);
}

////////////////////////////////////////////////////////////

void dmxAnim_atomicFX_Blinder() {
  dmxAnim_atomicFX(ATOMICFX_INTENSITY, ATOMICFX_CONTINUOUS, ATOMICFX_SPEED_FAST, 0);
}

////////////////////////////////////////////////////////////

void dmxAnim_atomicFX(int intensity, int flashLength, int speed, int fxNumber) {
  for (DMX_Stroboscope stroboscope: DMXList_FrontLeftStroboscopes) {
    //This is a function specific to the Martin strobes, which can be set apart using their number of channels
    if (stroboscope.numberOfChannels == 4) {
      stroboscope.startDMX(speed, intensity, flashLength, fxNumber); 
    }
    else {
      stroboscope.stopDMX();
    }
  }
  for (DMX_Stroboscope stroboscope: DMXList_FrontRightStroboscopes) {
    stroboscope.stopDMX();
    if (stroboscope.numberOfChannels == 4) {
      stroboscope.startDMX(speed, intensity, flashLength, fxNumber);
    }
    else {
      stroboscope.stopDMX();
    }
  }
  
  for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
    if (stroboscope.numberOfChannels == 4) {
      stroboscope.startDMX(speed, intensity, flashLength, fxNumber);
    }
    else {
      stroboscope.stopDMX();
    }
  }
}
