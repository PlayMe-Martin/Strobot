
///////////////////////////////////////////////////////////////////////
/// Read MIDI files at startup, and build a base of auto animations ///
///////////////////////////////////////////////////////////////////////


import javax.sound.midi.MidiEvent;
import javax.sound.midi.MidiMessage;
import javax.sound.midi.MidiSystem;
import javax.sound.midi.Sequence;
import javax.sound.midi.ShortMessage;
import javax.sound.midi.Track;
//java.io.File is needed by these functions, but it's already imported in Configuration

final int NOTE_ON = 0x90;
final int NOTE_OFF = 0x80;
final float ONE_BAR_LENGTH = 384.0;      //Length of 1 bar, in MIDI ticks - in float, as this is often used as a division denominator
//For the following note off events, an action is allowed
final int[] AVAILABLE_NOTE_OFF = {PITCH_GENERAL_STROBO_FRONT_LEFT, PITCH_GENERAL_STROBO_FRONT_RIGHT, PITCH_GENERAL_STROBO_BACK, 
                                  PITCH_DMX_ANIMATION_BANK1, PITCH_DMX_ANIMATION_BANK2, PITCH_DMX_ANIMATION_BANK3, 
                                  PITCH_DISPLAY_EFFECT};
  
ArrayList<MidiSequence> MidiSequences_DefaultIntensity;
ArrayList<MidiSequence> MidiSequences_LowIntensity;
ArrayList<MidiSequence> MidiSequences_MediumIntensity;
ArrayList<MidiSequence> MidiSequences_HighIntensity;

// Check in the data folder all the MIDI files available, and parse them
void parseAllAvailableMidiClips() {
  
  String[] directoriesToParse = { "Default Intensity", "Low Intensity", "Medium Intensity", "High Intensity" };
  MidiSequences_DefaultIntensity = new ArrayList<MidiSequence>();
  MidiSequences_LowIntensity     = new ArrayList<MidiSequence>();
  MidiSequences_MediumIntensity  = new ArrayList<MidiSequence>();
  MidiSequences_HighIntensity    = new ArrayList<MidiSequence>();
  
  //Parse all three data folders, and create MidiSequence objects
  for (String directoryToParse: directoriesToParse) {
    
    try {
      String fullDirectoryPath = dataPath("") + "/MIDI/" + directoryToParse;
      File dir = new File(fullDirectoryPath);
      String[] children = dir.list();
      for (String child : children) {
        parseMIDISequence(fullDirectoryPath + "/" + child);
      }
    }
    catch (Exception e) {
      println("Exception while parsing MIDI clip directories : " + e);
    }
  }
}

void parseMIDISequence(String filepath) {
    
  try {
    Sequence sequence = MidiSystem.getSequence(new File(filepath));
    int trackNumber = 0;
    for (Track track :  sequence.getTracks()) {
      int endOfTrackTickNumber = 1;
      ArrayList<MidiAction> actionList = new ArrayList<MidiAction>();
      trackNumber++;
      for (int i=0; i < track.size(); i++) {
        MidiEvent event = track.get(i);
        MidiMessage message = event.getMessage();
        
        if (message instanceof ShortMessage) {
          ShortMessage sm = (ShortMessage) message;
          int channel = sm.getChannel();

          if (sm.getCommand() == NOTE_ON) {
            int notePitch = sm.getData1();
            int noteVelocity = sm.getData2();
            MidiAction newEvent = new MidiAction(event.getTick()*4/ONE_BAR_LENGTH, NOTE_ON, notePitch, noteVelocity);        //  Timestamp in pulses-per-quarter-note | Event Type | Action Type | Action Parameter
            actionList.add(newEvent);
          }
          else if (sm.getCommand() == NOTE_OFF) {
            int notePitch = sm.getData1();
            boolean addNoteToActionList = false;
            for (int allowedNote: AVAILABLE_NOTE_OFF) {
              if (notePitch == allowedNote) {
                addNoteToActionList = true;
                break;
              }
            }
            if (addNoteToActionList) {
              int noteVelocity = sm.getData2();
              MidiAction newEvent = new MidiAction(event.getTick()*4/ONE_BAR_LENGTH, NOTE_OFF, notePitch, noteVelocity);      //  Timestamp in pulses-per-quarter-note | Event Type | Action Type | Action Parameter
            }
          } 
          else { }    //The controller change commands could be used
        }
        else {
          String className = "" + message.getClass();
          if (className.contains("ImmutableEndOfTrack")) {
            endOfTrackTickNumber = (int) event.getTick();
          }          
        }
      }
      
      //Length of the animation : MidiSequence's constructor shall round the value to the upper int, all animations should be whole bars
      MidiSequence newSeq = new MidiSequence(endOfTrackTickNumber/ONE_BAR_LENGTH, actionList);
      if (filepath.contains("Default")) {
        MidiSequences_DefaultIntensity.add(newSeq);
      }
      if (filepath.contains("Low")) {
        MidiSequences_LowIntensity.add(newSeq);
      }
      else if (filepath.contains("Medium")) {
        MidiSequences_MediumIntensity.add(newSeq);
      }
      else if (filepath.contains("High")) {
        MidiSequences_HighIntensity.add(newSeq);
      }      
    }
  }
  catch (Exception e) 
  {
    outputLog.println("Exception when parsing AutoMode MIDI files : " + e);
  }  
}

//Sequence created by a single MIDI clip
class MidiSequence {
  float lengthInBars;                 //Number of bars the sequence will last, in bars - rounded to the nearest upper value, all sequences are full bars
  ArrayList<MidiAction> actionBank;   //List of the actions contained in this clip, organized in [MIDI Tick #, Action, Argument], ID card of this sequence
  ArrayList<MidiAction> actionQueue;  //List of the actions consumed by the sequencer, updated either when the sequence is read, or when an action is executed 
  
  MidiSequence(float _length, ArrayList<MidiAction> _actions) {
    lengthInBars = ceil(_length);
    actionBank   = _actions;
    initActions();
    outputLog.println(this.toString());
  }
  
  void initActions() {
    actionQueue = (ArrayList<MidiAction>) actionBank.clone();
  }
  
  //Non-javadoc toString method for MidiSequence objects
  String toString() {
    String temp = "";
    for (MidiAction action: actionBank) {
      temp += action.timestamp + "->" + action.actionType + "|" + action.actionVal + ", ";
    }
    //Remove the useless ", " at the end of the temp string
    if (temp.length() > 2) {
      temp = temp.substring(0, temp.length()-2);
    }
    return "Registered MIDI clip : Animation length =" + lengthInBars + " bars ||| Sequenced actions : " + temp;
  }
}

//Single MIDI action
class MidiAction {
  
  float timestamp;    //In pulses per quarter note, the MIDI timestamp when the action should be executed
  int eventType;      //Note on, or Note off
  int actionType;     //Which action should be executed ("load animation bank 1", "display an image", ...)
  int actionVal;      //The argument to feed the action function
  
  //Timestamp in pulses-per-quarter-note | Action Type | Action Parameter
  MidiAction(float _timestamp, int _eventType, int _actionType, int _actionVal) {
    timestamp  = _timestamp;
    eventType  = _eventType;
    actionType = _actionType;
    actionVal  = _actionVal;
  }
  
}
