//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Automatic light selector, A.I. responding to input MIDI messages and selecting appropriately the correct animations  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
Concept behind the AI:
The automations shall use Maschine's scenes : in addition to the drum (or bass) pattern the scene has, an additional lights MIDI pattern 
will be registered for all the impro scenes. This pattern will not contain specific animation information, like the long patterns used for 
full songs, but more general commands, ie "I'd like something violent and red", "This is the current tempo", "Shift to a smooth blue ambience"

The AI knows which animations fulfill these requirements, through the use of the registered attributes (which might have to be completed,
depending on the needs of the AI. 

The AI is made of a PlayMeSequencer object, which is instanciated during application init. 

/// User Manual ///
Create a pattern in Maschine, and route its output to external MIDI. 
If used inside Ableton, create a MIDI track getting MIDI data from Maschine's output, and configure this MIDI track's output to be the IAC driver (MIDI virtual bus)
The easiest way to proceed is to create a group reserved to lights (or rather, the best would be two groups : one for manually programmed MIDI tracks, and one for automatic)
The automatic could be layered the following way :
All MIDI messages output on channel 2 (no interference with keyboard input)
Each pad should have its base note set to a different root note (starting from bottom left, E0, F0, F#0, etc.), so that manual edition of these patterns from within Maschine could still be possible
Each pattern MUST have at its beginning the following messages :
- Automatic mode active
- Tempo Sync 1st beat / Scene start (and the regular beat messages on all subsequent beats)
- Intensity (to be chosen among four levels, low, medium, high and hardcore, hardcore being similar to medium but with increased stroboscope)
- Color (Red, Blue, Colorful, Free)


In this mode, the following messages can be treated :
Pad 1 - Shift mode : shift to automatic mode (give general instructions to pilot the screen), or manual mode (execute only the actions input through the MIDI files)
Pad 2 - Tempo sync : first beat + start of the pattern
  Different velocities may indicate different functions :
    ex : E0 - velocity > 100       : , scene intensity = velocity - 100 
         E0 - velocity in [2,30] : first beat
         E0 - velocity in [1]   : second, third or fourth beat
- Device input : the external keyboard and pads must also be allowed to send commands
    ex : lowpass filter -> kill the brightness
         hipass filter -> screen whiteout
         stutter pads -> tempo sync stroboscope
         loop repeater fader -> shiftpixels, or shredpixels, depending on the velocity
         etc.
- Scene init : first beat of the scene, allows to sync important effects. Also necessary to make internal parameters evolve (color for instance)
- Scene character : does this scene correspond to an agressive beat ? Or is it a laid back groove ?
- Scene complexity : should the chosen animations be complex and evolving ? Or should it be an simple flasher (ex : only kick drum on all the beats) ?
        This parameter should also be allowed to evolve in accordance to the other internal parameters

The AI should also have the intelligence to detect and adopt this kind of behaviour :
- when the lowpass filter is on (in particular if it's for a long time), the chosen animations should be relatively calm or slow
- when the lowpass filter or the hipass filter goes off, the general atmosphere should step up in intensity

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

  
  //Arraylist of ints/timestamps containing the future animations to be played
  //This list works like a cue, the sequencer checks the current timestamp, and if an animation is scheduled to be played, the FutureAction object
  //is removed from the list, and the actionNbr attribute becomes the current animationnumber 
  FutureActionsList animationsQueue;
  DMXFutureActionsList stroboQueue;
  
  //Initialize the parameters which will allow the AI to determine which animations to choose
  int currentColorSet              = COLORSET_BLACK;
  int currentIntensity             = INTENSITY_MEDIUM;
  
  //Count the passing scenes to make the light show evolve after some time
  int colorsetCounter              = 0;
  int lowIntensityCounter          = 0;
  int mediumIntensityCounter       = 0;
  int highIntensityCounter         = 0;

  //Flags raised when new instructions are received
  boolean newBeatInformation       = false;
  boolean newColorInformation      = false;
  boolean newIntensityInformation  = false;
  
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
  float currentTempo;
  Long beatLengthNanoSec;                          //Beat length in nanoseconds (useful to preserve resources)
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
  
  Long currentBeatTimestamp;                       //Timestamp from the last processed beat message
  
  boolean automaticModeIsInitialised = false;
  
  PlayMeSequencer() {
    
    animationsQueue = new FutureActionsList();
    stroboQueue = new DMXFutureActionsList();
    
    previousBeatsTimestamps = new ArrayList<Long>();
    currentTempo = 120;
    currentTimeSignature = 4;
    currentBeat = 1;
    currentBar = 1;
    sceneCounter = 0;
    beatCounter = 0;
    subBeatCounter = 0;
    beatLengthNanoSec = convertSecToNanosec(60.0 / ((float)currentTempo));
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
     
    if (setShredderAutoMode == true) {
      draw_AutoModeShredder(shredderPower);
    }
    else if (setStrobeAutoMode64th == true) {
      draw_stroboAutoPad(currentColorSet, currentTempo, 8);
    }
    else if (setStrobeAutoMode32nd == true) {
      draw_stroboAutoPad(currentColorSet, currentTempo, 8);
    }
    else if (setStrobeAutoMode16th == true) {
      draw_stroboAutoPad(currentColorSet, currentTempo, 4);        
    }
    else if (setStrobeAutoMode8th == true) {
      draw_stroboAutoPad(currentColorSet, currentTempo, 2);
    }
    else if (setStrobeAutoMode4th == true) {
      draw_stroboAutoPad(currentColorSet, currentTempo, 1);
    }
    else {
      specific_draw();
    }
    
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
        

     
        
    //Execute DMX-related actions : stroboscope
    //If an action is set to be executed, send the corresponding DMX message, else prepare for the future actions
    stroboQueue.play();

  }
  
  //Check the local system time, and if an animation is scheduled to be played, execute it
  void determineAutomaticAnimations() {
    long currentSystemTime = System.nanoTime();
        
    //Check if the main animation update is overdue
    if (beatCounter >= mainAnimationLength) { 
      updateFutureActionsPlanning();
    }
    
    //If no animation is scheduled, no need to do the check (ex : current animation is long and evolving, it is not necessary to disturb it)
    if (animationsQueue.futureActions.size() > 0) {      
      if (beatCounter >= animationsQueue.futureActions.get(0).executionBeatCounter) {
                
        FutureAction imminentAction = animationsQueue.popClosestAction();
        
        transitionBeingPlayed        = true;
        transitionInit               = true;
        transitionAnimationNbr       = imminentAction.animationnumber;
        transitionAnimationStartBar  = imminentAction.measure;
        transitionAnimationStartBeat = imminentAction.beat;
        transitionAnimationEndBar    = imminentAction.measureEnd;
        transitionAnimationEndBeat   = imminentAction.beatEnd;
                
        //Determine the end's timestamp. Easy to do using the current timestamp ("now" is the new beat !)
        //transitionAnimationEndBeatCount = (int) (animationsQueue.futureActions.get(0).executionBeatCounter + animationsQueue.futureActions.get(0).animationLength);
        transitionAnimationEndBeatCount = (int) (imminentAction.executionBeatCounter + imminentAction.animationLength);
                
        outputLog.println("Automatic mode : setting animation number " + animationnumber + ". Scheduled system time for this animation (nanoseconds) was " + imminentAction.executionTimestamp + 
                          " (bar|beat : " + imminentAction.measure + "|" + imminentAction.beat + ", current timestamp is " + currentSystemTime);
        
        animationShouldBeReinitialized = true;
      }
    
    }
    else {
      //Nothing to do ! No transition, either mainAnimation or the current transition shall be played
    }
    
    if (beatCounter > transitionAnimationEndBeatCount) {              //Enough precision, no need to work with timestamps
        transitionBeingPlayedToBeReset = true;                        //Synchronization occurs on first beats only !
    }

    if (transitionBeingPlayed == true) {
      animationnumber = transitionAnimationNbr;
      if (transitionInit == true) {
        transitionInit = false;
        animationShouldBeReinitialized = true;
      }
    }
    else {
        if (animationnumber != mainAnimationNbr) {
          backToExecutionMainAnimation = true;
        }
        animationnumber = mainAnimationNbr;
      
    }
        
    //If the animation is rhythmic, periodically execute the animation's setup function 
    //Do not choose another animation if another main animation was just chosen by ChooseRandomMainAnimation
    if (newMainAnimationWasJustChosen == false) {
      //Do not change animation if the application is still initializing itself :
      if (mainAnimationRhythmNextTimestamp == 0L) {
        mainAnimationRhythmNextTimestamp = currentSystemTime + (long)(beatLengthNanoSec*mainAnimationRhythmLength);
      }
      
      if (mainAnimationIsRhythmic == true) {
        
        if (mainAnimationRhythmLength < 1.0) {    //Animations below 1.0 must be reinitialized according to time, no need to do this for longer onces
          if (currentSystemTime > mainAnimationRhythmNextTimestamp) {
            mainAnimationRhythmPrevTimestamp = mainAnimationRhythmNextTimestamp; 
            mainAnimationRhythmNextTimestamp = currentSystemTime + (long)(beatLengthNanoSec*mainAnimationRhythmLength);
            mainAnimationStartBar  = currentBar;
            mainAnimationStartBeat = currentBeat;
            if (currentSetListID >= FILTEREDLIST_ID_SET_1) {    //If the animation is part of a set, choose the next one in the list
              chooseAnotherMainAnimationFromList(currentSetListID);
            }
            animationShouldBeReinitialized = true;
          }      
        }        
      }  
    }
        
    if (newMainAnimationWasJustChosen == true) {
      newMainAnimationWasJustChosen = false;
    }    
    
    //Reinitialize the animation if one of the flag was raised - but do not reinitialize if a transition is in the midst of being played
    if ((backToExecutionMainAnimation == true || animationShouldBeReinitialized == true) && transitionBeingPlayed == false) {
        nbrCallsForThisTransition = 0;    //Reinitialize the counter for the transitions
        backToExecutionMainAnimation = false;
        animationShouldBeReinitialized = false;
        if (true) {
          mainAnimationRhythmReinitFlag = false;
          setupcomplete = false;
          outputLog.println("Automatic mode : reinitializing animation");
          specificActions();
          framesSinceReinit = 0;
          subBeatCounter = 0;
        }
        mainAnimationRhythmReinitFlag = false;
    }
    else if (transitionBeingPlayed == true && animationShouldBeReinitialized == true) {    //Define the behaviour regarding reinit if an animation is being played 
      backToExecutionMainAnimation = false;
      animationShouldBeReinitialized = false;
      //if (true) {
      if (nbrCallsForThisTransition == 0) {
        nbrCallsForThisTransition += 1;
        mainAnimationRhythmReinitFlag = false;
        setupcomplete = false;
        /*outputLog.*/println("Automatic mode : reinitializing animation");
        specificActions();
        framesSinceReinit = 0;
      }
      mainAnimationRhythmReinitFlag = false;

    }            
  }
  
  //Determine the animations to be played and add them in the queue (FutureActionsList animationsQueue)
  void updateFutureActionsPlanning() {
    //Reinitialize the information flags
    newBeatInformation = false;
    newColorInformation = false;
    newIntensityInformation = false;
    
    //Reinitialize the future actions planning - new info, wouldn't want some old animations to be thrown in
    animationsQueue.reinitializeFutureActionsList();
    
    //Update mainAnimation only if the indicative animation length is over
    if (beatCounter >= mainAnimationLength) { 
      //beatCounterToBeReinitialized = true;
      beatCounter = 0;        //Reinitialize beatCounter    
    
      if (currentIntensity == INTENSITY_LOW) {
        if (currentColorSet == COLORSET_BLACK) {
          currentSetListID = FILTEREDLIST_ID_BLACK_ATMOSPHERIC;
          chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLACK_ATMOSPHERIC);
        }
  
        else if (currentColorSet == COLORSET_RED) {
          currentSetListID = FILTEREDLIST_ID_RED_ATMOSPHERIC;
          chooseRandomMainAnimationFromList(FILTEREDLIST_ID_RED_ATMOSPHERIC);
        }
  
        else if (currentColorSet == COLORSET_BLUE) {
          currentSetListID = FILTEREDLIST_ID_BLUE_ATMOSPHERIC;
          chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLUE_ATMOSPHERIC);
        }
  
        else if (currentColorSet == COLORSET_COLORFUL) {
          currentSetListID = FILTEREDLIST_ID_COLORFUL_ATMOSPHERIC;
          chooseRandomMainAnimationFromList(FILTEREDLIST_ID_COLORFUL_ATMOSPHERIC);
        }        
        
        //Don't put any stroboscope
        stroboQueue.currentStrobePattern = strobeOff.get(0);
        stroboQueue.currentStep = 0;    //Reinitialize the pattern step
        //The environment has changed, execute the actions which are currently coherent with the context
        stroboQueue.beatActions();
      }
      
      else if (currentIntensity == INTENSITY_MEDIUM) {
        //Choose a random filteredList among the sets
        
        if (currentColorSet == COLORSET_BLACK) {
          if (random(1) > 0.5) {
            currentSetListID = FILTEREDLIST_ID_BLACK_GEOMETRIC;
            chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLACK_GEOMETRIC);
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }
        
        else if (currentColorSet == COLORSET_RED) {
          if (random(1) > 0.5) {
            currentSetListID = FILTEREDLIST_ID_RED_GEOMETRIC;
            chooseRandomMainAnimationFromList(FILTEREDLIST_ID_RED_GEOMETRIC);
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }

        else if (currentColorSet == COLORSET_BLUE) {
          if (random(1) > 0.5) {
            if (random(1) > 0.5) {    //Not as many blue geometric animations, so give a chance to take B&W ones
              currentSetListID = FILTEREDLIST_ID_BLUE_GEOMETRIC;
              chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLUE_GEOMETRIC);
            }
            else {
              chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLACK_GEOMETRIC);
            }
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }

        else if (currentColorSet == COLORSET_COLORFUL) {
          if (random(1) > 0.5) {
            if (random(1) > 0.5) {    //Not as many colorful geometric animations, so give a chance to take B&W ones
              currentSetListID = FILTEREDLIST_ID_COLORFUL_GEOMETRIC;
              chooseRandomMainAnimationFromList(FILTEREDLIST_ID_COLORFUL_GEOMETRIC);
            }
            else {
              currentSetListID = FILTEREDLIST_ID_BLACK_GEOMETRIC;
              chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLACK_GEOMETRIC);
            }
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }

        //Don't put any stroboscope
        stroboQueue.currentStrobePattern = strobeOff.get(0);
        stroboQueue.currentStep = 0;    //Reinitialize the pattern step
        //The environment has changed, execute the actions which are currently coherent with the context
        stroboQueue.beatActions();

      }
      
      else if (currentIntensity == INTENSITY_HIGH) {
        
        if (currentColorSet == COLORSET_BLACK) {
          if (random(1) > 0.5) {
            currentSetListID = FILTEREDLIST_ID_BLACK_VIOLENT;
            chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLACK_VIOLENT);
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }
        
        else if (currentColorSet == COLORSET_RED) {
          if (random(1) > 0.5) {
            currentSetListID = FILTEREDLIST_ID_RED_VIOLENT;
            chooseRandomMainAnimationFromList(FILTEREDLIST_ID_RED_VIOLENT);
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }

        else if (currentColorSet == COLORSET_BLUE) {
          if (random(1) > 0.5) {
            if (random(1) > 0.5) {    //Not as many blue violent animations, so give a chance to take B&W ones
              currentSetListID = FILTEREDLIST_ID_BLUE_VIOLENT;
              chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLUE_VIOLENT);
            }
            else {
              currentSetListID = FILTEREDLIST_ID_BLACK_VIOLENT;
              chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLACK_VIOLENT);
            }
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }

        else if (currentColorSet == COLORSET_COLORFUL) {
          if (random(1) > 0.5) {  //No colorful violent animation, so choose among the B&W ones
            currentSetListID = FILTEREDLIST_ID_BLACK_VIOLENT;
            chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLACK_VIOLENT);
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }
        
        //Start putting a little stroboscope, choose among the medium intensity patterns
        stroboQueue.currentStrobePattern = weakStroboscopePatterns.get(floor(random(weakStroboscopePatterns.size())));
        stroboQueue.currentStep = 0;    //Reinitialize the pattern step
        
        //The environment has changed, execute the actions which are currently coherent with the context
        stroboQueue.beatActions();
      }
      
      else if (currentIntensity == INTENSITY_HARDCORE) {
        
        if (currentColorSet == COLORSET_BLACK) {
          if (random(1) > 0.5) {
            currentSetListID = FILTEREDLIST_ID_BLACK_VIOLENT;
            chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLACK_VIOLENT);
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }
        
        else if (currentColorSet == COLORSET_RED) {
          if (random(1) > 0.5) {
            currentSetListID = FILTEREDLIST_ID_RED_VIOLENT;
            chooseRandomMainAnimationFromList(FILTEREDLIST_ID_RED_VIOLENT);
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }

        else if (currentColorSet == COLORSET_BLUE) {
          if (random(1) > 0.5) {
            if (random(1) > 0.5) {    //Not as many blue violent animations, so give a chance to take B&W ones
              currentSetListID = FILTEREDLIST_ID_BLUE_VIOLENT;
              chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLUE_VIOLENT);
            }
            else {
              currentSetListID = FILTEREDLIST_ID_BLACK_VIOLENT;
              chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLACK_VIOLENT);
            }
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }

        else if (currentColorSet == COLORSET_COLORFUL) {
          if (random(1) > 0.5) {  //No colorful violent animation, so choose among the B&W ones
            currentSetListID = FILTEREDLIST_ID_BLACK_VIOLENT;
            chooseRandomMainAnimationFromList(FILTEREDLIST_ID_BLACK_VIOLENT);
          }
          else {
            chooseRandomMainAnimationFromList(chooseRandomListFromSets()); 
          }
        }

        //Put a lot of stroboscope, choose among the high intensity patterns
        stroboQueue.currentStrobePattern = strongStroboscopePatterns.get(floor(random(strongStroboscopePatterns.size())));
        stroboQueue.currentStep = 0;    //Reinitialize the pattern step
        //The environment has changed, execute the actions which are currently coherent with the context
        stroboQueue.beatActions();
      }
    }
    
    
    //Now insert transitions in the mix !
    if (currentIntensity == INTENSITY_LOW) {
      if (currentColorSet == COLORSET_RED) {
        addTransitionToAnimationQueue(8, FILTEREDLIST_ID_RED_FADEIN);
      }
      if (currentColorSet == COLORSET_BLACK) {
        addTransitionToAnimationQueue(8, FILTEREDLIST_ID_BLACK_FADEIN);
      }
      if (currentColorSet == COLORSET_BLUE) {
        addTransitionToAnimationQueue(8, FILTEREDLIST_ID_BLUE_FADEIN);
      }
      if (currentColorSet == COLORSET_COLORFUL) {
        addTransitionToAnimationQueue(8, FILTEREDLIST_ID_BLACK_FADEIN);
      }

    }
    else if (currentIntensity == INTENSITY_MEDIUM || currentIntensity == INTENSITY_HIGH || currentIntensity == INTENSITY_HARDCORE) {
      if (currentColorSet == COLORSET_RED) {
        //addTransitionToAnimationQueue(4, FILTEREDLIST_ID_RED_FADEIN);
        addTransitionToAnimationQueue(8, FILTEREDLIST_ID_RED_FADEIN);
      }
      if (currentColorSet == COLORSET_BLACK) {
        //addTransitionToAnimationQueue(4, FILTEREDLIST_ID_BLACK_FADEIN);
        addTransitionToAnimationQueue(8, FILTEREDLIST_ID_BLACK_FADEIN);
      }
      if (currentColorSet == COLORSET_BLUE) {
        //addTransitionToAnimationQueue(4, FILTEREDLIST_ID_BLUE_FADEIN);
        addTransitionToAnimationQueue(8, FILTEREDLIST_ID_BLUE_FADEIN);
      }
      if (currentColorSet == COLORSET_COLORFUL) {
        //addTransitionToAnimationQueue(4, FILTEREDLIST_ID_BLACK_FADEIN);
        addTransitionToAnimationQueue(8, FILTEREDLIST_ID_BLACK_FADEIN);
      }
      
    }
    
  }
  
  //Choose a random set among the AnimationFilteredList - return the listID from this particular list
  //Must be updated if more sets are created !!!
  int chooseRandomListFromSets() {
    int randomListID = floor(random(FILTEREDLIST_ID_SET_1, FILTEREDLIST_ID_MAX));
    currentSetListID = randomListID; 
    return randomListID;
  }
  
  void chooseAnotherMainAnimationFromList(int listID) {
    int index = -1;
    AnimationFilteredList filteredAnimations = getFilteredList(listID);
    
    if (filteredAnimations.mainAnimations.size() != 0) {          //Main animations registered for this list
      
      //index = floor(random(filteredAnimations.transitionAnimations.size()));    //Randomizer : not the most visually pleasant solution, but still a possibility
      
      //To get the next index, increment the previous index
      for (int i = 0; i < filteredAnimations.mainAnimations.size(); i++) {
        Attribute anim = filteredAnimations.mainAnimations.get(i);
        if (anim.animationNbr == mainAnimationNbr) {
          index = i;
          break;
        }
      }
      if (index == -1) {    //Couldn't find any corresponding animation, take a random one
        index = floor(random(filteredAnimations.mainAnimations.size()));
      }
      else {
        index = (index + 1) % filteredAnimations.mainAnimations.size();
      }

      mainAnimationNbr = filteredAnimations.mainAnimations.get(index).animationNbr;
    
      newMainAnimationWasJustChosen = true;
      
      //Determine if the chosen animation is rhythmic
      if (filteredAnimations.mainAnimations.get(index).attributes.contains("Rhythmic") == true) {
        mainAnimationIsRhythmic = true;
        mainAnimationRhythmLength = filteredAnimations.mainAnimations.get(index).animationLength;
        //In case of 16th notes fast rhythmic animations, make the animation 16 beat long
        mainAnimationLength = min(64 * mainAnimationRhythmLength, 32); 
      }
      else {
        mainAnimationIsRhythmic = false;
      }
    }
    else {     //Special case : no main animation, only animations registered as transitions
      
      //index = floor(random(filteredAnimations.transitionAnimations.size()));      //Randomizer : not the most visually pleasant solution, but still a possibility, keep it as a comment
      
      //To get the next index, increment the previous index
      for (int i = 0; i < filteredAnimations.transitionAnimations.size(); i++) {
        Attribute anim = filteredAnimations.transitionAnimations.get(i);
        if (anim.animationNbr == mainAnimationNbr) {
          index = i;
          break;
        }
      }
      index = (index + 1) % filteredAnimations.transitionAnimations.size();

      /*    //Randomizer
      possibleAnimationNumber = filteredAnimations.transitionAnimations.get(index).animationNbr;
      
      if (mainAnimationListSize != 1) {    //Special case with only one animation in this list to be excluded
        while (possibleAnimationNumber == mainAnimationNbr) {    //If the candidate is the same as the current animation number, change !
          index = floor(random(filteredAnimations.transitionAnimations.size()));
          possibleAnimationNumber = filteredAnimations.transitionAnimations.get(index).animationNbr;
        }      
      }
      mainAnimationNbr = possibleAnimationNumber;      
      */
      
      
      mainAnimationNbr = filteredAnimations.transitionAnimations.get(index).animationNbr;
     
      newMainAnimationWasJustChosen = true;
      
      //Determine if the chosen animation is rhythmic
      if (filteredAnimations.transitionAnimations.get(index).attributes.contains("Rhythmic") == true) {
        mainAnimationIsRhythmic = true;
        mainAnimationRhythmLength = filteredAnimations.transitionAnimations.get(index).animationLength;
        //In case of 16th notes fast rhythmic animations, make the animation 8 beat long
        mainAnimationLength = min(32 * mainAnimationRhythmLength, 16); 
      }
      else {
        mainAnimationIsRhythmic = false;
      }
    }
    
    //Enable reinit
    animationShouldBeReinitialized = true;
  }
  
  void chooseRandomMainAnimationFromList(int listID) {
    AnimationFilteredList filteredAnimations = getFilteredList(listID);
    int index = 0;

    if (filteredAnimations.mainAnimations.size() != 0) {          //Main animations registered for this list
      
      //Get a random animation inside the long animations corresponding to this filter
      index = floor(random(filteredAnimations.mainAnimations.size()));
      mainAnimationNbr = filteredAnimations.mainAnimations.get(index).animationNbr;
      
      newMainAnimationWasJustChosen = true;
      
      mainAnimationLength = filteredAnimations.mainAnimations.get(index).animationLength;

      //Determine if the chosen animation is rhythmic
      if (filteredAnimations.mainAnimations.get(index).attributes.contains("Rhythmic") == true) {
        mainAnimationIsRhythmic = true;
        mainAnimationRhythmLength = filteredAnimations.mainAnimations.get(index).animationLength;
        //In case of 16th notes fast rhythmic animations, make the animation 16 beat long
        mainAnimationLength = min(64 * mainAnimationRhythmLength, 32); 

      }
      else {
        mainAnimationIsRhythmic = false;
      }
    }
    
    else {        //Special case, only transitions registered
      
      //Get a random animation inside the long animations corresponding to this filter
      index = floor(random(filteredAnimations.transitionAnimations.size()));
      mainAnimationNbr = filteredAnimations.transitionAnimations.get(index).animationNbr;
      mainAnimationLength = filteredAnimations.transitionAnimations.get(index).animationLength;

            
      //Determine if the chosen animation is rhythmic
      if (filteredAnimations.transitionAnimations.get(index).attributes.contains("Rhythmic") == true) {
        mainAnimationIsRhythmic = true;
        mainAnimationRhythmLength = filteredAnimations.transitionAnimations.get(index).animationLength;
        //In case of 16th notes fast rhythmic animations, make the animation 8 beat long
        mainAnimationLength = min(32 * mainAnimationRhythmLength, 16);
 
      }
      else {
        mainAnimationIsRhythmic = false;
      }

    }
    
    animationShouldBeReinitialized = true;

    outputLog.println("Automatic mode - Changing main animation - new animation chosen from filtered list with ID " + listID + 
                      " // Animation number = " + mainAnimationNbr + ", rhythmic = " + mainAnimationIsRhythmic + ", next main animation shall be set in " + mainAnimationLength + " beats starting from now");
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

  //When the executionmeasure ends, the selected transition shall also end
  void addTransitionToAnimationQueue(int executionMeasure, int listID) {
    Float[] chosenTransition;    //Will contain (int) animationNumber, (float) animationLength
    chosenTransition = chooseRandomTransitionFromList(listID);
    float executionBeat = 1;
    int measure = executionMeasure;
    float animationLen = (float) chosenTransition[1];
    if (animationLen < 4.0) {    //The transition is shorter than 1 bar
      executionBeat = 5 - chosenTransition[1];
      measure = executionMeasure;
    }
    else if (animationLen < 8.0) {
      executionBeat = 9 - chosenTransition[1];
      measure = executionMeasure - 1;
    }
    else if (animationLen < 12.0) {
      executionBeat = 13 - chosenTransition[1];
      measure = executionMeasure - 2;
    }
    else if (animationLen < 16.0) {
      executionBeat = 17 - chosenTransition[1];
      measure = executionMeasure - 3;
    }
    
    int animationNbr = floor(chosenTransition[0]);
    animationsQueue.addFutureAction(new FutureAction(animationNbr, measure, executionBeat, animationLen));
  }
  
  //Actions to be taken when a message of type BeatSynchronization is received
  void processBeatMessage(int pitch) {
    
    //Update the current timestamp
    currentBeatTimestamp = System.nanoTime();
    if (previousBeatsTimestamps.size() > numberOfTempoEvaluationSteps) {
      previousBeatsTimestamps.add(System.nanoTime());                        //Add the system time corresponding to the latest beat
      previousBeatsTimestamps.remove(previousBeatsTimestamps.get(0));        //Remove the oldest beat timestamp
      updateTempo();                                                         //Update tempo using the new beatinfo
    }
    else {
      previousBeatsTimestamps.add(System.nanoTime());
    }

    
    //Update beat status
    if (pitch == PITCH_NEW_SCENE_FIRST_BEAT) {
      newBeatInformation = true;
      currentBeat = 1;
      currentBar = 1;
      sceneCounter += 1;
      beatCounter += 1;

      
      if (transitionBeingPlayedToBeReset == true) {
        transitionBeingPlayedToBeReset = false;
        transitionBeingPlayed = false;
      }
      
      //Forcefully reset the transition which might be played
      if (transitionBeingPlayed == true) {
        transitionBeingPlayed = false;
        animationShouldBeReinitialized = true;
      }
      
      //Useful for debug
      //println("NEW SCENE FIRST BEAT !!!!!!!! " + currentBar + ":" + currentBeat + "  - tempo = " + currentTempo + "   - beatcounter : " + beatCounter);
    }
    else if (pitch == PITCH_FIRST_BEAT) {
      currentBeat = 1;
      currentBar += 1;
      beatCounter += 1;
      
      //Useful for debug
      //println("FIRST BEAT ! " + currentBar + ":" + currentBeat + "  - tempo = " + currentTempo + "   - beatcounter : " + beatCounter);

      if (transitionBeingPlayedToBeReset == true) {
        transitionBeingPlayedToBeReset = false;
        transitionBeingPlayed = false;
      }
    }
    else if (pitch == PITCH_REGULAR_BEAT) {
      currentBeat += 1;
      beatCounter += 1;
      
      //Useful for debug
      //println("REGULAR BEAT.... " + currentBar + ":" + currentBeat + "  - tempo = " + currentTempo + "   - beatcounter : " + beatCounter);

    }
        
    //If the animation is rhythmic, update the animations' next activation timestamp (setup call) 
    if (mainAnimationIsRhythmic == true) {
      if (mainAnimationRhythmLength <= 1.0) {
        mainAnimationRhythmPrevTimestamp = mainAnimationRhythmNextTimestamp; 
        mainAnimationRhythmNextTimestamp = currentBeatTimestamp + (long)(beatLengthNanoSec*mainAnimationRhythmLength);
        mainAnimationStartBar  = currentBar;
        mainAnimationStartBeat = currentBeat;
        animationShouldBeReinitialized = true;
        if (currentSetListID >= FILTEREDLIST_ID_SET_1) { //The main animation was chosen from a set : choose another animation from this set
          chooseAnotherMainAnimationFromList(currentSetListID);
        }

      }
      else 
      {
        
        //Animations longer than 1 beat work slightly differently
        subBeatCounter += 1;
        if (subBeatCounter >= mainAnimationRhythmLength) {
          mainAnimationRhythmPrevTimestamp = mainAnimationRhythmNextTimestamp; 
          mainAnimationRhythmNextTimestamp = currentBeatTimestamp + (long)(beatLengthNanoSec*mainAnimationRhythmLength);
          mainAnimationStartBar  = currentBar;
          mainAnimationStartBeat = currentBeat;
          animationShouldBeReinitialized = true;
          if (currentSetListID >= FILTEREDLIST_ID_SET_1) { //The main animation was chosen from a set : choose another animation from this set
            chooseAnotherMainAnimationFromList(currentSetListID);   
          }
        }
      }
    }
                       
    //Wait until all three important messages are received before deciding on which animations to choose
    if (newColorInformation == true && newIntensityInformation == true && newBeatInformation == true) {
      updateFutureActionsPlanning();
    }
    
    //Execute the specific actions related to the stroboscope
    stroboQueue.beatActions();
    
  }
  
  
  void processIntensityMessage(int pitch) {
    
    newIntensityInformation = true;
    
    if (pitch == PITCH_INTENSITY_LOW) {
      lowIntensityCounter    += 1;
      mediumIntensityCounter  = 0;
      highIntensityCounter    = 0;
      currentIntensity        = INTENSITY_LOW;
    }
    else if (pitch == PITCH_INTENSITY_MEDIUM) {
      mediumIntensityCounter += 1;
      lowIntensityCounter     = 0;
      highIntensityCounter    = 0;
      currentIntensity        = INTENSITY_MEDIUM; 
    }
    else if (pitch == PITCH_INTENSITY_HIGH) {
      highIntensityCounter   += 1;
      lowIntensityCounter     = 0;
      mediumIntensityCounter  = 0;
      currentIntensity        = INTENSITY_HIGH;   
    }
    else if (pitch == PITCH_INTENSITY_HARDCORE) {
      highIntensityCounter    = 0;
      lowIntensityCounter     = 0;
      mediumIntensityCounter  = 0;
      currentIntensity        = INTENSITY_HARDCORE;   
    }
    
    //Step up the intensity after some time
    if (currentIntensity == INTENSITY_LOW && lowIntensityCounter >= NUMBER_OF_SCENES_UNTIL_INTENSITY_INCREASE) {
      currentIntensity = INTENSITY_MEDIUM;
    }
    else if (currentIntensity == INTENSITY_MEDIUM && mediumIntensityCounter >= NUMBER_OF_SCENES_UNTIL_INTENSITY_INCREASE) {
      currentIntensity = INTENSITY_HIGH;
    }
    else if (currentIntensity == INTENSITY_HIGH && highIntensityCounter >= NUMBER_OF_SCENES_UNTIL_INTENSITY_INCREASE) {
      currentIntensity = INTENSITY_HARDCORE;
    }    
        
    //Wait until all three important messages are received before deciding on which animations to choose
    if (newColorInformation == true && newIntensityInformation == true && newBeatInformation == true) {
      updateFutureActionsPlanning();
    }    
  }
  
  void processColorChangeMessage(int pitch) {
    
    newColorInformation = true;
    
    if (pitch == PITCH_COLORSET_RED) {
      currentColorSet = COLORSET_RED;
    }
    else if (pitch == PITCH_COLORSET_BLACK) {
      currentColorSet = COLORSET_BLACK;
    }
    else if (pitch == PITCH_COLORSET_BLUE) {
      currentColorSet = COLORSET_BLUE;
    }
    else if (pitch == PITCH_COLORSET_FREE) {
      colorsetCounter += 1;
      if (colorsetCounter % NUMBER_OF_SCENES_UNTIL_COLOR_CHANGE == 0) {
        colorsetCounter = 0;
        switch(currentColorSet) {
          case COLORSET_BLACK   : currentColorSet = COLORSET_RED; break;
          case COLORSET_RED     : currentColorSet = COLORSET_BLUE; break;
          case COLORSET_BLUE    : currentColorSet = COLORSET_COLORFUL; break;
          case COLORSET_COLORFUL: currentColorSet = COLORSET_BLACK; break;
        }
      } 
    }
                
    //Wait until all three important messages are received before deciding on which animations to choose
    if (newColorInformation == true && newIntensityInformation == true && newBeatInformation == true) {
      updateFutureActionsPlanning();
    }
  }
  
  

  void updateTempo() {
    ArrayList<Long> deltaBeatTimestamp = new ArrayList<Long>();              //Create an arraylist of the deltas between the timestamps
    for (int i = 0; i < previousBeatsTimestamps.size() - 1; i++) {
      deltaBeatTimestamp.add( (Long) previousBeatsTimestamps.get(i+1) - (Long) previousBeatsTimestamps.get(i) );
    }
    ArrayList<Float> tempoCandidates = new ArrayList<Float>();               //Create an arraylist of possible tempovalues
    for (Long timeDelta: deltaBeatTimestamp) {
      tempoCandidates.add(60.0 / convertNanosecToSec(timeDelta));
    }
    for (float tempo: tempoCandidates) {                                     //Remove unlikely tempo candidates
      if (tempo < 40) {                                                      //ex : music was stopped once, some time has passed since the last beat synchronization -> do not assume a tempo around 10 BPM !
        tempoCandidates.remove(tempo);
        break; 
      }
    }
    float tempTempo = 0;
    if (tempoCandidates.size() != 0) {
      for (float tempoCandidate: tempoCandidates) {                          //Average the possible tempovalues. If the average is impossible, assume default tempo : 120
        tempTempo += tempoCandidate / tempoCandidates.size();
      }
    }
    else {
      tempTempo = 120.0;
    }
    currentTempo = tempTempo;                                                //Update tempo
    beatLengthNanoSec = convertSecToNanosec(60.0 / ((float)currentTempo));   //Update tempo in nanoseconds
  }

  float convertNanosecToSec(Long nanosec) {
    return (float) nanosec / 1000000000.0;
  }

  Long convertSecToNanosec(float sec) {
    return Long.valueOf((int) (sec * 1000000000.0));
  }


  
  void determineTimestampsForThisMeasure(int measure) {
    for (FutureAction action: animationsQueue.futureActions) {
      if (action.isReadyToDefineTimestamp() == true) {
        action.defineExecTimestamp();

      }
    }
  }
  
}


class FutureActionsList {
  
  ArrayList<FutureAction> futureActions;
  
  FutureActionsList() {
    futureActions = new ArrayList<FutureAction>();
  }
  
  //Custom method to add to the arraylist, sorting directly the queue upon adding an element
  void addFutureAction(FutureAction action) {

    //Checking the measure/beat
    if (futureActions.size() == 0) {    //If no action has been registered yet, no need to worry about the place
      futureActions.add(action);
    }
    else {
      for (int i = 0; i < futureActions.size(); i++) {
        if (action.measure < futureActions.get(i).measure) {
          futureActions.add(i, action);
          break;
        }
        else if (action.measure == futureActions.get(i).measure && action.beat < futureActions.get(i).beat) {
          futureActions.add(i, action);
          break;
        }
      }
    }

  }
  
  void reinitializeFutureActionsList() {
    futureActions = new ArrayList<FutureAction>();
  }

  //Get the first FutureAction in the list, and remove it
  //Important : before trying this action, check the list has elements !
  FutureAction popClosestAction() {
    FutureAction imminentAction = futureActions.get(0);
    futureActions.remove(futureActions.get(0));
    return imminentAction;
  }
  
  void generateTimestampsForImminentAnimations() {
    for (FutureAction action : futureActions) {
      if (action.isReadyToDefineTimestamp()) {
        action.defineExecTimestamp();
      }
    }
  }
  
}

class FutureAction {
  
  //How is a future action executed :
  //The action is first requested for a certain beat of a certain bar.
  //This value, easy to define, is then converted to a beatCounter, which shall be compared to the beatCounter
  //For best precision, the real execution timestamp (in nanoseconds) is defined just before execution 
  
  Long executionTimestamp;    //Timestamp is in nanoseconds, comes from System.nanoTime()
  boolean timestampHasBeenDefined;

  int measure;
  float beat;
  int measureEnd;
  float beatEnd;
  float executionBeatCounter;
  float endBeatCounter;

  int animationnumber;
  float animationLength;
  
  
  FutureAction(int animationnbr, int requestedMeasure, float requestedBeat, float animationlength) {
    animationnumber = animationnbr;
    measure = requestedMeasure;
    beat = requestedBeat;
    if (beat == 5.0) {
      beat = 1;
      measure += 1;
    }
    
    animationLength = animationlength;
    executionTimestamp = automaticSequencer.currentBeatTimestamp + VERY_LONG_TIME_INIT_TIMESTAMP;
    timestampHasBeenDefined = false;
    
    if (requestedBeat + animationlength > 5) {  //The strobe continues over the new measure
      float animationLengthInMeasures = animationlength / 4;
      measureEnd = measure + max(1, floor(animationLengthInMeasures));
      beatEnd = beat + animationLength - 4*max(1, floor(animationLengthInMeasures));
    }
    else {
      measureEnd = measure;
      beatEnd = beat + animationLength;
    }
    
    if (beatEnd == 5.0) {
      beatEnd = 1;
      measureEnd += 1;
    }
    
    executionBeatCounter = (measure - 1) * 4 + (beat - 1);
    endBeatCounter = (measureEnd - 1) * 4 + (beatEnd - 1);
    
  }
  
  void defineExecTimestamp() {
    //This computation is wrong in the case of live jamming with scenes : the scene will be around 4 bars long, so if the transition is defined to be executed at the 8th measure, it will never be played
    //float beatDifference = (measure - automaticSequencer.currentBar) * 4 + (beat - automaticSequencer.currentBeat);
    float beatDifference = executionBeatCounter - automaticSequencer.beatCounter;    
    
    this.executionTimestamp = automaticSequencer.currentBeatTimestamp + (long) (beatDifference * automaticSequencer.beatLengthNanoSec);
    
  }
  
  boolean isReadyToDefineTimestamp() {
    if (this.timestampHasBeenDefined == false) {
      if (automaticSequencer.currentBar == this.measure) {
        this.timestampHasBeenDefined = true;
        return true;
      }
      else if ((automaticSequencer.currentBar == this.measure - 1) && this.beat == 1) {
        this.timestampHasBeenDefined = true;
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }
  
}


////////////////////////////////
///Automatic Strobo functions///
////////////////////////////////

//Called during init, this function creates rhythmic patterns, by creating StroboRhythmBeat objects.
//These objects can be loaded in the DMXFutureAction list to be executed
void createStroboPatterns() {
  strobeOff = new ArrayList<StroboscopeRhythmBeat>();
  strongStroboscopePatterns = new ArrayList<StroboscopeRhythmBeat>();
  weakStroboscopePatterns = new ArrayList<StroboscopeRhythmBeat>();
  
  ArrayList<StroboAction> tempStroboList = new ArrayList<StroboAction>();
  
  //No stroboscope
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_OFF, 1, 1, 1, FOUR_BEAT_PATTERN));
  strobeOff.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));

  //Weak rhythm : flash every two beats
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_FAST_WEAK, 1, 1, 1, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_WEAK, 1, 3, 1, FOUR_BEAT_PATTERN));
  weakStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));
  
  //Weak rhythm : flash every beat
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_FAST_MEDIUM, 1, 1, 0.5, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_MEDIUM, 1, 2, 0.5, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_MEDIUM, 1, 3, 0.5, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_MEDIUM, 1, 4, 0.5, FOUR_BEAT_PATTERN));
  weakStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));

  
  //Weak rhythm : slow low-power 3-beat long continuous flash
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_REGULAR_WEAK, 1, 1, 3, FOUR_BEAT_PATTERN));
  weakStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));

  //Weak rhythm : slow medium-power 3-beat long continuous flash
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_REGULAR_MEDIUM, 1, 1, 3, FOUR_BEAT_PATTERN));
  weakStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));

