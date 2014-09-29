
//////////////////////////////////////////////
//   DMX functions - Commands for Teensy2   //
//////////////////////////////////////////////

//Create a DMX object - initialize the serial port for the microcontroller responsible for the DMX equipments
DMX myDMX;

//Create lists of DMX equipments
ArrayList<DMX_Stroboscope> DMXList_FrontStroboscopes;
ArrayList<DMX_Stroboscope> DMXList_BackStroboscopes;
ArrayList<DMX_PAR> DMXList_PARs;

//If an exception is raised when trying to send a DMX command, raise the flag, and do not try anymore for this particular device
boolean exceptionRaisedDMX = false;

//Create a preset table for the DMX stroboscope // {strobo_speed, strobo_brightness}
final int strobelist[][] = { {0,0},
    {25,25},{25,50},{25,75},{25,100},{25,125},{25,150},{25,175},{25,200},{25,225},{25,255},
    {50,25},{50,50},{50,75},{50,100},{50,125},{50,150},{50,175},{50,200},{50,225},{50,255},
    {75,25},{75,50},{75,75},{75,100},{75,125},{75,150},{75,175},{75,200},{75,225},{75,255},
    {100,25},{100,50},{100,75},{100,100},{100,125},{100,150},{100,175},{100,200},{100,225},{100,255},
    {125,25},{125,50},{125,75},{125,100},{125,125},{125,150},{125,175},{125,200},{125,225},{125,255},
    {150,25},{150,50},{150,75},{150,100},{150,125},{150,150},{150,175},{150,200},{150,225},{150,255},
    {175,25},{175,50},{175,75},{175,100},{175,125},{175,150},{175,175},{175,200},{175,225},{175,255},
    {200,25},{200,50},{200,75},{200,100},{200,125},{200,150},{200,175},{200,200},{200,225},{200,255},
    {225,25},{225,50},{225,75},{225,100},{225,125},{225,150},{225,175},{225,200},{225,225},{225,255},
    {255,25},{255,50},{255,75},{255,100},{255,125},{255,150},{255,175},{255,200},{255,225},{255,255},{255,255}};

//For 3 channel stroboscopes, a default flash length shall be used
final int DMXStroboscope_defaultFlashLengthValue = 127;

//General DMX object, serves as en entry point to send actual DMX data over the network
public class DMX{
 
  Serial myPort;
 
  DMX(PApplet myPApplet) {
    if (debug_without_dmx == false) {
      for (int element = 0; element < Serial.list().length; element++){
        if (Serial.list()[element].contains(DMX_MICROCONTROLLER_NAME) == true) {
          this.myPort = new Serial(myPApplet, Serial.list()[element], 9600);      
        }
      }
    }
  }

  // Send command to Teensy2 to update DMX channel
  void setDmxChannel(int channel, int value) throws SerialPortException {
    // Convert the parameters into a message of the form: 123c45w where 123 is the channel and 45 is the value
    // then send to the Arduino
    if (debug_without_dmx == false) 
    {
      if (exceptionRaisedDMX == false) {
        try {
          this.myPort.write( str(channel) + "c" + str(value) + "w" );
        }
        catch (Exception e) {
          throw new SerialPortException("DMX Output error: no serial port found! " + e);
        }
      }
    }
  } 
  
  void setStrobePreset_Front(int preset) {
    for (DMX_Stroboscope stroboscope: DMXList_FrontStroboscopes) {
      stroboscope.startDMX(preset);
    }
  }
  
  void stopStrobe_Front()  {
    for (DMX_Stroboscope stroboscope: DMXList_FrontStroboscopes) {
      stroboscope.stopDMX();
    }
  }
  
  void setStrobePreset_Back(int preset) {
    for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
      stroboscope.startDMX(preset);
    }
  }
  
  void stopStrobe_Back()  {
    for (DMX_Stroboscope stroboscope: DMXList_BackStroboscopes) {
      stroboscope.stopDMX();
    }
  }
}

