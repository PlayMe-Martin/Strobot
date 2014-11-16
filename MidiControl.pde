
///////////////////////////////////////////////////////////////
/// Allow the Processing sketch to be controlled using MIDI ///
///////////////////////////////////////////////////////////////

import themidibus.*;         //Import MIDI library


//MIDI configuration :
final int CHANNEL_KEYBOARD           = 0;      //MIDI Channel 1
final int CHANNEL_SEMIAUTOMODE       = 1;      //MIDI Channel 2
final int CHANNEL_AUTOMODE           = 2;      //MIDI Channel 3
final int CHANNEL_MANUALMODE_1       = 3;      //MIDI Channel 4
final int CHANNEL_MANUALMODE_2       = 4;      //MIDI Channel 5
final int CHANNEL_MANUALMODE_3       = 5;      //MIDI Channel 6
final int CHANNEL_MANUALMODE_4       = 6;      //MIDI Channel 7

//Pitches for messages coming from the keyboard
final int PITCH_P1_LEFT              = 0;
final int PITCH_P1_RIGHT             = 2;
final int PITCH_P2_LEFT              = 22;
final int PITCH_P2_RIGHT             = 23;

//Pitches for messages coming from the pads + knobs
//These parameters must not be declared as final : they may be reconfigured later on 
int PITCH_PAD_KILL_LED_PANELS  = 40;
int PITCH_PAD_STROBE_4TH       = 36;
int PITCH_PAD_STROBE_8TH       = 37;
int PITCH_PAD_STROBE_16TH      = 41;
int PITCH_PAD_STROBE_32ND      = 42;
int PITCH_PAD_STROBE_64TH      = 38;
int PITCH_KNOB_BRIGHTNESS      = -1;      //Might be used again in the future, but for now, is pretty useless
int PITCH_KNOB_BLACKOUT        = 1;
int PITCH_KNOB_WHITEOUT        = 2;
int PITCH_KNOB_SHREDDER        = 5;
int PITCH_KNOB_COLORCHANGE     = 3;
int PITCH_KNOB_WHITEJAMAMONO   = -1;      //Not very fun as an animation, don't use it
int PITCH_KNOB_WHITENOISE      = 7;


//Pitches for messages coming from the DAW - Manual mode
final int PITCH_SET_AUTOMODE_OFF           = 90;
final int PITCH_SET_AUTOMODE_ON            = 91;

final int PITCH_CHANGE_STROBO_FRONT        = 100;
final int PITCH_START_STROBO_FRONT         = 101;
final int PITCH_STOP_STROBO_FRONT          = 102;
final int PITCH_GENERAL_STROBO_FRONT_LEFT  = 103;
final int PITCH_GENERAL_STROBO_FRONT_RIGHT = 104;
final int PITCH_GENERAL_STROBO_BACK        = 105;
final int PITCH_DMX_ANIMATION_BANK1        = 106;
final int PITCH_DMX_ANIMATION_BANK2        = 107;
final int PITCH_DMX_ANIMATION_BANK3        = 108;
final int PITCH_ENABLE_MAN_INPUT           = 110;
final int PITCH_DISABLE_MAN_INPUT          = 111;
final int PITCH_CUSTOM_DEVICE_BANK1        = 118;
final int PITCH_CUSTOM_DEVICE_BANK2        = 119;
final int PITCH_CUSTOM_DEVICE_BANK3        = 120;
final int PITCH_DISPLAY_EFFECT             = 121;
final int PITCH_LOAD_ANIMATION_BANK1       = 123;
final int PITCH_LOAD_ANIMATION_BANK2       = 124;
final int PITCH_LOAD_ANIMATION_BANK3       = 125;
final int PITCH_LOAD_ANIMATION_BANK4       = 122;
final int PITCH_LOAD_IMAGE_BANK1           = 126;
final int PITCH_CHANGE_OUTPUTMAPPING       = 127;


// Allow LED Panel remapping using the keyboard
// Use case : this boolean is set to true using the Maschine
// Once it is on, listen to the keyboard input : record NUMBER_OF_PANELS notes (with a different pitch)
// The mapping is then set using the input order and the pitch of the notes
// Ex : keyboard [ C5 E5 G#5 D5 F5 ] -> panel mapping [1 3 5 2 4]
boolean authorizePanelRemappingUsingKeyboard = false;
int[] manualLEDPanelRemappingNoteArray;
int manualLEDPanelRemappingNoteCounter = 0;

void midiInit() {
  outputLog.println("--- Initializing MIDI Control ---");
  MidiBus.list(); 
  //Arguments to create the MidiBus : Parent Class, IN device, OUT device, NAME
  myMainBus = new MidiBus(this, MIDI_BUS_MAIN_INPUT, MIDI_BUS_MAIN_INPUT, MIDI_BUS_MAIN_INPUT);
  outputLog.println("Configuration --- Main Input MIDI device : " + MIDI_BUS_MAIN_INPUT);
  try {myControllerBus = new MidiBus(this, MIDI_BUS_CONTROLLER_INPUT, MIDI_BUS_CONTROLLER_INPUT, MIDI_BUS_CONTROLLER_INPUT);}
  catch (Exception e) {println("Problem during initialization of controller MIDI input port : " + e);}
  outputLog.println("Configuration --- Controller Input MIDI device : " + MIDI_BUS_CONTROLLER_INPUT);
  
  try {myKeyboardBus = new MidiBus(this, MIDI_BUS_KEYBOARD_INPUT, MIDI_BUS_KEYBOARD_INPUT, MIDI_BUS_KEYBOARD_INPUT);}
  catch (Exception e) {println("Problem during initialization of controller MIDI input port : " + e);}
  outputLog.println("Configuration --- Keyboard Input MIDI device : " + MIDI_BUS_KEYBOARD_INPUT);

  outputLog.println("--- MIDI initialization over ---");
}


/////////////////////////////////////////////////
//////////////       NOTE ON       //////////////
/////////////////////////////////////////////////