//  //Weak rhythm : crescendo over one bar
//  tempStroboList = new ArrayList<StroboAction>();
//  tempStroboList.add(new StroboAction(STROBO_FAST_VERYWEAK, 1, 1, 4, FOUR_BEAT_PATTERN));
//  tempStroboList.add(new StroboAction(STROBO_FAST_WEAK, 1, 2, 4, FOUR_BEAT_PATTERN));
//  tempStroboList.add(new StroboAction(STROBO_FAST_MEDIUM, 1, 2, 4, FOUR_BEAT_PATTERN));
//  tempStroboList.add(new StroboAction(STROBO_FAST_HIMEDIUM, 1, 2, 4, FOUR_BEAT_PATTERN));
//  weakStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));
  
  //Strong rhythm : continuous strobe
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 1, 4, FOUR_BEAT_PATTERN));
  strongStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));
  
  //Strong rhythm : all the beats
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 1, 0.5, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 2, 0.5, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 3, 0.5, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 4, 0.5, FOUR_BEAT_PATTERN));
  strongStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));
    
  //Strong rhythm : crescendo over one bar
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_FAST_LOWMEDIUM, 1, 1, 1, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_MEDIUM, 1, 2, 1, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_HIMEDIUM, 1, 3, 1, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 4, 1, FOUR_BEAT_PATTERN));
  strongStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));
  
  //Strong rhythm : all the beats, last one longer than the others
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 1, 0.5, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 2, 0.5, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 3, 0.5, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 4, 1, FOUR_BEAT_PATTERN));
  strongStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));

  //Strong rhythm : speed crescendo over one bar
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_SLOW_STRONG, 1, 1, 1, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_REGULAR_STRONG, 1, 3, 1, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 4, 1, FOUR_BEAT_PATTERN));
  strongStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));
  
  //Strong rhythm : first and fourth beats
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 1, 1, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 4, 0.5, FOUR_BEAT_PATTERN));
  strongStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));
  
  //Strong rhythm : second and fourth beats
  tempStroboList = new ArrayList<StroboAction>();
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 2, 1, FOUR_BEAT_PATTERN));
  tempStroboList.add(new StroboAction(STROBO_FAST_STRONG, 1, 4, 1, FOUR_BEAT_PATTERN));
  strongStroboscopePatterns.add(new StroboscopeRhythmBeat(tempStroboList, FOUR_BEAT_PATTERN));
}

