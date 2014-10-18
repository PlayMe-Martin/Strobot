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
- TimeInfo : Transport informations, ie current position, BPM and whether playback is active. Only one instance should be set to send these messages, it's enough !
These messages are received by the different threads in AudioSignalProcessing, and the variables they set are to be consumed by this class

The AI should compute a general intensity using these different infos, and determine whether the atmosphere is set to be something 
laid back, or to something more intense. The animations which can be chosen are classified using Tags in the Attributes class
Some rules should be applied when choosing animations :
- If the animation is part of a set, play rhythmically and alternatively the animations part of the set
- Do not mix too fast different color sets, the objective is to create coherent graphics, not some kind of Winamp rainbow
- A color set change may occur on the following conditions : 
    - Enough time has passed in the same color set
    - A scene change could be detected inside the DAW 
      This can be detected through the current transport position : 
      in Maschine, there is an important and sudden change in the position - ie, at least 4 bars in the future, or 8 bars in the past (the scenes can loop !)
      in Ableton, the position goes back to 1:1:1 when a scene is triggered
      in other DAWs... other rules will have to be applied, but ideally these rules should apply to all DAWs (except for the ones with no transport, like MainStage)
- Rather than playing the same animation in a loop, some transitions will be inserted, and effects will be applied rhythmically
- Some additional effects will be possible using the classic MIDI inputs (for example, a set of pads/knobs triggering stutter effects will trigger the stroboscope)
- Depending on the computed intensity, trigger DMX devices (mainly strobes)
- The panel animations will have to be mixed with the LED tubes - so that means no opposing colors between the two
- Some patterns using all the devices will be generated, using simultaneously or alternatively (to create depth effects) the panels, the LED tubes and the strobes 
*/

//Time constants, used to determine evolution speed
final int NUMBER_OF_SCENES_UNTIL_COLOR_CHANGE = 16;
final int NUMBER_OF_SCENES_UNTIL_INTENSITY_INCREASE = 8;

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

//Presets to make strobo pattern creation easier
final int STROBO_OFF               = -1;
final int STROBO_SLOW_VERYWEAK     = 0;
final int STROBO_REGULAR_VERYWEAK  = 1;
final int STROBO_FAST_VERYWEAK     = 2;
final int STROBO_SLOW_WEAK         = 3;
final int STROBO_REGULAR_WEAK      = 4;
final int STROBO_FAST_WEAK         = 5;
final int STROBO_SLOW_LOWMEDIUM    = 6;
final int STROBO_REGULAR_LOWMEDIUM = 7;
final int STROBO_FAST_LOWMEDIUM    = 8;
final int STROBO_SLOW_MEDIUM       = 9;
final int STROBO_REGULAR_MEDIUM    = 10;
final int STROBO_FAST_MEDIUM       = 11;
final int STROBO_SLOW_HIMEDIUM     = 12;
final int STROBO_REGULAR_HIMEDIUM  = 13;
final int STROBO_FAST_HIMEDIUM     = 14;
final int STROBO_SLOW_STRONG       = 15;
final int STROBO_REGULAR_STRONG    = 16;
final int STROBO_FAST_STRONG       = 17;
final int FOUR_BEAT_PATTERN        = 4;
final int EIGHT_BEAT_PATTERN       = 8;

//Automatic mode flag : set to true or false by input MIDI notes
boolean AUTOMATIC_MODE = false;

//Anticipation time : the queued animations could be executed once their timestamp is older than the current system timestamp
//For better disponibility, include an anticipation time, kind of a barrier after which if the beat is still not received, setup shall be called
//If the delta between the scheduled animation and the current system time is inferior to 3 ms, execute the animation
//Init timestamp : initialize the upcoming animations in the distant future (five minutes from the current beat), their timestamp shall be set later
final long ANIMATION_ANTICIPATION_TIME_MARGIN = -6000000L;          //-6 ms
final long ANIMATION_RHYTHM_EXEC_TIME_MARGIN  = 0L;//10000000L;          //0 ms
final long VERY_LONG_TIME_INIT_TIMESTAMP      =  3000000000000L;    //50 minutes


