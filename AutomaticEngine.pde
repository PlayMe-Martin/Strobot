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
- FFT : instant 8-band Fast Fourier Transform of the signal. Fairly expensive CPU-wise, so only switch it on for the instances which really need it (Bass for example) 
- TimeInfo : Transport informations, ie current position, BPM and whether playback is active. Only one instance should be set to send these messages, it's enough !
These messages are received by the different threads in AudioSignalProcessing, and the variables they set are to be consumed by this class

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
The scenarios may include use cases such as : 

*/


//Color sets : declare them as finals for better code readability
final int COLORSET_BLACK     = 0;
final int COLORSET_RED       = 1;
final int COLORSET_BLUE      = 2;
final int COLORSET_COLORFUL  = 3;

//Intensity levels
final int INTENSITY_LOW      = 0;
final int INTENSITY_MEDIUM   = 1;
final int INTENSITY_HIGH     = 2;
final int INTENSITY_HARDCORE = 3;


//Automatic mode flag : set to true or false by input MIDI notes
boolean AUTOMATIC_MODE = false;


class PlayMeSequencer {

  boolean isPlaying = false;                //State of the host, is equal to true if playback is set to true
  float currentBPM = 120.0;                 //Current BPM of the host
  float currentPosition = 0.0;              //Current position, in pulses-per-quarter-note (ie, 1:1:1 -> 0.0,  1:2:4 -> 1.75, 2:1:1 -> 4.0)

  MidiSequence currentSequence;             //Sequence being currently played by the sequencer
  float currentSequenceStartingPos = 0.0;   //Starting position of the sequence being currently played (in pulses per quarter note)
  
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
  
  
  PlayMeSequencer() {
    chooseNewMidiSequence();
  }
  
  
  //Determine which actions to take, depending on the current system time regarding to the beat
  void performAutomaticActions() {

    drawAnimation = 1;
    drawImage = 0;
    determineAutomaticAnimations();
    
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

  void determineAutomaticAnimations() {
    if (currentSequence.actionQueue.size() > 0) {
      if (currentSequence.actionQueue.get(0).timestamp <= currentPosition % (currentSequence.lengthInBars*4)) {
        playAction(currentSequence.actionQueue.get(0).eventType, currentSequence.actionQueue.get(0).actionType, currentSequence.actionQueue.get(0).actionVal);
        currentSequence.actionQueue.remove(0);
      }
    }
    else {
      
      //Don't try to reinitialize the sequence if it's empty anyways
      if (currentSequence.actionBank.size() != 0) {
         
        //If the sequence is over, loop it
        if (currentPosition - currentSequenceStartingPos > currentSequence.lengthInBars * 4 ) {
          loopCurrentSequence();
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
  
  void loopCurrentSequence() {
    //previousSequenceStartingPosition = ((int)(currentPosition*10)/10.0);
    currentSequenceStartingPos = currentPosition - currentPosition%4;
    currentSequence.initActions();

    
  }

  void chooseNewMidiSequence() {
    //JUST FOR DEBUG !!! This function will need to be based on the Audio AI, choosing sequences according to scenarios
    currentSequence = MidiSequences_DefaultIntensity.get((int)random(MidiSequences_DefaultIntensity.size()));
    currentSequence.initActions();
    currentSequenceStartingPos = currentPosition - currentPosition%4;    //Define the sequence's starting point as the current bar's start
  }
  
}