void noteOn(int channel, int pitch, int velocity, long timestamp, String bus_name) {
  println("note on : " + pitch + " - " + velocity);
  
  if (initComplete == true) {
    // Receive a noteOn
    if (bus_name == myControllerBus.getBusName() || bus_name == myKeyboardBus.getBusName()) {
      //Drumpad sub-keyboard - couldn't use a switch here because the pitches are not declared as finals 
      if (pitch == PITCH_P1_LEFT)                  {p1Left(channel, pitch, velocity);}
      else if (pitch == PITCH_P1_RIGHT)            {p1Right(channel, pitch, velocity);}
      else if (pitch == PITCH_P2_LEFT)             {p2Left(channel, pitch, velocity);}
      else if (pitch == PITCH_P2_RIGHT)            {p2Right(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_KILL_LED_PANELS) {activateKillLedPanel(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_STROBE_4TH)      {activatePadStrobe4th(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_STROBE_8TH)      {activatePadStrobe8th(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_STROBE_16TH)     {activatePadStrobe16th(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_STROBE_32ND)     {activatePadStrobe32nd(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_STROBE_64TH)     {activatePadStrobe64th(channel, pitch, velocity);}
      
      //Custom function : Remapping using the keyboard, record the input notes 
      if (authorizePanelRemappingUsingKeyboard == true) {
        //Do not allow the same panel to be mapped to two different outputs
        boolean pitchAlreadyInArray = false;
        for (int element: manualLEDPanelRemappingNoteArray) {
          if (pitch == element) {
            pitchAlreadyInArray = true;
          }
        }
        
        if (manualLEDPanelRemappingNoteCounter == 0) {
          manualLEDPanelRemappingNoteArray[manualLEDPanelRemappingNoteCounter] = pitch;
          manualLEDPanelRemappingNoteCounter += 1;
          imagenumber = 0 - manualLEDPanelRemappingNoteCounter - 1;
        }
        else if (pitchAlreadyInArray == false) {
          manualLEDPanelRemappingNoteArray[manualLEDPanelRemappingNoteCounter] = pitch;
          manualLEDPanelRemappingNoteCounter += 1;
          imagenumber = 0 - manualLEDPanelRemappingNoteCounter - 1;
        }
        
        if (manualLEDPanelRemappingNoteCounter == NUMBER_OF_PANELS) {
          finalizeLEDPanelRemappingProcedure();
          imagenumber = 0;
        }
        
      }
    }
    
    if (channel == CHANNEL_MANUALMODE_1 || channel == CHANNEL_MANUALMODE_2 || channel == CHANNEL_MANUALMODE_3 || channel == CHANNEL_MANUALMODE_4) {
      //Release automatic mode in case of explicit input
      //This mode corresponds to a MPC-like controller selecting manually animations
      AUTOMATIC_MODE = false;
      setManualAnimation(channel, pitch);
    }
    
    if (channel == CHANNEL_SEMIAUTOMODE) {
      //Release automatic mode in case of explicit input
      //This mode corresponds to a DAW sending MIDI commands, for example through the use of clips (Ableton Live), scenes (Maschine), or plain old MIDI tracks (Logic)
      AUTOMATIC_MODE = false;
      switch (pitch) {
        //Manual input
        case PITCH_SET_AUTOMODE_OFF:           setAutomaticModeOff();break;                                             //F#5   - Disable the automatic mode
        case PITCH_SET_AUTOMODE_ON:            setAutomaticModeOn();break;                                              //G5    - Enable the automatic mode
        
        case PITCH_CHANGE_STROBO_FRONT:        changeStrobe(velocity);break;                                            //E7    - Deprecated way to use the stroboscope
        case PITCH_START_STROBO_FRONT:         startStrobe(velocity);break;                                             //F7    - Deprecated way to use the stroboscope
        case PITCH_STOP_STROBO_FRONT:          stopStrobe();break;                                                      //F#7   - Deprecated way to use the stroboscope
        
        case PITCH_GENERAL_STROBO_FRONT_LEFT:  startStrobe_FrontLeft(velocity);break;                                   //G7    - New way to use the stroboscope : noteOff releases the strobe
        case PITCH_GENERAL_STROBO_FRONT_RIGHT: startStrobe_FrontRight(velocity);break;                                  //G#7   - New way to use the stroboscope : noteOff releases the strobe
        case PITCH_GENERAL_STROBO_BACK:        startStrobe_Back(velocity);break;                                        //A7    - New way to use the stroboscope : noteOff releases the strobe

        case PITCH_DMX_ANIMATION_BANK1:        loadDMXAnimation1(velocity); break;                                      //A#7   - Load an animation using DMX devices
        case PITCH_DMX_ANIMATION_BANK2:        loadDMXAnimation2(velocity); break;                                      //B7
        case PITCH_DMX_ANIMATION_BANK3:        loadDMXAnimation3(velocity); break;                                      //C8
        
        case PITCH_ENABLE_MAN_INPUT:           enableManualInput();break;                                               //D8
        case PITCH_DISABLE_MAN_INPUT:          disableManualInput();break;                                              //D#8
        
        case PITCH_CUSTOM_DEVICE_BANK1:        loadCustomDeviceAnimation1(velocity);break;                              //A#8   - Load an animation for the custom devices
        case PITCH_CUSTOM_DEVICE_BANK2:        loadCustomDeviceAnimation2(velocity);break;                              //B8
        case PITCH_CUSTOM_DEVICE_BANK3:        loadCustomDeviceAnimation3(velocity);break;                              //C9
        case PITCH_DISPLAY_EFFECT:             activateAdditionalEffect(velocity);break;                                //C#9
        case PITCH_LOAD_ANIMATION_BANK1:       loadAnimation1(velocity);break;                                          //D#9   - Load an animation using the LED panels
        case PITCH_LOAD_ANIMATION_BANK2:       loadAnimation2(velocity);break;                                          //E9
        case PITCH_LOAD_ANIMATION_BANK3:       loadAnimation3(velocity);break;                                          //F9
        case PITCH_LOAD_ANIMATION_BANK4:       loadAnimation4(velocity);break;                                          //D9
        case PITCH_LOAD_IMAGE_BANK1:           loadImage1(velocity);break;                                              //F#9
        case PITCH_CHANGE_OUTPUTMAPPING:       activateKeyboardLEDPanelMapping();break;                                 //G9    - Activate the remapping procedure
        default: break;
      }
    }
  }
}

void p1Left(int channel, int pitch, int velocity) {
  //P1_LEFT 
  command_p1_left = true;
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : P1_LEFT");
}

void p1Right(int channel, int pitch, int velocity) {
  //P1_RIGHT
  command_p1_right = true;
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : P1_RIGHT");
}

void p2Left(int channel, int pitch, int velocity) {
  //P2_LEFT
  command_p2_left = true;
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : P2_LEFT");
}

void p2Right(int channel, int pitch, int velocity) {
  //P2_RIGHT
  command_p2_right = true; 
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : P2_RIGHT");
}

void activateKillLedPanel(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : ACTIVATE_KILL_LEDPANEL");
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setKillLedPanel = true;
  }
  if (authorizeKillLedPanelManualMode == true) {
    setKillLedPanelManualMode = true;
    if (authorizeDMXStrobe == true) {
      strobepreset_frontleft = 0;
      strobepreset_frontright = 0;
      stopStrobe_FrontLeft();
      stopStrobe_FrontRight();
    }
  }
}

void activatePadStrobe4th(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : ACTIVATE_PAD_STROBE_4TH");
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setStrobeAutoMode4th = true;
    registeredTempo = frameRate;
  }
  if (authorizeStrobeManualMode4th == true) {
    if (authorizePanelStrobe == true) {
      setStrobeManualMode4th = true;
    }
    if (authorizeDMXStrobe == true) {
      if ((setStrobeManualMode4th == true || setStrobeManualMode8th == true || setStrobeManualMode32nd == true || setStrobeManualMode64th == true) == false) {
        previousFrontLeftStrobeState = drawStrobe_FrontLeft;
        previousFrontLeftStrobePreset = strobepreset_frontleft;
        previousFrontRightStrobeState = drawStrobe_FrontRight;
        previousFrontRightStrobePreset = strobepreset_frontright;
      }
      strobepreset_frontleft = 40;
      strobepreset_frontright = 40;
      //Only need to call this function once
      startStrobe(strobepreset_frontleft);
    }
    registeredTempo = frameRate;
  }
}

void activatePadStrobe8th(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : ACTIVATE_PAD_STROBE_8TH");
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setStrobeAutoMode8th = true;
    registeredTempo = frameRate;
  }
  if (authorizeStrobeManualMode8th == true) {
    if (authorizePanelStrobe == true) {
      registeredTempo = frameRate;
    }
    if (authorizeDMXStrobe == true) {
      if ((setStrobeManualMode4th == true || setStrobeManualMode16th == true || setStrobeManualMode32nd == true || setStrobeManualMode64th == true) == false) {
        previousFrontLeftStrobeState = drawStrobe_FrontLeft;
        previousFrontLeftStrobePreset = strobepreset_frontleft;
        previousFrontRightStrobeState = drawStrobe_FrontRight;
        previousFrontRightStrobePreset = strobepreset_frontright;
      }
      strobepreset_frontleft = 60;
      strobepreset_frontright = 60;
      startStrobe(strobepreset_frontleft);
    }
    setStrobeManualMode8th = true;
  }
}

void activatePadStrobe16th(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : ACTIVATE_PAD_STROBE_16TH");
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setStrobeAutoMode16th = true;
    registeredTempo = frameRate;
  }
  if (authorizeStrobeManualMode16th == true) {
    if (authorizePanelStrobe == true) {
      registeredTempo = frameRate;
    }
    if (authorizeDMXStrobe == true) {
      if ((setStrobeManualMode4th == true || setStrobeManualMode8th == true || setStrobeManualMode32nd == true || setStrobeManualMode64th == true) == false) {
        previousFrontLeftStrobeState = drawStrobe_FrontLeft;
        previousFrontLeftStrobePreset = strobepreset_frontleft;
        previousFrontRightStrobeState = drawStrobe_FrontRight;
        previousFrontRightStrobePreset = strobepreset_frontright;
      }
      strobepreset_frontleft = 80;
      strobepreset_frontright = 80;
      startStrobe(strobepreset_frontleft);
    }
    setStrobeManualMode16th = true;
  }
}

void activatePadStrobe32nd(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : ACTIVATE_PAD_STROBE_32ND");
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setStrobeAutoMode32nd = true;
    registeredTempo = frameRate;
  }
  if (authorizeStrobeManualMode32nd == true) {
    if (authorizePanelStrobe == true) {
      registeredTempo = frameRate;
    }
    if (authorizeDMXStrobe == true) {
      if ((setStrobeManualMode4th == true || setStrobeManualMode8th == true || setStrobeManualMode16th == true || setStrobeManualMode64th == true) == false) {
        previousFrontLeftStrobeState = drawStrobe_FrontLeft;
        previousFrontLeftStrobePreset = strobepreset_frontleft;
        previousFrontRightStrobeState = drawStrobe_FrontRight;
        previousFrontRightStrobePreset = strobepreset_frontright;
      }
      strobepreset_frontleft = 100;
      strobepreset_frontright = 100;
      startStrobe(strobepreset_frontleft);
    }
    setStrobeManualMode32nd = true;
  }
}

void activatePadStrobe64th(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : ACTIVATE_PAD_STROBE_64TH");
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setStrobeAutoMode64th = true;
    registeredTempo = frameRate;
  }
  if (authorizeStrobeManualMode64th == true) {
    if (authorizePanelStrobe == true) {
      registeredTempo = frameRate;
    }
    if (authorizeDMXStrobe == true) {
      if ((setStrobeManualMode4th == true || setStrobeManualMode8th == true || setStrobeManualMode16th == true || setStrobeManualMode32nd == true) == false) {
        previousFrontLeftStrobeState = drawStrobe_FrontLeft;
        previousFrontLeftStrobePreset = strobepreset_frontleft;
        previousFrontRightStrobeState = drawStrobe_FrontRight;
        previousFrontRightStrobePreset = strobepreset_frontright;
        previousBackStrobeState = drawStrobe_Back;
        previousBackStrobePreset = strobepreset_back;
      }
      strobepreset_frontleft = 100;
      strobepreset_frontright = 100;
      strobepreset_back = 100;
      startStrobe(strobepreset_frontleft);
      startStrobe_Back(strobepreset_back);
    }
    setStrobeManualMode64th = true;
  }
}

