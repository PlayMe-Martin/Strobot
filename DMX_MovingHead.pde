///////////////////////////////////////////
//   Fixture management - moving heads   //
///////////////////////////////////////////

final String DMX_MOVINGHEAD_DIMMER                = "DIMMER";
final String DMX_MOVINGHEAD_PAN                   = "PAN";
final String DMX_MOVINGHEAD_TILT                  = "TILT";
final String DMX_MOVINGHEAD_COLOR                 = "COLOR";
final String DMX_MOVINGHEAD_SPEED                 = "SPEED";
final String DMX_MOVINGHEAD_SPEEDMODE             = "SPEEDMODE";
final String DMX_MOVINGHEAD_SHUTTER               = "SHUTTER";
final String DMX_MOVINGHEAD_APERTURE              = "APERTURE";
final String DMX_MOVINGHEAD_GOBO                  = "GOBO";


final int    DMX_COLORMODE_UNDEFINED              = 0;
final int    DMX_COLORMODE_WHEEL                  = 1;
final String DMX_COLORMODE_WHEEL_TEXT             = "WHEEL";
final int    DMX_COLORMODE_RGB                    = 2;
final String DMX_COLORMODE_RGB_TEXT               = "RGB";
final int    DMX_COLORMODE_CMY                    = 3;
final String DMX_COLORMODE_CMY_TEXT               = "CMY";
final int    DMX_COLORMODE_RGBW                   = 4;
final String DMX_COLORMODE_RGBW_TEXT              = "RGBW";

final String DMX_COLORMODE_RGB_R                  = "R";
final String DMX_COLORMODE_RGB_G                  = "G";
final String DMX_COLORMODE_RGB_B                  = "B";
final String DMX_COLORMODE_RGB_W                  = "W";
final String DMX_COLORMODE_CMY_C                  = "C";
final String DMX_COLORMODE_CMY_M                  = "M";
final String DMX_COLORMODE_CMY_Y                  = "Y";

final String DMX_COLORWHEEL_WHITE_TEXT            = "WHITE";
final String DMX_COLORWHEEL_RED_TEXT              = "RED";
final String DMX_COLORWHEEL_DEEP_RED_TEXT         = "DEEP_RED";
final String DMX_COLORWHEEL_BLUE_TEXT             = "BLUE";
final String DMX_COLORWHEEL_DEEP_BLUE_TEXT        = "DEEP_BLUE";
final String DMX_COLORWHEEL_YELLOW_TEXT           = "YELLOW";
final String DMX_COLORWHEEL_GREEN_TEXT            = "GREEN";
final String DMX_COLORWHEEL_ULTRAVIOLET_TEXT      = "ULTRAVIOLET";
final String DMX_COLORWHEEL_ORANGE_TEXT           = "ORANGE";
final String DMX_COLORWHEEL_CTO_TEXT              = "CTO";
final int    DMX_COLORWHEEL_WHITE                 = 0;
final int    DMX_COLORWHEEL_RED                   = 1;
final int    DMX_COLORWHEEL_DEEP_RED              = 2;
final int    DMX_COLORWHEEL_BLUE                  = 3;
final int    DMX_COLORWHEEL_DEEP_BLUE             = 4;
final int    DMX_COLORWHEEL_YELLOW                = 5;
final int    DMX_COLORWHEEL_GREEN                 = 6;
final int    DMX_COLORWHEEL_ULTRAVIOLET           = 7;
final int    DMX_COLORWHEEL_ORANGE                = 8;
final int    DMX_COLORWHEEL_CTO                   = 9;

final int    DMX_SPEEDMODE_DEFAULT                = 0;
final int    DMX_SPEEDMODE_MAX                    = 1;
final int    DMX_SPEEDMODE_PROGRESSIVE            = 2;
final int    DMX_SPEEDMODE_FIXED                  = 3;
final String DMX_SPEEDMODE_DEFAULT_TEXT           = "STANDARD";
final String DMX_SPEEDMODE_MAX_TEXT               = "MAX_SPEED";
final String DMX_SPEEDMODE_PROGRESSIVE_TEXT       = "SPEED";

final String DMX_SHUTTER_OPEN                     = "OPEN";
final String DMX_SHUTTER_CLOSED                   = "CLOSED";
final String DMX_SHUTTER_STROBE                   = "STROBE";
final int    DMX_SHUTTERMODE_DEFAULT              = 0;
final int    DMX_SHUTTERMODE_STROBE               = 1;

final int    DMX_APERTUREMODE_DEFAULT             = 0;          // Default Aperture control means no aperture control !
final String DMX_APERTUREMODE_DEFAULT_TEXT        = "DEFAULT";
final int    DMX_APERTUREMODE_PROGRESSIVE         = 1;
final String DMX_APERTUREMODE_PROGRESSIVE_TEXT    = "APERTURE";
final int    DMX_APERTUREMODE_STEP                = 2;
final String DMX_APERTUREMODE_STEP_TEXT           = "APERTURE_STEP";  // ChannelSet defined either in an aperture, or a gobo channel. Combined with an int suffix, aperture size (the larger the int, the smaller the aperture)

final int    DMX_DEFAULT_FALLBACK_VAL             = 0;          // Default value used at initialisation, and in case of error

final int    DMX_DEFAULT_PAN_TOTALRANGE           = 540;
final int    DMX_DEFAULT_TILT_TOTALRANGE          = 540;

// Constants used for the animations
final int    DMXANIM_BLACKOUT                     = 0;
final int    DMXANIM_CONTINUOUS_LIGHT             = 1;
final int    DMXANIM_SINGLE_LONG_FLASH            = 2;
final int    DMXANIM_SINGLE_SHORT_FLASH           = 3;
final int    DMXANIM_SLOW_CRESCENDO               = 4;
final int    DMXANIM_FAST_CRESCENDO               = 5;
final int    DMXANIM_SLOW_STROBE                  = 6;
final int    DMXANIM_MEDIUM_STROBE                = 7;
final int    DMXANIM_FAST_STROBE                  = 8;
final int    DMXANIM_SLOW_SINE_WAVE               = 9;
final int    DMXANIM_FAST_SINE_WAVE               = 10;
final int    DMXANIM_RANDOM_GLITCH                = 11;
final int    DMXANIM_MIN_APERTURE_BEAM            = 12;

class DMX_MovingHead {

  Fixture movingHead;                                 // The fixture defining this object
  int deviceID;                                       // Device ID: defined at device instanciation, 0 for the fixtures located on house left, n for the fixtures on house right
  int dmxStartAddr;                                   // Address of the first channel

  int nbChannels                           = 0;
  int[] dmxVal;                                       // Array which shall contain all the instant DMX values for all of this fixture's channels

  // Config parameters - depending on these values, the library functions will behave differently
  int chIndex_dimmer                       = -1;
  int chIndex_dimmerFine                   = -1;
  boolean fineDimmerControl                = false;
  int dimmer_minVal                        = -1;
  int dimmer_maxVal                        = -1;

  int chIndex_pan                          = -1;
  int chIndex_panFine                      = -1;
  boolean finePanControl                   = false;
  int pan_minVal                           = -1;
  int pan_maxVal                           = -1;

  int chIndex_tilt                         = -1;
  int chIndex_tiltFine                     = -1;
  boolean fineTiltControl                  = false;
  int tilt_minVal                          = -1;
  int tilt_maxVal                          = -1;
  
  
  IntList available_chIndex_color;
  int colorControlMode                     = DMX_COLORMODE_UNDEFINED;
  int chIndex_color_WHEEL                  = -1;
  int chIndex_color_CMY_C                  = -1;      // Shall be defined only if used
  int chIndex_color_CMY_M                  = -1;      // Shall be defined only if used
  int chIndex_color_CMY_Y                  = -1;      // Shall be defined only if used
  int chIndex_color_RGB_R                  = -1;      // Shall be defined only if used
  int chIndex_color_RGB_G                  = -1;      // Shall be defined only if used
  int chIndex_color_RGB_B                  = -1;      // Shall be defined only if used
  int chIndex_color_RGB_W                  = -1;      // Shall be defined only if used
    

  int speedMode                            = DMX_SPEEDMODE_DEFAULT;    
  int chIndex_speedMode                    = -1;
  int chIndex_speedSet                     = -1;   // May be equal to chIndex_speedMode (in most cases)
  int speedMode_standardSpeed_val          = -1;   // Set speedSet channel to this value to shift to the default speed
  int speedMode_maxSpeed_val               = -1;   // Set speedSet channel to this value to shift to the maximum speed
  int speedMode_fine_range_max             = -1;   // Set speedSet channel to a value between the max/min range to set a smooth speed
  int speedMode_fine_range_min             = -1;

  int shutterMode                          = DMX_SHUTTERMODE_DEFAULT;
  int chIndex_shutter                      = -1;
  int shutter_open                         = -1;
  int shutter_closed                       = -1;
  int shutter_strobe_minSpeed              = -1;
  int shutter_strobe_maxSpeed              = -1;

  int apertureMode                         = DMX_APERTUREMODE_DEFAULT;
  int chIndex_aperture                     = -1;
  int aperture_defaultVal                  = -1;
  int aperture_progressive_max             = -1;   // Large aperture / wide beam
  int aperture_progressive_min             = -1;   // Small aperture / narrow beam
  ArrayList<int[]> aperture_steps;                 // List of the different aperture settings. Arranged from large to narrow - last values correspond to a narrow beam 
  

  // Constants corresponding to specific values
  int dmxVal_color_colorWheel_white        = -1;
  int dmxVal_color_colorWheel_red          = -1;
  int dmxVal_color_colorWheel_deepRed      = -1;
  int dmxVal_color_colorWheel_blue         = -1;
  int dmxVal_color_colorWheel_deepBlue     = -1;
  int dmxVal_color_colorWheel_yellow       = -1;
  int dmxVal_color_colorWheel_green        = -1;
  int dmxVal_color_colorWheel_ultraviolet  = -1;
  int dmxVal_color_colorWheel_orange       = -1;
  int dmxVal_color_colorWheel_cto          = -1;

  int dmxVal_pan_totalRange_degrees        = -1;   // Most moving heads have a 540° pan range - center val is half of this
  float dmxVal_specificVal_pan_center_perCent;
  float dmxVal_specificVal_pan_left_perCent;
  float dmxVal_specificVal_pan_right_perCent;
  int dmxVal_tilt_totalRange_degrees       = -1;   // Most moving heads have a 270° tilt range
  float dmxVal_specificVal_tilt_low_perCent;
  float dmxVal_specificVal_tilt_front_perCent;
  float dmxVal_specificVal_tilt_high_perCent;
  float dmxVal_specificVal_tilt_upright_perCent;
  float dmxVal_specificVal_tilt_back_perCent;

  //// - End of the physical moving head description - ////

