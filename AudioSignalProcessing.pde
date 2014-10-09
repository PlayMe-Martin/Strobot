
////////////////////////////////////////////////////////////////////////////////////////////////
// Protocol Buffer parser - deserialize the data sent by the SignalProcessor plugin instances //
////////////////////////////////////////////////////////////////////////////////////////////////

import java.net.*;
import java.io.*;
import com.google.protobuf.*;

ServerSocket timeInfoServer;
Socket timeInfoServiceSocket;

ServerSocket audioDataServer_Kick;
ServerSocket audioDataServer_Snare;
ServerSocket audioDataServer_Cymbals;
ServerSocket audioDataServer_Bass;
ServerSocket audioDataServer_Keys;
ServerSocket audioDataServer_Guitar;

ServerSocket impulseServer_Kick;
ServerSocket impulseServer_Snare;
ServerSocket impulseServer_Cymbals;
ServerSocket impulseServer_Bass;
ServerSocket impulseServer_Keys;
ServerSocket impulseServer_Guitar;

Socket audioDataServiceSocket_Kick;
Socket audioDataServiceSocket_Snare;
Socket audioDataServiceSocket_Cymbals;
Socket audioDataServiceSocket_Bass;
Socket audioDataServiceSocket_Keys;
Socket audioDataServiceSocket_Guitar;

Socket impulseServiceSocket_Kick;
Socket impulseServiceSocket_Snare;
Socket impulseServiceSocket_Cymbals;
Socket impulseServiceSocket_Bass;
Socket impulseServiceSocket_Keys;
Socket impulseServiceSocket_Guitar;

final int THREAD_SLEEP_TIME = 1;    //15 ms (for reference, 50 fps means a 20ms period)

//ID numbers for the incoming signals - these are set according to the configuration file
int SIGNAL_ID_KICK    = 1;
int SIGNAL_ID_SNARE   = 2;
int SIGNAL_ID_CYMBALS = 3;
int SIGNAL_ID_BASS    = 4;
int SIGNAL_ID_KEYS    = 5;
int SIGNAL_ID_GUITAR  = 6;

//Ring buffers used to store audio data 
CircularArrayList<Float> audioInputBuffer_Kick;
CircularArrayList<Float> audioInputBuffer_Snare;
CircularArrayList<Float> audioInputBuffer_Cymbals;
CircularArrayList<Float> audioInputBuffer_Bass;
CircularArrayList<Float> audioInputBuffer_Keys;
CircularArrayList<Float> audioInputBuffer_Guitar;

//Flags triggered when an impulse is received. These are to be set back to false each cycle so that no old data will be processed
boolean impulse_Kick    = false;
boolean impulse_Snare   = false;
boolean impulse_Cymbals = false;
boolean impulse_Bass    = false;
boolean impulse_Keys    = false;
boolean impulse_Guitar  = false;

// Port number must be greater than 1000
int timeInfoPortNumber  = 7000;
int audioDataPortNumber = 8000;
int impulsePortNumber   = 9000;
int backlog = 128;              //backlog : size of the serverSocket's waiting list for incoming connections
 
final int timeInfoMessageSize = 12;
final int signalLevelMessageSize = 7;
final int impulseMessageSize = 2;

void initializeCircularBuffers() {
  // Initialize the ring buffers used to store the incoming signal data
  // Set the size of these buffers to be equal to the largest value between the screen width and the screen height
  int size = max(PANEL_RESOLUTION_X*NUMBER_OF_PANELS, PANEL_RESOLUTION_Y);
  
  audioInputBuffer_Kick    = new CircularArrayList<Float>(size);
  audioInputBuffer_Snare   = new CircularArrayList<Float>(size);
  audioInputBuffer_Cymbals = new CircularArrayList<Float>(size);
  audioInputBuffer_Bass    = new CircularArrayList<Float>(size);
  audioInputBuffer_Keys    = new CircularArrayList<Float>(size);
  audioInputBuffer_Guitar  = new CircularArrayList<Float>(size);
  
  for (int i = 0; i<size; i++) {
    audioInputBuffer_Kick.addAndRemoveLast(0f);
    audioInputBuffer_Snare.addAndRemoveLast(0f);
    audioInputBuffer_Cymbals.addAndRemoveLast(0f);
    audioInputBuffer_Bass.addAndRemoveLast(0f);
    audioInputBuffer_Keys.addAndRemoveLast(0f);
    audioInputBuffer_Guitar.addAndRemoveLast(0f);
  }

}