//DMX actions are a bit different from regular animations : instead of setting flags, one-off messages must be sent
//The actionlist contains a StroboscopepRhythmBeat object, made of multiple actions and timestamps. 
//When the current timestamp is > to the action's timestamp, it is executed, and the next action in the StroboscopepRhythmBeat object is queued
class DMXFutureActionsList {
  
  StroboscopeRhythmBeat currentStrobePattern;    //Pattern to be executed
  int currentStep;                               //Current step inside the strobe pattern (0: first step)
  Long actionEndTimestamp;                       //Barrier to stop the stroboscope : will either be executed normally if there are breaks between the actions, or delayed further otherwise
  boolean stroboHasBeenStopped;                  //Flag to determine if the stroboscope is currently stopped : useful to execute the stop command only once to avoid spamming the DMX link
  boolean stroboHasBeenSetup;                    //Flag to determine if the stroboscope is currently on : useful to execute the stop command only once to avoid spamming the DMX link
  boolean DMXFutureActionsInit; 
  boolean readyToIncrementStep;
  boolean checkTimeStopDMX;                      //Check the current time to stop the animation - used only for animations shorter than 1 beat
  int endActionBeatCounter;                      //Beatcounter during which no matter what the action must be stopped
  
  DMXFutureActionsList() {
    currentStrobePattern = strobeOff.get(0);     //Initialize the object with a "stroboscope off" preset
    currentStep = 0;                             //Start at the beginning of the stroboscope sequence
    actionEndTimestamp = System.nanoTime() + VERY_LONG_TIME_INIT_TIMESTAMP;
    stroboHasBeenStopped = false;
    stroboHasBeenSetup = false;
    DMXFutureActionsInit = true;
    readyToIncrementStep = false;
  }
  
