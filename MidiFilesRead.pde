
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
final String[] NOTE_NAMES = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};

final int ONE_BAR_LENGTH = 384;      //Length of 1 bar, in MIDI ticks

ArrayList<MidiSequence> MidiSequences_LowIntensity;
ArrayList<MidiSequence> MidiSequences_MediumIntensity;
ArrayList<MidiSequence> MidiSequences_HighIntensity;

// Check in the data folder all the MIDI files available, and parse them
void parseAllAvailableMidiClips() {
  
  String[] directoriesToParse = { "Low Intensity", "Medium Intensity", "High Intensity" };
  MidiSequences_LowIntensity    = new ArrayList<MidiSequence>();
  MidiSequences_MediumIntensity = new ArrayList<MidiSequence>();
  MidiSequences_HighIntensity   = new ArrayList<MidiSequence>();
  
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
      ArrayList<int[]> actionList = new ArrayList<int[]>();
      
      println("New track ------------------");
      trackNumber++;
      System.out.println("Track " + trackNumber + ": size = " + track.size());
      System.out.println();
      for (int i=0; i < track.size(); i++) {
        MidiEvent event = track.get(i);
        System.out.print("@" + event.getTick() + " ");
        MidiMessage message = event.getMessage();
        if (message instanceof ShortMessage) {
          ShortMessage sm = (ShortMessage) message;

          int channel = sm.getChannel();

          if (sm.getCommand() == NOTE_ON) {
            int notePitch = sm.getData1();
            int noteVelocity = sm.getData2();
            int[] newEvent = {notePitch, noteVelocity};
            actionList.add(newEvent);
          }
          else if (sm.getCommand() == NOTE_OFF) {
            // What to do with NOTE_OFF messages is still up to debate
            // It could be necessary to implement this with DMX animations, but with panel, only NOTE_ON is used
            
//            int key = sm.getData1();
//            int octave = (key / 12)-1;
//            int note = key % 12;
//            String noteName = NOTE_NAMES[note];
//            int velocity = sm.getData2();
//            println("Note off, " + noteName + octave + " key=" + key + " velocity: " + velocity);

          } 
          else {
//            System.out.println("Command:" + sm.getCommand());
          }
        }
        else {
          String className = "" + message.getClass();
          if (className.contains("ImmutableEndOfTrack")) {
            endOfTrackTickNumber = (int) event.getTick();
          }          
        }
        println((float)(endOfTrackTickNumber)/ONE_BAR_LENGTH);
        MidiSequence newSeq = new MidiSequence(endOfTrackTickNumber/ONE_BAR_LENGTH, actionList);
        
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
  }
  catch (Exception e) 
  {
    println("Exception : " + e);
  }  
}

//Sequence created by a single MIDI clip
class MidiSequence {
  float lengthInBars;            //Number of bars the sequence will last, in bars
  ArrayList<int[]> actions;      //List of actions contained in this clip, organized in [MIDI Tick #, Action, Argument]
  
  MidiSequence(float _length, ArrayList<int[]> _actions) {
    lengthInBars = _length;
    actions = _actions;
  }
}