/////////////////////////////////////////////////////////////////////////


void startAudioSignalMonitoringThread() {
  // Create the Java servers which will listen to the different SignalProcessor plugin instances
  try {
    timeInfoServer          = new ServerSocket(timeInfoPortNumber, backlog);
    audioDataServer_Kick    = new ServerSocket(audioDataPortNumber + SIGNAL_ID_KICK, backlog);
    audioDataServer_Snare   = new ServerSocket(audioDataPortNumber + SIGNAL_ID_SNARE, backlog);
    audioDataServer_Cymbals = new ServerSocket(audioDataPortNumber + SIGNAL_ID_CYMBALS, backlog);
    audioDataServer_Bass    = new ServerSocket(audioDataPortNumber + SIGNAL_ID_BASS, backlog);
    audioDataServer_Keys    = new ServerSocket(audioDataPortNumber + SIGNAL_ID_KEYS, backlog);
    audioDataServer_Guitar  = new ServerSocket(audioDataPortNumber + SIGNAL_ID_GUITAR, backlog);
    impulseServer_Kick      = new ServerSocket(impulsePortNumber + SIGNAL_ID_KICK, backlog);
    impulseServer_Snare     = new ServerSocket(impulsePortNumber + SIGNAL_ID_SNARE, backlog);
    impulseServer_Cymbals   = new ServerSocket(impulsePortNumber + SIGNAL_ID_CYMBALS, backlog);
    impulseServer_Bass      = new ServerSocket(impulsePortNumber + SIGNAL_ID_BASS, backlog);
    impulseServer_Keys      = new ServerSocket(impulsePortNumber + SIGNAL_ID_KEYS, backlog);
    impulseServer_Guitar    = new ServerSocket(impulsePortNumber + SIGNAL_ID_GUITAR, backlog);
  }
  catch (Exception e) {outputLog.println("Couldn't create audioDataServer : " + e);}  
  // Create a separate thread which will listen forever to the audio plugins
  thread("listenToIncomingTimeInfo");
  thread("listenToIncomingSignalLevels_Kick");
  thread("listenToIncomingImpulses_Kick");
  thread("listenToIncomingSignalLevels_Snare");
  thread("listenToIncomingImpulses_Snare");
  thread("listenToIncomingSignalLevels_Cymbals");
  thread("listenToIncomingImpulses_Cymbals");
  thread("listenToIncomingSignalLevels_Bass");
  thread("listenToIncomingImpulses_Bass");
  thread("listenToIncomingSignalLevels_Keys");
  thread("listenToIncomingImpulses_Keys");
  thread("listenToIncomingSignalLevels_Guitar");
  thread("listenToIncomingImpulses_Guitar");
}

///////////////////////////////////////////////////////////////////////////
  

void listenToIncomingSignalLevels_Kick() {
  listenToIncomingSignalLevels(SIGNAL_ID_KICK, audioDataServer_Kick, audioDataServiceSocket_Kick);
}

void listenToIncomingSignalLevels_Snare() {
  listenToIncomingSignalLevels(SIGNAL_ID_SNARE, audioDataServer_Snare, audioDataServiceSocket_Snare);
}

void listenToIncomingSignalLevels_Cymbals() {
  listenToIncomingSignalLevels(SIGNAL_ID_CYMBALS, audioDataServer_Cymbals, audioDataServiceSocket_Cymbals);
}

void listenToIncomingSignalLevels_Bass() {
  listenToIncomingSignalLevels(SIGNAL_ID_BASS, audioDataServer_Bass, audioDataServiceSocket_Bass);
}