  int currentLightStyle                   = DMXANIM_BLACKOUT;                 // Used by the global animations
  int animCpt1                            = 0;                                // Counters used for the global animations
  int animCpt2                            = 0;
  int animCpt3                            = 0;

  
  //Additional variables which might be used by other non-DMX related functions (most notably, the simulator)
  int[] simulator_colorRGB;


  // Fixtures are instanciated using their name: the constructor will then look up in the fixture library if such a device exists, and throw an exception if not
  DMX_MovingHead(String name, int deviceID, int startAddr) throws UndefinedFixtureException {

    this.deviceID = deviceID;
    this.dmxStartAddr = startAddr;

    // Init
    movingHead = getFixtureFromName(name);
    if (movingHead.isValidFixture() == false) {
      throw new UndefinedFixtureException("Undefined fixture: " + name);
    }

    nbChannels       = movingHead.getNbChannels();
    dmxVal           = new int[nbChannels];
    for (int i=0; i<nbChannels; i++) {
      dmxVal[i] = DMX_DEFAULT_FALLBACK_VAL;
    }

    boolean fixtureCanBeCreated = checkDmxAddressMapping(dmxStartAddr, nbChannels);
    if (fixtureCanBeCreated == false) {
      outputLog.println("Moving Head DMX instanciation failure - check the mapping for device ID " + this.deviceID + " (start address=" + startAddr + ", number of channels=" + nbChannels);
    }

    // Now parse individual functions

    parseFixtureDimmerControl();
    
    parseFixturePanControl();

    parseFixtureTiltControl();

    // If more than one color mode is available, the priority goes to the color wheel. If not, use what's possible
    parseFixtureColorModes();
    colorControlMode = defineColorMode();

    parseFixtureSpeedModes();
    speedMode = defineSpeedMode();

    parseFixtureShutterModes();

    parseFixtureApertureModes();

    // Check other functions this fixture may have - search for all channels with a recommended channel set - this will become the default value for these channels
    parseDefaultChannels();

    setMainChannelsDefaultValues();
    setMiscVariablesDefaultValues();
  }

  int getDeviceID() {
    return this.deviceID;
  }

  // Set the default values for the main channels
  void setMainChannelsDefaultValues() {
    dmxVal[chIndex_pan]  = 127;
    dmxVal[chIndex_tilt] = 127;
    if (chIndex_panFine != -1) {
      dmxVal[chIndex_panFine]  = 127;
    }
    if (chIndex_tiltFine != -1) {
      dmxVal[chIndex_tiltFine]  = 127;
    }
  }

  // Set the default values for non-dmx related variables
  void setMiscVariablesDefaultValues() {
    simulator_colorRGB = new int[3];
    simulator_colorRGB[0] = 255;   // White
    simulator_colorRGB[1] = 255;   // White
    simulator_colorRGB[2] = 255;   // White
  }