class PlayMeSequencer {

  boolean isPlaying = false;      //State of the host, is equal to true if playback is set to true
  float currentBPM = 120.0;       //Current BPM of the host
  float currentPosition = 0.0;    //Current position, in pulses-per-quarter-note (ie, 1:1:1 -> 0.0,  1:2:4 -> 1.75, 2:1:1 -> 4.0)

    
  //Initialize the parameters which will allow the AI to determine which animations to choose
  int currentColorSet              = COLORSET_BLACK;
  int currentIntensity             = INTENSITY_MEDIUM;
  
  //Count the passing scenes to make the light show evolve after some time
  int colorsetCounter              = 0;
  int lowIntensityCounter          = 0;
  int mediumIntensityCounter       = 0;
  int highIntensityCounter         = 0;
  
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


  //Some user input-driven animations will make the display change too much to be reusable : this flag alerts the sequencer that the animation needs to be reinitialized
  boolean animationShouldBeReinitialized = false;
  boolean backToExecutionMainAnimation   = true;
  boolean newMainAnimationWasJustChosen  = false;

  //Main animation currently played and its length, in easily accessable variables (this animation is integrated in a 16, or 32 beat cycle)
  int mainAnimationNbr                   = 0;
  float mainAnimationLength              = 0;
  boolean mainAnimationIsRhythmic        = false;
  boolean mainAnimationRhythmReinitFlag  = true;
  int mainAnimationStartBar              = 0;
  float mainAnimationStartBeat           = 0;
  Long mainAnimationRhythmNextTimestamp  = 0L;
  Long mainAnimationRhythmPrevTimestamp  = 0L;
  float mainAnimationRhythmLength        = 0;      //In case of a rhythmic main animation, contains the indicative animation length
  
  boolean transitionBeingPlayed          = false;
  boolean transitionInit                 = false;
  int transitionAnimationNbr             = 0;
  int transitionAnimationStartBar        = 0;
  float transitionAnimationStartBeat     = 0;
  int transitionAnimationEndBar          = 0;
  float transitionAnimationEndBeat       = 0;
  int transitionAnimationStartBeatCount  = 0;
  int transitionAnimationEndBeatCount    = 0;
  int framesSinceReinit                  = 3;      //Start with the possibility to initialize
  int nbrCallsForThisTransition          = 0;
  
  int currentSetListID                   = 1;      //ListID of the latest animation coming from a set

  //Determine the current position in the musical grid
  int sceneCounter;                                //How many scenes have passed until now
  int beatCounter;                                 //How many beats have passed since the last main animation was decided
  int subBeatCounter;                              //How many beats have passed since the last reinit of a rhythmic animation (only used for animations longer than 2 beats)
  int currentBeat;                                 //Current beat : 1, 2, 3, 4...
  int currentBar;                                  //Maschine's current scene's bar
  int currentTimeSignature;                        //Time signature. Default is 4 (4/4 time signature), more complex time signatures shall be implemented later
  int numberOfTempoEvaluationSteps = 3;            //Compromise between latency and precision 
  ArrayList<Long> previousBeatsTimestamps;
  boolean beatCounterToBeReinitialized = false;    //Flag to reset beatcounter - beatcounter should only be reset upon resetting a new scene first beat message
  boolean transitionBeingPlayedToBeReset = false;  //Flag to reset beatCounterToBeInitialized
  
  boolean automaticModeIsInitialised = false;
  
  PlayMeSequencer() {

  }
  
  
  //Determine which actions to take, depending on the current system time regarding to the beat
  void performAutomaticActions() {

    drawAnimation = 1;
    drawImage = 0;
    determineAutomaticAnimations();
        
    //Reinitialize the rhythm init flag after some time
    if (framesSinceReinit > 2) {
      framesSinceReinit += 1;
      mainAnimationRhythmReinitFlag = true;
    }
    else {
      framesSinceReinit += 1;
    }
     
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
    // TBIL
  }
  