void listenToIncomingSignalLevels_Keys() {
  listenToIncomingSignalLevels(SIGNAL_ID_KEYS, audioDataServer_Keys, audioDataServiceSocket_Keys);
}

void listenToIncomingSignalLevels_Guitar() {
  listenToIncomingSignalLevels(SIGNAL_ID_GUITAR, audioDataServer_Guitar, audioDataServiceSocket_Guitar);
}



void listenToIncomingImpulses_Kick() {
  listenToIncomingImpulses(SIGNAL_ID_KICK, impulseServer_Kick, impulseServiceSocket_Kick);
}

void listenToIncomingImpulses_Snare() {
  listenToIncomingImpulses(SIGNAL_ID_SNARE, impulseServer_Snare, impulseServiceSocket_Snare);
}

void listenToIncomingImpulses_Cymbals() {
  listenToIncomingImpulses(SIGNAL_ID_CYMBALS, impulseServer_Cymbals, impulseServiceSocket_Cymbals);
}

void listenToIncomingImpulses_Bass() {
  listenToIncomingImpulses(SIGNAL_ID_BASS, impulseServer_Bass, impulseServiceSocket_Bass);
}

void listenToIncomingImpulses_Keys() {
  listenToIncomingImpulses(SIGNAL_ID_KEYS, impulseServer_Keys, impulseServiceSocket_Keys);
}

void listenToIncomingImpulses_Guitar() {
  listenToIncomingImpulses(SIGNAL_ID_GUITAR, impulseServer_Guitar, impulseServiceSocket_Guitar);
}


void listenToIncomingTimeInfo() {
  try {    
    // Create a new connection with the remote plugin
    timeInfoServiceSocket = timeInfoServer.accept();
    // Create a Datainputstream to hold the data received by the socket
    DataInputStream timeInfoInput = new DataInputStream(timeInfoServiceSocket.getInputStream());
    
    println("Created time info server");
    
    // Infinite loop ! The train goes on and on... Every time some data is received, the following loops
    while (true) {
      // Read the available number of bytes
      int lengthAvailable = timeInfoInput.available();
      
      if (lengthAvailable != 0) {
        //println("lengthAvailable : " + lengthAvailable);
        byte[] buf = new byte[timeInfoMessageSize];
        //Read exactly as many bytes as needed (offset = 0)
        timeInfoInput.read(buf, 0, timeInfoMessageSize);
        try {
          SignalMessages.TimeInfo timeInfo = SignalMessages.TimeInfo.parseFrom(buf);
          processTimeInfoMessage(timeInfo);
        }
        catch (Exception e) {
          println("Couldn't parse a timeInfo message : " + e);
          println("Contents of the message : ");
          println(buf);
          println("----------------------------------");
          //Purge the current buffer
          try {
            //int lengthGarbage = signalLevelInput.available();
            //byte[] garbage = new byte[lengthGarbage];
            //signalLevelInput.readFully(garbage);
          }
          catch (Exception e2) { println("Couldn't purge the garbage inside the input buffer"); }
        }
      }
      // If no byte is available, sleep a little to avoid CPU overload 
      else {
        Thread.sleep(THREAD_SLEEP_TIME);
      }
    } 
  }
  catch (Exception e) {
    println("Exception occured when creating the audio input data server : " + e);
  }
}

