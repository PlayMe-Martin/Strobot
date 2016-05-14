
///////////////////////////////
//   DMX generic functions   //
///////////////////////////////

// Important note:
// Due to the project's development history, the strobes are dealt with in a particular way
// A possible future evolution could be to harmonize the behaviour of all devices - this shall be done if enough time is available



//Create a DMX object - initialize the serial port for the microcontroller responsible for the DMX equipments
DMX myDMX;

//Create lists of DMX equipments corresponding to "families"
ArrayList<DMX_Stroboscope> DMXList_FrontLeftStroboscopes;
ArrayList<DMX_Stroboscope> DMXList_FrontRightStroboscopes;
ArrayList<DMX_Stroboscope> DMXList_BackStroboscopes;
ArrayList<DMX_MovingHead>  DMXList_MovingHeads;

//Create sublists of the registered devices
ArrayList<DMX_MovingHead>  DMXList_MovingHeads_side;
ArrayList<DMX_MovingHead>  DMXList_MovingHeads_center;
ArrayList<DMX_MovingHead>  DMXList_MovingHeads_right;
ArrayList<DMX_MovingHead>  DMXList_MovingHeads_left;

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

  dmxInit_registerDefaultStrobes();
  dmxInit_registerDefaultMovingHeads();

}

void empty_DMXDevices() {
  DMXList_FrontLeftStroboscopes  = new ArrayList<DMX_Stroboscope>();
  DMXList_FrontRightStroboscopes = new ArrayList<DMX_Stroboscope>();
  DMXList_BackStroboscopes       = new ArrayList<DMX_Stroboscope>();
}

boolean checkDmxAddressMapping(int startAddr, int nbChNewFixture) {
  //TBIL - check that no fixture conflicts with another
  return true;
}


void dmxInit_registerDefaultStrobes() {
  DMXList_FrontLeftStroboscopes  = new ArrayList<DMX_Stroboscope>();
  DMXList_FrontRightStroboscopes = new ArrayList<DMX_Stroboscope>();
  DMXList_BackStroboscopes       = new ArrayList<DMX_Stroboscope>();
  DMXList_MovingHeads            = new ArrayList<DMX_MovingHead>();

  //The default DMX devices consist of two small stroboscopes on the left and on the right, and one big in the middle
  DMXList_BackStroboscopes.add(new DMX_Stroboscope(5,6,7,8));
  DMXList_FrontLeftStroboscopes.add(new DMX_Stroboscope(1, 2));
  DMXList_FrontRightStroboscopes.add(new DMX_Stroboscope(3, 4));
}

void dmxInit_registerDefaultMovingHeads() {
  DMXList_MovingHeads            = new ArrayList<DMX_MovingHead>();

  // New style fixtures
  try {
    DMXList_MovingHeads.add(new DMX_MovingHead("Robe Pointe (24 channels)", 0, 10 + 0*24));
    DMXList_MovingHeads.add(new DMX_MovingHead("Robe Pointe (24 channels)", 1, 10 + 1*24));
    DMXList_MovingHeads.add(new DMX_MovingHead("Robe Pointe (24 channels)", 2, 10 + 2*24));
    DMXList_MovingHeads.add(new DMX_MovingHead("Robe Pointe (24 channels)", 3, 10 + 3*24));
    // DMXList_MovingHeads.add(new DMX_MovingHead("Robe Pointe (24 channels)", 4, 10 + 4*24));
    // DMXList_MovingHeads.add(new DMX_MovingHead("Robe Pointe (24 channels)", 5, 10 + 5*24));
    // DMXList_MovingHeads.add(new DMX_MovingHead("Robe Pointe (24 channels)", 6, 10 + 6*24));
    // DMXList_MovingHeads.add(new DMX_MovingHead("Robe Pointe (24 channels)", 7, 10 + 7*24));
    // DMXList_MovingHeads.add(new DMX_MovingHead("Robe Pointe (24 channels)", 8, 10 + 7*24));
    // DMXList_MovingHeads.add(new DMX_MovingHead("Robe Pointe (24 channels)", 9, 10 + 7*24));
    
  }
  catch (UndefinedFixtureException e) {
    println("Undefined Fixture");
  }

  // Now build the center/side/right/left sublists
  dmx_buildFixtureSublists_movingHead();
}

