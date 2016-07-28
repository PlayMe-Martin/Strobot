///////////////////////////////////////////
//       Fixture management - PAR        //
///////////////////////////////////////////


final String DMX_PAR_DIMMER_GLOBAL                           = "DIMMER";
final String DMX_PAR_DIMMER_RED                              = "DIMMER_RED";
final String DMX_PAR_DIMMER_GREEN                            = "DIMMER_GREEN";
final String DMX_PAR_DIMMER_BLUE                             = "DIMMER_BLUE";
final String DMX_PAR_DIMMER_WHITE                            = "DIMMER_WHITE";
final String DMX_PAR_STROBE                                  = "DIMMER_STROBE";
final String DMX_PAR_INTENSITY_RED                           = "INTENSITY_RED";
final String DMX_PAR_INTENSITY_GREEN                         = "INTENSITY_GREEN";
final String DMX_PAR_INTENSITY_BLUE                          = "INTENSITY_BLUE";
final String DMX_PAR_COLORWHEEL                              = "COLORWHEEL";

final int    DMX_PAR_COLORMODE_UNDEFINED              = 0;
final int    DMX_PAR_COLORMODE_WHEEL                  = 1;
final String DMX_PAR_COLORMODE_WHEEL_TEXT             = "WHEEL";
final int    DMX_PAR_COLORMODE_RGB                    = 2;
final String DMX_PAR_COLORMODE_RGB_TEXT               = "RGB";
final int    DMX_PAR_COLORMODE_CMY                    = 3;
final String DMX_PAR_COLORMODE_CMY_TEXT               = "CMY";
final int    DMX_PAR_COLORMODE_RGBW                   = 4;
final String DMX_PAR_COLORMODE_RGBW_TEXT              = "RGBW";
final int    DMX_PAR_COLORMODE_SINGLE                 = 5;
final String DMX_PAR_COLORMODE_SINGLE_TEXT            = "SINGLE";

// final String DMX_MOVINGHEAD_COLORMODE_RGB_R                  = "R";
// final String DMX_MOVINGHEAD_COLORMODE_RGB_G                  = "G";
// final String DMX_MOVINGHEAD_COLORMODE_RGB_B                  = "B";
// final String DMX_MOVINGHEAD_COLORMODE_RGB_W                  = "W";
// final String DMX_MOVINGHEAD_COLORMODE_CMY_C                  = "C";
// final String DMX_MOVINGHEAD_COLORMODE_CMY_M                  = "M";
// final String DMX_MOVINGHEAD_COLORMODE_CMY_Y                  = "Y";

final String DMX_PAR_COLORWHEEL_WHITE_TEXT            = "WHITE";
final String DMX_PAR_COLORWHEEL_RED_TEXT              = "RED";
final String DMX_PAR_COLORWHEEL_DEEP_RED_TEXT         = "DEEP_RED";
final String DMX_PAR_COLORWHEEL_BLUE_TEXT             = "BLUE";
final String DMX_PAR_COLORWHEEL_DEEP_BLUE_TEXT        = "DEEP_BLUE";
final String DMX_PAR_COLORWHEEL_YELLOW_TEXT           = "YELLOW";
final String DMX_PAR_COLORWHEEL_GREEN_TEXT            = "GREEN";
final String DMX_PAR_COLORWHEEL_ULTRAVIOLET_TEXT      = "ULTRAVIOLET";
final String DMX_PAR_COLORWHEEL_ORANGE_TEXT           = "ORANGE";
final String DMX_PAR_COLORWHEEL_CTO_TEXT              = "CTO";
final int    DMX_PAR_COLORWHEEL_WHITE                 = 0;
final int    DMX_PAR_COLORWHEEL_RED                   = 1;
final int    DMX_PAR_COLORWHEEL_DEEP_RED              = 2;
final int    DMX_PAR_COLORWHEEL_BLUE                  = 3;
final int    DMX_PAR_COLORWHEEL_DEEP_BLUE             = 4;
final int    DMX_PAR_COLORWHEEL_YELLOW                = 5;
final int    DMX_PAR_COLORWHEEL_GREEN                 = 6;
final int    DMX_PAR_COLORWHEEL_ULTRAVIOLET           = 7;
final int    DMX_PAR_COLORWHEEL_ORANGE                = 8;
final int    DMX_PAR_COLORWHEEL_CTO                   = 9;

final String DMX_PAR_STROBE_OPEN                      = "OPEN";
final String DMX_PAR_SHUTTER_STROBE                   = "STROBE";
final int    DMX_PAR_STROBEMODE_DEFAULT               = 0;
final int    DMX_PAR_STROBEMODE_STROBE                = 1;

final int    DMX_PAR_DEFAULT_FALLBACK_VAL             = 0;          // Default value used at initialisation, and in case of error


// // Constants used for the animations
final int    DMXANIM_PAR_BLACKOUT                     = 0;
final int    DMXANIM_PAR_CONTINUOUS_LIGHT_MAX         = 1;
final int    DMXANIM_PAR_CONTINUOUS_LIGHT_STRONG      = 2;
final int    DMXANIM_PAR_CONTINUOUS_LIGHT_MEDIUM      = 3;
final int    DMXANIM_PAR_CONTINUOUS_LIGHT_WEAK        = 4;
final int    DMXANIM_PAR_SINGLE_LONG_FLASH            = 5;
final int    DMXANIM_PAR_SINGLE_SHORT_FLASH           = 6;
final int    DMXANIM_PAR_SLOW_CRESCENDO               = 7;
final int    DMXANIM_PAR_FAST_CRESCENDO               = 8;
final int    DMXANIM_PAR_SLOW_STROBE                  = 9;
final int    DMXANIM_PAR_MEDIUM_STROBE                = 10;
final int    DMXANIM_PAR_FAST_STROBE                  = 11;
final int    DMXANIM_PAR_SLOW_SINE_WAVE_CLOCKWISE     = 12;
final int    DMXANIM_PAR_FAST_SINE_WAVE_CLOCKWISE     = 13;
final int    DMXANIM_PAR_SLOW_SINE_WAVE_ANTICLOCKWISE = 14;
final int    DMXANIM_PAR_FAST_SINE_WAVE_ANTICLOCKWISE = 15;
final int    DMXANIM_PAR_RANDOM_GLITCH                = 16;