//Specific object for stroboscopes
class DMX_Stroboscope {
  int DMXAddress_stroboscopeSpeed;
  int DMXAddress_stroboscopeBrightness;
  int DMXAddress_stroboscopeFlashLength;
  int numberOfChannels;
  boolean exceptionRaisedDMX = false;
  
  DMX_Stroboscope(int stroboscopeSpeed, int stroboscopeBrightness) {
    this.DMXAddress_stroboscopeSpeed = stroboscopeSpeed;
    this.DMXAddress_stroboscopeBrightness = stroboscopeBrightness;
    this.DMXAddress_stroboscopeFlashLength = -1;
    this.numberOfChannels = 2;
  }
  
  DMX_Stroboscope(int stroboscopeSpeed, int stroboscopeBrightness, int stroboscopeFlashLength) {
    this.DMXAddress_stroboscopeSpeed = stroboscopeSpeed;
    this.DMXAddress_stroboscopeBrightness = stroboscopeBrightness;
    this.DMXAddress_stroboscopeFlashLength = stroboscopeFlashLength;
    if (stroboscopeFlashLength < 0) {
      this.numberOfChannels = 2;
    }
    else {
      this.numberOfChannels = 3;
    }
  }
  
  //Used to print the informations regarding this device in the configuration file
  String printStatus() {
    if (this.numberOfChannels == 2) {
      return "Speed:" + this.DMXAddress_stroboscopeSpeed + "|Brightness:" + this.DMXAddress_stroboscopeBrightness;
    }
    else {
      return "Speed:" + this.DMXAddress_stroboscopeSpeed + "|Brightness:" + this.DMXAddress_stroboscopeBrightness + "|FlashLength:" + this.DMXAddress_stroboscopeFlashLength;
    }
  }
  
  void startDMX(int preset) {
    if (this.exceptionRaisedDMX == false) {
      try {
        if (this.numberOfChannels == 2) { 
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpeed,strobelist[preset][0]);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeBrightness,strobelist[preset][1]);
        }
        else if (this.numberOfChannels == 3) {
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpeed,strobelist[preset][0]);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeBrightness,strobelist[preset][1]);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeFlashLength,DMXStroboscope_defaultFlashLengthValue);
        }
      }
      catch (Exception e) {
        outputLog.println("DMX exception : " + e);
        this.exceptionRaisedDMX = true;
      }
    }
  }
  
  void stopDMX() {
    if (this.exceptionRaisedDMX == false) {
      try {
        if (this.numberOfChannels == 2) {
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpeed,strobelist[0][0]);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeBrightness,strobelist[0][1]);
        }
        else if (this.numberOfChannels == 3) {
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpeed,strobelist[0][0]);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeBrightness,strobelist[0][1]);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeFlashLength,DMXStroboscope_defaultFlashLengthValue);
        }
      }
      catch (Exception e) {
        outputLog.println(e); 
        this.exceptionRaisedDMX = true;
      }    
    }
  }
}

//Specific object for projectors
class DMX_PAR {
  //TBIL
  String printStatus() {
    return "";
  }
}

void init_defaultDMXDevices() {
  DMXList_FrontStroboscopes = new ArrayList<DMX_Stroboscope>();
  DMXList_BackStroboscopes  = new ArrayList<DMX_Stroboscope>();
  DMXList_PARs              = new ArrayList<DMX_PAR>();
  
  //The default DMX devices consist of a single stroboscope, in 2-channel mode, and with the DMX addresses 1 and 2 for speed and brightness
  DMXList_FrontStroboscopes.add(new DMX_Stroboscope(1, 2));
}

void empty_DMXDevices() {
  DMXList_FrontStroboscopes = new ArrayList<DMX_Stroboscope>();
  DMXList_BackStroboscopes  = new ArrayList<DMX_Stroboscope>();
  DMXList_PARs              = new ArrayList<DMX_PAR>();
}
