
////////////////////////////////////////////////////////////////////////////////////////////////
// Protocol Buffer parser - deserialize the data sent by the SignalProcessor plugin instances //
////////////////////////////////////////////////////////////////////////////////////////////////

import java.net.*;
import java.io.*;
import com.google.protobuf.*;


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

//Containers to hold the FFT values
SignalFFT signalFFT_Kick;
SignalFFT signalFFT_Snare;
SignalFFT signalFFT_Cymbals;
SignalFFT signalFFT_Bass;
SignalFFT signalFFT_Keys;
SignalFFT signalFFT_Guitar;

//Flags triggered when an impulse is received. These are to be set back to false each cycle so that no old data will be processed
boolean impulse_Kick    = false;
boolean impulse_Snare   = false;
boolean impulse_Cymbals = false;
boolean impulse_Bass    = false;
boolean impulse_Keys    = false;
boolean impulse_Guitar  = false;
long previousImpulseTimestamp_Kick    = System.nanoTime();
long previousImpulseTimestamp_Snare   = System.nanoTime();
long previousImpulseTimestamp_Cymbals = System.nanoTime();
long previousImpulseTimestamp_Bass    = System.nanoTime();
long previousImpulseTimestamp_Keys    = System.nanoTime();
long previousImpulseTimestamp_Guitar  = System.nanoTime();
long OUTDATED_IMPULSE_AGE = 250*1000*1000;      //Consider that after OUTDATED_IMPULSE_AGE ns, the previous impulse is outdated, and should be invalidated

// Port number must be greater than 1000
int audioDataPortNumber = 7001;
int impulsePortNumber   = 7002;
int timeInfoPortNumber  = 7003;
int fftPortNumber       = 7004;
DatagramSocket AudioDataServer = null;
DatagramSocket ImpulseServer   = null;
DatagramSocket TimeInfoServer  = null;
DatagramSocket FFTServer       = null;
 
final int timeInfoMessageSize    = 12;
final int signalLevelMessageSize = 7;
final int impulseMessageSize     = 2;
final int fftMessageSize         = 67;
final int THREAD_SLEEP_TIME      = 5;    //5 ms (for reference, 50 fps means a 20ms period)
//Audio buffer size, big enough to have one value for each LED pixel (= 4 pixels in Processing)
//Important note : the number of panels is hard coded, so that even when using 3 panels, the buffer is the same
//This is important, as the thresholds set in the Auto mode depend on this value
final int AUDIO_BUFFER_SIZE      = max(PANEL_RESOLUTION_X*5, PANEL_RESOLUTION_Y);

// These thresholds are used to determine the intensity of the incoming sources
// The different thresholds between the sources are due to the natural waveforms of the sounds
// A bass's RMS value will always be higher than that of a snare which is only hit on beats 2 and 4
final float INTENSITY_THRESHOLD_KICK    = 0.003 * AUDIO_BUFFER_SIZE;    //About equal to 0.12 with an audio buffer size equal to 40
final float INTENSITY_THRESHOLD_SNARE   = 0.001 * AUDIO_BUFFER_SIZE;    //About equal to 0.04
final float INTENSITY_THRESHOLD_CYMBALS = 0.002 * AUDIO_BUFFER_SIZE;    //About equal to 0.08
final float INTENSITY_THRESHOLD_BASS    = 0.010 * AUDIO_BUFFER_SIZE;    //About equal to 0.40
final float INTENSITY_THRESHOLD_KEYS    = 0.010 * AUDIO_BUFFER_SIZE;    //About equal to 0.40
final float INTENSITY_THRESHOLD_GUITAR  = 0.010 * AUDIO_BUFFER_SIZE;    //About equal to 0.40

void initializeCircularBuffers() {
  // Initialize the ring buffers used to store the incoming signal data
  // Set the size of these buffers to be equal to the largest value between the screen width and the screen height
  
  audioInputBuffer_Kick    = new CircularArrayList<Float>(AUDIO_BUFFER_SIZE);
  audioInputBuffer_Snare   = new CircularArrayList<Float>(AUDIO_BUFFER_SIZE);
  audioInputBuffer_Cymbals = new CircularArrayList<Float>(AUDIO_BUFFER_SIZE);
  audioInputBuffer_Bass    = new CircularArrayList<Float>(AUDIO_BUFFER_SIZE);
  audioInputBuffer_Keys    = new CircularArrayList<Float>(AUDIO_BUFFER_SIZE);
  audioInputBuffer_Guitar  = new CircularArrayList<Float>(AUDIO_BUFFER_SIZE);
  
  // Initialize all the buffers with 0s
  for (int i = 0; i<AUDIO_BUFFER_SIZE; i++) {
    audioInputBuffer_Kick.addAndRemoveLast(0f);
    audioInputBuffer_Snare.addAndRemoveLast(0f);
    audioInputBuffer_Cymbals.addAndRemoveLast(0f);
    audioInputBuffer_Bass.addAndRemoveLast(0f);
    audioInputBuffer_Keys.addAndRemoveLast(0f);
    audioInputBuffer_Guitar.addAndRemoveLast(0f);
  }

}