void changeStrobe(int velocity) {
  //CHANGE_STROBE - change both front stroboscopes
  strobepreset_frontleft = velocity;
  strobepreset_frontright = velocity;
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : Change both front stroboscope speed/brightness to preset " + strobepreset_frontleft);
  
  // if the velocity is out of the table's bounds, prevent a crash
  if (velocity >= strobelist.length)
  {
    strobepreset_frontleft = 1;
    strobepreset_frontright = 1;
    outputLog.println("DMX changeStrobe function input error : Input MIDI velocity is out of bounds, setting default speed preset"); 
  }

  // if the stroboscope is already active, update the preset
  if (drawStrobe_FrontLeft == 1 || drawStrobe_FrontRight == 1) {
    drawStrobe_FrontLeft  = 1;
    drawStrobe_FrontRight = 1;
    myDMX.setStrobePreset_FrontLeft(strobepreset_frontleft);
    myDMX.setStrobePreset_FrontRight(strobepreset_frontright);
  }
  
}

//Old method to call the front stroboscope, still works, but the more up-to-date startStrobe_FrontRight/Left should be used
void startStrobe(int velocity) {
  //START_STROBE
  drawStrobe_FrontLeft = 1;
  drawStrobe_FrontRight = 1;
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: Start front stroboscope with speed/brightness preset " + strobepreset_frontleft);
}