  void parseFixtureDimmerControl() {
    chIndex_dimmer   = movingHead.getChannelIndexCorrespondingToFunction(DMX_MOVINGHEAD_DIMMER);
    if (movingHead.getLinkedChannelIndexCorrespondingToIndex(chIndex_dimmer) != -1) {
      fineDimmerControl = true;
      chIndex_dimmerFine = movingHead.getLinkedChannelIndexCorrespondingToIndex(chIndex_dimmer);
    }

    ChannelDesc channel = movingHead.getChannelCorrespondingToIndex(chIndex_dimmer);
    ArrayList<ChannelSet> channelSets = channel.getAllChannelSets();
    for (ChannelSet channelSet: channelSets) {
      if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_DIMMER)) {
        if (channelSet.isProportional_Increasing()) {  // The dimmer is always proportional - only need to check if it's increasing or decreasing
          dimmer_minVal = channelSet.getFrom_dmx();
          dimmer_maxVal = channelSet.getTo_dmx();
        }
        else if (channelSet.isProportional() && (channelSet.isProportional_Increasing() == false)) {
          dimmer_minVal = channelSet.getTo_dmx();
          dimmer_maxVal = channelSet.getFrom_dmx();
        }
        else {    // Default : increasing proportional - the user may have forgotten to mark the channel set as proportional
          dimmer_minVal = channelSet.getFrom_dmx();
          dimmer_maxVal = channelSet.getTo_dmx();
        }
      }
    }
  }

  void parseFixturePanControl() {
    chIndex_pan      = movingHead.getChannelIndexCorrespondingToFunction(DMX_MOVINGHEAD_PAN);
    if (movingHead.getLinkedChannelIndexCorrespondingToIndex(chIndex_pan) != -1) {
      finePanControl = true;
      chIndex_panFine = movingHead.getLinkedChannelIndexCorrespondingToIndex(chIndex_pan);
    }

    ChannelDesc channel = movingHead.getChannelCorrespondingToIndex(chIndex_pan);
    ArrayList<ChannelSet> channelSets = channel.getAllChannelSets();
    for (ChannelSet channelSet: channelSets) {
      if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_PAN)) {
        if (channelSet.isProportional_Increasing()) {  // The pan is always proportional - only need to check if it's increasing or decreasing
          pan_minVal = channelSet.getFrom_dmx();
          pan_maxVal = channelSet.getTo_dmx();
        }
        else if (channelSet.isProportional() && (channelSet.isProportional_Increasing() == false)) {
          pan_minVal = channelSet.getTo_dmx();
          pan_maxVal = channelSet.getFrom_dmx();
        }
        else {    // Default : increasing proportional - the user may have forgotten to mark the channel set as proportional
          pan_minVal = channelSet.getFrom_dmx();
          pan_maxVal = channelSet.getTo_dmx();
        }

        //Get the range of this moving head's pan: how many degrees for a 0-100% change
        dmxVal_pan_totalRange_degrees = channelSet.getChannelRange();
      }
    }
    
    if (dmxVal_pan_totalRange_degrees == -1) {
      dmxVal_pan_totalRange_degrees = DMX_DEFAULT_PAN_TOTALRANGE;   //Default value for the range - consider it to be equal to 540°
    }
    dmxVal_specificVal_pan_left_perCent   = 100 * (dmxVal_pan_totalRange_degrees/2.0 - 90) / dmxVal_pan_totalRange_degrees;
    dmxVal_specificVal_pan_right_perCent  = 100 * (dmxVal_pan_totalRange_degrees/2.0 + 90) / dmxVal_pan_totalRange_degrees;
    dmxVal_specificVal_pan_center_perCent = 100 * (dmxVal_pan_totalRange_degrees/2.0 + 0)  / dmxVal_pan_totalRange_degrees;
  }

  void parseFixtureTiltControl() {
    chIndex_tilt     = movingHead.getChannelIndexCorrespondingToFunction(DMX_MOVINGHEAD_TILT);
    if (movingHead.getLinkedChannelIndexCorrespondingToIndex(chIndex_tilt) != -1) {
      fineTiltControl = true;
      chIndex_tiltFine = movingHead.getLinkedChannelIndexCorrespondingToIndex(chIndex_tilt);
    }

    ChannelDesc channel = movingHead.getChannelCorrespondingToIndex(chIndex_tilt);
    ArrayList<ChannelSet> channelSets = channel.getAllChannelSets();
    for (ChannelSet channelSet: channelSets) {
      if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_TILT)) {
        if (channelSet.isProportional_Increasing()) {  // The tilt is always proportional - only need to check if it's increasing or decreasing
          pan_minVal = channelSet.getFrom_dmx();
          pan_maxVal = channelSet.getTo_dmx();
        }
        else if (channelSet.isProportional() && (channelSet.isProportional_Increasing() == false)) {
          pan_minVal = channelSet.getTo_dmx();
          pan_maxVal = channelSet.getFrom_dmx();
        }
        else {    // Default : increasing proportional - the user may have forgotten to mark the channel set as proportional
          pan_minVal = channelSet.getFrom_dmx();
          pan_maxVal = channelSet.getTo_dmx();
        }
      }

      //Get the range of this moving head's tilt: how many degrees for a 0-100% change
      dmxVal_tilt_totalRange_degrees = channelSet.getChannelRange();
    }
    
    if (dmxVal_tilt_totalRange_degrees == -1) {
      dmxVal_tilt_totalRange_degrees = DMX_DEFAULT_PAN_TOTALRANGE;   //Default value for the range - consider it to be equal to 540°
    }
    dmxVal_specificVal_tilt_low_perCent     = 100 * (dmxVal_tilt_totalRange_degrees/2.0 - 135) / dmxVal_tilt_totalRange_degrees;
    dmxVal_specificVal_tilt_front_perCent   = 100 * (dmxVal_tilt_totalRange_degrees/2.0 - 90)  / dmxVal_tilt_totalRange_degrees;
    dmxVal_specificVal_tilt_high_perCent    = 100 * (dmxVal_tilt_totalRange_degrees/2.0 - 45)  / dmxVal_tilt_totalRange_degrees;
    dmxVal_specificVal_tilt_upright_perCent = 100 * (dmxVal_tilt_totalRange_degrees/2.0 - 0)   / dmxVal_tilt_totalRange_degrees;
    dmxVal_specificVal_tilt_back_perCent    = 100 * (dmxVal_tilt_totalRange_degrees/2.0 + 90)  / dmxVal_tilt_totalRange_degrees;

  }

  void parseFixtureColorModes() {
    // Define the available color modes
    available_chIndex_color = movingHead.getAllChannelIndexesCorrespondingToFunction(DMX_MOVINGHEAD_COLOR);
    for (int chIndex: available_chIndex_color) {
      ChannelDesc channel = movingHead.getChannelCorrespondingToIndex(chIndex);
      if (channel.getOption().equals(DMX_COLORMODE_WHEEL_TEXT)) {
        chIndex_color_WHEEL = channel.getIndex();
        parseColorWheelChannel(channel);
      }
      else if (channel.getOption().equals(DMX_COLORMODE_RGB_TEXT)) {
        if (channel.getOptionArgument().equals(DMX_COLORMODE_RGB_R)) {
          chIndex_color_RGB_R = channel.getIndex();
        }
        else if (channel.getOptionArgument().equals(DMX_COLORMODE_RGB_G)) {
          chIndex_color_RGB_G = channel.getIndex();
        }
        else if (channel.getOptionArgument().equals(DMX_COLORMODE_RGB_B)) {
          chIndex_color_RGB_B = channel.getIndex();
        }
      }
      else if (channel.getOption().equals(DMX_COLORMODE_CMY_TEXT)) {
        if (channel.getOptionArgument().equals(DMX_COLORMODE_CMY_C)) {
          chIndex_color_CMY_C = channel.getIndex();
        }
        else if (channel.getOptionArgument().equals(DMX_COLORMODE_CMY_M)) {
          chIndex_color_CMY_M = channel.getIndex();
        }
        else if (channel.getOptionArgument().equals(DMX_COLORMODE_CMY_Y)) {
          chIndex_color_CMY_Y = channel.getIndex();
        }
      }
      else if (channel.getOption().equals(DMX_COLORMODE_RGBW_TEXT)) {
        if (channel.getOptionArgument().equals(DMX_COLORMODE_RGB_R)) {
          chIndex_color_RGB_R = channel.getIndex();
        }
        else if (channel.getOptionArgument().equals(DMX_COLORMODE_RGB_G)) {
          chIndex_color_RGB_G = channel.getIndex();
        }
        else if (channel.getOptionArgument().equals(DMX_COLORMODE_RGB_B)) {
          chIndex_color_RGB_B = channel.getIndex();
        }
        else if (channel.getOptionArgument().equals(DMX_COLORMODE_RGB_W)) {
          chIndex_color_RGB_W = channel.getIndex();
        }
      }
    }
  }

  void parseColorWheelChannel(ChannelDesc colorWheelCh) {
    ArrayList<ChannelSet> channelSets = colorWheelCh.getAllChannelSets();
    for (ChannelSet channelSet: channelSets) {
      if (channelSet.getSubfunction().equals(DMX_COLORWHEEL_WHITE_TEXT)) {
        dmxVal_color_colorWheel_white = channelSet.getFrom_dmx();
      }
      else if (channelSet.getSubfunction().equals(DMX_COLORWHEEL_RED_TEXT)) {
        dmxVal_color_colorWheel_red = channelSet.getFrom_dmx();
      }
      else if (channelSet.getSubfunction().equals(DMX_COLORWHEEL_DEEP_RED_TEXT)) {
        dmxVal_color_colorWheel_deepRed = channelSet.getFrom_dmx();
      }
      else if (channelSet.getSubfunction().equals(DMX_COLORWHEEL_BLUE_TEXT)) {
        dmxVal_color_colorWheel_blue = channelSet.getFrom_dmx();
      }
      else if (channelSet.getSubfunction().equals(DMX_COLORWHEEL_DEEP_BLUE_TEXT)) {
        dmxVal_color_colorWheel_deepBlue = channelSet.getFrom_dmx();
      }
      else if (channelSet.getSubfunction().equals(DMX_COLORWHEEL_YELLOW_TEXT)) {
        dmxVal_color_colorWheel_yellow = channelSet.getFrom_dmx();
      }
      else if (channelSet.getSubfunction().equals(DMX_COLORWHEEL_GREEN_TEXT)) {
        dmxVal_color_colorWheel_green = channelSet.getFrom_dmx();
      }
      else if (channelSet.getSubfunction().equals(DMX_COLORWHEEL_ULTRAVIOLET_TEXT)) {
        dmxVal_color_colorWheel_ultraviolet = channelSet.getFrom_dmx();
      }
      else if (channelSet.getSubfunction().equals(DMX_COLORWHEEL_ORANGE_TEXT)) {
        dmxVal_color_colorWheel_orange = channelSet.getFrom_dmx();
      }
      else if (channelSet.getSubfunction().equals(DMX_COLORWHEEL_CTO_TEXT)) {
        dmxVal_color_colorWheel_cto = channelSet.getFrom_dmx();
      }
    }
  }

  int defineColorMode() {
    if (chIndex_color_WHEEL != -1) {
      return DMX_COLORMODE_WHEEL;
    }
    else if (chIndex_color_RGB_R != -1 && chIndex_color_RGB_G != -1 && chIndex_color_RGB_B != -1 && chIndex_color_RGB_W != -1) {
      return DMX_COLORMODE_RGBW;
    }
    else if (chIndex_color_RGB_R != -1 && chIndex_color_RGB_G != -1 && chIndex_color_RGB_B != -1) {
      return DMX_COLORMODE_RGB;
    }
    else if (chIndex_color_CMY_C != -1 && chIndex_color_CMY_M != -1 && chIndex_color_CMY_Y != -1) {
      return DMX_COLORMODE_CMY;
    }
    else {
      return DMX_COLORMODE_UNDEFINED;
    }
  }

  void parseFixtureSpeedModes() {
    // Either there is a special channel dedicated to setting the speed mode, either a single channel does both
    chIndex_speedSet  = movingHead.getChannelIndexCorrespondingToFunction(DMX_MOVINGHEAD_SPEED);
    if (movingHead.getChannelIndexCorrespondingToFunction(DMX_MOVINGHEAD_SPEEDMODE) == -1) {
      chIndex_speedMode = chIndex_speedSet;
    }
    else {
      chIndex_speedMode = movingHead.getChannelIndexCorrespondingToFunction(DMX_MOVINGHEAD_SPEEDMODE);
    }

    if (chIndex_speedSet == -1) {
      speedMode = DMX_SPEEDMODE_FIXED;
    }

    // Now parse the Channel sets describing the values which must be sent
    ArrayList<ChannelSet> channelSets = movingHead.getChannelCorrespondingToIndex(chIndex_speedMode).getAllChannelSets();

    for (ChannelSet channelSet: channelSets) {
      if (channelSet.getSubfunction().equals(DMX_SPEEDMODE_DEFAULT_TEXT)) {   //DMX Value to send to set the default mode
        speedMode_standardSpeed_val = channelSet.getFrom_dmx();
      }
      if (channelSet.getSubfunction().equals(DMX_SPEEDMODE_MAX_TEXT)) {
        speedMode_maxSpeed_val = channelSet.getFrom_dmx();
      }
      if (channelSet.getSubfunction().equals(DMX_SPEEDMODE_PROGRESSIVE_TEXT)) {
        if (channelSet.isProportional()) {
          if (channelSet.isProportional_Increasing()) {
            speedMode_fine_range_min = channelSet.getFrom_dmx();
            speedMode_fine_range_max = channelSet.getTo_dmx();
          }
          else {
            speedMode_fine_range_min = channelSet.getTo_dmx();
            speedMode_fine_range_max = channelSet.getFrom_dmx(); 
          }
        }
        else {
          // Shouldn't really matter as the channel is set as "non-proportional". However, it is strange that the progressive mode should be defined as such
          // By default, set these values as proportional-decreasing (ie this channel set describes the time the fixture takes to go from one position to another)
          speedMode_fine_range_min = channelSet.getTo_dmx();
          speedMode_fine_range_max = channelSet.getFrom_dmx();
        }
      }
    }
  }

  int defineSpeedMode() {
    //The default speed mode should be the max speed mode. If no solution is found, consider the device to be speed-fixed
    if (speedMode_maxSpeed_val != -1) {
      return DMX_SPEEDMODE_MAX;
    }
    else if (speedMode_standardSpeed_val != -1) {
      return DMX_SPEEDMODE_DEFAULT;
    }
    else if (speedMode_fine_range_min != -1 && speedMode_fine_range_max != -1) {
      return DMX_SPEEDMODE_PROGRESSIVE;
    }
    else {
      return DMX_SPEEDMODE_FIXED;
    }
  }

  void parseFixtureShutterModes() {
    chIndex_shutter = movingHead.getChannelIndexCorrespondingToFunction(DMX_MOVINGHEAD_SHUTTER);
    ArrayList<ChannelSet> channelSets = movingHead.getChannelCorrespondingToIndex(chIndex_shutter).getAllChannelSets();

    for (ChannelSet channelSet: channelSets) {
      if (channelSet.getSubfunction().equals(DMX_SHUTTER_OPEN)) {
        shutter_open = channelSet.getFrom_dmx();
      }
      if (channelSet.getSubfunction().equals(DMX_SHUTTER_CLOSED)) { 
        shutter_closed = channelSet.getFrom_dmx();
      }
      if (channelSet.getSubfunction().equals(DMX_SHUTTER_STROBE)) { 
        if (channelSet.isProportional()) {
          if (channelSet.isProportional_Increasing()) {
            shutter_strobe_minSpeed = channelSet.getFrom_dmx();
            shutter_strobe_maxSpeed = channelSet.getTo_dmx();
          }
        }
        else {
          // Shouldn't really matter as the channel is set as "non-proportional". However, it is strange that the progressive mode should be defined as such
          // By default, set these values as proportional-increasing
          shutter_strobe_minSpeed = channelSet.getFrom_dmx();
          shutter_strobe_maxSpeed = channelSet.getTo_dmx();
        }
      }
    }
  }

  // Aperture is a bit particular - this is very device-specific, this function might have to be modified to deal with different implementations
  void parseFixtureApertureModes() {
    chIndex_aperture = movingHead.getChannelIndexCorrespondingToFunction(DMX_MOVINGHEAD_APERTURE);
    aperture_steps = new ArrayList<int[]>();
    

    if (chIndex_aperture != -1) {
      // A "normal" aperture channel is available
      ArrayList<ChannelSet> channelSets = movingHead.getChannelCorrespondingToIndex(chIndex_aperture).getAllChannelSets();
      for (ChannelSet channelSet: channelSets) {
        if (channelSet.getSubfunction().equals(DMX_APERTUREMODE_DEFAULT_TEXT)) {
          aperture_defaultVal = channelSet.getFrom_dmx();
        }

        if (channelSet.getSubfunction().equals(DMX_APERTUREMODE_PROGRESSIVE_TEXT)) {
          apertureMode = DMX_APERTUREMODE_PROGRESSIVE;
          if (channelSet.isProportional()) {
            if (channelSet.isProportional_Increasing()) {
              aperture_progressive_min = channelSet.getFrom_dmx();
              aperture_progressive_max = channelSet.getTo_dmx();
            }
          }
          else {
            aperture_progressive_min = channelSet.getTo_dmx();
            aperture_progressive_max = channelSet.getFrom_dmx();            
          }
        }

        if (channelSet.getSubfunction().contains(DMX_APERTUREMODE_STEP_TEXT)) {
          parseApertureStep(channelSet);
          apertureMode = DMX_APERTUREMODE_STEP;
        }

      }
    }
    else {
      // Check if an alternative aperture channel is available
      IntList available_gobo_channels = movingHead.getAllChannelIndexesCorrespondingToFunction(DMX_MOVINGHEAD_GOBO);
      for (int index: available_gobo_channels) {
        ChannelDesc channel = movingHead.getChannelCorrespondingToIndex(index);
        ArrayList<ChannelSet> channelSets = channel.getAllChannelSets();
        for (ChannelSet channelSet: channelSets) {
          if (channelSet.getSubfunction().equals(DMX_APERTUREMODE_DEFAULT_TEXT)) {
            aperture_defaultVal = channelSet.getFrom_dmx();
          }
          else if (channelSet.getSubfunction().contains(DMX_APERTUREMODE_STEP_TEXT)) {
            chIndex_aperture = channel.getIndex();    // Even though this is not a "real" aperture channel, consider the gobo channel to be the aperture channel
            parseApertureStep(channelSet);
            apertureMode = DMX_APERTUREMODE_STEP;
          }
        }
      }
    }
    
  }

  void parseApertureStep(ChannelSet channelSet) {
    int suffix = int(channelSet.getSubfunction().split("_")[ channelSet.getSubfunction().split("_").length - 1 ]);
    int min = channelSet.getFrom_dmx();
    int max = channelSet.getTo_dmx();
    int[] dataStruct = new int[3];
    dataStruct[0] = suffix;
    dataStruct[1] = min;
    dataStruct[2] = max;
    
    //TODO: reorder aperture_steps, just in case
    aperture_steps.add(dataStruct);

  }


  void parseDefaultChannels() {
    ArrayList<ChannelDesc> channelsWithDefaultVal = movingHead.getAllChannelsWithDefaultVal();
    for (ChannelDesc channel: channelsWithDefaultVal) {
      int index = channel.getIndex();
      int val = 0;
      for (ChannelSet channelSet: channel.getAllChannelSets()) {
        if (channelSet.recommended == true) {
          val = channelSet.getFrom_dmx();
          break;
        }
      }
      // Set the requested default value for the corresponding channel index
      dmxVal[index] = val;
    }
  }


  //// BASIC LIB FUNCTIONS
  //////////////////////////////

  //DMX control : use percentage values

  void setDimmer(float val_percent) {
    if (fineDimmerControl) {
      int val = int( map(val_percent, 0.0, 100.0, 0, 65535) );
      dmxVal[chIndex_dimmer]     = (val & 0xffff) >> 8;
      dmxVal[chIndex_dimmerFine] = (val & 0xffff) &  0xFF;
    }
    else {
      dmxVal[chIndex_dimmer] = int( map(val_percent, 0.0, 100.0, dimmer_minVal, dimmer_maxVal) );
    }
  }

  void setPan(float val_percent) {
    if (finePanControl) {
      int val = int( map(val_percent, 0.0, 100.0, 0, 65535) );
      dmxVal[chIndex_pan]     = (val & 0xffff) >> 8;
      dmxVal[chIndex_panFine] = (val & 0xffff) &  0xFF;
    }
    else {
      dmxVal[chIndex_pan] = int( map(val_percent, 0.0, 100.0, pan_minVal, pan_maxVal) );
    }
  }

  void setTilt(float val_percent) {
    if (fineTiltControl) {
      int val = int( map(val_percent, 0.0, 100.0, 0, 65535) );
      dmxVal[chIndex_tilt]     = (val & 0xffff) >> 8;
      dmxVal[chIndex_tiltFine] = (val & 0xffff) &  0xFF;
    }
    else {
      dmxVal[chIndex_tilt] = int( map(val_percent, 0.0, 100.0, tilt_minVal, tilt_maxVal) );
    }
  }

  void setSpeed(float val_percent) {
    switch (speedMode) {
      case DMX_SPEEDMODE_DEFAULT:       dmxVal[chIndex_speedSet] = speedMode_standardSpeed_val; break;  //Ignore the input argument: default speed mode
      case DMX_SPEEDMODE_MAX:           dmxVal[chIndex_speedSet] = speedMode_maxSpeed_val; break;       //Ignore the input argument: max speed mode
      case DMX_SPEEDMODE_PROGRESSIVE:   dmxVal[chIndex_speedSet] = int( map(val_percent, 0.0, 100.0, speedMode_fine_range_min, speedMode_fine_range_max) ); break;
      case DMX_SPEEDMODE_FIXED:         break;  // Nothing to do, no channel reserved for pan/tilt movement speed
      default: break;
    }
  }

  void setSpeedMode(int requestedMode) {
    if (requestedMode == DMX_SPEEDMODE_DEFAULT) {
      if (chIndex_speedSet != -1 && speedMode_standardSpeed_val != -1) {
        speedMode = DMX_SPEEDMODE_DEFAULT;
      }
      else {
        speedMode = DMX_SPEEDMODE_FIXED;
      }
    }
    else if (requestedMode == DMX_SPEEDMODE_MAX) {
      if (chIndex_speedSet != -1 && speedMode_maxSpeed_val != -1) {
        speedMode = DMX_SPEEDMODE_MAX;
      }
      else if (chIndex_speedSet != -1 && speedMode_standardSpeed_val != -1) {
        speedMode = DMX_SPEEDMODE_DEFAULT;
      }
      else {
        speedMode = DMX_SPEEDMODE_FIXED;
      }
    }
    else if (requestedMode == DMX_SPEEDMODE_PROGRESSIVE) {
      if (chIndex_speedSet != -1 && speedMode_fine_range_min != -1 && speedMode_fine_range_max != -1) {
        speedMode = DMX_SPEEDMODE_MAX;
      }
      else if (chIndex_speedSet != -1 && speedMode_standardSpeed_val != -1) {
        speedMode = DMX_SPEEDMODE_DEFAULT;
      }
      else {
        speedMode = DMX_SPEEDMODE_FIXED;
      }
    }
    else {
      speedMode = DMX_SPEEDMODE_FIXED;
    }
  }

  void setSpeed_defaultSpeed() {
    setSpeedMode(DMX_SPEEDMODE_DEFAULT);
    setSpeed(50.0);
  }

  void setSpeed_maxSpeed() {
    setSpeedMode(DMX_SPEEDMODE_MAX);
    setSpeed(100.0);
  }

  void setSpeed_progressiveSpeed(float val) {
    setSpeedMode(DMX_SPEEDMODE_PROGRESSIVE);
    setSpeed(val);
  }


  void setShutter(float val_percent) {
    if (chIndex_shutter != -1 && shutter_open != -1 && shutter_closed != -1) {
      if (shutterMode == DMX_SHUTTERMODE_DEFAULT) {
        if (val_percent < 50.0) {
          dmxVal[chIndex_shutter] = shutter_open;
        }
        else {
          dmxVal[chIndex_shutter] = shutter_closed;
        }
      }
      else if (shutterMode == DMX_SHUTTERMODE_STROBE) {
        if (shutter_strobe_maxSpeed != -1 && shutter_strobe_minSpeed != -1) {
          dmxVal[chIndex_shutter] = int( map(val_percent, 0.0, 100.0, shutter_strobe_minSpeed, shutter_strobe_maxSpeed) );
        }
        else {
          dmxVal[chIndex_shutter] = shutter_open;   // This fuxture does not have a strobe control incorporated to its shutter channel
        }
      }
    }
    else {
      // Do nothing - this fixture does not support shutter control
    }
  }

  void setShutterMode(int requestedMode) {
    if (requestedMode == DMX_SHUTTERMODE_DEFAULT) {
      shutterMode = DMX_SHUTTERMODE_DEFAULT;
    }
    else if (requestedMode == DMX_SHUTTERMODE_STROBE) {
      if (shutter_strobe_maxSpeed != -1 && shutter_strobe_minSpeed != -1) {
        shutterMode = DMX_SHUTTERMODE_STROBE;
      }
      else {
        shutterMode = DMX_SHUTTERMODE_DEFAULT;  // Unsupoorted strobe mode   
      }
    }
  }

  void setColor(int requestedColor) {
    switch (requestedColor) {
      case DMX_COLORWHEEL_WHITE      : setColor_white();break;
      case DMX_COLORWHEEL_RED        : setColor_red();break;
      case DMX_COLORWHEEL_DEEP_RED   : setColor_deepRed();break;
      case DMX_COLORWHEEL_BLUE       : setColor_blue();break;
      case DMX_COLORWHEEL_DEEP_BLUE  : setColor_deepBlue();break;
      case DMX_COLORWHEEL_YELLOW     : setColor_yellow();break;
      case DMX_COLORWHEEL_GREEN      : setColor_green();break;
      case DMX_COLORWHEEL_ULTRAVIOLET: setColor_ultraviolet();break;
      case DMX_COLORWHEEL_ORANGE     : setColor_orange();break;
      case DMX_COLORWHEEL_CTO        : setColor_cto();break;
      default: break;
    }
  }

  void setColor_genericColor(int colorWheel_code, int[] colorRGB, int[] colorRGBW) {
    int[] colorCMY   = {255 - colorRGB[0], 255 - colorRGB[1], 255 - colorRGB[2]};
    switch (colorControlMode) {
      case DMX_COLORMODE_WHEEL    : dmxVal[chIndex_color_WHEEL] = colorWheel_code; break; 
      case DMX_COLORMODE_RGB      : dmxVal[chIndex_color_RGB_R] = colorRGB[0];       dmxVal[chIndex_color_RGB_G] = colorRGB[1];       dmxVal[chIndex_color_RGB_B] = colorRGB[2];       break; 
      case DMX_COLORMODE_CMY      : dmxVal[chIndex_color_CMY_C] = 255 - colorRGB[0]; dmxVal[chIndex_color_CMY_M] = 255 - colorRGB[1]; dmxVal[chIndex_color_CMY_Y] = 255 - colorRGB[2]; break; 
      case DMX_COLORMODE_RGBW     : dmxVal[chIndex_color_RGB_R] = colorRGB[0];       dmxVal[chIndex_color_RGB_G] = colorRGB[1];       dmxVal[chIndex_color_RGB_B] = colorRGB[2];       dmxVal[chIndex_color_RGB_W] = colorRGB[3]; break; 
      case DMX_COLORMODE_UNDEFINED: break; 
      default: break;
    }

    // Save colorRGB in order to have the simulator know which color is currently active easily
    simulator_colorRGB = colorRGB;
  }

  int getFallbackColorIfInvalidColorVal(int inputColor) {
    if (inputColor == -1) {
      if (dmxVal_color_colorWheel_white != -1) {
        return dmxVal_color_colorWheel_white;
      }
      else {
        return 0;
      }
    }
    else {
      return inputColor;
    }
  }

  int getFallbackColorIfInvalidColorVal(int inputColor, int fallbackColor) {
    if (inputColor == -1) {
      if (fallbackColor != -1) {
        return fallbackColor;
      }
      else if (dmxVal_color_colorWheel_white != -1) {
        return dmxVal_color_colorWheel_white;
      }
      else {
        return 0;
      }
    }
    else {
      return inputColor;
    }
  }

  void setColor_white() {
    int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_white);
    int[] colorRGB   = {255, 255, 255};
    int[] colorRGBW  = {0,   0,   0, 255};
    setColor_genericColor(colorWheel, colorRGB, colorRGBW);
  }

  void setColor_red() {
    int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_red);
    int[] colorRGB   = {255, 0,   0};
    int[] colorRGBW  = {255, 0,   0,   0};
    setColor_genericColor(colorWheel, colorRGB, colorRGBW); 
  }

  void setColor_deepRed() {
    int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_deepRed, dmxVal_color_colorWheel_red);
    int[] colorRGB   = {139, 0,   0};
    int[] colorRGBW  = {139, 0,   0,   0};
    setColor_genericColor(colorWheel, colorRGB, colorRGBW); 
  }

  void setColor_blue() {
    int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_blue);
    int[] colorRGB   = {0,   0, 255};
    int[] colorRGBW  = {0,   0, 255,   0};
    setColor_genericColor(colorWheel, colorRGB, colorRGBW); 
  }

  void setColor_deepBlue() {
    int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_deepBlue, dmxVal_color_colorWheel_blue);
    int[] colorRGB   = {0,   0, 155};
    int[] colorRGBW  = {0,   0, 155,   0};
    setColor_genericColor(colorWheel, colorRGB, colorRGBW); 
  }

  void setColor_yellow() {
    int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_yellow);
    int[] colorRGB   = {255, 240, 0};
    int[] colorRGBW  = {255, 240, 0,   0};
    setColor_genericColor(colorWheel, colorRGB, colorRGBW);  
  }

  void setColor_green() {
    int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_green);
    int[] colorRGB   = {71, 182, 164};
    int[] colorRGBW  = {71, 182, 164,   0};
    setColor_genericColor(colorWheel, colorRGB, colorRGBW);  
  }

  void setColor_ultraviolet() {
    int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_ultraviolet, dmxVal_color_colorWheel_blue);
    int[] colorRGB   = {62,  6, 148};
    int[] colorRGBW  = {62,  6, 148,   0};
    setColor_genericColor(colorWheel, colorRGB, colorRGBW);  
  }

  void setColor_orange() {
    int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_orange, dmxVal_color_colorWheel_red);
    int[] colorRGB   = {253, 141, 28};
    int[] colorRGBW  = {255,   0,  0, 160};
    setColor_genericColor(colorWheel, colorRGB, colorRGBW);  
  }

  void setColor_cto() {
    int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_cto);
    int[] colorRGB   = {255, 241, 224};
    int[] colorRGBW  = {200,   0,  0, 255};
    setColor_genericColor(colorWheel, colorRGB, colorRGBW);  
  }



  void setApertureReduction(float val_percent) {
    // 100% -> closed aperture. 0% -> open aperture
    // Different implementations available for the aperture:
    // - Iris width (continuous control)
    // - Beam reduction using gobos (step control)
    if (apertureMode == DMX_APERTUREMODE_DEFAULT) {
      // Do nothing: no aperture control for this device
    }
    else if (apertureMode == DMX_APERTUREMODE_PROGRESSIVE) {
      if (chIndex_aperture != -1 && aperture_progressive_min != -1 && aperture_progressive_max != -1) {
        dmxVal[chIndex_aperture] = int( map(val_percent, 0.0, 100.0, aperture_progressive_min, aperture_progressive_max) );
      }
    }
    else if (apertureMode == DMX_APERTUREMODE_STEP) {
      if (aperture_steps.size() > 0) {
        int step =  int( map(val_percent,0,100.0, 0, aperture_steps.size()));
        dmxVal[chIndex_aperture] = aperture_steps.get(min(step, aperture_steps.size()-1))[1];
      }
    }
  }

  void setCurrentLightStyle(int style) {
    currentLightStyle = style;
  }

  void reinitAnimVars() {
    this.animCpt1 = 0;
    this.animCpt2 = 0;
    this.animCpt3 = 0;
  }


  ////////////////////////////////////////////////////////////////////////////////
  // MOVING HEAD VARIABLES ACCESSORS
  //////////////////////


  int[] getSimulatorColor() {
    return simulator_colorRGB;
  }

  int getSimulatorDimmer() {
    return int( map(dmxVal[chIndex_dimmer], dimmer_minVal, dimmer_maxVal, 0.0, 255.0) );
  }

  int getSimulatorTilt() {
    return dmxVal[chIndex_tilt];
  }

  float getSimulatorPan() {
    if (chIndex_panFine != -1) {
      return (255.0*dmxVal[chIndex_pan] + dmxVal[chIndex_panFine]) / 255.0;
    }
    else {
      return dmxVal[chIndex_pan];
    }
  }

  int getSimulatorShutterMode() {
    return shutterMode;
  }

  int getSimulatorShutter() {
    return int( map(dmxVal[chIndex_shutter], shutter_strobe_minSpeed, shutter_strobe_maxSpeed, 0.0, 255.0) );
  }


  ////////////////////////////////////////////////////////////////////////////////
  // ANIMATION FUNCTIONS
  //////////////////////

  void performLight_blackout() {
    this.setDimmer(0);
  }

  void performLight_continuousLight() {
    this.setShutterMode(DMX_SHUTTERMODE_DEFAULT);
    this.setDimmer(100);
    this.setApertureReduction(0);
  }

  void performLight_singleLongFlash() {
    this.setShutterMode(DMX_SHUTTERMODE_DEFAULT);
    this.setDimmer(max(0,100-this.animCpt1));
    this.setApertureReduction(0);
    this.animCpt1 += 1;
  }

  void performLight_singleShortFlash() {
    this.setShutterMode(DMX_SHUTTERMODE_DEFAULT);
    this.setDimmer(max(0,100-4*this.animCpt1));
    this.setApertureReduction(0);
    this.animCpt1 += 1;
  }

  void performLight_slowCrescendo() {
    this.setShutterMode(DMX_SHUTTERMODE_DEFAULT);
    this.setDimmer(min(100,this.animCpt1));
    this.setApertureReduction(0);
    this.animCpt1 += 1;
  }

  void performLight_fastCrescendo() {
    this.setShutterMode(DMX_SHUTTERMODE_DEFAULT);
    this.setDimmer(min(100,4*this.animCpt1));
    this.setApertureReduction(0);
    this.animCpt1 += 1;
  }

  void performLight_strobe(float dimmer_perCent, float strobeSpeed_perCent) {
    this.setShutter(strobeSpeed_perCent);
    this.setShutterMode(DMX_SHUTTERMODE_STROBE);
    this.setDimmer(dimmer_perCent);
    this.setApertureReduction(0);
  }

  void performLight_slowStrobe() {
    performLight_strobe(100, 20);
  }

  void performLight_mediumStrobe() {
    performLight_strobe(100, 50);
  }

  void performLight_fastStrobe() {
    performLight_strobe(100, 90);
  }

  void performLight_sineWave(float speed) {
    this.setShutterMode(DMX_SHUTTERMODE_DEFAULT);
    float offset = this.deviceID * TWO_PI/float(DMXList_MovingHeads.size());
    this.setDimmer(100 *  (0.5 + 0.5*sin(offset + animCpt1 * speed)));
    this.setApertureReduction(0);
    this.animCpt1 += 1;
  }

  void performLight_slowSineWave() {
    performLight_sineWave(0.125);
  }

  void performLight_fastSineWave() {
    performLight_sineWave(0.250);
  }

  void performLight_randomGlitch() {
    // Use perlin noise + deviceID as random seed
    this.setShutterMode(DMX_SHUTTERMODE_DEFAULT);
    this.setDimmer(100 * noise(frameCount*0.1));
    this.setApertureReduction(0);
  }

  void performLight_minimalApertureBeam() {
    this.setShutterMode(DMX_SHUTTERMODE_DEFAULT);
    this.setDimmer(100);
    this.setApertureReduction(80);
  }



}