void initializeSignalFFTBuffers() {
  signalFFT_Kick    = new SignalFFT(SIGNAL_ID_KICK);
  signalFFT_Snare   = new SignalFFT(SIGNAL_ID_SNARE);
  signalFFT_Cymbals = new SignalFFT(SIGNAL_ID_CYMBALS);
  signalFFT_Bass    = new SignalFFT(SIGNAL_ID_BASS);
  signalFFT_Keys    = new SignalFFT(SIGNAL_ID_KEYS);
  signalFFT_Guitar  = new SignalFFT(SIGNAL_ID_GUITAR);
}

/////////////////////////////////////////////////////////////////////////


void startAudioSignalMonitoringThread() {
  // Create the Java servers which will listen to the different SignalProcessor plugin instances

  thread("createAudioDataServer");
  thread("createImpulseServer");
  thread("createTimeInfoServer");
  thread("createFFTServer");

}

///////////////////////////////////////////////////////////////////////////


void createAudioDataServer() {
  try {
    outputLog.println("Audio Data server initialization");
    AudioDataServer = new DatagramSocket(audioDataPortNumber);
    
    //Specify a timeout for the receive, in order to avoid useless CPU usage
    AudioDataServer.setSoTimeout(THREAD_SLEEP_TIME);
     
    //buffer to receive incoming data
    byte[] bufferAudioData = new byte[signalLevelMessageSize];
    DatagramPacket incomingAudioData = new DatagramPacket(bufferAudioData, bufferAudioData.length);

    while(true)
    {
      try {
        AudioDataServer.receive(incomingAudioData);
        processSignalLevelMessage(SignalMessages.SignalLevel.parseFrom(incomingAudioData.getData()));
      }
      catch (Exception e) {}
    }
  }
  catch (Exception e) {
    outputLog.println("Audio Data server error : " + e);
  }
}


void createImpulseServer() {
  try {
    outputLog.println("Impulse server initialization");
    ImpulseServer = new DatagramSocket(impulsePortNumber);
    
    //Specify a timeout for the receive, in order to avoid useless CPU usage
    ImpulseServer.setSoTimeout(THREAD_SLEEP_TIME);
     
    //buffer to receive incoming data
    byte[] bufferImpulse = new byte[impulseMessageSize];
    DatagramPacket incomingImpulse = new DatagramPacket(bufferImpulse, bufferImpulse.length);

    while(true)
    {
      try {
        ImpulseServer.receive(incomingImpulse);
        processImpulseMessage(SignalMessages.Impulse.parseFrom(incomingImpulse.getData()));
      }
      catch (Exception e) {}
    }
  }
  catch (Exception e) {
    outputLog.println("Audio impulse server error : " + e);
  }
}


void createTimeInfoServer() {
  try {
    outputLog.println("TimeInfo server initialization");
    TimeInfoServer = new DatagramSocket(timeInfoPortNumber);
    
    //Specify a timeout for the receive, in order to avoid useless CPU usage
    TimeInfoServer.setSoTimeout(THREAD_SLEEP_TIME);
     
    //buffer to receive incoming data
    byte[] bufferTimeInfo = new byte[timeInfoMessageSize];
    DatagramPacket incomingTimeInfo = new DatagramPacket(bufferTimeInfo, bufferTimeInfo.length);

    while(true)
    {
      try {
        TimeInfoServer.receive(incomingTimeInfo);
        processTimeInfoMessage(SignalMessages.TimeInfo.parseFrom(incomingTimeInfo.getData()));
      }
      catch (Exception e) {}
    }
  }
  catch (Exception e) {
    outputLog.println("Time info server error : " + e);
  }
}

void createFFTServer() {
  try {
    outputLog.println("FFT server initialization");
    FFTServer = new DatagramSocket(fftPortNumber);
    
    //Specify a timeout for the receive, in order to avoid useless CPU usage
    FFTServer.setSoTimeout(THREAD_SLEEP_TIME);
     
    //buffer to receive incoming data
    byte[] bufferFFT = new byte[fftMessageSize];
    DatagramPacket incomingFFT = new DatagramPacket(bufferFFT, bufferFFT.length);

    while(true)
    {
      try {
        FFTServer.receive(incomingFFT);
        processFFTMessage(SignalMessages.LogFFT.parseFrom(incomingFFT.getData()));
      }
      catch (Exception e) {}
    }
  }
  catch (Exception e) {
    outputLog.println("FFT server error : " + e);
  }
}