//Old method to call the front stroboscope, still works, but the more up-to-date stopStrobe_Front should be used
void stopStrobe() {
  //STOP_STROBE
  drawStrobe_FrontLeft = 0;
  drawStrobe_FrontRight = 0;
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: Corresponding message : Stop front stroboscope");

}



void setAutomaticModeOff() {     
  outputLog.println("Action received: Set Automatic Mode OFF");
  AUTOMATIC_MODE = false;
  // Update the GUI's Auto Mode toggle
  controlFrame.setAutomaticModeToggle.setValue(false);
}
  
void setAutomaticModeOn() {  
  outputLog.println("Action received: Set Automatic Mode ON");
  AUTOMATIC_MODE = true;
  controlFrame.setAutomaticModeToggle.setValue(true);
}


void activateAdditionalEffect(int velocity) {
  effectToBeDrawn = true;
  currentEffectNumber = velocity;
  effectNumberToDeactivateEffects = velocity;
}

void deactivateAdditionalEffect(int velocity) {
  effectToBeDrawn = false;
}

void loadDMXAnimation1(int velocity) {
  loadDMXAnimation(velocity);
}

void loadDMXAnimation2(int velocity) {
  loadDMXAnimation(velocity + 127);
}

void loadDMXAnimation3(int velocity) {
  loadDMXAnimation(velocity + 254);
}

void loadDMXAnimation(int dmxAnimNumber) {
  //When such a command is received, and while the note continues, the DMX control is up to Strobot
  dmxAutomaticControl = true;
  
  dmxAnimationNumber = dmxAnimNumber;
  setupDMXAnimation();
}

void loadCustomDeviceAnimation1(int velocity) {
  customDeviceAnimation(velocity);
}

void loadCustomDeviceAnimation2(int velocity) {
  customDeviceAnimation(velocity + 127);
}

void loadCustomDeviceAnimation3(int velocity) {
  customDeviceAnimation(velocity + 254);
}


void loadAnimation1(int velocity) {
  //Update the animation number
  loadAnimation(velocity);
}

void loadAnimation2(int velocity) {
  //Update the animation number
  loadAnimation(velocity + 127);
}

void loadAnimation3(int velocity) {
  //Update the animation number
  loadAnimation(velocity + 254);
}

void loadAnimation4(int velocity) {  
  //Update the animation number
  loadAnimation(velocity + 381);
}

void loadAnimation (int number) {
  drawImage = 0;
  drawAnimation = 1;
  
  //Reset the flag to prevent any nullpointer exception
  setupcomplete = false;
  
  //Update the animation number
  animationnumber = number;
  
  //Kept for debug, not necessary in the release version
  //outputLog.println("Semi-auto action : Change current animation to " + animationnumber);
  
  //Execute specific actions related to this particular animation
  specificActions();  
}

void loadImage1(int velocity) {
  //LOAD_IMAGE_BANK1
  drawImage = 1;
  drawAnimation = 0;

  //No need to reset the flag
  setupcomplete = true;

  //Get the first value as an string
  imagenumber = velocity;
  
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note On received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : Load image number " + imagenumber);      
}

void activateKeyboardLEDPanelMapping() {
  //Without this reset, no common base exists to say "this is the nth panel"
  resetLEDPanelMapping();
  
  manualLEDPanelRemappingNoteArray = new int[NUMBER_OF_PANELS];
  for (int i=0;i<NUMBER_OF_PANELS;i++) { manualLEDPanelRemappingNoteArray[i] = -1; }
    
  manualLEDPanelRemappingNoteCounter = 0;
  authorizePanelRemappingUsingKeyboard = true;
  
  //Display an image lighting only the current panel to map to inform the user 
  drawImage = 1;
  drawAnimation = 0;
  imagenumber = -1;
}

