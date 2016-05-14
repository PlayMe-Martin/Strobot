
///////////////////////////////////////////////////////////////
//   DMX animations - Sequences used by the automatic mode   //
///////////////////////////////////////////////////////////////


// Strobe related constants
final int SINGLEFLASH_INITVAL = 6;
final float SIDESTROBE_MAX_SPEED = 0.8;    //Max speed ratio for the side strobes (1 -> full speed => 255 DMX speed)
final float BACKSTROBE_MAX_SPEED = 0.8;

void playDMXAnimation() {
  playDMXAnimation_strobe();
  playDMXAnimation_movingHead();
}

// Play the DMX animations
void playDMXAnimation_strobe() {
  switch(dmxAnimationNumber_strobe) {
    case 1:   dmxAnim_strobe_blackout();                         break;         // 1 -   Full Blackout
                                                                 
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
    
    case 79:  dmxAnim_atomicFX_Blinder_VeryWeak();               break;         // 79 -  Atomic 3000 SpecialFX - Blinder - Very Weak
    case 80:  dmxAnim_atomicFX_Blinder_Weak();                   break;         // 80 -  Atomic 3000 SpecialFX - Blinder - Weak
    case 81:  dmxAnim_atomicFX_Blinder_Medium();                 break;         // 81 -  Atomic 3000 SpecialFX - Blinder - Medium
    case 82:  dmxAnim_atomicFX_Blinder_Strong();                 break;         // 82 -  Atomic 3000 SpecialFX - Blinder - Strong
    case 83:  dmxAnim_atomicFX_Blinder_VeryStrong();             break;         // 83 -  Atomic 3000 SpecialFX - Blinder - Very Strong
    
    case 84:  dmxAnim_leftStrobeVeryWeak();                      break;         // 84 -  Left Strobe - Very Weak / Full speed
    case 85:  dmxAnim_rightStrobeVeryWeak();                     break;         // 85 -  Right Strobe - Very Weak / Full speed
    case 86:  dmxAnim_backStrobeVeryWeak();                      break;         // 86 -  Center Strobe - Very Weak / Full speed
    case 87:  dmxAnim_leftRightStrobeVeryWeak();                 break;         // 87 -  Left/Right Strobe - Very Weak / Full speed
    case 88:  dmxAnim_fullStrobeVeryWeak();                      break;         // 88 -  Full Strobe - Very Weak / Full speed
    
    case 89:  dmxAnim_leftStrobeWeak();                          break;         // 89 -  Left Strobe - Weak / Full speed
    case 90:  dmxAnim_rightStrobeWeak();                         break;         // 90 -  Right Strobe - Weak / Full speed
    case 91:  dmxAnim_backStrobeWeak();                          break;         // 91 -  Center Strobe - Weak / Full speed
    case 92:  dmxAnim_leftRightStrobeWeak();                     break;         // 92 -  Left/Right Strobe - Weak / Full speed
    case 93:  dmxAnim_fullStrobeWeak();                          break;         // 93 -  Full Strobe - Weak / Full speed
    
    case 94:  dmxAnim_leftStrobeModerate();                      break;         // 94 -  Left Strobe - Moderate / Full speed
    case 95:  dmxAnim_rightStrobeModerate();                     break;         // 95 -  Right Strobe - Moderate / Full speed
    case 96:  dmxAnim_backStrobeModerate();                      break;         // 96 -  Center Strobe - Moderate / Full speed
    case 97:  dmxAnim_leftRightStrobeModerate();                 break;         // 97 -  Left/Right Strobe - Moderate / Full speed
    case 98:  dmxAnim_fullStrobeModerate();                      break;         // 98 -  Full Strobe - Moderate / Full speed

    case 99:  dmxAnim_leftStrobeStrong();                        break;         // 99 -  Left Strobe - Strong / Full speed
    case 100: dmxAnim_rightStrobeStrong();                       break;         // 100 - Right Strobe - Strong / Full speed
    case 101: dmxAnim_backStrobeStrong();                        break;         // 101 - Center Strobe - Strong / Full speed
    case 102: dmxAnim_leftRightStrobeStrong();                   break;         // 102 - Left/Right Strobe - Strong / Full speed
    case 103: dmxAnim_fullStrobeStrong();                        break;         // 103 - Full Strobe - Strong / Full speed
        
    default:  dmxAnim_strobe_blackout();                         break;
  }
}

