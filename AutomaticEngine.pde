//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Automatic light selector, A.I. responding to input MIDI messages and selecting appropriately the correct animations  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
The automatic engine relies on audio which may be sent by the DAW, using the SignalProcessor VST plugin.
The plugin is to be put as an effect on each track with a special function :
- Kick
- Snare
- Hats/Cymbals
- Bass
- Keys (high synths, leads, piano)
- Guitar (even if in PlayMe's case, the guitar is not to be routed to the master output)

The six plugin instances can send the following messages :
- Signal level : an instant value of the track's output level, averaged on a user-defined buffer
- Impulses : the plugin detects important changes in intensity, and associates them to beats, or impulses
- FFT : 12-band Fast Fourier Transform of the signal, averaged over a few values for more precision. Fairly expensive CPU-wise, so only switch it on for the instances which really need it (Bass for example) 
- TimeInfo : Transport informations, ie current position, BPM and whether playback is active. Only one instance should be set to send these messages, it's enough !
These messages are received by the different threads in AudioSignalProcessing, and the variables they set are to be consumed by this class

--------------------------------
-- Setting up SignalProcessor --
--------------------------------
Different settings may be recommended depending on the source
For the kick : short averaging buffer (512) to have a lot of messages per second (and be reactive if the intensity changes)
For the snare : longer averaging buffer (2048) to have a picture over a longer period whether the snare is here or not


An ultra-general all-powerful AI is too hard to make, and realistically speaking, would probably fail at being ultra-dynamic
and always appropriated to the musical context.
The first version of the AI (before the complete rewrite) was using this paradigm, and even though it kinda worked, it wasn't
too fancy : an algorithmic main animation - transition - another main animation AI can only go so far without being redundant,
or without being a CPU hog. It's also to be noted that the transitions which were chosen by the AI, while not out of context, 
had an "average" feeling to them, the difference between machine-made and man-made sequences  would have been clear to the public.
A lot of animations are way too specific to be integrated in an auto-mode like that without looking bland (sets, multi-controls, rhythm...)

To do something more usable live, and generally speaking more impressive, a compromise was made : part of the work still needs to
be done by a human.
The AI processes a general intensity using all these messages, and creates a set of variables which correspond more or less to a "I
think that something like that is going on with the music" declaration. These variables are then used, following a certain number of
scenarios, to pick in specific banks of animation sequences.
These sequences are short MIDI clips created by the user, containing DMX, panel or custom device animations. They are divided into banks 
of different intensities, and processed at the start of the program.

*/


//Color sets : declare them as finals for better code readability
final int COLORSET_BLACK     = 0;
final int COLORSET_RED       = 1;
final int COLORSET_BLUE      = 2;
final int COLORSET_COLORFUL  = 3;

//Intensity levels
final int INTENSITY_DEFAULT  = 0;
final int INTENSITY_LOW      = 1;
final int INTENSITY_MEDIUM   = 2;
final int INTENSITY_HIGH     = 3;
final int INTENSITY_HARDCORE = 4;


//Automatic mode flag : set to true or false by input MIDI notes
boolean AUTOMATIC_MODE = true;


class PlayMeSequencer {

  boolean isPlaying = false;                //State of the host, is equal to true if playback is set to true
  float currentBPM = 120.0;                 //Current BPM of the host
  float currentPosition = 0.0;              //Current position, in pulses-per-quarter-note (ie, 1:1:1 -> 0.0,  1:2:4 -> 1.75, 2:1:1 -> 4.0)
  
  int currentIntensity = INTENSITY_DEFAULT; //Intensity of the sequences which will be played, defined the incoming audio
  
  MidiSequence currentSequence;             //Sequence being currently played by the sequencer
  float currentSequenceStartingPos = 0.0;   //Starting position of the sequence being currently played (in pulses per quarter note)
  float currentSequenceTimeElapsed = 0.0;   //How long the current sequence has been active. Necessary to use this variable, because the current position can jump at anytime (loop/restart)
  float previouslyCheckedTimestamp = 0.0;   
  boolean timestampToBeReinit      = false;
  boolean timestampChanged         = true;  //Set to true when the timestamp has changed since the last time we checked. If the time has not changed, it is not necessary to perform all the checks
  
  // Sum of all the signal samples in the buffer
  float globalIntensity_Kick    = 0;
  float globalIntensity_Snare   = 0;
  float globalIntensity_Cymbals = 0;
  float globalIntensity_Bass    = 0;
  float globalIntensity_Keys    = 0;
  float globalIntensity_Guitar  = 0;
  
  
  //Flags raised by user input, MIDI keyboard related animations
  boolean setStrobeAutoMode4th     = false;
  boolean setStrobeAutoMode8th     = false;
  boolean setStrobeAutoMode16th    = false;
  boolean setStrobeAutoMode32nd    = false;
  boolean setStrobeAutoMode64th    = false;
  boolean setKillLedPanel          = false;
  boolean setBlackOutAutomode      = false;
  int blackoutPower                = 0;
  boolean setWhiteOutAutomode      = false;
  int whiteoutPower                = 0;
  boolean setShredderAutoMode      = false; 
  int shredderPower                = 0;
  boolean setWhiteJamaMonoAutoMode = false;
  int whiteJamaMonoPower           = 0;
  boolean setColorChangeAutoMode   = false;
  int colorChangePower             = 0;
  
  boolean automaticModeIsInitialised = false;
  
  boolean animationShouldBeReinitialized = false;
  
  //Flags raised by the scenario functions : set depending on the audio/transport conditions
  boolean tempoIsVerySlow          = false;
  boolean onlyGuitarIsPlaying      = false;
  boolean firstBeat                = false;
  
  PlayMeSequencer() {
    chooseNewMidiSequence();
  }
  
  
  // Perform any action on the list, depending on the current system time regarding to the beat
  void performAutomaticActions() {
    
    //Check the current time
    checkCurrentTime();
    
    // If the timestamp is the same as during the previous analysis, don't try to do the work a second time
    if (timestampChanged) {
      // Check what's going on with the audio
      determineAudioModeVariables();
      
      printSystemDebugData();
      
      // Now do something with the variables which were computed right now
      // TODO
      // Placeholder code is used for now
      
      drawAnimation = 1;
      drawImage = 0;
      playCurrentMidiLoop();
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // Now that we've determined which animations should be played, play them
    
    specific_draw();
    
    if (setBlackOutAutomode == true) {
      draw_AutoModeBlackOut(blackoutPower);
    }
    
    if (setWhiteOutAutomode == true) {
      draw_AutoModeWhiteOut(whiteoutPower);
    }
    
    if (setColorChangeAutoMode == true) {
      draw_AutoModeColorChange();
    }
    if (setWhiteJamaMonoAutoMode == true) {
      draw_whiteJamaMono(this.whiteJamaMonoPower);
    }  
  }

  // Check the current MIDI loop : is an action to be executed ? If so, do it
  void playCurrentMidiLoop() {
    if (currentSequence.actionQueue.size() > 0) {
      //if (currentSequence.actionQueue.get(0).timestamp <= currentPosition % (currentSequence.lengthInBars*4)) {
      if (currentSequence.actionQueue.get(0).timestamp <= currentSequenceTimeElapsed) {
        playAction(currentSequence.actionQueue.get(0).eventType, currentSequence.actionQueue.get(0).actionType, currentSequence.actionQueue.get(0).actionVal);
        currentSequence.actionQueue.remove(0);
      }
    }
    else {
      
      //Don't try to reinitialize the sequence if it's empty anyways
      if (currentSequence.actionBank.size() != 0) {
         
        //If the sequence is over, loop it
        //if (currentPosition - currentSequenceStartingPos > currentSequence.lengthInBars * 4 ) {
        if (currentSequenceTimeElapsed >= currentSequence.lengthInBars * 4 ) {
          loopCurrentSequence();
          println("-------------------------------------");
          println("-------------------------------------");
          println("                LOOP !");
          println("-------------------------------------");
          println("-------------------------------------");
        }
      }
    }
  }
  
  void playAction(int eventType, int actionNumber, int actionValue) {
    println("Executing " + eventType + " : " + actionNumber + " -- " + actionValue);
    // The actions done here are similar to those done in MidiControl, though restrictions apply
    
    if (eventType == NOTE_ON) {
      switch (actionNumber) {
        case PITCH_GENERAL_STROBO_FRONT_LEFT:  startStrobe_FrontLeft(actionValue);break;
        case PITCH_GENERAL_STROBO_FRONT_RIGHT: startStrobe_FrontRight(actionValue);break;
        case PITCH_GENERAL_STROBO_BACK:        startStrobe_Back(actionValue);break;

        case PITCH_DMX_ANIMATION_BANK1:        loadDMXAnimation1(actionValue); break;
        case PITCH_DMX_ANIMATION_BANK2:        loadDMXAnimation2(actionValue); break;
        case PITCH_DMX_ANIMATION_BANK3:        loadDMXAnimation3(actionValue); break;
        
        case PITCH_CUSTOM_DEVICE_BANK1:        loadCustomDeviceAnimation1(actionValue);break;
        case PITCH_CUSTOM_DEVICE_BANK2:        loadCustomDeviceAnimation2(actionValue);break;
        case PITCH_CUSTOM_DEVICE_BANK3:        loadCustomDeviceAnimation3(actionValue);break;
        case PITCH_DISPLAY_EFFECT:             activateAdditionalEffect(actionValue);break;
        case PITCH_LOAD_ANIMATION_BANK1:       loadAnimation1(actionValue);break;
        case PITCH_LOAD_ANIMATION_BANK2:       loadAnimation2(actionValue);break;
        case PITCH_LOAD_ANIMATION_BANK3:       loadAnimation3(actionValue);break;
        case PITCH_LOAD_ANIMATION_BANK4:       loadAnimation4(actionValue);break;
        case PITCH_LOAD_IMAGE_BANK1:           loadImage1(actionValue);break;
        default: break;
      }
    }
    else if (eventType == NOTE_OFF) {
      switch (actionNumber) {
        case PITCH_GENERAL_STROBO_FRONT_LEFT:  stopStrobe_FrontLeft();break;
        case PITCH_GENERAL_STROBO_FRONT_RIGHT: stopStrobe_FrontRight();break;
        case PITCH_GENERAL_STROBO_BACK:        stopStrobe_Back();break;
        
        case PITCH_DMX_ANIMATION_BANK1:        unloadDMXAnimation(); break;
        case PITCH_DMX_ANIMATION_BANK2:        unloadDMXAnimation(); break;
        case PITCH_DMX_ANIMATION_BANK3:        unloadDMXAnimation(); break;
        case PITCH_DISPLAY_EFFECT:             deactivateAdditionalEffect(actionValue);break;
        default: break;
      }
    }
  }
  
  // Loop the current Midi clip
  void loopCurrentSequence() {
    //previousSequenceStartingPosition = ((int)(currentPosition*10)/10.0);
    currentSequenceStartingPos = currentPosition - currentPosition%4;
    
    //Reset currentSequenceTimeElapsed - not to 0, but to the current position normalized to a bar, for more precision
    currentSequenceTimeElapsed = currentPosition%4;
    
    
    currentSequence.initActions();

  }

  void chooseNewMidiSequence() {
    //JUST FOR DEBUG !!! This function will need to be based on the Audio AI, choosing sequences according to scenarios
    currentSequence = MidiSequences_DefaultIntensity.get((int)random(MidiSequences_DefaultIntensity.size()));
    currentSequence.initActions();
    currentSequenceStartingPos = currentPosition - currentPosition%4;    //Define the sequence's starting point as the current bar's start
    
    currentSequenceTimeElapsed = currentPosition%4;
  }
  
  // Check the current time : increment currentSequenceTimeElapsed each elapsed beat
  // Since there is no way to predict if the time won't go back in the past (loop/restart), only the beat subdivision is used to calculate the elapsed time
  // Enough time messages are sent for the system to have at least 4-5 messages per beat.
  // In DAWs such as Maschine or Ableton, the position may jump with no warning (particularly during scene changes), even if the position suddenly flies
  // 16 bars ahead, only to come back 2 beats later, the elapsed time must still be incremented properly
  void checkCurrentTime() {
    
    if (isPlaying == false) {
      currentSequenceTimeElapsed = 0;
      timestampToBeReinit        = true;
      timestampChanged           = false;
    }
    else {
      // Playback just started, so check where we are on the grid. The scene's starting point is set to the current bar's first beat
      if (timestampToBeReinit) {
        currentSequenceTimeElapsed = currentPosition%4.0;
      }
      
      if (currentPosition > previouslyCheckedTimestamp) {
        println("currentPosition > previouslyCheckedTimestamp --> " + currentSequenceTimeElapsed + " += " + ((currentPosition - previouslyCheckedTimestamp)%1.0));
        currentSequenceTimeElapsed += (currentPosition - previouslyCheckedTimestamp)%1.0;
        previouslyCheckedTimestamp = currentPosition;
        timestampChanged           = true;
      }
      else if (currentPosition < previouslyCheckedTimestamp) {
        println("currentPosition < previouslyCheckedTimestamp --> " + currentSequenceTimeElapsed + " += " + (1.0 - ((previouslyCheckedTimestamp - currentPosition)%1.0)));
        currentSequenceTimeElapsed += 1.0 - ((previouslyCheckedTimestamp - currentPosition)%1.0);
        previouslyCheckedTimestamp = currentPosition;
        timestampChanged           = true;
      }
      else {
        println("The time has not changed, nothing to do");
        //If currentPosition is equal to previouslyCheckedTimestamp, no need to go further in analyzing stuff
        timestampChanged           = false;
      }
    }
  }
  
  // Using the different scenarios, set the different variables which will be used to determine which animation is to play
  void determineAudioModeVariables() {
    computeSignalIntensity();
    
    isTheTempoVerySlow();
    isFirstBeat();
    isOnlyTheGuitarPlaying();
    determineIntensity();
  }
  
  // Scenario functions : the following functions check specific parts of the data transmitted the plugin, and set internal variables accordingly
  void isTheTempoVerySlow() {
    if (currentBPM <= 90.0) {
      tempoIsVerySlow = true;
    }
    else {
      tempoIsVerySlow = true;
    } 
  }
  
  void isFirstBeat() {
    if (int(currentPosition%4) == 0) {
      firstBeat = true;
    }
    else {
      firstBeat = false;
    }
  }
  
  void isOnlyTheGuitarPlaying() {
    float INTENSITY_THRESHOLD = 0.1; 
    if (audioInputBuffer_Guitar.get(0) > INTENSITY_THRESHOLD
        && audioInputBuffer_Kick.get(0) < INTENSITY_THRESHOLD 
        && audioInputBuffer_Snare.get(0) < INTENSITY_THRESHOLD
        && audioInputBuffer_Cymbals.get(0) < INTENSITY_THRESHOLD
        && audioInputBuffer_Bass.get(0) < INTENSITY_THRESHOLD
        && audioInputBuffer_Keys.get(0) < INTENSITY_THRESHOLD) 
    {
      onlyGuitarIsPlaying = true;
    }
    else {
      onlyGuitarIsPlaying = false;
    }
  }
  
  void computeSignalIntensity() {
    globalIntensity_Kick    = 0;
    globalIntensity_Snare   = 0;
    globalIntensity_Cymbals = 0;
    globalIntensity_Bass    = 0;
    globalIntensity_Keys    = 0;
    globalIntensity_Guitar  = 0;
    
    for (int i=1; i<AUDIO_BUFFER_SIZE; i++) {
      globalIntensity_Kick    += audioInputBuffer_Kick.get(i);
      globalIntensity_Snare   += audioInputBuffer_Snare.get(i);
      globalIntensity_Cymbals += audioInputBuffer_Cymbals.get(i);
      globalIntensity_Bass    += audioInputBuffer_Bass.get(i);
      globalIntensity_Keys    += audioInputBuffer_Keys.get(i);
      globalIntensity_Guitar  += audioInputBuffer_Guitar.get(i);
    }
  }
  
  void determineIntensity() {
    // Check all the instrument buffers, define the intensity according to the audio :
    
    // The value will be adjusted during testing
    float INTENSITY_THRESHOLD = 0.004 * AUDIO_BUFFER_SIZE;    //About equal to 0.16

    if (globalIntensity_Kick > 5*INTENSITY_THRESHOLD
        && globalIntensity_Snare > INTENSITY_THRESHOLD
        && globalIntensity_Cymbals > INTENSITY_THRESHOLD
        && globalIntensity_Bass > INTENSITY_THRESHOLD
        && globalIntensity_Keys > INTENSITY_THRESHOLD)
    {
      currentIntensity = INTENSITY_HARDCORE;
    }
    else if (globalIntensity_Kick > INTENSITY_THRESHOLD
       && globalIntensity_Snare > INTENSITY_THRESHOLD
       && globalIntensity_Cymbals > INTENSITY_THRESHOLD
       && globalIntensity_Bass > INTENSITY_THRESHOLD)
    {
      currentIntensity = INTENSITY_HIGH;
    }
    else if (globalIntensity_Kick > INTENSITY_THRESHOLD
       && globalIntensity_Snare > INTENSITY_THRESHOLD)
    {
      currentIntensity = INTENSITY_MEDIUM;
    }
    else {
      currentIntensity = INTENSITY_LOW;
    }
  }

  //Debug function used for tuning the system, print the most important informations in a clear, readable way
  void printSystemDebugData() {
    String debugString = "Automatic mode debug info : ";
    if (currentIntensity == INTENSITY_HARDCORE)     {debugString += "Intensity=Hardcore";}
    else if (currentIntensity == INTENSITY_HIGH)    {debugString += "Intensity=High";}
    else if (currentIntensity == INTENSITY_MEDIUM)  {debugString += "Intensity=Medium";}
    else if (currentIntensity == INTENSITY_LOW)     {debugString += "Intensity=Low";}
    else if (currentIntensity == INTENSITY_DEFAULT) {debugString += "Intensity=Default";}
    debugString += ", GuitarOnly="         + onlyGuitarIsPlaying;
    debugString += ", Intensity[Kick|Snare|Cymbal|Bass|Keys|Guitar]=[" + globalIntensity_Kick + "|" + globalIntensity_Snare + "|" + globalIntensity_Cymbals + "|" + globalIntensity_Bass + "|" + globalIntensity_Keys + "|" + globalIntensity_Guitar + "]";
    debugString += ", CurrentPosition=" + currentPosition;
    debugString += ", CurrentSequenceStartingPos=" + currentSequenceStartingPos;
    debugString += ", CurrentSequenceTimeElapsed=" + currentSequenceTimeElapsed;
    println(debugString);
    //outputLog.println(debugString);
  }
}