void finalizeLEDPanelRemappingProcedure() {
  
  int[] sortedNoteList = sort(manualLEDPanelRemappingNoteArray);
  int[] sortedArray = new int[sortedNoteList.length];
  
  for (int i=0; i<sortedNoteList.length; i++) {
    for (int panelNb=0; panelNb<manualLEDPanelRemappingNoteArray.length; panelNb++) {
      if (sortedNoteList[i] == manualLEDPanelRemappingNoteArray[panelNb]) {
        sortedArray[i] = panelNb;
      }
    }
  }
    
  // Most critical part : update the panelNumber directly inside the Output objects !
  for (int i=0; i<outputDevices.length; i++) {
    outputDevices[i].panelNumber = sortedArray[i];
    screen_order_configuration[i] = sortedArray[i];
  }
  
  manualLEDPanelRemappingNoteCounter = 0;
  authorizePanelRemappingUsingKeyboard = false;
  
  //Make the configuration change persistant
  writeScreenOrderInConfigurationFile();
}

//Reset the output order of the panels back to their original pre-conf value
void resetLEDPanelMapping() {
  for (int i=0; i<outputDevices.length; i++) {
    outputDevices[i].panelNumber = i;
  }
}



void startStrobe_FrontLeft(int velocity) {
  strobepreset_frontleft = velocity;
  drawStrobe_FrontLeft = 1;
  myDMX.setStrobePreset_FrontLeft(velocity); 
}

void startStrobe_FrontRight(int velocity) {
  strobepreset_frontright = velocity;
  drawStrobe_FrontRight = 1;
  myDMX.setStrobePreset_FrontRight(velocity);
 
}

void startStrobe_Back(int velocity) {
  strobepreset_back = velocity;
  drawStrobe_Back = 1;
  myDMX.setStrobePreset_Back(velocity);
 
}


//////////////////////////////////////////////////
//////////////       NOTE OFF       //////////////
//////////////////////////////////////////////////