void dmxAnim_movingHead_setupReinit_allDevices() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.reinitAnimVars();
  }
}


/////////////////////////////////////////////////////////////////////////////////////
// Each individual function is a single animation using the registered DMX devices

// Note :
// These animations can use every Moving Head device and call startDMX with the desired values
// When implementing these animations, be careful to stay modular : everything needs to be scalable, and look good no matter the number of fixtures
// Also, consider "left" to be House Left, and "right" to be House Right


// Basic directions, with the dimmer off

void dmxAnim_movingHead_prepareDirection_CenterPan_LowTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_center_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_low_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_LeftPan_LowTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_left_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_low_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_RightPan_LowTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_right_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_low_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_CenterPan_FrontTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_center_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_front_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_LeftPan_FrontTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_left_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_front_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_RightPan_FrontTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_right_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_front_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_CenterPan_HighTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_center_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_high_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_LeftPan_HighTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_left_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_high_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_RightPan_HighTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_right_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_high_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_CenterPan_UprightTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_center_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_upright_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_LeftPan_UprightTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_left_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_upright_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_RightPan_UprightTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_right_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_upright_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_CenterPan_BackTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_center_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_back_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_LeftPan_BackTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_left_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_back_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_RightPan_BackTilt() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    movingHead.setPan(movingHead.dmxVal_specificVal_pan_right_perCent);
    movingHead.setTilt(movingHead.dmxVal_specificVal_tilt_back_perCent);
  }
}