void listenToIncomingSignalLevels(int signalID, ServerSocket audioDataServer, Socket audioDataServiceSocket) {
  try {    
    // Create a new connection with the remote plugin
    audioDataServiceSocket = audioDataServer.accept();
    // Create a Datainputstream to hold the data received by the socket
    DataInputStream signalLevelInput = new DataInputStream(audioDataServiceSocket.getInputStream());
    
    println("Created signal level server for " + signalID);
    
    // Infinite loop ! The train goes on and on... Every time some data is received, the following loops
    while (true) {
      // Read the available number of bytes
      int lengthAvailable = signalLevelInput.available();
      
      if (lengthAvailable != 0) {
        byte[] buf = new byte[signalLevelMessageSize];
        //Read exactly as many bytes as needed (offset = 0)
        signalLevelInput.read(buf, 0, signalLevelMessageSize);
        try {
          SignalMessages.SignalLevel signalLevel = SignalMessages.SignalLevel.parseFrom(buf);
          processSignalLevelMessage(signalLevel);
        }
        catch (Exception e) {
          println("Couldn't parse a signalLevel message : " + e);
          println("Contents of the message : ");
          println(buf);
          println("----------------------------------");
          //Purge the current buffer
          try {
            //int lengthGarbage = signalLevelInput.available();
            //byte[] garbage = new byte[lengthGarbage];
            //signalLevelInput.readFully(garbage);
          }
          catch (Exception e2) { println("Couldn't purge the garbage inside the input buffer"); }
        }
      }
      // If no byte is available, sleep a little to avoid CPU overload 
      else {
        Thread.sleep(THREAD_SLEEP_TIME);
      }
    } 
  }
  catch (Exception e) {
    println("Exception occured when creating the audio input data server : " + e);
  }
}



void listenToIncomingImpulses(int signalID, ServerSocket impulseServer, Socket impulseServiceSocket) {
  try {    
    // Create a new connection with the remote plugin
    impulseServiceSocket = impulseServer.accept();
    // Create a Datainputstream to hold the data received by the socket
    DataInputStream impulseInput = new DataInputStream(impulseServiceSocket.getInputStream());
    
    println("Created impulse server for " + signalID);

    // Infinite loop ! The train goes on and on... Every time some data is received, the following loops
    while (true) {
      // Read the available number of bytes
      int lengthAvailable = impulseInput.available();
      
      if (lengthAvailable != 0) {
        println(signalID + " -- " + lengthAvailable);
//        byte[] buf = new byte[impulseMessageSize];
//        println("lengthAvailable : " + lengthAvailable);
//        println(buf);
//        //Read exactly as many bytes as needed (offset = 0)
//        impulseInput.read(buf, 0, impulseMessageSize);

        byte[] buf = new byte[lengthAvailable];
        impulseInput.readFully(buf);

        try {
          SignalMessages.Impulse impulse = SignalMessages.Impulse.parseFrom(buf);
          processImpulseMessage(impulse);
        }
        catch (Exception e) {
          println("Couldn't parse an impulse message : " + e);
          //Purge the current buffer
          try {
            int lengthGarbage = impulseInput.available();
            byte[] garbage = new byte[lengthGarbage];
            impulseInput.readFully(garbage);
          }
          catch (Exception e2) { println("Couldn't purge the garbage inside the input buffer"); }
        }
      }
      // If no byte is available, sleep a little to avoid CPU overload 
      else {
        Thread.sleep(THREAD_SLEEP_TIME);
      }
    } 
  }
  catch (Exception e) {
    println("Exception occured when creating the audio input data server : " + e);
  }
}


///////////////////////////////////////////////////////////////////////////////
void processTimeInfoMessage(SignalMessages.TimeInfo timeInfo) {
  println("------------------");
  println("IsPlaying : " + timeInfo.isPlaying);
  println("Tempo : " + timeInfo.tempo);
  println("Position : " + timeInfo.position);
  
}

void processSignalLevelMessage(SignalMessages.SignalLevel signalLevel) {
  //Store the signal information in the correct ring buffer
  //println("SignalID : " + signalLevel.getSignalID() + "   SignalLevel : " + signalLevel.getSignalLevel());
  if (signalLevel.getSignalID() == SIGNAL_ID_KICK)          { audioInputBuffer_Kick.addAndRemoveLast(signalLevel.getSignalLevel()); }
  else if (signalLevel.getSignalID() == SIGNAL_ID_SNARE)    { audioInputBuffer_Snare.addAndRemoveLast(signalLevel.getSignalLevel()); }
  else if (signalLevel.getSignalID() == SIGNAL_ID_CYMBALS)  { audioInputBuffer_Cymbals.addAndRemoveLast(signalLevel.getSignalLevel()); }
  else if (signalLevel.getSignalID() == SIGNAL_ID_BASS)     { audioInputBuffer_Bass.addAndRemoveLast(signalLevel.getSignalLevel()); }
  else if (signalLevel.getSignalID() == SIGNAL_ID_KEYS)     { audioInputBuffer_Keys.addAndRemoveLast(signalLevel.getSignalLevel()); }
  else if (signalLevel.getSignalID() == SIGNAL_ID_GUITAR)   { audioInputBuffer_Guitar.addAndRemoveLast(signalLevel.getSignalLevel()); }
}