void noteOff(int channel, int pitch, int velocity, long timestamp, String bus_name) {
    
  // Receive a noteOff
  if (initComplete == true) {
    if (bus_name == myControllerBus.getBusName() || bus_name == myKeyboardBus.getBusName()) {
      if (pitch == PITCH_P1_LEFT)                  {p1LeftStop(channel, pitch, velocity);}
      else if (pitch == PITCH_P1_RIGHT)            {p1RightStop(channel, pitch, velocity);}
      else if (pitch == PITCH_P2_LEFT)             {p2LeftStop(channel, pitch, velocity);}
      else if (pitch == PITCH_P2_RIGHT)            {p2RightStop(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_KILL_LED_PANELS) {deactivateKillLedPanel(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_STROBE_4TH)      {deactivatePadStrobe4th(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_STROBE_8TH)      {deactivatePadStrobe8th(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_STROBE_16TH)     {deactivatePadStrobe16th(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_STROBE_32ND)     {deactivatePadStrobe32nd(channel, pitch, velocity);}
      else if (pitch == PITCH_PAD_STROBE_64TH)     {deactivatePadStrobe64th(channel, pitch, velocity);}
    }
    
    //Semi-automatic mode - Release for DMX actions, or for effects
    if (channel == CHANNEL_SEMIAUTOMODE) {
      //Do not release automatic mode : only Note On events have this right
      //AUTOMATIC_MODE = false;
      switch (pitch) {
        case PITCH_GENERAL_STROBO_FRONT_LEFT:  stopStrobe_FrontLeft();break;                               //G7    - New way to use the stroboscope : noteOff releases the strobe
        case PITCH_GENERAL_STROBO_FRONT_RIGHT: stopStrobe_FrontRight();break;                              //G#7   - New way to use the stroboscope : noteOff releases the strobe
        case PITCH_GENERAL_STROBO_BACK:        stopStrobe_Back();break;                                    //A7    - New way to use the stroboscope : noteOff releases the strobe

        case PITCH_DMX_ANIMATION_BANK1:        unloadDMXAnimation(); break;                                //A#7   - Unload an animation using DMX devices : noteOff releases DMX
        case PITCH_DMX_ANIMATION_BANK2:        unloadDMXAnimation(); break;                                //B7
        case PITCH_DMX_ANIMATION_BANK3:        unloadDMXAnimation(); break;                                //C8
        
        case PITCH_DISPLAY_EFFECT:             deactivateAdditionalEffect(velocity);break;                 //C9    - Reset the effect
        default: break;
      }
    }
    
    //Manual mode : release the animation in case of momentary animations
    if (channel == CHANNEL_MANUALMODE_1 || channel == CHANNEL_MANUALMODE_2 || channel == CHANNEL_MANUALMODE_3 || channel == CHANNEL_MANUALMODE_4) {
      
      int animationToBePlayed = 1;
      int behaviour = 1;
      for (int[] pad: manualMode_InputTranslationList) {
        if (pad[0] == channel && pad[1] == pitch) {
          animationToBePlayed = pad[2];
          behaviour = pad[3];
          break;
        }
      }
      
      //The command aims to change the LED panels
      if (animationToBePlayed >0) {
        if (expectingNoteOffForRelease == true) {
          if (noteOffToResetAnimation == pitch) {
            noteOffRevertToPreviousAnimation();
          }
        }        
      }
      //The command is an order for DMX devices
      else {
        if (pitch == noteOffToResetDMX) {
          strobepreset_frontleft = 0;
          myDMX.stopStrobe_FrontLeft();
          strobepreset_frontright = 0;
          myDMX.stopStrobe_FrontRight();
          strobepreset_back = 0;
          myDMX.stopStrobe_Back();
        }
      }
    }
  }
}

void stopStrobe_FrontLeft() {
  drawStrobe_FrontLeft = 0;
  myDMX.stopStrobe_FrontLeft();
}

void stopStrobe_FrontRight() {
  drawStrobe_FrontRight = 0;
  myDMX.stopStrobe_FrontRight();
}

void stopStrobe_Back() {
  drawStrobe_Back = 0;
  myDMX.stopStrobe_Back();
 
}

void unloadDMXAnimation() {
  //Note off for the DMX animation, kill the DMX animation by switching everything back to a blackout
  dmxAutomaticControl = false;
  dmxAnimationNumber = 1;
  dmxAnim_blackout();
}

void p1LeftStop(int channel, int pitch, int velocity) {          //Pitch == 0
  command_p1_left = false;
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note Off received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : P1_LEFT_STOP");
}

void p1RightStop(int channel, int pitch, int velocity) {         //Pitch == 2
  command_p1_right = false;
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note Off received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : P1_RIGHT_STOP");
}

void p2LeftStop(int channel, int pitch, int velocity) {          //Pitch == 23
  command_p2_left = false;
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note Off received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : P2_LEFT_STOP");
}

void p2RightStop(int channel, int pitch, int velocity) {         //Pitch == 24
  command_p2_right = false;
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note Off received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : P2_RIGHT_STOP");
}


void deactivateKillLedPanel(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note Off received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : DEACTIVATE_KILL_LEDPANEL");
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setKillLedPanel = false;
  }
  if (authorizeKillLedPanelManualMode == true) {
    setKillLedPanelManualMode = false;
  }
}


void deactivatePadStrobe4th(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note Off received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : DEACTIVATE_PAD_STROBE_4TH");
  
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setStrobeAutoMode4th = false;
    frameRate(registeredTempo);
    stroboAutoPadNoteOff = false;
  }
  if (authorizeStrobeManualMode4th == true) {
    if (authorizePanelStrobe == true) {
      frameRate(registeredTempo);
    }
    if (authorizeDMXStrobe == true) {
      if ((setStrobeManualMode8th == true || setStrobeManualMode16th == true || setStrobeManualMode32nd == true || setStrobeManualMode64th == true) == false) {
        drawStrobe_FrontLeft = previousFrontLeftStrobeState;
        strobepreset_frontleft = previousFrontLeftStrobePreset;
        drawStrobe_FrontRight = previousFrontRightStrobeState;
        strobepreset_frontright = previousFrontRightStrobePreset;
        
        if (drawStrobe_FrontLeft == 0 || drawStrobe_FrontRight == 0) {
          drawStrobe_FrontLeft  = 0;
          drawStrobe_FrontRight = 0;
          stopStrobe_FrontLeft();
          stopStrobe_FrontRight();
        }
        else {
          startStrobe_FrontRight(strobepreset_frontright);
          startStrobe_FrontLeft(strobepreset_frontleft);
        }
      }
    }
    setStrobeManualMode4th = false;
  }
}

void deactivatePadStrobe8th(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note Off received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : DEACTIVATE_PAD_STROBE_8TH");
  
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setStrobeAutoMode8th = false;
    frameRate(registeredTempo);
    stroboAutoPadNoteOff = false;
  }
  if (authorizeStrobeManualMode8th == true) {
    if (authorizePanelStrobe == true) {
      frameRate(registeredTempo);
    }
    if (authorizeDMXStrobe == true) {
      if ((setStrobeManualMode4th == true || setStrobeManualMode16th == true || setStrobeManualMode32nd == true || setStrobeManualMode64th == true) == false) {
        drawStrobe_FrontRight = previousFrontRightStrobeState;
        strobepreset_frontright = previousFrontRightStrobePreset;
        drawStrobe_FrontLeft = previousFrontLeftStrobeState;
        strobepreset_frontleft = previousFrontLeftStrobePreset;
        
        if (drawStrobe_FrontLeft == 0 || drawStrobe_FrontRight == 0) {
          drawStrobe_FrontLeft  = 0;
          drawStrobe_FrontRight = 0;
          stopStrobe_FrontLeft();
          stopStrobe_FrontRight();
        }
        else {
          startStrobe_FrontRight(strobepreset_frontright);
          startStrobe_FrontLeft(strobepreset_frontleft);
        }
      }
    }
    setStrobeManualMode8th = false;
  }
}

void deactivatePadStrobe16th(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note Off received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : DEACTIVATE_PAD_STROBE_16TH");
  
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setStrobeAutoMode16th = false;
    frameRate(registeredTempo);
    stroboAutoPadNoteOff = false;
  }
  if (authorizeStrobeManualMode16th == true) {
    if (authorizePanelStrobe == true) {
      frameRate(registeredTempo);
    }
    if (authorizeDMXStrobe == true) {
      if ((setStrobeManualMode4th == true || setStrobeManualMode8th == true || setStrobeManualMode32nd == true || setStrobeManualMode64th == true) == false) {
        drawStrobe_FrontLeft = previousFrontLeftStrobeState;
        strobepreset_frontleft = previousFrontLeftStrobePreset;
        drawStrobe_FrontRight = previousFrontRightStrobeState;
        strobepreset_frontright = previousFrontRightStrobePreset;
        
        if (drawStrobe_FrontLeft == 0 || drawStrobe_FrontRight == 0) {
          drawStrobe_FrontLeft  = 0;
          drawStrobe_FrontRight = 0;
          stopStrobe_FrontLeft();
          stopStrobe_FrontRight();
        }
        else {
          startStrobe_FrontRight(strobepreset_frontright);
          startStrobe_FrontLeft(strobepreset_frontleft);
        }
      }
    }
    setStrobeManualMode16th = false;
  }
}

void deactivatePadStrobe32nd(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note Off received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : DEACTIVATE_PAD_STROBE_32ND");
  
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setStrobeAutoMode32nd = false;
    frameRate(registeredTempo);
    stroboAutoPadNoteOff = false;
  }
  if (authorizeStrobeManualMode32nd == true) {
    if (authorizePanelStrobe == true) {
      frameRate(registeredTempo);
    }
    if (authorizeDMXStrobe == true) {
      if ((setStrobeManualMode8th == true || setStrobeManualMode16th == true || setStrobeManualMode4th == true || setStrobeManualMode64th == true) == false) {
        drawStrobe_FrontLeft = previousFrontLeftStrobeState;
        strobepreset_frontleft = previousFrontLeftStrobePreset;
        drawStrobe_FrontRight = previousFrontRightStrobeState;
        strobepreset_frontright = previousFrontRightStrobePreset;
        
        if (drawStrobe_FrontLeft == 0 || drawStrobe_FrontRight == 0) {
          drawStrobe_FrontLeft  = 0;
          drawStrobe_FrontRight = 0;
          stopStrobe_FrontLeft();
          stopStrobe_FrontRight();
        }
        else {
          startStrobe_FrontRight(strobepreset_frontright);
          startStrobe_FrontLeft(strobepreset_frontleft);
        }
      }
    }
    setStrobeManualMode32nd = false;
  }
}

