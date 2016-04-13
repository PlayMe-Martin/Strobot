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


class DMX_MovingHead {

  Fixture movingHead;                                 // The fixture defining this object

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
  
  // DMX values to be sent
  int dmxVal_dimmer                        = 0;
  int dmxVal_pan                           = 0;
  int dmxVal_tilt                          = 0;
  int dmxVal_color_param1                  = 0;    // Only parameter used by the wheel mode
  int dmxVal_color_param2                  = 0;    // Used by the RGB and the CMY mode
  int dmxVal_color_param3                  = 0;    // Used by the RGB and the CMY mode
  int dmxVal_color_param4                  = 0;    // Used by the RGBW mode
  int dmxVal_speed                         = 0;    // Used if the speed is fine-tuned (DMX_SPEED_MODE_PROGRESSIVE)
  int dmxVal_shutter                       = 0;
  int dmxVal_aperture                      = 0;

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

  



  // Fixtures are instanciated using their name: the constructor will then look up in the fixture library if such a device exists, and throw an exception if not
  DMX_MovingHead(String name) throws UndefinedFixtureException {

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
        if (channelSet.isProportional_Increasing()) {  // The dimmer is always proportional - only need to check if it's increasing or decreasing
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
    }
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
        if (channelSet.isProportional_Increasing()) {  // The dimmer is always proportional - only need to check if it's increasing or decreasing
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
    }

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
      // case DMX_COLORWHEEL_DEEP_RED   : setColor_deepRed();break;
      // case DMX_COLORWHEEL_BLUE       : setColor_blue();break;
      // case DMX_COLORWHEEL_DEEP_BLUE  : setColor_deepBlue();break;
      // case DMX_COLORWHEEL_YELLOW     : setColor_yellow();break;
      // case DMX_COLORWHEEL_GREEN      : setColor_green();break;
      // case DMX_COLORWHEEL_ULTRAVIOLET: setColor_ultraviolet();break;
      // case DMX_COLORWHEEL_ORANGE     : setColor_orange();break;
      // case DMX_COLORWHEEL_CTO        : setColor_cto();break;
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


  ////////////////////////////////////////////////////////////////////////////////
  // ANIMATION FUNCTIONS
  //////////////////////

}




