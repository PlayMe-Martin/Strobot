
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

public static final int NOTE_ON = 0x90;
public static final int NOTE_OFF = 0x80;
public static final String[] NOTE_NAMES = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};

ArrayList<MidiSequence> MidiSequences_LowIntensity;
ArrayList<MidiSequence> MidiSequences_MediumIntensity;
ArrayList<MidiSequence> MidiSequences_HighIntensity;

// Check in the data folder all the MIDI files available, and parse them
void parseAllAvailableMidiClips() {
  //Parse all three data folders, and create MidiSequence objects
}

void parseMIDISequence(String filepath) {
  try {
    Sequence sequence = MidiSystem.getSequence(new File(filepath));
    int trackNumber = 0;
    for (Track track :  sequence.getTracks()) {
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
          System.out.print("Channel: " + sm.getChannel() + " ");
          if (sm.getCommand() == NOTE_ON) {
            int key = sm.getData1();
            int octave = (key / 12)-1;
            int note = key % 12;
            String noteName = NOTE_NAMES[note];
            int velocity = sm.getData2();
            System.out.println("Note on, " + noteName + octave + " key=" + key + " velocity: " + velocity);
          } else if (sm.getCommand() == NOTE_OFF) {
            int key = sm.getData1();
            int octave = (key / 12)-1;
            int note = key % 12;
            String noteName = NOTE_NAMES[note];
            int velocity = sm.getData2();
            System.out.println("Note off, " + noteName + octave + " key=" + key + " velocity: " + velocity);
          } else {
            System.out.println("Command:" + sm.getCommand());
          }
        } else {
          System.out.println("Other message: " + message.getClass());
        }
      }

      System.out.println();
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