void deactivatePadStrobe64th(int channel, int pitch, int velocity) {
  //Kept for debug, not necessary in the release version
  //outputLog.println("Note Off received: (Channel, Pitch, Velocity = (" + channel + ", " + pitch + ", " + velocity + ")    -> Corresponding message : DEACTIVATE_PAD_STROBE_64TH");
  
  if (AUTOMATIC_MODE == true) {
    automaticSequencer.setStrobeAutoMode64th = false;
    frameRate(registeredTempo);
    stroboAutoPadNoteOff = false;
  }
  if (authorizeStrobeManualMode32nd == true) {
    if (authorizePanelStrobe == true) {
      frameRate(registeredTempo);
    }
    if (authorizeDMXStrobe == true) {
      if ((setStrobeManualMode8th == true || setStrobeManualMode16th == true || setStrobeManualMode4th == true || setStrobeManualMode32nd == true) == false) {
        drawStrobe_FrontLeft = previousFrontLeftStrobeState;
        strobepreset_frontleft = previousFrontLeftStrobePreset;
        drawStrobe_FrontRight = previousFrontRightStrobeState;
        strobepreset_frontright = previousFrontRightStrobePreset;
        drawStrobe_Back = previousBackStrobeState;
        strobepreset_back = previousBackStrobePreset;
        
        if (drawStrobe_FrontLeft == 0 || drawStrobe_FrontRight == 0) {
          drawStrobe_FrontLeft  = 0;
          drawStrobe_FrontRight = 0;
          stopStrobe_FrontLeft();
          stopStrobe_FrontRight();
        }
        else {
          startStrobe_FrontRight(strobepreset_frontright);
          startStrobe_FrontLeft(strobepreset_frontleft);
        }
        
        if (drawStrobe_Back == 0) {
          stopStrobe_Back();
        }
        else {
          startStrobe_Back(strobepreset_back);
        }
      }
    }
    setStrobeManualMode64th = false;
  }
}

/////////////////////////////////////////////////
//////////////  CONTROLLER CHANGE  //////////////
/////////////////////////////////////////////////

// Receive a controllerChange  
void controllerChange(int channel, int number, int value, long timestamp, String bus_name) {
  if (bus_name == MIDI_BUS_CONTROLLER_INPUT || bus_name == MIDI_BUS_KEYBOARD_INPUT) {    //Filter the panic all-notes-off messages sent to other channels
    if (number == PITCH_KNOB_BRIGHTNESS)         {changeBrightness(channel, number, value);}          //Modulation wheel : change global brightness
    else if (number == PITCH_KNOB_BLACKOUT)      {setBlackOutAutoMode(channel, number, value);}       //Low-pass filter knob : blackout
    else if (number == PITCH_KNOB_WHITEOUT)      {setWhiteOutAutoMode(channel, number, value);}       //Hi-pass filter knob : whiteout
    else if (number == PITCH_KNOB_SHREDDER)      {setShredderAutoMode(channel, number, value);}       //Repeat knob : depending on the value, set splitter or shredder on
    else if (number == PITCH_KNOB_COLORCHANGE)   {setColorChangeAutoMode(channel, number, value);}    //Color change : when the phaser is set, tint the screen with a cycling color
    else if (number == PITCH_KNOB_WHITEJAMAMONO) {setWhiteJamaMonoAutoMode(channel, number, value);}  //WhiteJamaMono : when the pitch shift is set, a white rectangle enters the screen
    else if (number == PITCH_KNOB_WHITENOISE)    {setWhiteNoiseAutoMode(channel, number, value);}     //White noise : pixelize the output accordingly to the input value 
  }
}

void changeBrightness(int channel, int number, int value) {
  //CHANGE_BRIGHTNESS
  //outputLog.println("Note On received: (Channel, Number, Value = (" + channel + ", " + number + ", " + value + ")    -> Corresponding message : CHANGE_BRIGHTNESS");
  brightness = value / 127.0;
}

void setBlackOutAutoMode(int channel, int number, int value) {
  if (AUTOMATIC_MODE == true) {
    if (value == 0) {
      automaticSequencer.setBlackOutAutomode = false;
      automaticSequencer.blackoutPower = 0;
      //outputLog.println("Note On received: (Channel, Number, Value = (" + channel + ", " + number + ", " + value + ")    -> Corresponding message : SET_BLACKOUT_OFF");
    }
    else {
      automaticSequencer.setBlackOutAutomode = true;
      automaticSequencer.blackoutPower = value;
      //outputLog.println("Note On received: (Channel, Number, Value = (" + channel + ", " + number + ", " + value + ")    -> Corresponding message : SET_BLACKOUT_ON");
    }
  }
  else {
    if (authorizeBlackOutManualMode == true) {
      if (value == 0) {
        setBlackOutManualMode = false;
        blackoutPowerManualMode = 0;
      }
      else {
        setBlackOutManualMode = true;
        blackoutPowerManualMode = value;
      }
    }
  }
}