///////////////////////////////////////////////////////////////////////////////
void processTimeInfoMessage(SignalMessages.TimeInfo timeInfo) {
  automaticSequencer.isPlaying = timeInfo.getIsPlaying();
  automaticSequencer.currentBPM = timeInfo.getTempo();
  automaticSequencer.currentPosition = timeInfo.getPosition();
}

void processSignalLevelMessage(SignalMessages.SignalLevel signalLevel) {
  //Store the signal information in the correct ring buffer
  if (signalLevel.getSignalID() == SIGNAL_ID_KICK)          { audioInputBuffer_Kick.addAndRemoveLast(signalLevel.getSignalLevel()); }
  else if (signalLevel.getSignalID() == SIGNAL_ID_SNARE)    { audioInputBuffer_Snare.addAndRemoveLast(signalLevel.getSignalLevel()); }
  else if (signalLevel.getSignalID() == SIGNAL_ID_CYMBALS)  { audioInputBuffer_Cymbals.addAndRemoveLast(signalLevel.getSignalLevel()); }
  else if (signalLevel.getSignalID() == SIGNAL_ID_BASS)     { audioInputBuffer_Bass.addAndRemoveLast(signalLevel.getSignalLevel()); }
  else if (signalLevel.getSignalID() == SIGNAL_ID_KEYS)     { audioInputBuffer_Keys.addAndRemoveLast(signalLevel.getSignalLevel()); }
  else if (signalLevel.getSignalID() == SIGNAL_ID_GUITAR)   { audioInputBuffer_Guitar.addAndRemoveLast(signalLevel.getSignalLevel()); }
}

void processImpulseMessage(SignalMessages.Impulse impulse) {
  //Raise the correct flag, according to the signal's ID
  if (impulse.getSignalID() == SIGNAL_ID_KICK)             { impulse_Kick    = true; previousImpulseTimestamp_Kick    = System.nanoTime();}
  else if (impulse.getSignalID() == SIGNAL_ID_SNARE)       { impulse_Snare   = true; previousImpulseTimestamp_Snare   = System.nanoTime();}
  else if (impulse.getSignalID() == SIGNAL_ID_CYMBALS)     { impulse_Cymbals = true; previousImpulseTimestamp_Cymbals = System.nanoTime();}
  else if (impulse.getSignalID() == SIGNAL_ID_BASS)        { impulse_Bass    = true; previousImpulseTimestamp_Bass    = System.nanoTime();}
  else if (impulse.getSignalID() == SIGNAL_ID_KEYS)        { impulse_Keys    = true; previousImpulseTimestamp_Keys    = System.nanoTime();}
  else if (impulse.getSignalID() == SIGNAL_ID_GUITAR)      { impulse_Guitar  = true; previousImpulseTimestamp_Guitar  = System.nanoTime();}
}

void processFFTMessage(SignalMessages.LogFFT fft) {
  //Put the FFT's data in the correct buffers, according to the signal's ID
  if (fft.getSignalID() == SIGNAL_ID_KICK)             { signalFFT_Kick.setFFTBandValues(fft.getFundamentalFreq(), fft.getBand1(), fft.getBand2(), fft.getBand3(), fft.getBand4(), fft.getBand5(), fft.getBand6(), fft.getBand7(), fft.getBand8(), fft.getBand9(), fft.getBand10(), fft.getBand11(), fft.getBand12()); }
  else if (fft.getSignalID() == SIGNAL_ID_SNARE)       { signalFFT_Snare.setFFTBandValues(fft.getFundamentalFreq(), fft.getBand1(), fft.getBand2(), fft.getBand3(), fft.getBand4(), fft.getBand5(), fft.getBand6(), fft.getBand7(), fft.getBand8(), fft.getBand9(), fft.getBand10(), fft.getBand11(), fft.getBand12()); }
  else if (fft.getSignalID() == SIGNAL_ID_CYMBALS)     { signalFFT_Cymbals.setFFTBandValues(fft.getFundamentalFreq(), fft.getBand1(), fft.getBand2(), fft.getBand3(), fft.getBand4(), fft.getBand5(), fft.getBand6(), fft.getBand7(), fft.getBand8(), fft.getBand9(), fft.getBand10(), fft.getBand11(), fft.getBand12()); }
  else if (fft.getSignalID() == SIGNAL_ID_BASS)        { signalFFT_Bass.setFFTBandValues(fft.getFundamentalFreq(), fft.getBand1(), fft.getBand2(), fft.getBand3(), fft.getBand4(), fft.getBand5(), fft.getBand6(), fft.getBand7(), fft.getBand8(), fft.getBand9(), fft.getBand10(), fft.getBand11(), fft.getBand12()); }
  else if (fft.getSignalID() == SIGNAL_ID_KEYS)        { signalFFT_Keys.setFFTBandValues(fft.getFundamentalFreq(), fft.getBand1(), fft.getBand2(), fft.getBand3(), fft.getBand4(), fft.getBand5(), fft.getBand6(), fft.getBand7(), fft.getBand8(), fft.getBand9(), fft.getBand10(), fft.getBand11(), fft.getBand12()); }
  else if (fft.getSignalID() == SIGNAL_ID_GUITAR)      { signalFFT_Guitar.setFFTBandValues(fft.getFundamentalFreq(), fft.getBand1(), fft.getBand2(), fft.getBand3(), fft.getBand4(), fft.getBand5(), fft.getBand6(), fft.getBand7(), fft.getBand8(), fft.getBand9(), fft.getBand10(), fft.getBand11(), fft.getBand12()); }
}