void dmx_buildFixtureSublists_movingHead() {
  //Initialize the sublists
  DMXList_MovingHeads_side       = new ArrayList<DMX_MovingHead>();
  DMXList_MovingHeads_center     = new ArrayList<DMX_MovingHead>();
  DMXList_MovingHeads_right      = new ArrayList<DMX_MovingHead>();
  DMXList_MovingHeads_left       = new ArrayList<DMX_MovingHead>();

  int nbMovingHeads = DMXList_MovingHeads.size();
  
  // Consider that about one third of the fixtures go in the "center" group
  float centerRatio = 1.0/3.0;

  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    if (nbMovingHeads%2 == 1) {
      // Left / Right fixtures
      if (movingHead.getDeviceID() < (nbMovingHeads-1)/2) {
        DMXList_MovingHeads_left.add(movingHead);
      }
      else if (movingHead.getDeviceID() > (nbMovingHeads-1)/2) {
        DMXList_MovingHeads_right.add(movingHead);
      }
      
      // Side / Center fixtures
      int nbCenterMovingHeads = ceil(nbMovingHeads*centerRatio) + ( (ceil(nbMovingHeads*centerRatio) + 1) % 2);
      if (movingHead.getDeviceID() < (nbMovingHeads-nbCenterMovingHeads)/2 || movingHead.getDeviceID() >= (nbMovingHeads-nbCenterMovingHeads)/2 + nbCenterMovingHeads) {
        DMXList_MovingHeads_side.add(movingHead);
      }
      else {
        DMXList_MovingHeads_center.add(movingHead);
      }

    }
    else {
      // Left / Right fixtures
      if (movingHead.getDeviceID() <= (nbMovingHeads-1)/2) {
        DMXList_MovingHeads_left.add(movingHead);
      }
      else {
        DMXList_MovingHeads_right.add(movingHead);
      }

      // Side / Center fixtures
      int nbCenterMovingHeads = ceil(nbMovingHeads*centerRatio) + ( (ceil(nbMovingHeads*centerRatio) + 1) % 2);
      if (movingHead.getDeviceID() <= (nbMovingHeads-nbCenterMovingHeads)/2 || movingHead.getDeviceID() >= (nbMovingHeads-nbCenterMovingHeads)/2 + nbCenterMovingHeads) {
        DMXList_MovingHeads_side.add(movingHead);
      }
      else {
        DMXList_MovingHeads_center.add(movingHead);
      }
    }
  }

  // Special case: if not enough moving heads are declared, the side list might be empty (ex: 2 fixtures -> "2 center fixtures"). In this case, consider the side and the center lists to be equal
  if (DMXList_MovingHeads_side.size() == 0) {
    DMXList_MovingHeads_side = DMXList_MovingHeads_center;
  }
  if (DMXList_MovingHeads_center.size() == 0) {
    DMXList_MovingHeads_center = DMXList_MovingHeads_side;
  }
  if (DMXList_MovingHeads.size() == 1) {
    DMXList_MovingHeads_left  = DMXList_MovingHeads;
    DMXList_MovingHeads_right = DMXList_MovingHeads;
  }

  for (DMX_MovingHead movingHead: DMXList_MovingHeads_side) {
    println("DMXList_MovingHeads_side - " + movingHead.getDeviceID());
  }
  for (DMX_MovingHead movingHead: DMXList_MovingHeads_center) {
    println("DMXList_MovingHeads_center - " + movingHead.getDeviceID());
  }
  for (DMX_MovingHead movingHead: DMXList_MovingHeads_right) {
    println("DMXList_MovingHeads_right - " + movingHead.getDeviceID());
  }
  for (DMX_MovingHead movingHead: DMXList_MovingHeads_left) {
    println("DMXList_MovingHeads_left - " + movingHead.getDeviceID());
  }

}