// // Constants used for the light rhythms
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_NOSYNC                     = 0;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_32NDSYNC          = 1;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_16THSYNC          = 2;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_8THSYNC           = 3;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_4THSYNC           = 4;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_2NDSYNC           = 5;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_BARSYNC           = 6;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_32NDSYNC         = 7;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_16THSYNC         = 8;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_8THSYNC          = 9;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_4THSYNC          = 10;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_2NDSYNC          = 11;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_BARSYNC          = 12;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_32NDSYNC     = 13;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_16THSYNC     = 14;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_8THSYNC      = 15;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_4THSYNC      = 16;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_2NDSYNC      = 17;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_BARSYNC      = 18;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_32NDSYNC            = 19;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_16THSYNC            = 20;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_8THSYNC             = 21;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_4THSYNC             = 22;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_2NDSYNC             = 23;
// final int    DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_BARSYNC             = 24;



class DMX_PAR {

  Fixture par;                                        // The fixture defining this object
  int deviceID;                                       // Device ID: defined at device instanciation, 0 for the fixtures located on house left, n for the fixtures on house right
  int dmxStartAddr;                                   // Address of the first channel
  int syncIdx                              = 0;       // Among the BPM-synced fixtures, define the index

  int nbChannels                           = 0;
  int[] dmxVal;                                       // Array which shall contain all the instant DMX values for all of this fixture's channels

  // Config parameters - depending on these values, the library functions will behave differently
  int chIndex_dimmer_global                = -1;
  int dimmer_global_minVal                 = -1;
  int dimmer_global_maxVal                 = -1;

  int colorControlMode                     = DMX_PAR_COLORMODE_UNDEFINED;

  int chIndex_dimmer_red                   = -1;
  int dimmer_red_minVal                    = -1;
  int dimmer_red_maxVal                    = -1;

  int chIndex_dimmer_green                 = -1;
  int dimmer_green_minVal                  = -1;
  int dimmer_green_maxVal                  = -1;

  int chIndex_dimmer_blue                  = -1;
  int dimmer_blue_minVal                   = -1;
  int dimmer_blue_maxVal                   = -1;

  int chIndex_dimmer_white                 = -1;
  int dimmer_white_minVal                  = -1;
  int dimmer_white_maxVal                  = -1;

  int chIndex_intensity_red                = -1;
  int intensity_red_minVal                 = -1;
  int intensity_red_maxVal                 = -1;

  int chIndex_intensity_green              = -1;
  int intensity_green_minVal               = -1;
  int intensity_green_maxVal               = -1;

  int chIndex_intensity_blue               = -1;
  int intensity_blue_minVal                = -1;
  int intensity_blue_maxVal                = -1;

  int chIndex_strobe                       = -1;
  int strobe_minVal                        = -1;
  int strobe_maxVal                        = -1;

  int chIndex_colorWheel                   = -1;
  
  
  IntList available_chIndex_color;
  
  // int chIndex_color_WHEEL                  = -1;
  // int chIndex_color_CMY_C                  = -1;      // Shall be defined only if used
  // int chIndex_color_CMY_M                  = -1;      // Shall be defined only if used
  // int chIndex_color_CMY_Y                  = -1;      // Shall be defined only if used
  // int chIndex_color_RGB_R                  = -1;      // Shall be defined only if used
  // int chIndex_color_RGB_G                  = -1;      // Shall be defined only if used
  // int chIndex_color_RGB_B                  = -1;      // Shall be defined only if used
  // int chIndex_color_RGB_W                  = -1;      // Shall be defined only if used
      

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


  //// - End of the physical PAR description - ////

  int currentLightStyle                   = DMXANIM_PAR_CONTINUOUS_LIGHT_MAX;     // Used by the global animations
  // int currentRhythmPattern                = DMXANIM_PAR_LIGHTRHYTHM_NOSYNC;       // Used by the global animations
  int animCpt1                            = 0;                                    // Counters used for the global animations
  int animCpt2                            = 0;


  
  //Additional variables which might be used by other non-DMX related functions (most notably, the simulator)
  int[] simulator_colorRGB;


  // Fixtures are instanciated using their name: the constructor will then look up in the fixture library if such a device exists, and throw an exception if not
  DMX_PAR(String name, int deviceID, int startAddr) throws UndefinedFixtureException {

    this.deviceID = deviceID;
    this.dmxStartAddr = startAddr;

    // Init
    par = getFixtureFromName(name);
    if (par.isValidFixture() == false) {
      throw new UndefinedFixtureException("Undefined fixture: " + name);
    }

    nbChannels       = par.getNbChannels();
    dmxVal           = new int[nbChannels];
    for (int i=0; i<nbChannels; i++) {
      dmxVal[i] = DMX_PAR_DEFAULT_FALLBACK_VAL;
    }

    boolean fixtureCanBeCreated = checkDmxAddressMapping(dmxStartAddr, nbChannels);
    if (fixtureCanBeCreated == false) {
      outputLog.println("PAR DMX instanciation failure - check the mapping for device ID " + this.deviceID + " (start address=" + startAddr + ", number of channels=" + nbChannels);
    }

    // Now parse individual functions

    parseFixtureDimmerControl();
    parseFixtureIndividualColorIntensityControl();
    
    // If more than one color mode is available, the priority goes to the color wheel. If not, use what's possible
    // parseFixtureColorModes();
    // colorControlMode = defineColorMode();


    // parseFixtureShutterModes();

    // Check other functions this fixture may have - search for all channels with a recommended channel set - this will become the default value for these channels
    parseDefaultChannels();


    setMiscVariablesDefaultValues();
  }

  int getDeviceID() {
    return this.deviceID;
  }

  void setSyncIdx(int idx) {
    this.syncIdx = idx;
  }



  // Set the default values for non-dmx related variables
  void setMiscVariablesDefaultValues() {
    simulator_colorRGB = new int[3];
    simulator_colorRGB[0] = 255;   // White
    simulator_colorRGB[1] = 255;   // White
    simulator_colorRGB[2] = 255;   // White
  }