////////////////////////////////////////////////////////////

// openingWidthAngle_perCent: % of the angle between "front" and "full sideways"
// tiltValue_perCent: % of the angle between "max low" and "upright"
void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(float openingWidthAngle_perCent, float tiltValue_perCent) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    float panHalfWidth = map(openingWidthAngle_perCent, 0, 100, movingHead.dmxVal_specificVal_pan_center_perCent, movingHead.dmxVal_specificVal_pan_left_perCent);
    float pan_perCent  = map(movingHead.getDeviceID(), 0, DMXList_MovingHeads.size()-1, panHalfWidth, 100 - panHalfWidth);
    float tilt_perCent = map(tiltValue_perCent, 0, 100, movingHead.dmxVal_specificVal_tilt_low_perCent, movingHead.dmxVal_specificVal_tilt_upright_perCent);
    movingHead.setPan(pan_perCent);
    movingHead.setTilt(tilt_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_WidePan_LowTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(80, 0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_ClassicPan_LowTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(60, 0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_NarrowPan_LowTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(30, 0);
}


void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_WidePan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(80, 100 - 100*90.0/135.0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_ClassicPan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(60, 100 - 100*90.0/135.0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_NarrowPan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(30, 100 - 100*90.0/135.0);
}


void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_WidePan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(80, 100 - 100*45.0/135.0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_ClassicPan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(60, 100 - 100*45.0/135.0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_NarrowPan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(30, 100 - 100*45.0/135.0);
}


void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_WidePan_UprightTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(80, 100);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_ClassicPan_UprightTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(60, 100);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_NarrowPan_UprightTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan(30, 100);
}


void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(float openingWidthAngle_perCent, float tiltValue_perCent) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    float panHalfWidth = map(openingWidthAngle_perCent, 0, 100, movingHead.dmxVal_specificVal_pan_center_perCent, movingHead.dmxVal_specificVal_pan_left_perCent);
    float pan_perCent  = map(movingHead.getDeviceID(), 0, DMXList_MovingHeads.size()-1, 100 - panHalfWidth, panHalfWidth);
    float tilt_perCent = map(tiltValue_perCent, 0, 100, movingHead.dmxVal_specificVal_tilt_low_perCent, movingHead.dmxVal_specificVal_tilt_upright_perCent);
    movingHead.setPan(pan_perCent);
    movingHead.setTilt(tilt_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_WidePan_LowTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(80, 0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_ClassicPan_LowTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(60, 0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_NarrowPan_LowTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(30, 0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_WidePan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(80, 100 - 100*90.0/135.0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_ClassicPan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(60, 100 - 100*90.0/135.0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_NarrowPan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(30, 100 - 100*90.0/135.0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_WidePan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(80, 100 - 100*45.0/135.0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_ClassicPan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(60, 100 - 100*45.0/135.0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_NarrowPan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(30, 100 - 100*45.0/135.0);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_WidePan_UprightTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(80, 100);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_ClassicPan_UprightTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(60, 100);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_NarrowPan_UprightTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan(30, 100);
}


////////////////////////////////////////////////////////////

void dmxAnim_movingHead_prepareDirection_SymmetricalExtremePan_DivergentTilt(float openingTiltAngle_perCent) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();

    float pan_perCent = movingHead.dmxVal_specificVal_pan_center_perCent;
    if (DMXList_MovingHeads.size() % 2 == 0) {
      if (movingHead.getDeviceID() < DMXList_MovingHeads.size()/2) {
        pan_perCent = movingHead.dmxVal_specificVal_pan_left_perCent;
      }
      else {
        pan_perCent = movingHead.dmxVal_specificVal_pan_right_perCent;
      }
    }
    else {
      if (movingHead.getDeviceID() < DMXList_MovingHeads.size()/2) {
        pan_perCent = movingHead.dmxVal_specificVal_pan_left_perCent;
      }
      else if (movingHead.getDeviceID() < DMXList_MovingHeads.size()/2) {
        pan_perCent = movingHead.dmxVal_specificVal_pan_left_perCent;
      }
      else {
        pan_perCent = movingHead.dmxVal_specificVal_pan_center_perCent;
      }
    }
    float minTiltAngle = map(openingTiltAngle_perCent, 0, 100, movingHead.dmxVal_specificVal_tilt_upright_perCent, movingHead.dmxVal_specificVal_tilt_front_perCent);
    float tilt_perCent = movingHead.dmxVal_specificVal_tilt_upright_perCent - (movingHead.dmxVal_specificVal_tilt_upright_perCent - minTiltAngle) * abs( movingHead.getDeviceID()-0.5*(DMXList_MovingHeads.size()-1) ) / (0.5*(DMXList_MovingHeads.size()-1));

    movingHead.setPan(pan_perCent);
    movingHead.setTilt(tilt_perCent);
  }
}

// openingTiltAngle_perCent corresponds to the angle between the front position (upright + 90°) and the upright position
void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt(float openingWidthAngle_perCent, float openingTiltAngle_perCent) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_blackout();
    movingHead.setSpeed_maxSpeed();
    float panHalfWidth   = map(openingWidthAngle_perCent, 0, 100, movingHead.dmxVal_specificVal_pan_center_perCent, movingHead.dmxVal_specificVal_pan_left_perCent);
    float pan_perCent    = map(movingHead.getDeviceID(), 0, DMXList_MovingHeads.size()-1, panHalfWidth, 100 - panHalfWidth);

    float minTiltAngle = map(openingTiltAngle_perCent, 0, 100, movingHead.dmxVal_specificVal_tilt_upright_perCent, movingHead.dmxVal_specificVal_tilt_front_perCent);
    float tilt_perCent = movingHead.dmxVal_specificVal_tilt_upright_perCent - (movingHead.dmxVal_specificVal_tilt_upright_perCent - minTiltAngle) * abs( movingHead.getDeviceID()-0.5*(DMXList_MovingHeads.size()-1) ) / (0.5*(DMXList_MovingHeads.size()-1));

    movingHead.setPan(pan_perCent);
    movingHead.setTilt(tilt_perCent);
  }
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_WideNegTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalExtremePan_DivergentTilt(100);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_NarrowNegTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalExtremePan_DivergentTilt(60);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_WidePan_WideNegTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt(100.0, 100);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_WidePan_NarrowNegTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt(100.0, 60);
}


void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_WidePosTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalExtremePan_DivergentTilt(-100);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_NarrowPosTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalExtremePan_DivergentTilt(-60);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_WidePan_WidePosTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt(100.0, -100);
}

void dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_WidePan_NarrowPosTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt(100.0, -60);
}

////////////////////////////////////////////////////////////
// Standard lighting functions for all devices

void dmxAnim_movingHead_noMovement_allDev_continuousLight() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_continuousLight();
  }
}

void dmxAnim_movingHead_noMovement_allDev_singleLongFlash() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_singleLongFlash();
  }
}

void dmxAnim_movingHead_noMovement_allDev_singleShortFlash() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_singleShortFlash();
  }
}

void dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_slowCrescendo();
  }
}

void dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_fastCrescendo();
  }
}


void dmxAnim_movingHead_noMovement_allDev_slowStrobe() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_slowStrobe();
  }
}

void dmxAnim_movingHead_noMovement_allDev_mediumStrobe() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_mediumStrobe();
  }
}

void dmxAnim_movingHead_noMovement_allDev_fastStrobe() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.performLight_fastStrobe();
  }
}

////////////////////////////////////////////////////////////
// Set the color to use in the more complex animations

void dmxAnim_movingHead_setColor_allDev(int colorCode) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.setColor(colorCode);
  }
}

void dmxAnim_movingHead_setColor_centerDev(int colorCode) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads_center) {
    movingHead.setColor(colorCode);
  }  
}

void dmxAnim_movingHead_setColor_sideDev(int colorCode) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads_side) {
    movingHead.setColor(colorCode);
  }  
}

void dmxAnim_movingHead_setColor_leftDev(int colorCode) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads_left) {
    movingHead.setColor(colorCode);
  }  
}

void dmxAnim_movingHead_setColor_rightDev(int colorCode) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads_right) {
    movingHead.setColor(colorCode);
  }  
}

void dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle() {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    switch (movingHead.currentLightStyle) {
      case DMXANIM_BLACKOUT:              movingHead.performLight_blackout();             break;
      case DMXANIM_CONTINUOUS_LIGHT:      movingHead.performLight_continuousLight();      break;
      case DMXANIM_SINGLE_LONG_FLASH:     movingHead.performLight_singleLongFlash();      break;
      case DMXANIM_SINGLE_SHORT_FLASH:    movingHead.performLight_singleShortFlash();     break;
      case DMXANIM_SLOW_CRESCENDO:        movingHead.performLight_slowCrescendo();        break;
      case DMXANIM_FAST_CRESCENDO:        movingHead.performLight_fastCrescendo();        break;
      case DMXANIM_SLOW_STROBE:           movingHead.performLight_slowStrobe();           break;
      case DMXANIM_MEDIUM_STROBE:         movingHead.performLight_mediumStrobe();         break;
      case DMXANIM_FAST_STROBE:           movingHead.performLight_fastStrobe();           break;
      case DMXANIM_SLOW_SINE_WAVE:        movingHead.performLight_slowSineWave();         break;
      case DMXANIM_FAST_SINE_WAVE:        movingHead.performLight_fastSineWave();         break;
      case DMXANIM_RANDOM_GLITCH:         movingHead.performLight_randomGlitch();         break;
      case DMXANIM_MIN_APERTURE_BEAM:     movingHead.performLight_minimalApertureBeam();  break;
      default:                            break;
    }
  }
}

////////////////////////////////////////////////////////////

void dmxAnim_movingHead_noMovement_allDev_continuousLight_white() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_WHITE);
  dmxAnim_movingHead_noMovement_allDev_continuousLight();
}

void dmxAnim_movingHead_noMovement_allDev_continuousLight_red() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_RED);
  dmxAnim_movingHead_noMovement_allDev_continuousLight();
}

void dmxAnim_movingHead_noMovement_allDev_continuousLight_deepRed() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_RED);
  dmxAnim_movingHead_noMovement_allDev_continuousLight();
}

void dmxAnim_movingHead_noMovement_allDev_continuousLight_blue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_BLUE);
  dmxAnim_movingHead_noMovement_allDev_continuousLight();
}

void dmxAnim_movingHead_noMovement_allDev_continuousLight_deepBlue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_BLUE);
  dmxAnim_movingHead_noMovement_allDev_continuousLight();
}

void dmxAnim_movingHead_noMovement_allDev_continuousLight_yellow() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_YELLOW);
  dmxAnim_movingHead_noMovement_allDev_continuousLight();
}

void dmxAnim_movingHead_noMovement_allDev_continuousLight_green() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_GREEN);
  dmxAnim_movingHead_noMovement_allDev_continuousLight();
}

void dmxAnim_movingHead_noMovement_allDev_continuousLight_ultraviolet() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ULTRAVIOLET);
  dmxAnim_movingHead_noMovement_allDev_continuousLight();
}

void dmxAnim_movingHead_noMovement_allDev_continuousLight_orange() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ORANGE);
  dmxAnim_movingHead_noMovement_allDev_continuousLight();
}

void dmxAnim_movingHead_noMovement_allDev_continuousLight_CTO() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_CTO);
  dmxAnim_movingHead_noMovement_allDev_continuousLight();
}

////////////////////////////////////////////////////////////

void dmxAnim_movingHead_noMovement_allDev_singleLongFlash_white() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_WHITE);
  dmxAnim_movingHead_noMovement_allDev_singleLongFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleLongFlash_red() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_RED);
  dmxAnim_movingHead_noMovement_allDev_singleLongFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleLongFlash_deepRed() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_RED);
  dmxAnim_movingHead_noMovement_allDev_singleLongFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleLongFlash_blue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_BLUE);
  dmxAnim_movingHead_noMovement_allDev_singleLongFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleLongFlash_deepBlue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_BLUE);
  dmxAnim_movingHead_noMovement_allDev_singleLongFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleLongFlash_yellow() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_YELLOW);
  dmxAnim_movingHead_noMovement_allDev_singleLongFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleLongFlash_green() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_GREEN);
  dmxAnim_movingHead_noMovement_allDev_singleLongFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleLongFlash_ultraviolet() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ULTRAVIOLET);
  dmxAnim_movingHead_noMovement_allDev_singleLongFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleLongFlash_orange() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ORANGE);
  dmxAnim_movingHead_noMovement_allDev_singleLongFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleLongFlash_CTO() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_CTO);
  dmxAnim_movingHead_noMovement_allDev_singleLongFlash();
}

////////////////////////////////////////////////////////////

void dmxAnim_movingHead_noMovement_allDev_singleShortFlash_white() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_WHITE);
  dmxAnim_movingHead_noMovement_allDev_singleShortFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleShortFlash_red() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_RED);
  dmxAnim_movingHead_noMovement_allDev_singleShortFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleShortFlash_deepRed() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_RED);
  dmxAnim_movingHead_noMovement_allDev_singleShortFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleShortFlash_blue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_BLUE);
  dmxAnim_movingHead_noMovement_allDev_singleShortFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleShortFlash_deepBlue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_BLUE);
  dmxAnim_movingHead_noMovement_allDev_singleShortFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleShortFlash_yellow() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_YELLOW);
  dmxAnim_movingHead_noMovement_allDev_singleShortFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleShortFlash_green() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_GREEN);
  dmxAnim_movingHead_noMovement_allDev_singleShortFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleShortFlash_ultraviolet() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ULTRAVIOLET);
  dmxAnim_movingHead_noMovement_allDev_singleShortFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleShortFlash_orange() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ORANGE);
  dmxAnim_movingHead_noMovement_allDev_singleShortFlash();
}

void dmxAnim_movingHead_noMovement_allDev_singleShortFlash_CTO() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_CTO);
  dmxAnim_movingHead_noMovement_allDev_singleShortFlash();
}