// Must be called whenever dmxAnimationNumber_strobe is modified
void setupDMXAnimation_strobe() {
  switch(dmxAnimationNumber_strobe) {
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


void playDMXAnimation_movingHead() {

  switch(dmxAnimationNumber_movingHead) {

    // Prepare direction : set all moving heads facing towards a specific direction in order to anticipate the subsequent animation
    case 1:   dmxAnim_movingHead_prepareDirection_CenterPan_LowTilt();                                                  break;
    case 2:   dmxAnim_movingHead_prepareDirection_LeftPan_LowTilt();                                                    break;
    case 3:   dmxAnim_movingHead_prepareDirection_RightPan_LowTilt();                                                   break;
    case 4:   dmxAnim_movingHead_prepareDirection_CenterPan_FrontTilt();                                                break;
    case 5:   dmxAnim_movingHead_prepareDirection_LeftPan_FrontTilt();                                                  break;
    case 6:   dmxAnim_movingHead_prepareDirection_RightPan_FrontTilt();                                                 break;
    case 7:   dmxAnim_movingHead_prepareDirection_CenterPan_HighTilt();                                                 break;
    case 8:   dmxAnim_movingHead_prepareDirection_LeftPan_HighTilt();                                                   break;
    case 9:   dmxAnim_movingHead_prepareDirection_RightPan_HighTilt();                                                  break;
    case 10:  dmxAnim_movingHead_prepareDirection_CenterPan_UprightTilt();                                              break;
    case 11:  dmxAnim_movingHead_prepareDirection_LeftPan_UprightTilt();                                                break;
    case 12:  dmxAnim_movingHead_prepareDirection_RightPan_UprightTilt();                                               break;
    case 13:  dmxAnim_movingHead_prepareDirection_CenterPan_BackTilt();                                                 break;
    case 14:  dmxAnim_movingHead_prepareDirection_LeftPan_BackTilt();                                                   break;
    case 15:  dmxAnim_movingHead_prepareDirection_RightPan_BackTilt();                                                  break;

    case 16:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_WidePan_LowTilt();                            break;
    case 17:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_ClassicPan_LowTilt();                         break;
    case 18:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_NarrowPan_LowTilt();                          break;
    case 19:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_WidePan_FrontTilt();                          break;
    case 20:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_ClassicPan_FrontTilt();                       break;
    case 21:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_NarrowPan_FrontTilt();                        break;
    case 22:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_WidePan_HighTilt();                           break;
    case 23:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_ClassicPan_HighTilt();                        break;
    case 24:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_NarrowPan_HighTilt();                         break;
    case 25:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_WidePan_UprightTilt();                        break;
    case 26:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_ClassicPan_UprightTilt();                     break;
    case 27:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_NarrowPan_UprightTilt();                      break;

    case 28:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_WidePan_LowTilt();                           break;
    case 29:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_ClassicPan_LowTilt();                        break;
    case 30:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_NarrowPan_LowTilt();                         break;
    case 31:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_WidePan_FrontTilt();                         break;
    case 32:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_ClassicPan_FrontTilt();                      break;
    case 33:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_NarrowPan_FrontTilt();                       break;
    case 34:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_WidePan_HighTilt();                          break;
    case 35:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_ClassicPan_HighTilt();                       break;
    case 36:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_NarrowPan_HighTilt();                        break;
    case 37:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_WidePan_UprightTilt();                       break;
    case 38:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_ClassicPan_UprightTilt();                    break;
    case 39:  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_NarrowPan_UprightTilt();                     break;

    case 40:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_WideNegTilt();       break;
    case 41:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_NarrowNegTilt();     break;
    case 42:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_WidePan_WideNegTilt();          break;
    case 43:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_WidePan_NarrowNegTilt();        break;
    case 44:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_WidePosTilt();       break;
    case 45:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_NarrowPosTilt();     break;
    case 46:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_WidePan_WidePosTilt();          break;
    case 47:  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_WidePan_NarrowPosTilt();        break;


    // Simple commands for the various possible lightings and colors, without changing the direction of the projector

    case 48:  dmxAnim_movingHead_noMovement_allDev_continuousLight_white();                                             break;
    case 49:  dmxAnim_movingHead_noMovement_allDev_continuousLight_red();                                               break;
    case 50:  dmxAnim_movingHead_noMovement_allDev_continuousLight_deepRed();                                           break;
    case 51:  dmxAnim_movingHead_noMovement_allDev_continuousLight_blue();                                              break;
    case 52:  dmxAnim_movingHead_noMovement_allDev_continuousLight_deepBlue();                                          break;
    case 53:  dmxAnim_movingHead_noMovement_allDev_continuousLight_yellow();                                            break;
    case 54:  dmxAnim_movingHead_noMovement_allDev_continuousLight_green();                                             break;
    case 55:  dmxAnim_movingHead_noMovement_allDev_continuousLight_ultraviolet();                                       break;
    case 56:  dmxAnim_movingHead_noMovement_allDev_continuousLight_orange();                                            break;
    case 57:  dmxAnim_movingHead_noMovement_allDev_continuousLight_CTO();                                               break;

    //////////////////////////////////////////////////////////// 
 
    case 58:  dmxAnim_movingHead_noMovement_allDev_singleLongFlash_white();                                             break;
    case 59:  dmxAnim_movingHead_noMovement_allDev_singleLongFlash_red();                                               break;
    case 60:  dmxAnim_movingHead_noMovement_allDev_singleLongFlash_deepRed();                                           break;
    case 61:  dmxAnim_movingHead_noMovement_allDev_singleLongFlash_blue();                                              break;
    case 62:  dmxAnim_movingHead_noMovement_allDev_singleLongFlash_deepBlue();                                          break;
    case 63:  dmxAnim_movingHead_noMovement_allDev_singleLongFlash_yellow();                                            break;
    case 64:  dmxAnim_movingHead_noMovement_allDev_singleLongFlash_green();                                             break;
    case 65:  dmxAnim_movingHead_noMovement_allDev_singleLongFlash_ultraviolet();                                       break;
    case 66:  dmxAnim_movingHead_noMovement_allDev_singleLongFlash_orange();                                            break;
    case 67:  dmxAnim_movingHead_noMovement_allDev_singleLongFlash_CTO();                                               break;
 
    //////////////////////////////////////////////////////////// 
 
    case 68:  dmxAnim_movingHead_noMovement_allDev_singleShortFlash_white();                                            break;
    case 69:  dmxAnim_movingHead_noMovement_allDev_singleShortFlash_red();                                              break;
    case 70:  dmxAnim_movingHead_noMovement_allDev_singleShortFlash_deepRed();                                          break;
    case 71:  dmxAnim_movingHead_noMovement_allDev_singleShortFlash_blue();                                             break;
    case 72:  dmxAnim_movingHead_noMovement_allDev_singleShortFlash_deepBlue();                                         break;
    case 73:  dmxAnim_movingHead_noMovement_allDev_singleShortFlash_yellow();                                           break;
    case 74:  dmxAnim_movingHead_noMovement_allDev_singleShortFlash_green();                                            break;
    case 75:  dmxAnim_movingHead_noMovement_allDev_singleShortFlash_ultraviolet();                                      break;
    case 76:  dmxAnim_movingHead_noMovement_allDev_singleShortFlash_orange();                                           break;
    case 77:  dmxAnim_movingHead_noMovement_allDev_singleShortFlash_CTO();                                              break;
 
    //////////////////////////////////////////////////////////// 
 
    case 78:  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_white();                                          break;
    case 79:  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_red();                                            break;
    case 80:  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_deepRed();                                        break;
    case 81:  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_blue();                                           break;
    case 82:  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_deepBlue();                                       break;
    case 83:  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_yellow();                                         break;
    case 84:  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_green();                                          break;
    case 85:  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_ultraviolet();                                    break;
    case 86:  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_orange();                                         break;
    case 87:  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_CTO();                                            break;
 
    ////////////////////////////////////////////////////////////  
 
    case 88:  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_white();                                          break;
    case 89:  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_red();                                            break;
    case 90:  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_deepRed();                                        break;
    case 91:  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_blue();                                           break;
    case 92:  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_deepBlue();                                       break;
    case 93:  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_yellow();                                         break;
    case 94:  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_green();                                          break;
    case 95:  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_ultraviolet();                                    break;
    case 96:  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_orange();                                         break;
    case 97:  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_CTO();                                            break;
 
    //////////////////////////////////////////////////////////// 

    case 98:  dmxAnim_movingHead_noMovement_allDev_slowStrobe_white();                                                  break;
    case 99:  dmxAnim_movingHead_noMovement_allDev_slowStrobe_red();                                                    break;
    case 100: dmxAnim_movingHead_noMovement_allDev_slowStrobe_deepRed();                                                break;
    case 101: dmxAnim_movingHead_noMovement_allDev_slowStrobe_blue();                                                   break;
    case 102: dmxAnim_movingHead_noMovement_allDev_slowStrobe_deepBlue();                                               break;
    case 103: dmxAnim_movingHead_noMovement_allDev_slowStrobe_yellow();                                                 break;
    case 104: dmxAnim_movingHead_noMovement_allDev_slowStrobe_green();                                                  break;
    case 105: dmxAnim_movingHead_noMovement_allDev_slowStrobe_ultraviolet();                                            break;
    case 106: dmxAnim_movingHead_noMovement_allDev_slowStrobe_orange();                                                 break;
    case 107: dmxAnim_movingHead_noMovement_allDev_slowStrobe_CTO();                                                    break;
    case 108: dmxAnim_movingHead_noMovement_allDev_mediumStrobe_white();                                                break;
    case 109: dmxAnim_movingHead_noMovement_allDev_mediumStrobe_red();                                                  break;
    case 110: dmxAnim_movingHead_noMovement_allDev_mediumStrobe_deepRed();                                              break;
    case 111: dmxAnim_movingHead_noMovement_allDev_mediumStrobe_blue();                                                 break;
    case 112: dmxAnim_movingHead_noMovement_allDev_mediumStrobe_deepBlue();                                             break;
    case 113: dmxAnim_movingHead_noMovement_allDev_mediumStrobe_yellow();                                               break;
    case 114: dmxAnim_movingHead_noMovement_allDev_mediumStrobe_green();                                                break;
    case 115: dmxAnim_movingHead_noMovement_allDev_mediumStrobe_ultraviolet();                                          break;
    case 116: dmxAnim_movingHead_noMovement_allDev_mediumStrobe_orange();                                               break;
    case 117: dmxAnim_movingHead_noMovement_allDev_mediumStrobe_CTO();                                                  break;
    case 118: dmxAnim_movingHead_noMovement_allDev_fastStrobe_white();                                                  break;
    case 119: dmxAnim_movingHead_noMovement_allDev_fastStrobe_red();                                                    break;
    case 120: dmxAnim_movingHead_noMovement_allDev_fastStrobe_deepRed();                                                break;
    case 121: dmxAnim_movingHead_noMovement_allDev_fastStrobe_blue();                                                   break;
    case 122: dmxAnim_movingHead_noMovement_allDev_fastStrobe_deepBlue();                                               break;
    case 123: dmxAnim_movingHead_noMovement_allDev_fastStrobe_yellow();                                                 break;
    case 124: dmxAnim_movingHead_noMovement_allDev_fastStrobe_green();                                                  break;
    case 125: dmxAnim_movingHead_noMovement_allDev_fastStrobe_ultraviolet();                                            break;
    case 126: dmxAnim_movingHead_noMovement_allDev_fastStrobe_orange();                                                 break;
    case 127: dmxAnim_movingHead_noMovement_allDev_fastStrobe_CTO();                                                    break;

    //////////////////////////////////////////////////////////// 

    // For the more complex animations: set the color for the different devices (all/center/side/left/right)

    case 128: dmxAnim_movingHead_setColorForCompositeAnimations_allDev_white();                                         break;
    case 129: dmxAnim_movingHead_setColorForCompositeAnimations_allDev_red();                                           break;
    case 130: dmxAnim_movingHead_setColorForCompositeAnimations_allDev_deepRed();                                       break;
    case 131: dmxAnim_movingHead_setColorForCompositeAnimations_allDev_blue();                                          break;
    case 132: dmxAnim_movingHead_setColorForCompositeAnimations_allDev_deepBlue();                                      break;
    case 133: dmxAnim_movingHead_setColorForCompositeAnimations_allDev_yellow();                                        break;
    case 134: dmxAnim_movingHead_setColorForCompositeAnimations_allDev_green();                                         break;
    case 135: dmxAnim_movingHead_setColorForCompositeAnimations_allDev_ultraviolet();                                   break;
    case 136: dmxAnim_movingHead_setColorForCompositeAnimations_allDev_orange();                                        break;
    case 137: dmxAnim_movingHead_setColorForCompositeAnimations_allDev_CTO();                                           break;

    case 138: dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_white();                                      break;
    case 139: dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_red();                                        break;
    case 140: dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_deepRed();                                    break;
    case 141: dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_blue();                                       break;
    case 142: dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_deepBlue();                                   break;
    case 143: dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_yellow();                                     break;
    case 144: dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_green();                                      break;
    case 145: dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_ultraviolet();                                break;
    case 146: dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_orange();                                     break;
    case 147: dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_CTO();                                        break;

    case 148: dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_white();                                        break;
    case 149: dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_red();                                          break;
    case 150: dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_deepRed();                                      break;
    case 151: dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_blue();                                         break;
    case 152: dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_deepBlue();                                     break;
    case 153: dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_yellow();                                       break;
    case 154: dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_green();                                        break;
    case 155: dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_ultraviolet();                                  break;
    case 156: dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_orange();                                       break;
    case 157: dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_CTO();                                          break;

    case 158: dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_white();                                        break;
    case 159: dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_red();                                          break;
    case 160: dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_deepRed();                                      break;
    case 161: dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_blue();                                         break;
    case 162: dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_deepBlue();                                     break;
    case 163: dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_yellow();                                       break;
    case 164: dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_green();                                        break;
    case 165: dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_ultraviolet();                                  break;
    case 166: dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_orange();                                       break;
    case 167: dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_CTO();                                          break;

    case 168: dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_white();                                       break;
    case 169: dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_red();                                         break;
    case 170: dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_deepRed();                                     break;
    case 171: dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_blue();                                        break;
    case 172: dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_deepBlue();                                    break;
    case 173: dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_yellow();                                      break;
    case 174: dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_green();                                       break;
    case 175: dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_ultraviolet();                                 break;
    case 176: dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_orange();                                      break;
    case 177: dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_CTO();                                         break;


    case 178: dmxAnim_movingHead_setLightingStyle_allDev_continuousLight();                                             break;
    case 179: dmxAnim_movingHead_setLightingStyle_allDev_slowCrescendoLight();                                          break;
    case 180: dmxAnim_movingHead_setLightingStyle_allDev_fastCrescendoLight();                                          break;
    case 181: dmxAnim_movingHead_setLightingStyle_allDev_singleShortFlash();                                            break;
    case 182: dmxAnim_movingHead_setLightingStyle_allDev_singleLongFlash();                                             break;
    case 183: dmxAnim_movingHead_setLightingStyle_allDev_slowStrobe();                                                  break;
    case 184: dmxAnim_movingHead_setLightingStyle_allDev_mediumStrobe();                                                break;
    case 185: dmxAnim_movingHead_setLightingStyle_allDev_fastStrobe();                                                  break;
    case 186: dmxAnim_movingHead_setLightingStyle_allDev_slowSineWave();                                                break;
    case 187: dmxAnim_movingHead_setLightingStyle_allDev_fastSineWave();                                                break;
    case 188: dmxAnim_movingHead_setLightingStyle_allDev_randomGlitch();                                                break;
    case 189: dmxAnim_movingHead_setLightingStyle_allDev_minimalApertureBeam();                                         break;

    case 190: dmxAnim_movingHead_setLightingStyle_centerDev_continuousLight();                                          break;
    case 191: dmxAnim_movingHead_setLightingStyle_centerDev_slowCrescendoLight();                                       break;
    case 192: dmxAnim_movingHead_setLightingStyle_centerDev_fastCrescendoLight();                                       break;
    case 193: dmxAnim_movingHead_setLightingStyle_centerDev_singleShortFlash();                                         break;
    case 194: dmxAnim_movingHead_setLightingStyle_centerDev_singleLongFlash();                                          break;
    case 195: dmxAnim_movingHead_setLightingStyle_centerDev_slowStrobe();                                               break;
    case 196: dmxAnim_movingHead_setLightingStyle_centerDev_mediumStrobe();                                             break;
    case 197: dmxAnim_movingHead_setLightingStyle_centerDev_fastStrobe();                                               break;
    case 198: dmxAnim_movingHead_setLightingStyle_centerDev_slowSineWave();                                             break;
    case 199: dmxAnim_movingHead_setLightingStyle_centerDev_fastSineWave();                                             break;
    case 200: dmxAnim_movingHead_setLightingStyle_centerDev_randomGlitch();                                             break;
    case 201: dmxAnim_movingHead_setLightingStyle_centerDev_minimalApertureBeam();                                      break;

    case 202: dmxAnim_movingHead_setLightingStyle_sideDev_continuousLight();                                            break;
    case 203: dmxAnim_movingHead_setLightingStyle_sideDev_slowCrescendoLight();                                         break;
    case 204: dmxAnim_movingHead_setLightingStyle_sideDev_fastCrescendoLight();                                         break;
    case 205: dmxAnim_movingHead_setLightingStyle_sideDev_singleShortFlash();                                           break;
    case 206: dmxAnim_movingHead_setLightingStyle_sideDev_singleLongFlash();                                            break;
    case 207: dmxAnim_movingHead_setLightingStyle_sideDev_slowStrobe();                                                 break;
    case 208: dmxAnim_movingHead_setLightingStyle_sideDev_mediumStrobe();                                               break;
    case 209: dmxAnim_movingHead_setLightingStyle_sideDev_fastStrobe();                                                 break;
    case 210: dmxAnim_movingHead_setLightingStyle_sideDev_slowSineWave();                                               break;
    case 211: dmxAnim_movingHead_setLightingStyle_sideDev_fastSineWave();                                               break;
    case 212: dmxAnim_movingHead_setLightingStyle_sideDev_randomGlitch();                                               break;
    case 213: dmxAnim_movingHead_setLightingStyle_sideDev_minimalApertureBeam();                                        break;
    
    case 214: dmxAnim_movingHead_setLightingStyle_leftDev_continuousLight();                                            break;
    case 215: dmxAnim_movingHead_setLightingStyle_leftDev_slowCrescendoLight();                                         break;
    case 216: dmxAnim_movingHead_setLightingStyle_leftDev_fastCrescendoLight();                                         break;
    case 217: dmxAnim_movingHead_setLightingStyle_leftDev_singleShortFlash();                                           break;
    case 218: dmxAnim_movingHead_setLightingStyle_leftDev_singleLongFlash();                                            break;
    case 219: dmxAnim_movingHead_setLightingStyle_leftDev_slowStrobe();                                                 break;
    case 220: dmxAnim_movingHead_setLightingStyle_leftDev_mediumStrobe();                                               break;
    case 221: dmxAnim_movingHead_setLightingStyle_leftDev_fastStrobe();                                                 break;
    case 222: dmxAnim_movingHead_setLightingStyle_leftDev_slowSineWave();                                               break;
    case 223: dmxAnim_movingHead_setLightingStyle_leftDev_fastSineWave();                                               break;
    case 224: dmxAnim_movingHead_setLightingStyle_leftDev_randomGlitch();                                               break;
    case 225: dmxAnim_movingHead_setLightingStyle_leftDev_minimalApertureBeam();                                        break;
    
    case 226: dmxAnim_movingHead_setLightingStyle_rightDev_continuousLight();                                           break;
    case 227: dmxAnim_movingHead_setLightingStyle_rightDev_slowCrescendoLight();                                        break;
    case 228: dmxAnim_movingHead_setLightingStyle_rightDev_fastCrescendoLight();                                        break;
    case 229: dmxAnim_movingHead_setLightingStyle_rightDev_singleShortFlash();                                          break;
    case 230: dmxAnim_movingHead_setLightingStyle_rightDev_singleLongFlash();                                           break;
    case 231: dmxAnim_movingHead_setLightingStyle_rightDev_slowStrobe();                                                break;
    case 232: dmxAnim_movingHead_setLightingStyle_rightDev_mediumStrobe();                                              break;
    case 233: dmxAnim_movingHead_setLightingStyle_rightDev_fastStrobe();                                                break;
    case 234: dmxAnim_movingHead_setLightingStyle_rightDev_slowSineWave();                                              break;
    case 235: dmxAnim_movingHead_setLightingStyle_rightDev_fastSineWave();                                              break;
    case 236: dmxAnim_movingHead_setLightingStyle_rightDev_randomGlitch();                                              break;
    case 237: dmxAnim_movingHead_setLightingStyle_rightDev_minimalApertureBeam();                                       break;














































































    case x38: dmxAnim_movingHead_lightOn_fastMove_allDev_CenterPan_LowTilt();                                   break;
    case x39: dmxAnim_movingHead_lightOn_fastMove_allDev_LeftPan_LowTilt();                                     break;
    case x40: dmxAnim_movingHead_lightOn_fastMove_allDev_RightPan_LowTilt();                                    break;
    case x41: dmxAnim_movingHead_lightOn_fastMove_allDev_CenterPan_FrontTilt();                                 break;
    case x42: dmxAnim_movingHead_lightOn_fastMove_allDev_LeftPan_FrontTilt();                                   break;
    case x43: dmxAnim_movingHead_lightOn_fastMove_allDev_RightPan_FrontTilt();                                  break;
    case x44: dmxAnim_movingHead_lightOn_fastMove_allDev_CenterPan_HighTilt();                                  break;
    case x45: dmxAnim_movingHead_lightOn_fastMove_allDev_LeftPan_HighTilt();                                    break;
    case x46: dmxAnim_movingHead_lightOn_fastMove_allDev_RightPan_HighTilt();                                   break;
    case x47: dmxAnim_movingHead_lightOn_fastMove_allDev_CenterPan_UprightTilt();                               break;
    case x48: dmxAnim_movingHead_lightOn_fastMove_allDev_LeftPan_UprightTilt();                                 break;
    case x49: dmxAnim_movingHead_lightOn_fastMove_allDev_RightPan_UprightTilt();                                break;
    case x50: dmxAnim_movingHead_lightOn_fastMove_allDev_CenterPan_BackTilt();                                  break;
    case x51: dmxAnim_movingHead_lightOn_fastMove_allDev_LeftPan_BackTilt();                                    break;
    case x52: dmxAnim_movingHead_lightOn_fastMove_allDev_RightPan_BackTilt();                                   break;
    case x53: dmxAnim_movingHead_lightOn_fastMove_allDev_WideDivergentPan_FrontTilt();                          break;
    case x54: dmxAnim_movingHead_lightOn_fastMove_allDev_ClassicDivergentPan_FrontTilt();                       break;
    case x55: dmxAnim_movingHead_lightOn_fastMove_allDev_WideDivergentPan_HighTilt();                           break;
    case x56: dmxAnim_movingHead_lightOn_fastMove_allDev_ClassicDivergentPan_HighTilt();                        break;
    case x57: dmxAnim_movingHead_lightOn_fastMove_allDev_WideConvergentPan_FrontTilt();                         break;
    case x58: dmxAnim_movingHead_lightOn_fastMove_allDev_ClassicConergentPan_FrontTilt();                       break;
    case x59: dmxAnim_movingHead_lightOn_fastMove_allDev_WideConvergentPan_HighTilt();                          break;
    case x60: dmxAnim_movingHead_lightOn_fastMove_allDev_ClassicConvergentPan_HighTilt();                       break;
    case x61: dmxAnim_movingHead_lightOn_fastMove_allDev_ExtremeDivergentPan_WideNegTilt();                     break;
    case x62: dmxAnim_movingHead_lightOn_fastMove_allDev_ExtremeDivergentPan_NarrowNegTilt();                   break;
    case x63: dmxAnim_movingHead_lightOn_fastMove_allDev_ExtremeDivergentPan_WidePosTilt();                     break;
    case x64: dmxAnim_movingHead_lightOn_fastMove_allDev_ExtremeDivergentPan_NarrowPosTilt();                   break;




////////////////////////////////////







    // case xxx: dmxAnim_movingHead_lightOn_fastMove_centerDev_Symmetric_CenterPan_LowTilt();                      break;
    // case xxx: dmxAnim_movingHead_lightOn_fastMove_centerDev_Symmetric_CenterPan_LowTilt();                      break;



                                                                        
    // case 165: dmxAnim_movingHead_fastMove_allDev_fastStrobe_CenterPan_LowTilt();                                        break;
    // case 166: dmxAnim_movingHead_fastMove_allDev_fastStrobe_LeftPan_LowTilt();                                          break;
    // case 167: dmxAnim_movingHead_fastMove_allDev_fastStrobe_RightPan_LowTilt();                                         break;
    // case 168: dmxAnim_movingHead_fastMove_allDev_fastStrobe_CenterPan_FrontTilt();                                      break;
    // case 169: dmxAnim_movingHead_fastMove_allDev_fastStrobe_LeftPan_FrontTilt();                                        break;
    // case 170: dmxAnim_movingHead_fastMove_allDev_fastStrobe_RightPan_FrontTilt();                                       break;
    // case 171: dmxAnim_movingHead_fastMove_allDev_fastStrobe_CenterPan_HighTilt();                                       break;
    // case 172: dmxAnim_movingHead_fastMove_allDev_fastStrobe_LeftPan_HighTilt();                                         break;
    // case 173: dmxAnim_movingHead_fastMove_allDev_fastStrobe_RightPan_HighTilt();                                        break;
    // case 174: dmxAnim_movingHead_fastMove_allDev_fastStrobe_CenterPan_UprightTilt();                                    break;
    // case 175: dmxAnim_movingHead_fastMove_allDev_fastStrobe_LeftPan_UprightTilt();                                      break;
    // case 176: dmxAnim_movingHead_fastMove_allDev_fastStrobe_RightPan_UprightTilt();                                     break;
    // case 177: dmxAnim_movingHead_fastMove_allDev_fastStrobe_CenterPan_BackTilt();                                       break;
    // case 178: dmxAnim_movingHead_fastMove_allDev_fastStrobe_LeftPan_BackTilt();                                         break;
    // case 179: dmxAnim_movingHead_fastMove_allDev_fastStrobe_RightPan_BackTilt();                                        break;
    // case 180: dmxAnim_movingHead_fastMove_allDev_fastStrobe_WideDivergentPan_FrontTilt();                               break;
    // case 181: dmxAnim_movingHead_fastMove_allDev_fastStrobe_ClassicDivergentPan_FrontTilt();                            break;
    // case 182: dmxAnim_movingHead_fastMove_allDev_fastStrobe_WideDivergentPan_HighTilt();                                break;
    // case 183: dmxAnim_movingHead_fastMove_allDev_fastStrobe_ClassicDivergentPan_HighTilt();                             break;
    // case 184: dmxAnim_movingHead_fastMove_allDev_fastStrobe_WideConvergentPan_FrontTilt();                              break;
    // case 185: dmxAnim_movingHead_fastMove_allDev_fastStrobe_ClassicConvergentPan_FrontTilt();                           break;
    // case 186: dmxAnim_movingHead_fastMove_allDev_fastStrobe_WideConvergentPan_HighTilt();                               break;
    // case 187: dmxAnim_movingHead_fastMove_allDev_fastStrobe_ClassicConvergentPan_HighTilt();                            break;
    // case 189: dmxAnim_movingHead_fastMove_allDev_fastStrobe_ExtremeDivergentPan_WideNegTilt();                          break;
    // case 190: dmxAnim_movingHead_fastMove_allDev_fastStrobe_ExtremeDivergentPan_NarrowNegTilt();                        break;
    // case 191: dmxAnim_movingHead_fastMove_allDev_fastStrobe_ExtremeDivergentPan_WidePosTilt();                          break;
    // case 192: dmxAnim_movingHead_fastMove_allDev_fastStrobe_ExtremeDivergentPan_NarrowPosTilt();                        break;
    

    // // From here on, slightly more complex animations

    // case 193: dmxAnim_movingHead_beatMove_1
    default: break;
  }
}

void setupDMXAnimation_movingHead() {
  switch(dmxAnimationNumber_movingHead) {

    
    case 58:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 59:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 60:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 61:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 62:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 63:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 64:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 65:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 66:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 67:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    
    case 68:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 69:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 70:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 71:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 72:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 73:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 74:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 75:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 76:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 77:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    
    case 78:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 79:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 80:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 81:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 82:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 83:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 84:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 85:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 86:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 87:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;

    case 88:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 89:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 90:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 91:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 92:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 93:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 94:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 95:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 96:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;
    case 97:  dmxAnim_movingHead_setupReinit_allDevices();                                             break;


    case 101: dmxAnim_movingHead_globalAnimCpt += 1;                                                   break;
    default: break;
  }
}


void playDMXAnimation_par() {
  switch(dmxAnimationNumber_par) {
    default: break;
  }
}

void setupDMXAnimation_par() {
  switch(dmxAnimationNumber_par) {
    default: break;
  }
}

///////////////////////////////////////////////////////////
// Generic blackout functions for all the different devices

void dmxAnim_total_blackout() {
  dmxAnim_strobe_blackout();
  dmxAnim_par_blackout();
  dmxAnim_movingHead_blackout();
}

// Stop all strobe fixtures, create a complete blackout
void dmxAnim_strobe_blackout() {
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

void dmxAnim_par_blackout() {

}

void dmxAnim_movingHead_blackout() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.setDimmer(0);
    movingHead.setSpeed_maxSpeed();
    movingHead.setShutterMode(DMX_SHUTTERMODE_DEFAULT);
  }
}