  void parseFixtureDimmerControl() {

    chIndex_dimmer_global  = par.getChannelIndexCorrespondingToFunction(DMX_PAR_DIMMER_GLOBAL);
    chIndex_dimmer_red     = par.getChannelIndexCorrespondingToFunction(DMX_PAR_DIMMER_RED);
    chIndex_dimmer_green   = par.getChannelIndexCorrespondingToFunction(DMX_PAR_DIMMER_GREEN);
    chIndex_dimmer_blue    = par.getChannelIndexCorrespondingToFunction(DMX_PAR_DIMMER_BLUE);
    chIndex_dimmer_white   = par.getChannelIndexCorrespondingToFunction(DMX_PAR_DIMMER_WHITE);

    ChannelDesc channel;
    ArrayList<ChannelSet> channelSets;

    if (chIndex_dimmer_global != -1) {
      channel = par.getChannelCorrespondingToIndex(chIndex_dimmer_global);
      channelSets = channel.getAllChannelSets();
      for (ChannelSet channelSet: channelSets) {
        if (channelSet.getSubfunction().equals(DMX_PAR_DIMMER_GLOBAL)) {
            dimmer_global_minVal = channelSet.getFrom_dmx();
            dimmer_global_maxVal = channelSet.getTo_dmx();
        }
      }
    }

    if (chIndex_dimmer_red != -1) {
      channel = par.getChannelCorrespondingToIndex(chIndex_dimmer_red);
      channelSets = channel.getAllChannelSets();
      for (ChannelSet channelSet: channelSets) {
        if (channelSet.getSubfunction().equals(DMX_PAR_DIMMER_RED)) {
            dimmer_red_minVal = channelSet.getFrom_dmx();
            dimmer_red_maxVal = channelSet.getTo_dmx();
        }
      }
    }

    if (chIndex_dimmer_global != -1) {
      channel = par.getChannelCorrespondingToIndex(chIndex_dimmer_green);
      channelSets = channel.getAllChannelSets();
      for (ChannelSet channelSet: channelSets) {
        if (channelSet.getSubfunction().equals(DMX_PAR_DIMMER_GREEN)) {
            dimmer_green_minVal = channelSet.getFrom_dmx();
            dimmer_green_maxVal = channelSet.getTo_dmx();
        }
      }
    }

    if (chIndex_dimmer_global != -1) {
      channel = par.getChannelCorrespondingToIndex(chIndex_dimmer_blue);
      channelSets = channel.getAllChannelSets();
      for (ChannelSet channelSet: channelSets) {
        if (channelSet.getSubfunction().equals(DMX_PAR_DIMMER_BLUE)) {
            dimmer_blue_minVal = channelSet.getFrom_dmx();
            dimmer_blue_maxVal = channelSet.getTo_dmx();
        }
      }
    }

    if (chIndex_dimmer_global != -1) {
      channel = par.getChannelCorrespondingToIndex(chIndex_dimmer_white);
      channelSets = channel.getAllChannelSets();
      for (ChannelSet channelSet: channelSets) {
        if (channelSet.getSubfunction().equals(DMX_PAR_DIMMER_WHITE)) {
            dimmer_white_minVal = channelSet.getFrom_dmx();
            dimmer_white_maxVal = channelSet.getTo_dmx();
        }
      }
    }

  }

  void parseFixtureIndividualColorIntensityControl() {

    chIndex_intensity_red     = par.getChannelIndexCorrespondingToFunction(DMX_PAR_INTENSITY_RED);
    chIndex_intensity_green   = par.getChannelIndexCorrespondingToFunction(DMX_PAR_INTENSITY_GREEN);
    chIndex_intensity_blue    = par.getChannelIndexCorrespondingToFunction(DMX_PAR_INTENSITY_BLUE);
    
    ChannelDesc channel;
    ArrayList<ChannelSet> channelSets;

    if (chIndex_dimmer_red != -1) {
      channel = par.getChannelCorrespondingToIndex(chIndex_intensity_red);
      channelSets = channel.getAllChannelSets();
      for (ChannelSet channelSet: channelSets) {
        if (channelSet.getSubfunction().equals(DMX_PAR_INTENSITY_RED)) {
            intensity_red_minVal = channelSet.getFrom_dmx();
            intensity_red_maxVal = channelSet.getTo_dmx();
        }
      }
    }

    if (chIndex_dimmer_global != -1) {
      channel = par.getChannelCorrespondingToIndex(chIndex_intensity_green);
      channelSets = channel.getAllChannelSets();
      for (ChannelSet channelSet: channelSets) {
        if (channelSet.getSubfunction().equals(DMX_PAR_INTENSITY_GREEN)) {
            intensity_green_minVal = channelSet.getFrom_dmx();
            intensity_green_maxVal = channelSet.getTo_dmx();
        }
      }
    }

    if (chIndex_dimmer_global != -1) {
      channel = par.getChannelCorrespondingToIndex(chIndex_intensity_blue);
      channelSets = channel.getAllChannelSets();
      for (ChannelSet channelSet: channelSets) {
        if (channelSet.getSubfunction().equals(DMX_PAR_INTENSITY_BLUE)) {
            intensity_blue_minVal = channelSet.getFrom_dmx();
            intensity_blue_maxVal = channelSet.getTo_dmx();
        }
      }
    }

  }