  void play() {      //Check when the current strobe action comes to an end, and stop it 
    
    if (this.checkTimeStopDMX) {
      if (System.nanoTime() > automaticSequencer.currentBeatTimestamp + currentStrobePattern.stroboActions.get(currentStep).noteLength*automaticSequencer.beatLengthNanoSec) {
        if (stroboHasBeenStopped == false) {
          stroboHasBeenStopped = true;
          stopStroboscope();
        }
      }
    }
    
  }
  
  void beatActions() {    
    if (this.checkTimeStopDMX == true) {
      //Stop the strobe no matter what : the previous action was shorter than a beat
      if (stroboHasBeenStopped == false) {
        stopStroboscope();
        stroboHasBeenStopped = true;
      }
    }
    else {
      //Check if the animation is over
      if (automaticSequencer.beatCounter == this.endActionBeatCounter) {
        stopStroboscope();
        stroboHasBeenStopped = true;
      }
    }  
    
    
    //Is the current action ready to be played    
    if (currentStrobePattern.stroboActions.get(currentStep).isReadyToBePlayed()) {
      //Play the action
      currentStrobePattern.stroboActions.get(currentStep).playStroboAction(currentStrobePattern.stroboActions.get(currentStep).preset);
            
      //If the action's length is inferior to 1, the play function will check the system time to determine when the action must be stopped 
      if (currentStrobePattern.stroboActions.get(currentStep).noteLength < 1) {
        this.checkTimeStopDMX = true;
        this.endActionBeatCounter = automaticSequencer.beatCounter + 1;
      } else {
        this.checkTimeStopDMX = false;
        this.endActionBeatCounter = automaticSequencer.beatCounter + (int)(currentStrobePattern.stroboActions.get(currentStep).noteLength);
      }
     
      //Increment the step
      currentStep = ((currentStep + 1) % currentStrobePattern.stroboActions.size());
    }
    
  }  
  