  //Choose a random set among the AnimationFilteredList - return the listID from this particular list
  //Must be updated if more sets are created !!!
  int chooseRandomListFromSets() {
    int randomListID = floor(random(FILTEREDLIST_ID_SET_1, FILTEREDLIST_ID_MAX));
    currentSetListID = randomListID; 
    return randomListID;
  }
  

  
  //Return an animation number and an animation length
  Float[] chooseRandomTransitionFromList(int listID) {
    AnimationFilteredList filteredAnimations = getFilteredList(listID);
    
    //Get a random animation inside the long animations corresponding to this filter
    int index = floor(random(filteredAnimations.transitionAnimations.size()));
    int transitionNumber = filteredAnimations.transitionAnimations.get(index).animationNbr;
    float transitionAnimationLength = filteredAnimations.transitionAnimations.get(index).animationLength;
    Float[] temp = new Float[2];
    temp[0] = (float) transitionNumber;    //Because this way is more practical, use a float here
    temp[1] = transitionAnimationLength;
    return temp;
  }

  
}



  

  
//  void playStroboAction(int preset) {      //Will have to be checked, depends on the assumption that the strobe's DMX channels are speed/brightness
//    switch (preset) {       //This function may be made bigger, depending on the needs regarding the precision of the stroboscope's controls in Auto Mode
//      case STROBO_OFF:               myDMX.stopStrobe_FrontLeft(); break;
//      case STROBO_SLOW_VERYWEAK:     myDMX.setStrobePreset_FrontLeft(23); break;
//      case STROBO_REGULAR_VERYWEAK:  myDMX.setStrobePreset_FrontLeft(63); break;
//      case STROBO_FAST_VERYWEAK:     myDMX.setStrobePreset_FrontLeft(93); break;
//      case STROBO_SLOW_WEAK:         myDMX.setStrobePreset_FrontLeft(24); break;
//      case STROBO_REGULAR_WEAK:      myDMX.setStrobePreset_FrontLeft(64); break;
//      case STROBO_FAST_WEAK:         myDMX.setStrobePreset_FrontLeft(94); break;
//      case STROBO_SLOW_LOWMEDIUM:    myDMX.setStrobePreset_FrontLeft(26); break;
//      case STROBO_REGULAR_LOWMEDIUM: myDMX.setStrobePreset_FrontLeft(66); break;
//      case STROBO_FAST_LOWMEDIUM:    myDMX.setStrobePreset_FrontLeft(95); break;
//      case STROBO_SLOW_MEDIUM:       myDMX.setStrobePreset_FrontLeft(28); break;
//      case STROBO_REGULAR_MEDIUM:    myDMX.setStrobePreset_FrontLeft(68); break;
//      case STROBO_FAST_MEDIUM:       myDMX.setStrobePreset_FrontLeft(97); break;
//      case STROBO_SLOW_HIMEDIUM:     myDMX.setStrobePreset_FrontLeft(29); break;
//      case STROBO_REGULAR_HIMEDIUM:  myDMX.setStrobePreset_FrontLeft(69); break;
//      case STROBO_FAST_HIMEDIUM:     myDMX.setStrobePreset_FrontLeft(98); break;
//      case STROBO_SLOW_STRONG:       myDMX.setStrobePreset_FrontLeft(30); break;
//      case STROBO_REGULAR_STRONG:    myDMX.setStrobePreset_FrontLeft(70); break;
//      case STROBO_FAST_STRONG:       myDMX.setStrobePreset_FrontLeft(99); break;
//
//      default: break;
//    }
//    
//  }
//  
//  void stopStroboAction() {
//    myDMX.stopStrobe_FrontLeft();
//    myDMX.stopStrobe_FrontRight();
//  }
