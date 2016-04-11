
///////////////////////////////
//   DMX generic functions   //
///////////////////////////////

// Important note:
// Due to the project's development history, the strobes are dealt with in a particular way
// A possible future evolution could be to harmonize the behaviour of all devices - this shall be done if enough time is available



//Create a DMX object - initialize the serial port for the microcontroller responsible for the DMX equipments
DMX myDMX;

//Create lists of DMX equipments
ArrayList<DMX_Stroboscope> DMXList_FrontLeftStroboscopes;
ArrayList<DMX_Stroboscope> DMXList_FrontRightStroboscopes;
ArrayList<DMX_Stroboscope> DMXList_BackStroboscopes;

//If an exception is raised when trying to send a DMX command, raise the flag, and do not try anymore for this particular device
boolean exceptionRaisedDMX = false;

//For 4 channel stroboscopes, default values for the special channels
final int DMXStroboscope_defaultFlashLengthValue = 50;
final int DMXStroboscope_defaultSpecialFXValue   = 0;      // No effect  

//General DMX object, serves as en entry point to send actual DMX data over the network
public class DMX {
 
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
}

void init_defaultDMXDevices() {
  DMXList_FrontLeftStroboscopes  = new ArrayList<DMX_Stroboscope>();
  DMXList_FrontRightStroboscopes = new ArrayList<DMX_Stroboscope>();
  DMXList_BackStroboscopes       = new ArrayList<DMX_Stroboscope>();
  
  //The default DMX devices consist of two small stroboscopes on the left and on the right, and one big in the middle
  DMXList_BackStroboscopes.add(new DMX_Stroboscope(5,6,7,8));
  DMXList_FrontLeftStroboscopes.add(new DMX_Stroboscope(1, 2));
  DMXList_FrontRightStroboscopes.add(new DMX_Stroboscope(3, 4));
  
  try {
    DMX_MovingHead testMovingHead = new DMX_MovingHead("Robe Pointe (24 channels)");
  }
  catch (UndefinedFixtureException e) {
    println("dommage");
  }
}

void empty_DMXDevices() {
  DMXList_FrontLeftStroboscopes  = new ArrayList<DMX_Stroboscope>();
  DMXList_FrontRightStroboscopes = new ArrayList<DMX_Stroboscope>();
  DMXList_BackStroboscopes       = new ArrayList<DMX_Stroboscope>();
}