////////////////////////////////////////////////////////////

void dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_white() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_WHITE);
  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_red() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_RED);
  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_deepRed() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_RED);
  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_blue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_BLUE);
  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_deepBlue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_BLUE);
  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_yellow() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_YELLOW);
  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_green() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_GREEN);
  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_ultraviolet() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ULTRAVIOLET);
  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_orange() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ORANGE);
  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight_CTO() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_CTO);
  dmxAnim_movingHead_noMovement_allDev_slowCrescendoLight();
}

////////////////////////////////////////////////////////////

void dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_white() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_WHITE);
  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_red() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_RED);
  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_deepRed() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_RED);
  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_blue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_BLUE);
  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_deepBlue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_BLUE);
  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_yellow() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_YELLOW);
  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_green() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_GREEN);
  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_ultraviolet() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ULTRAVIOLET);
  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_orange() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ORANGE);
  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight();
}

void dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight_CTO() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_CTO);
  dmxAnim_movingHead_noMovement_allDev_fastCrescendoLight();
}

////////////////////////////////////////////////////////////



void dmxAnim_movingHead_noMovement_allDev_slowStrobe_white() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_WHITE);
  dmxAnim_movingHead_noMovement_allDev_slowStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_slowStrobe_red() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_RED);
  dmxAnim_movingHead_noMovement_allDev_slowStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_slowStrobe_deepRed() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_RED);
  dmxAnim_movingHead_noMovement_allDev_slowStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_slowStrobe_blue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_BLUE);
  dmxAnim_movingHead_noMovement_allDev_slowStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_slowStrobe_deepBlue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_BLUE);
  dmxAnim_movingHead_noMovement_allDev_slowStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_slowStrobe_yellow() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_YELLOW);
  dmxAnim_movingHead_noMovement_allDev_slowStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_slowStrobe_green() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_GREEN);
  dmxAnim_movingHead_noMovement_allDev_slowStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_slowStrobe_ultraviolet() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ULTRAVIOLET);
  dmxAnim_movingHead_noMovement_allDev_slowStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_slowStrobe_orange() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ORANGE);
  dmxAnim_movingHead_noMovement_allDev_slowStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_slowStrobe_CTO() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_CTO);
  dmxAnim_movingHead_noMovement_allDev_slowStrobe();
}


void dmxAnim_movingHead_noMovement_allDev_mediumStrobe_white() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_WHITE);
  dmxAnim_movingHead_noMovement_allDev_mediumStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_mediumStrobe_red() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_RED);
  dmxAnim_movingHead_noMovement_allDev_mediumStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_mediumStrobe_deepRed() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_RED);
  dmxAnim_movingHead_noMovement_allDev_mediumStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_mediumStrobe_blue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_BLUE);
  dmxAnim_movingHead_noMovement_allDev_mediumStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_mediumStrobe_deepBlue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_BLUE);
  dmxAnim_movingHead_noMovement_allDev_mediumStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_mediumStrobe_yellow() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_YELLOW);
  dmxAnim_movingHead_noMovement_allDev_mediumStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_mediumStrobe_green() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_GREEN);
  dmxAnim_movingHead_noMovement_allDev_mediumStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_mediumStrobe_ultraviolet() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ULTRAVIOLET);
  dmxAnim_movingHead_noMovement_allDev_mediumStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_mediumStrobe_orange() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ORANGE);
  dmxAnim_movingHead_noMovement_allDev_mediumStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_mediumStrobe_CTO() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_CTO);
  dmxAnim_movingHead_noMovement_allDev_mediumStrobe();
}


void dmxAnim_movingHead_noMovement_allDev_fastStrobe_white() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_WHITE);
  dmxAnim_movingHead_noMovement_allDev_fastStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_fastStrobe_red() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_RED);
  dmxAnim_movingHead_noMovement_allDev_fastStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_fastStrobe_deepRed() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_RED);
  dmxAnim_movingHead_noMovement_allDev_fastStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_fastStrobe_blue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_BLUE);
  dmxAnim_movingHead_noMovement_allDev_fastStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_fastStrobe_deepBlue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_BLUE);
  dmxAnim_movingHead_noMovement_allDev_fastStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_fastStrobe_yellow() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_YELLOW);
  dmxAnim_movingHead_noMovement_allDev_fastStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_fastStrobe_green() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_GREEN);
  dmxAnim_movingHead_noMovement_allDev_fastStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_fastStrobe_ultraviolet() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ULTRAVIOLET);
  dmxAnim_movingHead_noMovement_allDev_fastStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_fastStrobe_orange() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ORANGE);
  dmxAnim_movingHead_noMovement_allDev_fastStrobe();
}

void dmxAnim_movingHead_noMovement_allDev_fastStrobe_CTO() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_CTO);
  dmxAnim_movingHead_noMovement_allDev_fastStrobe();
}


/////// Set the color for composite animations

// -> All devices :    o o o o o

void dmxAnim_movingHead_setColorForCompositeAnimations_allDev_white() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_WHITE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_allDev_red() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_RED);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_allDev_deepRed() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_RED);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_allDev_blue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_BLUE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_allDev_deepBlue() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_DEEP_BLUE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_allDev_yellow() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_YELLOW);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_allDev_green() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_GREEN);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_allDev_ultraviolet() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ULTRAVIOLET);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_allDev_orange() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_ORANGE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_allDev_CTO() {
  dmxAnim_movingHead_setColor_allDev(DMX_COLORWHEEL_CTO);
}

// -> Center devices :   x o o o x

void dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_white() {
  dmxAnim_movingHead_setColor_centerDev(DMX_COLORWHEEL_WHITE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_red() {
  dmxAnim_movingHead_setColor_centerDev(DMX_COLORWHEEL_RED);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_deepRed() {
  dmxAnim_movingHead_setColor_centerDev(DMX_COLORWHEEL_DEEP_RED);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_blue() {
  dmxAnim_movingHead_setColor_centerDev(DMX_COLORWHEEL_BLUE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_deepBlue() {
  dmxAnim_movingHead_setColor_centerDev(DMX_COLORWHEEL_DEEP_BLUE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_yellow() {
  dmxAnim_movingHead_setColor_centerDev(DMX_COLORWHEEL_YELLOW);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_green() {
  dmxAnim_movingHead_setColor_centerDev(DMX_COLORWHEEL_GREEN);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_ultraviolet() {
  dmxAnim_movingHead_setColor_centerDev(DMX_COLORWHEEL_ULTRAVIOLET);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_orange() {
  dmxAnim_movingHead_setColor_centerDev(DMX_COLORWHEEL_ORANGE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_centerDev_CTO() {
  dmxAnim_movingHead_setColor_centerDev(DMX_COLORWHEEL_CTO);
}

// -> Side devices :     o x x x o

void dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_white() {
  dmxAnim_movingHead_setColor_sideDev(DMX_COLORWHEEL_WHITE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_red() {
  dmxAnim_movingHead_setColor_sideDev(DMX_COLORWHEEL_RED);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_deepRed() {
  dmxAnim_movingHead_setColor_sideDev(DMX_COLORWHEEL_DEEP_RED);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_blue() {
  dmxAnim_movingHead_setColor_sideDev(DMX_COLORWHEEL_BLUE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_deepBlue() {
  dmxAnim_movingHead_setColor_sideDev(DMX_COLORWHEEL_DEEP_BLUE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_yellow() {
  dmxAnim_movingHead_setColor_sideDev(DMX_COLORWHEEL_YELLOW);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_green() {
  dmxAnim_movingHead_setColor_sideDev(DMX_COLORWHEEL_GREEN);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_ultraviolet() {
  dmxAnim_movingHead_setColor_sideDev(DMX_COLORWHEEL_ULTRAVIOLET);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_orange() {
  dmxAnim_movingHead_setColor_sideDev(DMX_COLORWHEEL_ORANGE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_sideDev_CTO() {
  dmxAnim_movingHead_setColor_sideDev(DMX_COLORWHEEL_CTO);
}

// -> Left devices :     o o x x x

void dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_white() {
  dmxAnim_movingHead_setColor_leftDev(DMX_COLORWHEEL_WHITE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_red() {
  dmxAnim_movingHead_setColor_leftDev(DMX_COLORWHEEL_RED);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_deepRed() {
  dmxAnim_movingHead_setColor_leftDev(DMX_COLORWHEEL_DEEP_RED);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_blue() {
  dmxAnim_movingHead_setColor_leftDev(DMX_COLORWHEEL_BLUE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_deepBlue() {
  dmxAnim_movingHead_setColor_leftDev(DMX_COLORWHEEL_DEEP_BLUE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_yellow() {
  dmxAnim_movingHead_setColor_leftDev(DMX_COLORWHEEL_YELLOW);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_green() {
  dmxAnim_movingHead_setColor_leftDev(DMX_COLORWHEEL_GREEN);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_ultraviolet() {
  dmxAnim_movingHead_setColor_leftDev(DMX_COLORWHEEL_ULTRAVIOLET);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_orange() {
  dmxAnim_movingHead_setColor_leftDev(DMX_COLORWHEEL_ORANGE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_leftDev_CTO() {
  dmxAnim_movingHead_setColor_leftDev(DMX_COLORWHEEL_CTO);
}

// -> Right devices :    x x x o o

void dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_white() {
  dmxAnim_movingHead_setColor_rightDev(DMX_COLORWHEEL_WHITE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_red() {
  dmxAnim_movingHead_setColor_rightDev(DMX_COLORWHEEL_RED);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_deepRed() {
  dmxAnim_movingHead_setColor_rightDev(DMX_COLORWHEEL_DEEP_RED);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_blue() {
  dmxAnim_movingHead_setColor_rightDev(DMX_COLORWHEEL_BLUE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_deepBlue() {
  dmxAnim_movingHead_setColor_rightDev(DMX_COLORWHEEL_DEEP_BLUE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_yellow() {
  dmxAnim_movingHead_setColor_rightDev(DMX_COLORWHEEL_YELLOW);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_green() {
  dmxAnim_movingHead_setColor_rightDev(DMX_COLORWHEEL_GREEN);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_ultraviolet() {
  dmxAnim_movingHead_setColor_rightDev(DMX_COLORWHEEL_ULTRAVIOLET);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_orange() {
  dmxAnim_movingHead_setColor_rightDev(DMX_COLORWHEEL_ORANGE);
}

void dmxAnim_movingHead_setColorForCompositeAnimations_rightDev_CTO() {
  dmxAnim_movingHead_setColor_rightDev(DMX_COLORWHEEL_CTO);
}



// Set the light style for the animations

void dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(int style) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads) {
    movingHead.setCurrentLightStyle(style);
  }
}

void dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(int style) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads_center) {
    movingHead.setCurrentLightStyle(style);
  }
}

void dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(int style) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads_side) {
    movingHead.setCurrentLightStyle(style);
  }
}

void dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(int style) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads_left) {
    movingHead.setCurrentLightStyle(style);
  }
}

void dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(int style) {
  for (DMX_MovingHead movingHead: DMXList_MovingHeads_right) {
    movingHead.setCurrentLightStyle(style);
  }
}

void dmxAnim_movingHead_setLightStyle_allDev_continuousLight() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_CONTINUOUS_LIGHT);
}

void dmxAnim_movingHead_setLightStyle_allDev_slowCrescendoLight() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_SLOW_CRESCENDO);
}

void dmxAnim_movingHead_setLightStyle_allDev_fastCrescendoLight() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_FAST_CRESCENDO);
}

void dmxAnim_movingHead_setLightStyle_allDev_singleShortFlash() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_SINGLE_SHORT_FLASH);
}

void dmxAnim_movingHead_setLightStyle_allDev_singleLongFlash() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_SINGLE_LONG_FLASH);
}

void dmxAnim_movingHead_setLightStyle_allDev_slowStrobe() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_SLOW_STROBE);
}

void dmxAnim_movingHead_setLightStyle_allDev_mediumStrobe() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_MEDIUM_STROBE);
}

void dmxAnim_movingHead_setLightStyle_allDev_fastStrobe() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_FAST_STROBE);
}

void dmxAnim_movingHead_setLightStyle_allDev_slowSineWave() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_SLOW_SINE_WAVE);
}

void dmxAnim_movingHead_setLightStyle_allDev_fastSineWave() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_FAST_SINE_WAVE);
}

void dmxAnim_movingHead_setLightStyle_allDev_randomGlitch() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_RANDOM_GLITCH);
}

void dmxAnim_movingHead_setLightStyle_allDev_minimalApertureBeam() {
  dmxAnim_movingHead_setLightStyle_allDev_specificLightStyle(DMXANIM_MIN_APERTURE_BEAM); 
}

////

void dmxAnim_movingHead_setLightStyle_centerDev_continuousLight() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_CONTINUOUS_LIGHT);
}

void dmxAnim_movingHead_setLightStyle_centerDev_slowCrescendoLight() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_SLOW_CRESCENDO);
}

void dmxAnim_movingHead_setLightStyle_centerDev_fastCrescendoLight() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_FAST_CRESCENDO);
}

void dmxAnim_movingHead_setLightStyle_centerDev_singleShortFlash() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_SINGLE_SHORT_FLASH);
}

void dmxAnim_movingHead_setLightStyle_centerDev_singleLongFlash() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_SINGLE_LONG_FLASH);
}

void dmxAnim_movingHead_setLightStyle_centerDev_slowStrobe() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_SLOW_STROBE);
}

void dmxAnim_movingHead_setLightStyle_centerDev_mediumStrobe() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_MEDIUM_STROBE);
}

void dmxAnim_movingHead_setLightStyle_centerDev_fastStrobe() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_FAST_STROBE);
}

void dmxAnim_movingHead_setLightStyle_centerDev_slowSineWave() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_SLOW_SINE_WAVE);
}

void dmxAnim_movingHead_setLightStyle_centerDev_fastSineWave() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_FAST_SINE_WAVE);
}

