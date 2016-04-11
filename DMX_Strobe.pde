//////////////////////////////////////
//   Fixture management - strobes   //
//////////////////////////////////////

// Important note:
// Due to the project's development history, the strobes are dealt with in a particular way
// A possible future evolution could be to harmonize the behaviour of all devices - this shall be done if enough time is available

//The Atomic strobes have a maximum speed which is way too fast compared to the regular ones
//Harmonize the speeds using the two using this factor
final float ATOMICSTROBE_SPEEDFACTOR = 0.37;


//Specific object for stroboscopes
class DMX_Stroboscope {
  
  int DMXAddress_stroboscopeSpeed;
  int DMXAddress_stroboscopeBrightness;
  int DMXAddress_stroboscopeFlashLength;
  int DMXAddress_stroboscopeSpecialFX;
  int numberOfChannels;
  int currentSpeed           = 0;
  int currentBrightness      = 0;
  int currentFlashLength     = DMXStroboscope_defaultFlashLengthValue;
  int currentSpecialFX       = DMXStroboscope_defaultSpecialFXValue;
  boolean isActive           = false;
  boolean exceptionRaisedDMX = false;
  
  //Classic 2-channel stroboscope (eg. the cheap ones)
  DMX_Stroboscope(int stroboscopeSpeed, int stroboscopeBrightness) {
    this.DMXAddress_stroboscopeSpeed       = stroboscopeSpeed;
    this.DMXAddress_stroboscopeBrightness  = stroboscopeBrightness;
    this.DMXAddress_stroboscopeFlashLength = -1;
    this.DMXAddress_stroboscopeSpecialFX   = -1;
    this.numberOfChannels = 2;
  }
  
  //More complex 4-channel stroboscope (eg. Martin Atomic 3000)
  DMX_Stroboscope(int stroboscopeBrightness, int stroboscopeFlashLength, int stroboscopeSpeed, int stroboscopeSpecialFX ) {
    this.DMXAddress_stroboscopeSpeed       = stroboscopeSpeed;
    this.DMXAddress_stroboscopeBrightness  = stroboscopeBrightness;
    this.DMXAddress_stroboscopeFlashLength = stroboscopeFlashLength;
    this.DMXAddress_stroboscopeSpecialFX   = stroboscopeSpecialFX;
    this.numberOfChannels = 4;
  }
  
  //Used to print the informations regarding this device in the configuration file
  String printStatus() {
    if (this.numberOfChannels == 2) {
      return "Speed:" + this.DMXAddress_stroboscopeSpeed + "|Brightness:" + this.DMXAddress_stroboscopeBrightness;
    }
    else {
      return "Brightness:" + this.DMXAddress_stroboscopeBrightness + "|FlashLength:" + this.DMXAddress_stroboscopeFlashLength + "|Speed:" + this.DMXAddress_stroboscopeSpeed + "|SpecialFX:" + this.DMXAddress_stroboscopeSpecialFX;
    }
  }
  
  // Set all the device's channels to 0
  void stopDMX() {
    //Consider that the strobe is not active anymore
    this.isActive = false;
    this.currentSpeed = 10;      //the default speed is a bit particular : setting it to a non-null value allows to easily make single flashes using the Atomic 3000 strobes
    this.currentBrightness = 0;
        
    if (this.exceptionRaisedDMX == false) {
      try {
        if (this.numberOfChannels == 2) {
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpeed,this.currentSpeed);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeBrightness,this.currentBrightness);
        }
        else if (this.numberOfChannels == 4) {
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpeed,int(this.currentSpeed*ATOMICSTROBE_SPEEDFACTOR));
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeBrightness,this.currentBrightness);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeFlashLength, DMXStroboscope_defaultFlashLengthValue);
          if (this.DMXAddress_stroboscopeSpecialFX != -1) {
            myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpecialFX, DMXStroboscope_defaultSpecialFXValue);
          }
        }
        
      }
      catch (Exception e) {
        outputLog.println("DMX exception : " + e);
        this.exceptionRaisedDMX = true;
      }    
    }
  }
  
  // Specify the individual channels' value, maximum value is 255
  void startDMX(int stroboscopeSpeed, int stroboscopeBrightness) {
    //Consider that the strobe is active
    this.isActive = true;
    this.currentSpeed       = stroboscopeSpeed;
    this.currentBrightness  = stroboscopeBrightness;
    this.currentFlashLength = DMXStroboscope_defaultFlashLengthValue; 
    this.currentSpecialFX   = DMXStroboscope_defaultSpecialFXValue;
        
    if (this.exceptionRaisedDMX == false) {
      
      try {
        if (this.numberOfChannels == 2) { 
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpeed,this.currentSpeed);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeBrightness,this.currentBrightness);
        }
        else if (this.numberOfChannels == 4) {
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpeed,int(this.currentSpeed*ATOMICSTROBE_SPEEDFACTOR));
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeBrightness,this.currentBrightness);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeFlashLength,DMXStroboscope_defaultFlashLengthValue);
          if (this.DMXAddress_stroboscopeSpecialFX != -1) {
            myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpecialFX,DMXStroboscope_defaultSpecialFXValue);
          }
        }
      }
      catch (Exception e) {
        outputLog.println("DMX exception : " + e);
        this.exceptionRaisedDMX = true;
      }
    }
  }
  
  //Alternate function, with additional parameters
  //This function is only used by the Atomic 3000 functions, as such the ATOMICSTROBE_SPEEDFACTOR is not used : the rate is not restrained anymore 
  void startDMX(int stroboscopeSpeed, int stroboscopeBrightness, int stroboscopeFlashLength, int stroboscopeSpecialFX) {
    //Consider that the strobe is active
    this.isActive = true;
    this.currentSpeed       = stroboscopeSpeed;
    this.currentBrightness  = stroboscopeBrightness;
    this.currentFlashLength = stroboscopeFlashLength;
    this.currentSpecialFX   = stroboscopeSpecialFX;

    //Debug
    //println(this.currentSpeed + " - " + this.currentBrightness + " - " + this.currentFlashLength + " - " + this.currentSpecialFX);
      
    if (this.exceptionRaisedDMX == false) {
      try {
        // Additional security : only allow this function for the 4-channel strobes
        if (this.numberOfChannels == 4) {
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpeed,this.currentSpeed);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeBrightness,this.currentBrightness);
          myDMX.setDmxChannel(this.DMXAddress_stroboscopeFlashLength,this.currentFlashLength);
          if (this.DMXAddress_stroboscopeSpecialFX != -1) {
            myDMX.setDmxChannel(this.DMXAddress_stroboscopeSpecialFX,this.currentSpecialFX);
          }
        }
        else {
          outputLog.println("Internal DMX error : Tried calling a complete startDMX for devices other than the 4-channel strobes"); 
        }
      }
      catch (Exception e) {
        outputLog.println("DMX exception : " + e);
        this.exceptionRaisedDMX = true;
      }
    }
  }
}