// May be called by audio-responsive animations, invalidate old impulses
void invalidateOutdatedImpulseFlags() {
  if (System.nanoTime() - previousImpulseTimestamp_Kick    > OUTDATED_IMPULSE_AGE) {impulse_Kick    = false;}
  if (System.nanoTime() - previousImpulseTimestamp_Snare   > OUTDATED_IMPULSE_AGE) {impulse_Snare   = false;}
  if (System.nanoTime() - previousImpulseTimestamp_Cymbals > OUTDATED_IMPULSE_AGE) {impulse_Cymbals = false;}
  if (System.nanoTime() - previousImpulseTimestamp_Bass    > OUTDATED_IMPULSE_AGE) {impulse_Bass    = false;}
  if (System.nanoTime() - previousImpulseTimestamp_Keys    > OUTDATED_IMPULSE_AGE) {impulse_Keys    = false;}
  if (System.nanoTime() - previousImpulseTimestamp_Guitar  > OUTDATED_IMPULSE_AGE) {impulse_Guitar  = false;}
}

// May be called by audio-responsive animations (ie at the end of each cycle), reset all the flags
void resetImpulseFlags() {
  impulse_Kick    = false;
  impulse_Snare   = false;
  impulse_Cymbals = false;
  impulse_Bass    = false;
  impulse_Keys    = false;
  impulse_Guitar  = false;  
}


////////////////////////////////////////////////////
//   SignalFFT class to hold the signals' freqs   //
////////////////////////////////////////////////////

public class SignalFFT {
  int signalID;
  float mainFreq;          //Frequency of the first harmonic in Hz
  float band1;             //Energy in the 0 to 11 Hz band
  float band2;             //Energy in the 11 to 22 Hz band
  float band3;             //Energy in the 22 to 43 Hz band
  float band4;             //Energy in the 43 to 86 Hz band
  float band5;             //Energy in the 86 to 172 Hz band
  float band6;             //Energy in the 172 to 344 Hz band
  float band7;             //Energy in the 344 to 689 Hz band
  float band8;             //Energy in the 689 to 1378 Hz band
  float band9;             //Energy in the 1378 to 2756 Hz band
  float band10;            //Energy in the 2756 to 5512 Hz band
  float band11;            //Energy in the 5512 to 11025 Hz band
  float band12;            //Energy in the 11025 to 22050 Hz band
  
  SignalFFT(int _signalID) {
    signalID = _signalID;
    mainFreq = 0.0;
    band1  = 0.0;
    band2  = 0.0;
    band3  = 0.0;
    band4  = 0.0;
    band5  = 0.0;
    band6  = 0.0;
    band7  = 0.0;
    band8  = 0.0;
    band9  = 0.0;
    band10 = 0.0;
    band11 = 0.0;
    band12 = 0.0;
  }
  
  void setFFTBandValues(float freq, float val1, float val2, float val3, float val4, float val5, float val6, float val7, float val8, float val9, float val10, float val11, float val12) {
    mainFreq = freq;
    band1  = val1;
    band2  = val2;
    band3  = val3;
    band4  = val4;
    band5  = val5;
    band6  = val6;
    band7  = val7;
    band8  = val8;
    band9  = val9;
    band10 = val10;
    band11 = val11;
    band12 = val12;
  }
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