  void stopStroboscope() {
    myDMX.stopStrobe_FrontLeft();
    myDMX.stopStrobe_FrontRight();
  }
  
}


//Create a rhythmic pattern for the stroboscope
//Important : the stroboactions specified upon creating the object must not overlap
class StroboscopeRhythmBeat {
  
  ArrayList<StroboAction> stroboActions;
  int patternLength;
  
  //Actions for the stroboscope, patternLength (in beats)
  StroboscopeRhythmBeat(ArrayList<StroboAction> actions, int patternLen) {
    patternLength = patternLen;
    stroboActions = actions;
    
    outputLog.println("Registering Stroboscope rhythm for Automatic Mode : " + printRhythm(patternLength));
  }
  
  String printRhythm(int patternLen) {
    try {
    char[] temp = new char[patternLen*4];
    for (int i = 0; i < temp.length; i++) {
      temp[i] = '-'; 
    }
    for (StroboAction action: stroboActions) {
      int[] concerned16ths = range((int)((action.measureStart-1)*16 + (action.beatStart - 1)*4), (int) ((action.measureEnd-1)*16 + (action.beatEnd - 1)*4));
      for (int i : concerned16ths) {
        temp[i] = 'X';
      }
    }
    return new String(temp);
    }
    catch(Exception e) {
      outputLog.println("Stroboscope printRhythm caused an exception : " + e);
      return "";
    }
  }
  