  void parseFixtureColorModes() {
    // Define the available color modes
    // available_chIndex_color = par.getAllChannelIndexesCorrespondingToFunction(DMX_MOVINGHEAD_COLOR);
    // for (int chIndex: available_chIndex_color) {
    //   ChannelDesc channel = movingHead.getChannelCorrespondingToIndex(chIndex);
    //   if (channel.getOption().equals(DMX_MOVINGHEAD_COLORMODE_WHEEL_TEXT)) {
    //     chIndex_color_WHEEL = channel.getIndex();
    //     parseColorWheelChannel(channel);
    //   }
    //   else if (channel.getOption().equals(DMX_MOVINGHEAD_COLORMODE_RGB_TEXT)) {
    //     if (channel.getOptionArgument().equals(DMX_MOVINGHEAD_COLORMODE_RGB_R)) {
    //       chIndex_color_RGB_R = channel.getIndex();
    //     }
    //     else if (channel.getOptionArgument().equals(DMX_MOVINGHEAD_COLORMODE_RGB_G)) {
    //       chIndex_color_RGB_G = channel.getIndex();
    //     }
    //     else if (channel.getOptionArgument().equals(DMX_MOVINGHEAD_COLORMODE_RGB_B)) {
    //       chIndex_color_RGB_B = channel.getIndex();
    //     }
    //   }
    //   else if (channel.getOption().equals(DMX_MOVINGHEAD_COLORMODE_CMY_TEXT)) {
    //     if (channel.getOptionArgument().equals(DMX_MOVINGHEAD_COLORMODE_CMY_C)) {
    //       chIndex_color_CMY_C = channel.getIndex();
    //     }
    //     else if (channel.getOptionArgument().equals(DMX_MOVINGHEAD_COLORMODE_CMY_M)) {
    //       chIndex_color_CMY_M = channel.getIndex();
    //     }
    //     else if (channel.getOptionArgument().equals(DMX_MOVINGHEAD_COLORMODE_CMY_Y)) {
    //       chIndex_color_CMY_Y = channel.getIndex();
    //     }
    //   }
    //   else if (channel.getOption().equals(DMX_MOVINGHEAD_COLORMODE_RGBW_TEXT)) {
    //     if (channel.getOptionArgument().equals(DMX_MOVINGHEAD_COLORMODE_RGB_R)) {
    //       chIndex_color_RGB_R = channel.getIndex();
    //     }
    //     else if (channel.getOptionArgument().equals(DMX_MOVINGHEAD_COLORMODE_RGB_G)) {
    //       chIndex_color_RGB_G = channel.getIndex();
    //     }
    //     else if (channel.getOptionArgument().equals(DMX_MOVINGHEAD_COLORMODE_RGB_B)) {
    //       chIndex_color_RGB_B = channel.getIndex();
    //     }
    //     else if (channel.getOptionArgument().equals(DMX_MOVINGHEAD_COLORMODE_RGB_W)) {
    //       chIndex_color_RGB_W = channel.getIndex();
    //     }
    //   }
    // }
  }

  void parseColorWheelChannel(ChannelDesc colorWheelCh) {
    // ArrayList<ChannelSet> channelSets = colorWheelCh.getAllChannelSets();
    // for (ChannelSet channelSet: channelSets) {
    //   if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_COLORWHEEL_WHITE_TEXT)) {
    //     dmxVal_color_colorWheel_white = channelSet.getFrom_dmx();
    //   }
    //   else if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_COLORWHEEL_RED_TEXT)) {
    //     dmxVal_color_colorWheel_red = channelSet.getFrom_dmx();
    //   }
    //   else if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_COLORWHEEL_DEEP_RED_TEXT)) {
    //     dmxVal_color_colorWheel_deepRed = channelSet.getFrom_dmx();
    //   }
    //   else if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_COLORWHEEL_BLUE_TEXT)) {
    //     dmxVal_color_colorWheel_blue = channelSet.getFrom_dmx();
    //   }
    //   else if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_COLORWHEEL_DEEP_BLUE_TEXT)) {
    //     dmxVal_color_colorWheel_deepBlue = channelSet.getFrom_dmx();
    //   }
    //   else if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_COLORWHEEL_YELLOW_TEXT)) {
    //     dmxVal_color_colorWheel_yellow = channelSet.getFrom_dmx();
    //   }
    //   else if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_COLORWHEEL_GREEN_TEXT)) {
    //     dmxVal_color_colorWheel_green = channelSet.getFrom_dmx();
    //   }
    //   else if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_COLORWHEEL_ULTRAVIOLET_TEXT)) {
    //     dmxVal_color_colorWheel_ultraviolet = channelSet.getFrom_dmx();
    //   }
    //   else if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_COLORWHEEL_ORANGE_TEXT)) {
    //     dmxVal_color_colorWheel_orange = channelSet.getFrom_dmx();
    //   }
    //   else if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_COLORWHEEL_CTO_TEXT)) {
    //     dmxVal_color_colorWheel_cto = channelSet.getFrom_dmx();
    //   }
    // }
  }

  int defineColorMode() {
    // if (chIndex_color_WHEEL != -1) {
    //   return DMX_MOVINGHEAD_COLORMODE_WHEEL;
    // }
    // else if (chIndex_color_RGB_R != -1 && chIndex_color_RGB_G != -1 && chIndex_color_RGB_B != -1 && chIndex_color_RGB_W != -1) {
    //   return DMX_MOVINGHEAD_COLORMODE_RGBW;
    // }
    // else if (chIndex_color_RGB_R != -1 && chIndex_color_RGB_G != -1 && chIndex_color_RGB_B != -1) {
    //   return DMX_MOVINGHEAD_COLORMODE_RGB;
    // }
    // else if (chIndex_color_CMY_C != -1 && chIndex_color_CMY_M != -1 && chIndex_color_CMY_Y != -1) {
    //   return DMX_MOVINGHEAD_COLORMODE_CMY;
    // }
    // else {
    //   return DMX_MOVINGHEAD_COLORMODE_UNDEFINED;
    // }
    return 0;
  }

  void parseFixtureShutterModes() {
    // chIndex_shutter = movingHead.getChannelIndexCorrespondingToFunction(DMX_MOVINGHEAD_SHUTTER);
    // ArrayList<ChannelSet> channelSets = movingHead.getChannelCorrespondingToIndex(chIndex_shutter).getAllChannelSets();

    // for (ChannelSet channelSet: channelSets) {
    //   if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_SHUTTER_OPEN)) {
    //     shutter_open = channelSet.getFrom_dmx();
    //   }
    //   if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_SHUTTER_CLOSED)) { 
    //     shutter_closed = channelSet.getFrom_dmx();
    //   }
    //   if (channelSet.getSubfunction().equals(DMX_MOVINGHEAD_SHUTTER_STROBE)) { 
    //     if (channelSet.isProportional()) {
    //       if (channelSet.isProportional_Increasing()) {
    //         shutter_strobe_minSpeed = channelSet.getFrom_dmx();
    //         shutter_strobe_maxSpeed = channelSet.getTo_dmx();
    //       }
    //     }
    //     else {
    //       // Shouldn't really matter as the channel is set as "non-proportional". However, it is strange that the progressive mode should be defined as such
    //       // By default, set these values as proportional-increasing
    //       shutter_strobe_minSpeed = channelSet.getFrom_dmx();
    //       shutter_strobe_maxSpeed = channelSet.getTo_dmx();
    //     }
    //   }
    // }
  }