void setWhiteOutAutoMode(int channel, int number, int value) {
  if (AUTOMATIC_MODE == true) {
    if (value == 0) {
      automaticSequencer.setWhiteOutAutomode = false;
      automaticSequencer.whiteoutPower = 0;
      //outputLog.println("Note On received: (Channel, Number, Value = (" + channel + ", " + number + ", " + value + ")    -> Corresponding message : SET_WHITEOUT_OFF");
    }
    else {
      automaticSequencer.setWhiteOutAutomode = true;
      automaticSequencer.whiteoutPower = value;
      //outputLog.println("Note On received: (Channel, Number, Value = (" + channel + ", " + number + ", " + value + ")    -> Corresponding message : SET_WHITEOUT_ON");
    }
  }
  else {
    if (authorizeWhiteOutManualMode == true) {
      if (value == 0) {
        setWhiteOutManualMode = false;
        whiteoutPowerManualMode = 0;
      }
      else {
        setWhiteOutManualMode = true;
        whiteoutPowerManualMode = value;
      }
    }
  }
}

void setShredderAutoMode(int channel, int number, int value) {
  if (AUTOMATIC_MODE == true) {
    if (value == 0) {
      //outputLog.println("Note On received: (Channel, Number, Value = (" + channel + ", " + number + ", " + value + ")    -> Corresponding message : SET_SHREDDER_OFF");
      
      //The shredder was active : the animation needs to be reinitialised
      if (automaticSequencer.setShredderAutoMode == true) {
        automaticSequencer.animationShouldBeReinitialized = true;
      }
      
      automaticSequencer.setShredderAutoMode = false; 
      automaticSequencer.shredderPower = 0;
    }
    else {
      automaticSequencer.setShredderAutoMode = true; 
      automaticSequencer.shredderPower = value;
      //outputLog.println("Note On received: (Channel, Number, Value = (" + channel + ", " + number + ", " + value + ")    -> Corresponding message : SET_SHREDDER_ON");
    }
  }
  else {
    if (authorizeShredderManualMode == true) {
      if (value == 0) {
        setShredderManualMode = false;
        shredderPowerManualMode = 0;
        //Reinit
        specificActions();
      }
      else {
        setShredderManualMode = true;
        shredderPowerManualMode = value;
      }
    }
  }
}


void setColorChangeAutoMode(int channel, int number, int value) {
  if (AUTOMATIC_MODE == true) {
    if (value == 0) {
      //outputLog.println("Note On received: (Channel, Number, Value = (" + channel + ", " + number + ", " + value + ")    -> Corresponding message : SET_COLORCHANGE_OFF");
      automaticSequencer.setColorChangeAutoMode = false;
      automaticSequencer.colorChangePower = 0;
    }
    else {
      //outputLog.println("Note On received: (Channel, Number, Value = (" + channel + ", " + number + ", " + value + ")    -> Corresponding message : SET_COLORCHANGE_ON");
      automaticSequencer.setColorChangeAutoMode = true;
      automaticSequencer.colorChangePower = value;
    }
  }
  else {
    if (authorizeColorChangeManualMode == true) {
      if (value == 0) {
        setColorChangeManualMode = false;
        colorChangePowerManualMode = 0;
      }
      else {
        setColorChangeManualMode = true;
        colorChangePowerManualMode = value;
      }
    }
  }
}

void setWhiteJamaMonoAutoMode(int channel, int number, int value) {
  if (AUTOMATIC_MODE == true) {
    if (value == 0) {
      //outputLog.println("Note On received: (Channel, Number, Value = (" + channel + ", " + number + ", " + value + ")    -> Corresponding message : SET_WHITEJAMAMONO_OFF");
      automaticSequencer.setWhiteJamaMonoAutoMode = false;
      automaticSequencer.whiteJamaMonoPower = 0;
    }
    else {
      //outputLog.println("Note On received: (Channel, Number, Value = (" + channel + ", " + number + ", " + value + ")    -> Corresponding message : SET_WHITEJAMAMONO_ON");
      automaticSequencer.setWhiteJamaMonoAutoMode = true;
      automaticSequencer.whiteJamaMonoPower = value;
    }
  }
  else {
    if (authorizeWhiteJamaMonoManualMode == true) {
      if (value == 0) {
        setWhiteJamaMonoManualMode = false;
        whiteJamaMonoPowerManualMode = 0;
      }
      else {
        setWhiteJamaMonoManualMode = true;
        whiteJamaMonoPowerManualMode = value;
      }
    }
  }
}

void setWhiteNoiseAutoMode(int channel, int number, int value) {
  if (authorizeWhiteNoiseManualMode == true) {
    if (value == 0) {
      setWhiteNoiseManualMode = false;
      whiteNoisePowerManualMode = 0;
    }
    else {
      setWhiteNoiseManualMode = true;
      whiteNoisePowerManualMode = value;
    }
  }

}


////////////////////////////////////////////
// ENABLE / DISABLE ADDITIONAL MIDI INPUT //
////////////////////////////////////////////

void disableManualInput(){
  authorizeStrobeManualMode4th     = false;
  authorizeStrobeManualMode8th     = false;
  authorizeStrobeManualMode16th    = false;
  authorizeStrobeManualMode32nd    = false;
  authorizeStrobeManualMode64th    = false;
  authorizeColorChangeManualMode   = false;
  authorizeWhiteJamaMonoManualMode = false;
  authorizeWhiteNoiseManualMode    = true;
}

void enableManualInput(){
  authorizeStrobeManualMode4th     = true;
  authorizeStrobeManualMode8th     = true;
  authorizeStrobeManualMode16th    = true;
  authorizeStrobeManualMode32nd    = true;
  authorizeStrobeManualMode64th    = true;
  authorizeColorChangeManualMode   = true;
  authorizeWhiteJamaMonoManualMode = false;
  authorizeWhiteNoiseManualMode    = true;
}