  //Utility function, range : akin to Python's range
  int[] range(int start, int end) {
    int[] r = new int[end - start];
    for (int i = start; i < end; i++) {
        r[i-start] = i;
    }
    return r;
  }
}

//Helper object for using the stroboscope : put the brightness and the velocity in a unified object
class StroboAction {
    
  int measureStart;
  float beatStart;
  int measureEnd;
  float noteLength;
  float beatEnd;
  float startBeatCounter;
  float endBeatCounter;  
  int preset;
  int patternLength;    //Pattern length in bars
  
  StroboAction(int strobePreset, int measure_start, float beat_start, float noteLen, int patternLen) {    
    measureStart = measure_start;
    beatStart = beat_start;
    patternLength = patternLen;
    noteLength = noteLen;
    preset = strobePreset;
    
    if (beatStart + noteLen > 5) {  //The strobe continues over the new measure
      float noteLengthInMeasures = noteLen / 4;
      measureEnd = measureStart + max(1, floor(noteLengthInMeasures));
      beatEnd = beatStart + noteLen - 4*max(1, floor(noteLengthInMeasures));
    }
    else {
      measureEnd = measureStart;
      beatEnd = beatStart + noteLen;
    }
    
    startBeatCounter = (measureStart - 1) * 4 + (beatStart - 1);
    endBeatCounter = (measureEnd - 1) * 4 + (beatEnd - 1);
  }
  