void processImpulseMessage(SignalMessages.Impulse impulse) {
  //Raise the correct flag, according to the signal's ID
  if (impulse.getSignalID() == SIGNAL_ID_KICK)             { impulse_Kick = true; }
  else if (impulse.getSignalID() == SIGNAL_ID_SNARE)       { impulse_Snare = true; }
  else if (impulse.getSignalID() == SIGNAL_ID_CYMBALS)     { impulse_Cymbals = true; }
  else if (impulse.getSignalID() == SIGNAL_ID_BASS)        { impulse_Bass = true; }
  else if (impulse.getSignalID() == SIGNAL_ID_KEYS)        { impulse_Keys = true; }
  else if (impulse.getSignalID() == SIGNAL_ID_GUITAR)      { impulse_Guitar = true; }
}


//Called at the end of each draw cycle, to reset the flags
void resetImpulseFlags() {
  impulse_Kick    = false;
  impulse_Snare   = false;
  impulse_Cymbals = false;
  impulse_Bass    = false;
  impulse_Keys    = false;
  impulse_Guitar  = false;  
}



////////////////////////////////////////////////////
//   Ring buffer class to store the signal data   //
////////////////////////////////////////////////////

public class CircularArrayList<E>
        extends AbstractList<E> implements RandomAccess {
  
    private final int n; // buffer length
    private final List<E> buf; // a List implementing RandomAccess
    private int head = 0;
    private int tail = 0;
  
    public CircularArrayList(int capacity) {
        n = capacity + 1;
        buf = new ArrayList<E>(Collections.nCopies(n, (E) null));
    }
  
    public int capacity() {
        return n - 1;
    }
  
    private int wrapIndex(int i) {
        int m = i % n;
        if (m < 0) { // java modulus can be negative
            m += n;
        }
        return m;
    }
  
    // This method is O(n) but will never be called if the
    // CircularArrayList is used in its typical/intended role.
    private void shiftBlock(int startIndex, int endIndex) {
        assert (endIndex > startIndex);
        for (int i = endIndex - 1; i >= startIndex; i--) {
            set(i + 1, get(i));
        }
    }
  
    @Override
    public int size() {
        return tail - head + (tail < head ? n : 0);
    }
  
    @Override
    public E get(int i) {
        if (i < 0 || i >= size()) {
            throw new IndexOutOfBoundsException();
        }
        return buf.get(wrapIndex(head + i));
    }
  
    @Override
    public E set(int i, E e) {
        if (i < 0 || i >= size()) {
            throw new IndexOutOfBoundsException();
        }
        return buf.set(wrapIndex(head + i), e);
    }
  
    @Override
    public void add(int i, E e) {
        int s = size();
        if (s == n - 1) {
            throw new IllegalStateException("Cannot add element."
                    + " CircularArrayList is filled to capacity.");
        }
        if (i < 0 || i > s) {
            throw new IndexOutOfBoundsException();
        }
        tail = wrapIndex(tail + 1);
        if (i < s) {
            shiftBlock(i, s);
        }
        set(i, e);
    }
  
    @Override
    public E remove(int i) {
        int s = size();
        if (i < 0 || i >= s) {
            throw new IndexOutOfBoundsException();
        }
        E e = get(i);
        if (i > 0) {
            shiftBlock(0, i);
        }
        head = wrapIndex(head + 1);
        return e;
    }
    
    public void addAndRemoveLast(E e) {
      if (size() == capacity()) {
        remove(0);
      }
      add(e);
    }
}