  void parseDefaultChannels() {
    ArrayList<ChannelDesc> channelsWithDefaultVal = par.getAllChannelsWithDefaultVal();
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

//   void setDimmer(float val_percent) {
//     if (fineDimmerControl) {
//       int val = int( map(val_percent, 0.0, 100.0, 0, 65535) );
//       dmxVal[chIndex_dimmer]     = (val & 0xffff) >> 8;
//       dmxVal[chIndex_dimmerFine] = (val & 0xffff) &  0xFF;
//     }
//     else {
//       dmxVal[chIndex_dimmer] = int( map(val_percent, 0.0, 100.0, dimmer_minVal, dimmer_maxVal) );
//     }
//   }

//   void setPan(float val_percent) {
//     if (finePanControl) {
//       int val = int( map(val_percent, 0.0, 100.0, 0, 65535) );
//       dmxVal[chIndex_pan]     = (val & 0xffff) >> 8;
//       dmxVal[chIndex_panFine] = (val & 0xffff) &  0xFF;
//     }
//     else {
//       dmxVal[chIndex_pan] = int( map(val_percent, 0.0, 100.0, pan_minVal, pan_maxVal) );
//     }
//   }

//   void setTilt(float val_percent) {
//     if (fineTiltControl) {
//       int val = int( map(val_percent, 0.0, 100.0, 0, 65535) );
//       dmxVal[chIndex_tilt]     = (val & 0xffff) >> 8;
//       dmxVal[chIndex_tiltFine] = (val & 0xffff) &  0xFF;
//     }
//     else {
//       dmxVal[chIndex_tilt] = int( map(val_percent, 0.0, 100.0, tilt_minVal, tilt_maxVal) );
//     }
//   }

//   void setSpeed(float val_percent) {
//     switch (speedMode) {
//       case DMX_MOVINGHEAD_SPEEDMODE_DEFAULT:       dmxVal[chIndex_speedSet] = speedMode_standardSpeed_val; break;  //Ignore the input argument: default speed mode
//       case DMX_MOVINGHEAD_SPEEDMODE_MAX:           dmxVal[chIndex_speedSet] = speedMode_maxSpeed_val; break;       //Ignore the input argument: max speed mode
//       case DMX_MOVINGHEAD_SPEEDMODE_PROGRESSIVE:   dmxVal[chIndex_speedSet] = int( map(val_percent, 0.0, 100.0, speedMode_fine_range_min, speedMode_fine_range_max) ); break;
//       case DMX_MOVINGHEAD_SPEEDMODE_FIXED:         break;  // Nothing to do, no channel reserved for pan/tilt movement speed
//       default: break;
//     }
//   }

//   void setSpeedMode(int requestedMode) {
//     if (requestedMode == DMX_MOVINGHEAD_SPEEDMODE_DEFAULT) {
//       if (chIndex_speedSet != -1 && speedMode_standardSpeed_val != -1) {
//         speedMode = DMX_MOVINGHEAD_SPEEDMODE_DEFAULT;
//       }
//       else {
//         speedMode = DMX_MOVINGHEAD_SPEEDMODE_FIXED;
//       }
//     }
//     else if (requestedMode == DMX_MOVINGHEAD_SPEEDMODE_MAX) {
//       if (chIndex_speedSet != -1 && speedMode_maxSpeed_val != -1) {
//         speedMode = DMX_MOVINGHEAD_SPEEDMODE_MAX;
//       }
//       else if (chIndex_speedSet != -1 && speedMode_standardSpeed_val != -1) {
//         speedMode = DMX_MOVINGHEAD_SPEEDMODE_DEFAULT;
//       }
//       else {
//         speedMode = DMX_MOVINGHEAD_SPEEDMODE_FIXED;
//       }
//     }
//     else if (requestedMode == DMX_MOVINGHEAD_SPEEDMODE_PROGRESSIVE) {
//       if (chIndex_speedSet != -1 && speedMode_fine_range_min != -1 && speedMode_fine_range_max != -1) {
//         speedMode = DMX_MOVINGHEAD_SPEEDMODE_MAX;
//       }
//       else if (chIndex_speedSet != -1 && speedMode_standardSpeed_val != -1) {
//         speedMode = DMX_MOVINGHEAD_SPEEDMODE_DEFAULT;
//       }
//       else {
//         speedMode = DMX_MOVINGHEAD_SPEEDMODE_FIXED;
//       }
//     }
//     else {
//       speedMode = DMX_MOVINGHEAD_SPEEDMODE_FIXED;
//     }
//   }

//   void setSpeed_defaultSpeed() {
//     setSpeedMode(DMX_MOVINGHEAD_SPEEDMODE_DEFAULT);
//     setSpeed(50.0);
//   }

//   void setSpeed_maxSpeed() {
//     setSpeedMode(DMX_MOVINGHEAD_SPEEDMODE_MAX);
//     setSpeed(100.0);
//   }

//   void setSpeed_progressiveSpeed(float val) {
//     setSpeedMode(DMX_MOVINGHEAD_SPEEDMODE_PROGRESSIVE);
//     setSpeed(val);
//   }


//   void setShutter(float val_percent) {
//     if (chIndex_shutter != -1 && shutter_open != -1 && shutter_closed != -1) {
//       if (shutterMode == DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT) {
//         if (val_percent < 50.0) {
//           dmxVal[chIndex_shutter] = shutter_open;
//         }
//         else {
//           dmxVal[chIndex_shutter] = shutter_closed;
//         }
//       }
//       else if (shutterMode == DMX_MOVINGHEAD_SHUTTERMODE_STROBE) {
//         if (shutter_strobe_maxSpeed != -1 && shutter_strobe_minSpeed != -1) {
//           dmxVal[chIndex_shutter] = int( map(val_percent, 0.0, 100.0, shutter_strobe_minSpeed, shutter_strobe_maxSpeed) );
//         }
//         else {
//           dmxVal[chIndex_shutter] = shutter_open;   // This fuxture does not have a strobe control incorporated to its shutter channel
//         }
//       }
//     }
//     else {
//       // Do nothing - this fixture does not support shutter control
//     }
//   }

//   void setShutterMode(int requestedMode) {
//     if (requestedMode == DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT) {
//       shutterMode = DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT;
//     }
//     else if (requestedMode == DMX_MOVINGHEAD_SHUTTERMODE_STROBE) {
//       if (shutter_strobe_maxSpeed != -1 && shutter_strobe_minSpeed != -1) {
//         shutterMode = DMX_MOVINGHEAD_SHUTTERMODE_STROBE;
//       }
//       else {
//         shutterMode = DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT;  // Unsupoorted strobe mode   
//       }
//     }
//   }

//   void setColor(int requestedColor) {
//     switch (requestedColor) {
//       case DMX_MOVINGHEAD_COLORWHEEL_WHITE      : setColor_white();break;
//       case DMX_MOVINGHEAD_COLORWHEEL_RED        : setColor_red();break;
//       case DMX_MOVINGHEAD_COLORWHEEL_DEEP_RED   : setColor_deepRed();break;
//       case DMX_MOVINGHEAD_COLORWHEEL_BLUE       : setColor_blue();break;
//       case DMX_MOVINGHEAD_COLORWHEEL_DEEP_BLUE  : setColor_deepBlue();break;
//       case DMX_MOVINGHEAD_COLORWHEEL_YELLOW     : setColor_yellow();break;
//       case DMX_MOVINGHEAD_COLORWHEEL_GREEN      : setColor_green();break;
//       case DMX_MOVINGHEAD_COLORWHEEL_ULTRAVIOLET: setColor_ultraviolet();break;
//       case DMX_MOVINGHEAD_COLORWHEEL_ORANGE     : setColor_orange();break;
//       case DMX_MOVINGHEAD_COLORWHEEL_CTO        : setColor_cto();break;
//       default: break;
//     }
//   }

//   void setColor_genericColor(int colorWheel_code, int[] colorRGB, int[] colorRGBW) {
//     int[] colorCMY   = {255 - colorRGB[0], 255 - colorRGB[1], 255 - colorRGB[2]};
//     switch (colorControlMode) {
//       case DMX_MOVINGHEAD_COLORMODE_WHEEL    : dmxVal[chIndex_color_WHEEL] = colorWheel_code; break; 
//       case DMX_MOVINGHEAD_COLORMODE_RGB      : dmxVal[chIndex_color_RGB_R] = colorRGB[0];       dmxVal[chIndex_color_RGB_G] = colorRGB[1];       dmxVal[chIndex_color_RGB_B] = colorRGB[2];       break; 
//       case DMX_MOVINGHEAD_COLORMODE_CMY      : dmxVal[chIndex_color_CMY_C] = 255 - colorRGB[0]; dmxVal[chIndex_color_CMY_M] = 255 - colorRGB[1]; dmxVal[chIndex_color_CMY_Y] = 255 - colorRGB[2]; break; 
//       case DMX_MOVINGHEAD_COLORMODE_RGBW     : dmxVal[chIndex_color_RGB_R] = colorRGB[0];       dmxVal[chIndex_color_RGB_G] = colorRGB[1];       dmxVal[chIndex_color_RGB_B] = colorRGB[2];       dmxVal[chIndex_color_RGB_W] = colorRGB[3]; break; 
//       case DMX_MOVINGHEAD_COLORMODE_UNDEFINED: break; 
//       default: break;
//     }

//     // Save colorRGB in order to have the simulator know which color is currently active easily
//     simulator_colorRGB = colorRGB;
//   }

//   int getFallbackColorIfInvalidColorVal(int inputColor) {
//     if (inputColor == -1) {
//       if (dmxVal_color_colorWheel_white != -1) {
//         return dmxVal_color_colorWheel_white;
//       }
//       else {
//         return 0;
//       }
//     }
//     else {
//       return inputColor;
//     }
//   }

//   int getFallbackColorIfInvalidColorVal(int inputColor, int fallbackColor) {
//     if (inputColor == -1) {
//       if (fallbackColor != -1) {
//         return fallbackColor;
//       }
//       else if (dmxVal_color_colorWheel_white != -1) {
//         return dmxVal_color_colorWheel_white;
//       }
//       else {
//         return 0;
//       }
//     }
//     else {
//       return inputColor;
//     }
//   }

//   void setColor_white() {
//     int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_white);
//     int[] colorRGB   = {255, 255, 255};
//     int[] colorRGBW  = {0,   0,   0, 255};
//     setColor_genericColor(colorWheel, colorRGB, colorRGBW);
//   }

//   void setColor_red() {
//     int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_red);
//     int[] colorRGB   = {255, 0,   0};
//     int[] colorRGBW  = {255, 0,   0,   0};
//     setColor_genericColor(colorWheel, colorRGB, colorRGBW); 
//   }

//   void setColor_deepRed() {
//     int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_deepRed, dmxVal_color_colorWheel_red);
//     int[] colorRGB   = {139, 0,   0};
//     int[] colorRGBW  = {139, 0,   0,   0};
//     setColor_genericColor(colorWheel, colorRGB, colorRGBW); 
//   }

//   void setColor_blue() {
//     int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_blue);
//     int[] colorRGB   = {0,   0, 255};
//     int[] colorRGBW  = {0,   0, 255,   0};
//     setColor_genericColor(colorWheel, colorRGB, colorRGBW); 
//   }

//   void setColor_deepBlue() {
//     int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_deepBlue, dmxVal_color_colorWheel_blue);
//     int[] colorRGB   = {0,   0, 155};
//     int[] colorRGBW  = {0,   0, 155,   0};
//     setColor_genericColor(colorWheel, colorRGB, colorRGBW); 
//   }

//   void setColor_yellow() {
//     int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_yellow);
//     int[] colorRGB   = {255, 240, 0};
//     int[] colorRGBW  = {255, 240, 0,   0};
//     setColor_genericColor(colorWheel, colorRGB, colorRGBW);  
//   }

//   void setColor_green() {
//     int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_green);
//     int[] colorRGB   = {71, 182, 164};
//     int[] colorRGBW  = {71, 182, 164,   0};
//     setColor_genericColor(colorWheel, colorRGB, colorRGBW);  
//   }

//   void setColor_ultraviolet() {
//     int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_ultraviolet, dmxVal_color_colorWheel_blue);
//     int[] colorRGB   = {62,  6, 148};
//     int[] colorRGBW  = {62,  6, 148,   0};
//     setColor_genericColor(colorWheel, colorRGB, colorRGBW);  
//   }

//   void setColor_orange() {
//     int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_orange, dmxVal_color_colorWheel_red);
//     int[] colorRGB   = {253, 141, 28};
//     int[] colorRGBW  = {255,   0,  0, 160};
//     setColor_genericColor(colorWheel, colorRGB, colorRGBW);  
//   }

//   void setColor_cto() {
//     int   colorWheel = getFallbackColorIfInvalidColorVal(dmxVal_color_colorWheel_cto);
//     int[] colorRGB   = {255, 241, 224};
//     int[] colorRGBW  = {200,   0,  0, 255};
//     setColor_genericColor(colorWheel, colorRGB, colorRGBW);  
//   }



//   void setApertureReduction(float val_percent) {
//     // 100% -> closed aperture. 0% -> open aperture
//     // Different implementations available for the aperture:
//     // - Iris width (continuous control)
//     // - Beam reduction using gobos (step control)
//     if (apertureMode == DMX_MOVINGHEAD_APERTUREMODE_DEFAULT) {
//       // Do nothing: no aperture control for this device
//     }
//     else if (apertureMode == DMX_MOVINGHEAD_APERTUREMODE_PROGRESSIVE) {
//       if (chIndex_aperture != -1 && aperture_progressive_min != -1 && aperture_progressive_max != -1) {
//         dmxVal[chIndex_aperture] = int( map(val_percent, 0.0, 100.0, aperture_progressive_min, aperture_progressive_max) );
//       }
//     }
//     else if (apertureMode == DMX_MOVINGHEAD_APERTUREMODE_STEP) {
//       if (aperture_steps.size() > 0) {
//         int step =  int( map(val_percent,0,100.0, 0, aperture_steps.size()));
//         dmxVal[chIndex_aperture] = aperture_steps.get(min(step, aperture_steps.size()-1))[1];
//       }
//     }
//   }

//   void setCurrentLightStyle(int style) {
//     currentLightStyle = style;
//   }

//   void setCurrentRhythmPattern(int rhythm) {
//     currentRhythmPattern = rhythm;
//     dmxAnim_movingHead_computeNbSyncedFixtures();
//   }

//   boolean checkBPMSync() {
//     switch(currentRhythmPattern) {
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_NOSYNC:                      return true;
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_32NDSYNC:           return checkBPMSync_syncedRhythm(8.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_16THSYNC:           return checkBPMSync_syncedRhythm(4.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_8THSYNC:            return checkBPMSync_syncedRhythm(2.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_4THSYNC:            return checkBPMSync_syncedRhythm(1.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_2NDSYNC:            return checkBPMSync_syncedRhythm(0.5);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_TOGETHER_BARSYNC:            return checkBPMSync_syncedRhythm(0.25);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_32NDSYNC:          return checkBPMSync_clockwiseRhythm(8.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_16THSYNC:          return checkBPMSync_clockwiseRhythm(4.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_8THSYNC:           return checkBPMSync_clockwiseRhythm(2.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_4THSYNC:           return checkBPMSync_clockwiseRhythm(1.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_2NDSYNC:           return checkBPMSync_clockwiseRhythm(0.5);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_CLOCKWISE_BARSYNC:           return checkBPMSync_clockwiseRhythm(0.25);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_32NDSYNC:      return checkBPMSync_antiClockwiseRhythm(8.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_16THSYNC:      return checkBPMSync_antiClockwiseRhythm(4.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_8THSYNC:       return checkBPMSync_antiClockwiseRhythm(2.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_4THSYNC:       return checkBPMSync_antiClockwiseRhythm(1.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_2NDSYNC:       return checkBPMSync_antiClockwiseRhythm(0.5);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_ANTICLOCKWISE_BARSYNC:       return checkBPMSync_antiClockwiseRhythm(0.25);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_32NDSYNC:             return checkBPMSync_randomRhythm(8.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_16THSYNC:             return checkBPMSync_randomRhythm(4.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_8THSYNC:              return checkBPMSync_randomRhythm(2.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_4THSYNC:              return checkBPMSync_randomRhythm(1.0);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_2NDSYNC:              return checkBPMSync_randomRhythm(0.5);
//       case DMXANIM_MOVINGHEAD_LIGHTRHYTHM_RANDOM_BARSYNC:              return checkBPMSync_randomRhythm(0.25);

//       default:                                              return false;
//     }
//   }

//   boolean checkBPMSync_clockwiseRhythm(float factor) {
//     int seqRef = int((automaticSequencer.currentPosition*factor % dmxAnim_syncedMovingHeads.size()));
//     if (seqRef == this.syncIdx) {
//       return true;
//     }
//     else {
//       return false;
//     }
//   }

//   boolean checkBPMSync_antiClockwiseRhythm(float factor) {
//     int seqRef = int((automaticSequencer.currentPosition*factor % dmxAnim_syncedMovingHeads.size()));
//     seqRef = dmxAnim_syncedMovingHeads.size() - 1 - seqRef;
//     if (seqRef == this.syncIdx) {
//       return true;
//     }
//     else {
//       return false;
//     }
//   }

//   boolean checkBPMSync_randomRhythm(float factor) {
//     int seqRef = int((automaticSequencer.currentPosition*factor % dmxAnim_syncedMovingHeads.size()));
//     int randomIdx = getGlobalRandomVal_ChangingInt(dmxAnim_syncedMovingHeads.size(), seqRef);
//     if (randomIdx == this.syncIdx) {
//       return true;
//     }
//     else {
//       return false;
//     }
//   }

//   boolean checkBPMSync_syncedRhythm(float factor) {
//     if ((int)(automaticSequencer.currentPosition * factor * 2.0) % 2 == 0) {
//       return true;
//     }
//     else {
//       return false;
//     }
//   }

//   void reinitAnimVars() {
//     this.animCpt1_performLight = 0;
//     this.animCpt2 = 0;
//     this.animCpt3 = 0;
//   }


//   void reinitLightStyleCpt() {
//     this.animCpt1_performLight = 0;
//   }

//   ////////////////////////////////////////////////////////////////////////////////
//   // MOVING HEAD VARIABLES ACCESSORS
//   //////////////////////


//   int[] getSimulatorColor() {
//     return simulator_colorRGB;
//   }

//   int getSimulatorDimmer() {
//     return int( map(dmxVal[chIndex_dimmer], dimmer_minVal, dimmer_maxVal, 0.0, 255.0) );
//   }

//   int getSimulatorTilt() {
//     return dmxVal[chIndex_tilt];
//   }

//   float getSimulatorPan() {
//     if (chIndex_panFine != -1) {
//       return (255.0*dmxVal[chIndex_pan] + dmxVal[chIndex_panFine]) / 255.0;
//     }
//     else {
//       return dmxVal[chIndex_pan];
//     }
//   }

//   int getSimulatorShutterMode() {
//     return shutterMode;
//   }

//   int getSimulatorShutter() {
//     return int( map(dmxVal[chIndex_shutter], shutter_strobe_minSpeed, shutter_strobe_maxSpeed, 0.0, 255.0) );
//   }


//   ////////////////////////////////////////////////////////////////////////////////
//   // ANIMATION FUNCTIONS
//   //////////////////////

//   void performLight_standbyBlackout() {
//     performLight_blackout();
//     reinitLightStyleCpt();
//   }

//   void performLight_currentStyle() {
//     boolean performEnabled = this.checkBPMSync();
//     if (performEnabled) {
//       switch (this.currentLightStyle) {
//         case DMXANIM_MOVINGHEAD_BLACKOUT:                       this.performLight_blackout();                  break;
//         case DMXANIM_MOVINGHEAD_CONTINUOUS_LIGHT:               this.performLight_continuousLight();           break;
//         case DMXANIM_MOVINGHEAD_SINGLE_LONG_FLASH:              this.performLight_singleLongFlash();           break;
//         case DMXANIM_MOVINGHEAD_SINGLE_SHORT_FLASH:             this.performLight_singleShortFlash();          break;
//         case DMXANIM_MOVINGHEAD_SLOW_CRESCENDO:                 this.performLight_slowCrescendo();             break;
//         case DMXANIM_MOVINGHEAD_FAST_CRESCENDO:                 this.performLight_fastCrescendo();             break;
//         case DMXANIM_MOVINGHEAD_SLOW_STROBE:                    this.performLight_slowStrobe();                break;
//         case DMXANIM_MOVINGHEAD_MEDIUM_STROBE:                  this.performLight_mediumStrobe();              break;
//         case DMXANIM_MOVINGHEAD_FAST_STROBE:                    this.performLight_fastStrobe();                break;
//         case DMXANIM_MOVINGHEAD_SLOW_SINE_WAVE_CLOCKWISE:       this.performLight_slowClockwiseSineWave();     break;
//         case DMXANIM_MOVINGHEAD_FAST_SINE_WAVE_CLOCKWISE:       this.performLight_fastClockwiseSineWave();     break;
//         case DMXANIM_MOVINGHEAD_SLOW_SINE_WAVE_ANTICLOCKWISE:   this.performLight_slowAntiClockwiseSineWave(); break;
//         case DMXANIM_MOVINGHEAD_FAST_SINE_WAVE_ANTICLOCKWISE:   this.performLight_fastAntiClockwiseSineWave(); break;
//         case DMXANIM_MOVINGHEAD_RANDOM_GLITCH:                  this.performLight_randomGlitch();              break;
//         case DMXANIM_MOVINGHEAD_MIN_APERTURE_BEAM:              this.performLight_minimalApertureBeam();       break;
//         default:                                     break;
//       }
//     }
//     else {
//       this.performLight_standbyBlackout();
//     }
//   }

//   void performLight_blackout() {
//     this.setDimmer(0);
//   }

//   void performLight_continuousLight() {
//     this.setShutterMode(DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT);
//     this.setDimmer(100);
//     this.setApertureReduction(0);
//   }

//   void performLight_singleLongFlash() {
//     this.setShutterMode(DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT);
//     this.setDimmer(max(0,100-this.animCpt1_performLight));
//     this.setApertureReduction(0);
//     this.animCpt1_performLight += 1;
//   }

//   void performLight_singleShortFlash() {
//     this.setShutterMode(DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT);
//     this.setDimmer(max(0,100-4*this.animCpt1_performLight));
//     this.setApertureReduction(0);
//     this.animCpt1_performLight += 1;
//   }

//   void performLight_slowCrescendo() {
//     this.setShutterMode(DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT);
//     this.setDimmer(min(100,this.animCpt1_performLight));
//     this.setApertureReduction(0);
//     this.animCpt1_performLight += 1;
//   }

//   void performLight_fastCrescendo() {
//     this.setShutterMode(DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT);
//     this.setDimmer(min(100,4*this.animCpt1_performLight));
//     this.setApertureReduction(0);
//     this.animCpt1_performLight += 1;
//   }

//   void performLight_strobe(float dimmer_perCent, float strobeSpeed_perCent) {
//     this.setShutter(strobeSpeed_perCent);
//     this.setShutterMode(DMX_MOVINGHEAD_SHUTTERMODE_STROBE);
//     this.setDimmer(dimmer_perCent);
//     this.setApertureReduction(0);
//   }

//   void performLight_slowStrobe() {
//     performLight_strobe(100, 20);
//   }

//   void performLight_mediumStrobe() {
//     performLight_strobe(100, 50);
//   }

//   void performLight_fastStrobe() {
//     performLight_strobe(100, 90);
//   }

//   void performLight_sineWave(float speed, boolean clockwise) {
//     this.setShutterMode(DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT);
//     float offset = this.deviceID * TWO_PI/float(DMXList_MovingHeads.size());
//     if (clockwise) {
//       this.setDimmer(100 *  (0.5 + 0.5*sin(offset + animCpt1_performLight * speed)));
//     }
//     else {
//       this.setDimmer(100 *  (0.5 + 0.5*sin(offset - animCpt1_performLight * speed)));
//     }
//     this.setApertureReduction(0);
//     this.animCpt1_performLight += 1;
//   }

//   void performLight_slowClockwiseSineWave() {
//     performLight_sineWave(0.125, true);
//   }

//   void performLight_fastClockwiseSineWave() {
//     performLight_sineWave(0.250, true);
//   }

//   void performLight_slowAntiClockwiseSineWave() {
//     performLight_sineWave(0.125, false);
//   }

//   void performLight_fastAntiClockwiseSineWave() {
//     performLight_sineWave(0.250, false);
//   }

//   void performLight_randomGlitch() {
//     // Use perlin noise + deviceID as random seed
//     this.setShutterMode(DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT);
//     this.setDimmer(100 * noise(frameCount*0.1));
//     this.setApertureReduction(0);
//   }

//   void performLight_minimalApertureBeam() {
//     this.setShutterMode(DMX_MOVINGHEAD_SHUTTERMODE_DEFAULT);
//     this.setDimmer(100);
//     this.setApertureReduction(80);
//   }

}


// /////////////////////////////////////////////////////////////////////////////////////
// // Each individual function is a single animation using the registered DMX devices