  boolean isReadyToBePlayed() {
    if ((automaticSequencer.beatCounter % patternLength) == this.startBeatCounter) {
      return true;
    }
    else {
      return false;
    }
  }
  

  
  void playStroboAction(int preset) {      //Will have to be checked, depends on the assumption that the strobe's DMX channels are speed/brightness
    switch (preset) {       //This function may be made bigger, depending on the needs regarding the precision of the stroboscope's controls in Auto Mode
      case STROBO_OFF:               myDMX.stopStrobe_FrontLeft(); break;
      case STROBO_SLOW_VERYWEAK:     myDMX.setStrobePreset_FrontLeft(23); break;
      case STROBO_REGULAR_VERYWEAK:  myDMX.setStrobePreset_FrontLeft(63); break;
      case STROBO_FAST_VERYWEAK:     myDMX.setStrobePreset_FrontLeft(93); break;
      case STROBO_SLOW_WEAK:         myDMX.setStrobePreset_FrontLeft(24); break;
      case STROBO_REGULAR_WEAK:      myDMX.setStrobePreset_FrontLeft(64); break;
      case STROBO_FAST_WEAK:         myDMX.setStrobePreset_FrontLeft(94); break;
      case STROBO_SLOW_LOWMEDIUM:    myDMX.setStrobePreset_FrontLeft(26); break;
      case STROBO_REGULAR_LOWMEDIUM: myDMX.setStrobePreset_FrontLeft(66); break;
      case STROBO_FAST_LOWMEDIUM:    myDMX.setStrobePreset_FrontLeft(95); break;
      case STROBO_SLOW_MEDIUM:       myDMX.setStrobePreset_FrontLeft(28); break;
      case STROBO_REGULAR_MEDIUM:    myDMX.setStrobePreset_FrontLeft(68); break;
      case STROBO_FAST_MEDIUM:       myDMX.setStrobePreset_FrontLeft(97); break;
      case STROBO_SLOW_HIMEDIUM:     myDMX.setStrobePreset_FrontLeft(29); break;
      case STROBO_REGULAR_HIMEDIUM:  myDMX.setStrobePreset_FrontLeft(69); break;
      case STROBO_FAST_HIMEDIUM:     myDMX.setStrobePreset_FrontLeft(98); break;
      case STROBO_SLOW_STRONG:       myDMX.setStrobePreset_FrontLeft(30); break;
      case STROBO_REGULAR_STRONG:    myDMX.setStrobePreset_FrontLeft(70); break;
      case STROBO_FAST_STRONG:       myDMX.setStrobePreset_FrontLeft(99); break;

      default: break;
    }
    
  }
  
  void stopStroboAction() {
    myDMX.stopStrobe_FrontLeft();
    myDMX.stopStrobe_FrontRight();
  }
  
}