void dmxAnim_movingHead_setLightStyle_centerDev_randomGlitch() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_RANDOM_GLITCH);
}

void dmxAnim_movingHead_setLightStyle_centerDev_minimalApertureBeam() {
  dmxAnim_movingHead_setLightStyle_centerDev_specificLightStyle(DMXANIM_MIN_APERTURE_BEAM); 
}

////

void dmxAnim_movingHead_setLightStyle_sideDev_continuousLight() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_CONTINUOUS_LIGHT);
}

void dmxAnim_movingHead_setLightStyle_sideDev_slowCrescendoLight() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_SLOW_CRESCENDO);
}

void dmxAnim_movingHead_setLightStyle_sideDev_fastCrescendoLight() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_FAST_CRESCENDO);
}

void dmxAnim_movingHead_setLightStyle_sideDev_singleShortFlash() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_SINGLE_SHORT_FLASH);
}

void dmxAnim_movingHead_setLightStyle_sideDev_singleLongFlash() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_SINGLE_LONG_FLASH);
}

void dmxAnim_movingHead_setLightStyle_sideDev_slowStrobe() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_SLOW_STROBE);
}

void dmxAnim_movingHead_setLightStyle_sideDev_mediumStrobe() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_MEDIUM_STROBE);
}

void dmxAnim_movingHead_setLightStyle_sideDev_fastStrobe() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_FAST_STROBE);
}

void dmxAnim_movingHead_setLightStyle_sideDev_slowSineWave() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_SLOW_SINE_WAVE);
}

void dmxAnim_movingHead_setLightStyle_sideDev_fastSineWave() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_FAST_SINE_WAVE);
}

void dmxAnim_movingHead_setLightStyle_sideDev_randomGlitch() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_RANDOM_GLITCH);
}

void dmxAnim_movingHead_setLightStyle_sideDev_minimalApertureBeam() {
  dmxAnim_movingHead_setLightStyle_sideDev_specificLightStyle(DMXANIM_MIN_APERTURE_BEAM); 
}


//////

void dmxAnim_movingHead_setLightStyle_leftDev_continuousLight() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_CONTINUOUS_LIGHT);
}

void dmxAnim_movingHead_setLightStyle_leftDev_slowCrescendoLight() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_SLOW_CRESCENDO);
}

void dmxAnim_movingHead_setLightStyle_leftDev_fastCrescendoLight() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_FAST_CRESCENDO);
}

void dmxAnim_movingHead_setLightStyle_leftDev_singleShortFlash() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_SINGLE_SHORT_FLASH);
}

void dmxAnim_movingHead_setLightStyle_leftDev_singleLongFlash() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_SINGLE_LONG_FLASH);
}

void dmxAnim_movingHead_setLightStyle_leftDev_slowStrobe() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_SLOW_STROBE);
}

void dmxAnim_movingHead_setLightStyle_leftDev_mediumStrobe() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_MEDIUM_STROBE);
}

void dmxAnim_movingHead_setLightStyle_leftDev_fastStrobe() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_FAST_STROBE);
}

void dmxAnim_movingHead_setLightStyle_leftDev_slowSineWave() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_SLOW_SINE_WAVE);
}

void dmxAnim_movingHead_setLightStyle_leftDev_fastSineWave() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_FAST_SINE_WAVE);
}

void dmxAnim_movingHead_setLightStyle_leftDev_randomGlitch() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_RANDOM_GLITCH);
}

void dmxAnim_movingHead_setLightStyle_leftDev_minimalApertureBeam() {
  dmxAnim_movingHead_setLightStyle_leftDev_specificLightStyle(DMXANIM_MIN_APERTURE_BEAM); 
}

//////

void dmxAnim_movingHead_setLightStyle_rightDev_continuousLight() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_CONTINUOUS_LIGHT);
}

void dmxAnim_movingHead_setLightStyle_rightDev_slowCrescendoLight() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_SLOW_CRESCENDO);
}

void dmxAnim_movingHead_setLightStyle_rightDev_fastCrescendoLight() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_FAST_CRESCENDO);
}

void dmxAnim_movingHead_setLightStyle_rightDev_singleShortFlash() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_SINGLE_SHORT_FLASH);
}

void dmxAnim_movingHead_setLightStyle_rightDev_singleLongFlash() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_SINGLE_LONG_FLASH);
}

void dmxAnim_movingHead_setLightStyle_rightDev_slowStrobe() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_SLOW_STROBE);
}

void dmxAnim_movingHead_setLightStyle_rightDev_mediumStrobe() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_MEDIUM_STROBE);
}

void dmxAnim_movingHead_setLightStyle_rightDev_fastStrobe() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_FAST_STROBE);
}

void dmxAnim_movingHead_setLightStyle_rightDev_slowSineWave() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_SLOW_SINE_WAVE);
}

void dmxAnim_movingHead_setLightStyle_rightDev_fastSineWave() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_FAST_SINE_WAVE);
}

void dmxAnim_movingHead_setLightStyle_rightDev_randomGlitch() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_RANDOM_GLITCH);
}

void dmxAnim_movingHead_setLightStyle_rightDev_minimalApertureBeam() {
  dmxAnim_movingHead_setLightStyle_rightDev_specificLightStyle(DMXANIM_MIN_APERTURE_BEAM); 
}





// Reach a certain position with the dimmer on, as fast as the device can

void dmxAnim_movingHead_lightOn_fastMove_allDev_CenterPan_LowTilt() {
  dmxAnim_movingHead_prepareDirection_CenterPan_LowTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_LeftPan_LowTilt() {
  dmxAnim_movingHead_prepareDirection_LeftPan_LowTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_RightPan_LowTilt() {
  dmxAnim_movingHead_prepareDirection_RightPan_LowTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_CenterPan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_CenterPan_FrontTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_LeftPan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_LeftPan_FrontTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_RightPan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_RightPan_FrontTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_CenterPan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_CenterPan_HighTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_LeftPan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_LeftPan_HighTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_RightPan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_RightPan_HighTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_CenterPan_UprightTilt() {
  dmxAnim_movingHead_prepareDirection_CenterPan_UprightTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_LeftPan_UprightTilt() {
  dmxAnim_movingHead_prepareDirection_LeftPan_UprightTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_RightPan_UprightTilt() {
  dmxAnim_movingHead_prepareDirection_RightPan_UprightTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_CenterPan_BackTilt() {
  dmxAnim_movingHead_prepareDirection_CenterPan_BackTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_LeftPan_BackTilt() {
  dmxAnim_movingHead_prepareDirection_LeftPan_BackTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_RightPan_BackTilt() {
  dmxAnim_movingHead_prepareDirection_RightPan_BackTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}


void dmxAnim_movingHead_lightOn_fastMove_allDev_WideDivergentPan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_WidePan_FrontTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_ClassicDivergentPan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_ClassicPan_FrontTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_WideDivergentPan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_WidePan_HighTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_ClassicDivergentPan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_ClassicPan_HighTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_WideConvergentPan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_WidePan_FrontTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_ClassicConergentPan_FrontTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_ClassicPan_FrontTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_WideConvergentPan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_WidePan_HighTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_ClassicConvergentPan_HighTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalConvergentPan_ClassicPan_HighTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}


void dmxAnim_movingHead_lightOn_fastMove_allDev_ExtremeDivergentPan_WideNegTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_WideNegTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_ExtremeDivergentPan_NarrowNegTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_NarrowNegTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_ExtremeDivergentPan_WidePosTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_WidePosTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}

void dmxAnim_movingHead_lightOn_fastMove_allDev_ExtremeDivergentPan_NarrowPosTilt() {
  dmxAnim_movingHead_prepareDirection_SymmetricalDivergentPan_DivergentTilt_ExtremePan_NarrowPosTilt();
  dmxAnim_movingHead_noMovement_allDev_performCurrentLightStyle();
}


////////////////////////////////////////////////////////////////////////


