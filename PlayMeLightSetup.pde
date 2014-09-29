
///////////////////////////////////////////////////////////////////////////////////////////////////////////
///////// PlayMe TripleFuck LED panels - Processing sketch part of the PlayMe live lighting setup /////////
/////////                                 Martin Di Rollo - 2013                                  /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////Main file of the program, contains the configuration, as well as setup and draw functions/////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////



/*
/////////////////////////////////////////////    -  User manual  -    /////////////////////////////////////

This program allows to control a LED matrix synced to MIDI commands.
This program has two modes : automatic and manual. Manual mode allows to create very specific animations,
and leave very little chance in the selection of the different animations.
The easiest way to use this program is manual mode is either :
- within Ableton Live, create a MIDI clip and compose your sequence, in reference to the audio clip you want
- within Maschine, do the same as with Ableton, create a pattern, and link it to a scene
-> Configure the sequencer's MIDI to be output to the IAC virtual MIDI bus (OSX), this will allow this
   program to receive these MIDI commands.
   
In semi-automatic mode, specific MIDI notes control each animation, using MIDI channel 3 :
E7  (MIDI 100) : Change the front stroboscope's speed/intensity (without starting it if it's not active)
F7  (MIDI 101) : Start the front stroboscope
F#7 (MIDI 102) : Stop the front stroboscope
G7  (MIDI 103) : Start the front stroboscope, stop it upon releasing the note
G#7 (MIDI 104) : Start the back stroboscope, stop it upon releasing the note
F9  (MIDI 122) : Change LED panel animation - bank 4
D#9 (MIDI 123) : Change LED panel animation - bank 1
E9  (MIDI 124) : Change LED panel animation - bank 2
F9  (MIDI 125) : Change LED panel animation - bank 3
F#9 (MIDI 126) : Display an image on the LED panels
G9  (MIDI 127) : Change output mapping (change which panel each image is sent to)
For the animations and the images, the animation number is specified via the MIDI note's velocity

These additional commands are also available, using MIDI channel 1 (for a keyboard):
C-1 (MIDI 0)   : For the games - Player 1 Left
D-1 (MIDI 2)   : For the games - Player 1 Right
B0  (MIDI 23)  : For the games - Player 2 Left
C1  (MIDI 24)  : For the games - Player 2 Right

In manual mode, the paradigm is similar, except the selection is not made following the input notes' velocity
Using a MPC-like controller, such as Maschine, pads trigger the animations and the DMX equipments
The registered commands in this mode are:
Note On : trigger an animation according to the configuration
Note Off : in case of particular animations, black out (DMX equipments), or go back to the previous persistent animation (strobe)
The configuration allows to create groups of 16 animations which go pretty well together
In manual mode, the additional inputs used in automatic mode also apply

In automatic mode, the program's behaviour is completely different.
Automatic behaviour is set by various commands, which guide the program into choosing which animation to display
The way to use this program is through Maschine's scenes : each drum scene will also have a pattern
containing various instructions ("more powerful !", "faster !", "calm down !"), and the program will
adapt to these commands.
The instructions are to be sent on MIDI channel 3
C-1  (MIDI 0)  : First beat of the first bar of the scene
C#-1 (MIDI 1)  : First beat of any other bar
D-1  (MIDI 2)  : Any other beat
E-1  (MIDI 4)  : Choose mainly red animations
F-1  (MIDI 5)  : Choose mainly blue animations
F#-1 (MIDI 6)  : Choose mainly black and white animations
G-1  (MIDI 7)  : Choose animations of any color
G#-1 (MIDI 8)  : Set the general intensity to be low
A-1  (MIDI 9)  : Set the general intensity to be medium
A#-1 (MIDI 10) : Set the general intensity to be high
B-1  (MIDI 11) : Set the general intensity to be very high
D0   (MIDI 14) : Set Automatic mode Off
D#0  (MIDI 15) : Set Automatic mode On

In automatic mode, other actions include keyboard and pad input :
For example --- 
  - Pressing the stutter pads will trigger the stroboscope and violent animations
  - Using the low pass filter will kill the LED panels' brightness
  - Using the high pass filter will brighten the LED panels  

///////////////////////////////////////////////////////////////////////////////////////////////////////////
*/


import processing.video.*;
import processing.serial.*;
import java.util.Iterator;
import java.util.*;


/////////////////////////////////////////////////////
//-----------Start of user configuration-----------//
/////////////////////////////////////////////////////

//Set to true to create a web page allowing easy management of the registered animations
//This file's primary use is to provide support when creating large MIDI files calling multiple animations
boolean output_PHP = true;

/////////////////////////////////////////////////////
/////////Define the DMX configuration here !/////////
/////////////////////////////////////////////////////

//Set to True to execute the sketch in debug mode, without the Teensy2 connected
boolean debug_without_dmx = false;
boolean debug_without_custom_devices = false;

String DMX_MICROCONTROLLER_NAME = "tty.usbmodem12341";
String CUSTOMDEVICES_MICROCONTROLLER_NAME = "tty.usbserial-A961L7NJ";

/////////////////////////////////////////////////////
//Define the configuration of the LED matrix here !//
/////////////////////////////////////////////////////

//Set to True to execute the sketch in debug mode, without the LED panels' Teensy3 connected
boolean debug_without_panels = false;

final static int PANEL_RESOLUTION_X = 8;        //Resolution for each individual panel - width
final static int PANEL_RESOLUTION_Y = 16;       //Resolution for each individual panel - height 
final static String LED_COLOR_FORMAT = "RGB";   //LED color arrangement
int NUMBER_OF_PANELS = 5;                       //Number of panels - TBIL : automatic detection of the number of panels connected, either 3 or 5

//Define the serial ports for the microcontrollers
//String[] TEENSY_SERIAL_PORT_LIST_3 = {"NONSTATIC", "/dev/tty.usbmodem11331", "/dev/tty.usbmodem17031"};
//All the devices in the 3 panel configuration need to be nonstatic : we don't know what panels we will be taking
String[] TEENSY_SERIAL_PORT_LIST_3 = {"NONSTATIC", "NONSTATIC", "NONSTATIC"};
//String[] TEENSY_SERIAL_PORT_LIST_5 = {"/dev/tty.usbmodem113361", "/dev/tty.usbmodem170381", "/dev/tty.usbmodem265461", "/dev/tty.usbmodem479061", "/dev/tty.usbmodem479101"};
String[] TEENSY_SERIAL_PORT_LIST_5 = {"tty.usbmodem113361", "tty.usbmodem479101", "tty.usbmodem265461", "tty.usbmodem479061", "tty.usbmodem479101"};





//Define the Gamma value to be used for the panels - recommended for WS2801 modules : gamma_25
final String panelGamma = "gamma_25";

//Mapping for an individual LED Panel - if the LEDs are cabled the following way, follow the example to create the mapping
//    8 7 6
//    3 4 5     ->    {6,7,8,3,4,5,0,1,2}
//    2 1 0
final int[] MANUAL_MAPPING = {127, 126, 125, 124, 123, 122, 121, 120,
                              112, 113, 114, 115, 116, 117, 118, 119,
                              111, 110, 109, 108, 107, 106, 105, 104,
                               96,  97,  98,  99, 100, 101, 102, 103,
                               95,  94,  93,  92,  91,  90,  89,  88,
                               80,  81,  82,  83,  84,  85,  86,  87,
                               79,  78,  77,  76,  75,  74,  73,  72,
                               64,  65,  66,  67,  68,  69,  70,  71,
                               63,  62,  61,  60,  59,  58,  57,  56,
                               48,  49,  50,  51,  52,  53,  54,  55,
                               47,  46,  45,  44,  43,  42,  41,  40,
                               32,  33,  34,  35,  36,  37,  38,  39,
                               31,  30,  29,  28,  27,  26,  25,  24,
                               16,  17,  18,  19,  20,  21,  22,  23,
                               15,  14,  13,  12,  11,  10,   9,   8,
                                0,   1,   2,   3,   4,   5,   6,   7};

//Resize option : choose either QUALITY for a slow, but good resize (using mean average), or SPEED, for a faster, but low quality pixel resize
//Possible values : "QUALITY", "SPEED"
final String RESIZE_OPTION = "QUALITY";

//Choose the device from which Processing should receive MIDI commands
//Standard choice : IEC bus to receive internal MIDI messages from Ableton Live -> "Bus 1"
String MIDI_BUS_MAIN_INPUT = "Bus 1";
String MIDI_BUS_CONTROLLER_INPUT = "LPD8";
String MIDI_BUS_KEYBOARD_INPUT = "LPK25";
//Choose the device to which Processing should send the debug output DMX messages (to be processed by the stroboscope simulator)
String MIDI_BUS_DMX_DEBUG = "Bus 3";

//Used to changed on the fly the panel order, using MIDI commands
int[] screen_order_configuration = new int [NUMBER_OF_PANELS];

/////////////////////////////////////////////////////
//--Should also be configured :
//--Manual mode pad/animation mapping--
//  This can be set up in the ManualModeConfig file
/////////////////////////////////////////////////////

/////////////////////////////////////////////////////
//----------End of main user configuration---------//
/////////////////////////////////////////////////////



/////////////////////////////////////////////////////
// Misc global variables used everywhere in the program 

//Create a log file, where all system output shall be redirected to
static PrintWriter outputLog;

//Internal panel and resolution configuration
final int DISPLAY_SCALING_FACTOR = 4;
int PIXELS_X;                                                   //To be defined once the number of panels is known
int PIXELS_Y;                                                   //16 pixels high -> 64 pixels wide
int COM_BAUD_RATE = 115200;                                     //Serial communication rate between Processing and the LED Panel Teensy microcontrollers
int COM_BAUD_RATE_NANO = 57600;                                 //Serial communication rate between Processing and the Arduino Nano used to dispatch orders to custom devices

//Buffers used to stock the displayed pixels (not yet resized)
int[][] pixelsPanels;

//Buffer which will keep the resized transformed data for all panels (both the output devices and the simulator get their data here)
int[][] transformedBuffersLEDPanels;

//Output objects
Tpm2[] outputDevices;
ArrayList<String> registeredDevices;

//Resize objects : allows buffer resize, slow or fast
QualityResize qualityResize;
PixelResize pixelResize;

//RGB Colorspace : 3 bits per pixel
int BPP = 3;

//Flag to prevent execution of the draw function before custom setup : if a new animation is requested, setupcomplete is set back to false
boolean setupcomplete = false;

//Flag to prevent listening to MIDI events before completing the first INIT routine
boolean initComplete = false;

//the maximal UDP packet size
int MAXIMAL_UDP_PACKET_SIZE = 65507;

//Instanciate MIDI control objects
MidiBus myMainBus;
MidiBus myControllerBus;
MidiBus myKeyboardBus;

//Control the brightness of the LED panels - 1 for full brightness
float brightness = 1;

//Variables used to light up the stroboscope
int drawStrobe_Front = 0;
int strobepreset_front = 0;
int drawStrobe_Back = 0;
int strobepreset_back = 0;

//Variables used to select between image and animation mode, and which image/animation to draw
int drawImage = 0;
int drawAnimation = 0;
int imagenumber;
int animationnumber;

//Create a AnimatedGifEncoder object to allow for easy export of all the animations 
AnimatedGifEncoder gifRecorder;
boolean keyRegistered = false;
boolean setGifRecording = false;
boolean gifRecordingActive = false;
ArrayList gifRecordingFrameRate;
int gifRecordingFrameNumber = 0;
String ROOTDIR = "";    //Folder where the GIF shall be stored

//Create a Sequencer object, to allow for automatic animation selection
PlayMeSequencer automaticSequencer;

void setup()
{
  //Create a log file, where all system output shall be redirected to
  try {
    outputLog = createWriter("PlayMeLightSetup_Logfile.txt");
    outputLog.println("///////////////////////////////////////////");
    outputLog.println("//PlayMe Light Setup - Output logger file//");
    outputLog.println("///////////////////////////////////////////");
    outputLog.println("");
    outputLog.println("");
    outputLog.println("// All information output by the application shall be stored in this log file //");
    outputLog.println("");
    outputLog.flush();
  }
  catch (Exception e) {
    println("Couldn't create logger file : " + e); 
  }
  
  setDefaultScreenOrderConfiguration();
  init_defaultDMXDevices();
  init_defaultCustomDevices();
  
  //Read the configuration file, and initialize the different parameters accordingly, overwrite the default DMX setup
  getInfoFromConfigFile();
  
  //Declare the dimensions of the matrix now that we know how many panels there are
  PIXELS_X = PANEL_RESOLUTION_X * DISPLAY_SCALING_FACTOR * NUMBER_OF_PANELS;    //24 LEDs wide -> 96 pixels wide, or 40 LEDs wide -> 160 pixels wide
  PIXELS_Y = PANEL_RESOLUTION_Y * DISPLAY_SCALING_FACTOR;                       //16 pixels high -> 64 pixels wide
  
  //Register attributes for all loaded animations
  animationAttributes = new ArrayList<Attribute>();
  filteredLists = new ArrayList<AnimationFilteredList>();
  registeredAttributes = new StringList();
  setAnimationAttributes();
  
  //Do the same for Custom devices actions
  customDevicesAttributes = new ArrayList<Attribute>();
  setCustomDevicesActionsAttributes();

  if (output_PHP == true) {
    //Initialize and fill in the PHP file
    create_PHP_output();
  }
  
  //Initialize the ring buffers which will store incoming audio data
  initializeCircularBuffers();
  
  //Start the thread which will receive any protobuf audio data, coming from the different SignalProcessor plugin instances
  startAudioSignalMonitoringThread();
  
  //Create a new PlayMeSequencer object, to allow for automatic animation selection
  automaticSequencer = new PlayMeSequencer();
  
  //Useful for debug : initialize the sketch with a specific animation
  //For the final setup : Initialize the patch by displaying "1 2 3" on the panels 
  // -> useful to check if the panels were installed correctly, and if not, to have visual feedback when correcting the panel order
  animationnumber = 1;
  drawAnimation = 0;
  drawImage = 1;
  imagenumber = 0;
  

  //Initialize the frame buffers
  pixelsPanels = new int[NUMBER_OF_PANELS][PIXELS_X*PIXELS_Y];  
  transformedBuffersLEDPanels = new int[NUMBER_OF_PANELS][PANEL_RESOLUTION_X*PANEL_RESOLUTION_Y];
  outputLog.println("Frame buffers initialized. Size : " + str(PIXELS_X*PIXELS_Y));
  
  String[] devicesToParse = TEENSY_SERIAL_PORT_LIST_3;
  if (NUMBER_OF_PANELS == 3) {
    devicesToParse = TEENSY_SERIAL_PORT_LIST_3;
  }
  else if (NUMBER_OF_PANELS == 5) {
    devicesToParse = TEENSY_SERIAL_PORT_LIST_5;
  }
  IntList nonstaticDeviceArrayNumber = new IntList();  
  ArrayList<String> candidateDevices = new ArrayList<String>();
  registeredDevices = new ArrayList<String>();
  if (DMX_MICROCONTROLLER_NAME.equals("NONSTATIC") == false) {
    registeredDevices.add(DMX_MICROCONTROLLER_NAME);
  }
  for (int i = 0; i < devicesToParse.length; i++) {
    if (devicesToParse[i].equals("NONSTATIC") == false) {
      registeredDevices.add(devicesToParse[i]);
    }
    else {
      nonstaticDeviceArrayNumber.append(i);
    }
  }
  if (nonstaticDeviceArrayNumber.size() == 0) {
    outputLog.println("All USB serial devices are defined statically, no guesswork is needed"); 
  }
  else {
    outputLog.println(nonstaticDeviceArrayNumber.size() + " non static USB serial device configured, trying to guess the mystery Teensy...");
  }
  
  //Find out which microcontrollers of the configuration list are defined as non-static
  for (int i = 0; i < devicesToParse.length; i++) {
    if (devicesToParse[i].equals("NONSTATIC") == true) {
      nonstaticDeviceArrayNumber.append(i);
    }
  }
  
  boolean nameExceptionFound = false;
  if (nonstaticDeviceArrayNumber.size() >= 1) {
    String rootName = "/dev/tty.usbmodem";
    for (int i =0; i < nonstaticDeviceArrayNumber.size();i++) {
      for (String portName: Serial.list()) {
        if (portName.contains(rootName) == true) {
          for (String registeredDevice: registeredDevices) {
            if (registeredDevice.contains(portName.substring(5, portName.length())) == false || portName.equals("/dev/tty.usbmodem1")) {
              boolean newCandidate = true;
              for (int j = 0; j<candidateDevices.size();j++) {
                for (String registered: registeredDevices) {
                  if (portName.contains(registered) || registered.contains(portName)) {
                    newCandidate = false;
                  }
                  if (portName.equals("/dev/tty.usbmodem1")) {
                    newCandidate = true;
                  }
                }
                if (candidateDevices.get(j).equals(portName)) {
                  newCandidate = false;
                }
              }
              if (newCandidate) {
                if (portName.equals("/dev/tty.usbmodem1")) {
                  if (nameExceptionFound == false) {
                    outputLog.println("--- Found possible candidate for the non static device : " + portName);
                    candidateDevices.add(portName);
                    nameExceptionFound = true;
                  }
                }
                else { 
                  outputLog.println("--- Found possible candidate for the non static device : " + portName);
                  candidateDevices.add(portName);
                }
              }
            }
          }
        }
      }
    }
  }
  for (int i = 0; i<candidateDevices.size();i++) {
    registeredDevices.add(candidateDevices.get(i));
  }
  for (int i = 0; i<candidateDevices.size();i++) {
    devicesToParse[nonstaticDeviceArrayNumber.get(i)] = candidateDevices.get(i);
  }
  
  for (int i = 0; i<devicesToParse.length;i++) {
    if (devicesToParse[i].equals("NONSTATIC")) {
        outputLog.println("!!!!! -------------------------------------- !!!!!");
        outputLog.println("!!!!! Error - Among the serial devices registered by the OS, couldn't find a possible candidate for non static device number " + i + ", the corresponding panel will not be initialised");
        outputLog.println("!!!!! For information, the only available serial devices are :");
        for (String portName: Serial.list()) { 
            outputLog.println("!!!!! --- " + portName);
        }
        outputLog.println("!!!!! -------------------------------------- !!!!!");
    }
  }
  
  if (NUMBER_OF_PANELS == 3) {
    TEENSY_SERIAL_PORT_LIST_3 = devicesToParse;
  }
  else if (NUMBER_OF_PANELS == 5) {
    TEENSY_SERIAL_PORT_LIST_5 = devicesToParse;
  }
  
  
  //Initialize the output objects
  outputDevices = new Tpm2[NUMBER_OF_PANELS];
  for (int i=0; i<NUMBER_OF_PANELS; i++) {
    outputDevices[i] = new Tpm2(i);
  }
  
  //Initialize the resize objects
  //--- try out the results with the shitty resize, it might be enough, and the performance could be better
  qualityResize = new QualityResize();
  pixelResize = new PixelResize();
  
  //Define the frameRate - shall be redefined by each individual animation, inside specificActions()
  frameRate(50);
  //Define the size of the display
  size(PIXELS_X, PIXELS_Y);
  //Sanity check regarding the Teensy serial list
  if (NUMBER_OF_PANELS == 3) {
    if (TEENSY_SERIAL_PORT_LIST_3.length < NUMBER_OF_PANELS) {
      outputLog.println("!!! Error on Teensy Serial Port List ! Please fill in a correct serial port, or 'NONSTATIC' for each output !!!");
      println("!!! Error on Teensy Serial Port List ! Please fill in a correct serial port, or 'NONSTATIC' for each output !!!");
      System.exit(1);    //Quit application
    }
  }
  else if (NUMBER_OF_PANELS == 5) {
    if (TEENSY_SERIAL_PORT_LIST_5.length < NUMBER_OF_PANELS) {
      outputLog.println("!!! Error on Teensy Serial Port List ! Please fill in a correct serial port, or 'NONSTATIC' for each output !!!");
      println("!!! Error on Teensy Serial Port List ! Please fill in a correct serial port, or 'NONSTATIC' for each output !!!");
      System.exit(1);    //Quit application
    }
  }  
  
  //Initialize Object for Serial2DMX microcontroller
  myDMX = new DMX(this);
  //Initialize Object for Serial2CustomDevices microcontroller
  myCustomDeviceController = new CustomDeviceController(this);
  
  //Initialize MIDI Control object
  //This allows Processing to be controlled by MIDI messages coming from external equipments or the IEC internal MIDI Bus (ie. messages from Ableton)
  midiInit();
  
  //Pre-load video animations, there is a slight latency gain by not creating the objects upon reading the video
  initialize_video_animations();
    
  //Initialize manual mode
  init_ManualMode();
  
  noSmooth();
  noStroke();
  specificActions();

  //Refresh the outputLog file
  outputLog.flush();
    
  //Initialize GIF Recording object, set the GIF to loop
  gifRecorder = new AnimatedGifEncoder();
  gifRecorder.setRepeat(0);
    
  //Initialize the GUI
  setup_gui();
  
  initComplete = true;  
  
  //Set all the custom devices to light up
  customDeviceAnimation(4);
  
}
 
void draw()
{  
  if (setupcomplete == true) 
  {
    //Execute the draw function for the animation corresponding to animationnumber
    //The specific setup is executed once, upon reception of an MIDI message changing the animation
    try {
      if (AUTOMATIC_MODE == false) {
        if (authorizeGeneralManualMode == true) {
          if (setShredderManualMode == true) {
             //The shredder effect is a bit particular, and requires the main animation not to be drawn
             actionControlled_preSpecificDraw();
          }
          else {
            specific_draw();
            draw_effects();
          }
          //Draw the post-treatment effects
          actionControlled_postSpecificDraw();
        }
        //No additional user input is allowed, execute specific draw the regular way
        else {
          specific_draw();
          draw_effects();
        }
      }
      else {
        automaticSequencer.performAutomaticActions();
      }
    }
    catch(Exception e) {
      outputLog.println("Caught an exception in the draw thread ! " + e); 
    }
  }

  //Update the buffers corresponding to the panels
  update_buffer();

  
  //Fill the data buffers with the resized data of the Processing output window
  getNewTransformedBuffersLEDPanels();
  
  //Send actual data - when changing live the setting regarding the number of panels (using the GUI), this is set to false
  if (debug_without_panels == false) {
    
    //Update each device (only those registered during init though)
    for (int i=0; i<outputDevices.length; i++) { 
      outputDevices[i].update();
    }
    
  }
  
  //Refresh the outputLog file
  outputLog.flush();
  
  if (setGifRecording == true) {
    if (gifRecordingActive == true) {
      saveFrame("tmp/animation" + animationnumber + "-" + formatNumber(gifRecordingFrameNumber) + ".jpeg");
      gifRecordingFrameRate.add(frameRate);
      gifRecordingFrameNumber += 1;
    }      
  }
}



////////////////////////////////////////////
//   Render the animations to gif files   //
//Control the animations with the keyboard//
////////////////////////////////////////////
//Controls :
//BACKSPACE (DEL) : set active the gif recording process - can only be set during the Init
//TAB : set inactive the gif recording process
//RIGHT/LEFT : next/previous animation, start recording
//ENTER : close the gif file for the current animation

//Utility parameter : useful to cycle through the animations using the left and right keys. To be updated each time a new animation is added
final int totalNumberOfAnimations = 385;

void keyPressed()
{
  if (keyCode == BACKSPACE) {
    if (drawImage == 1 && imagenumber == 0) {
      outputLog.println("Setting GIF Recording mode to ON");
      selectFolder("Select a folder to save the GIF files:", "folderSelected");
      setGifRecording = true;
    }
  }
  if (keyCode == TAB) {
    setGifRecording = false;
    outputLog.println("Setting GIF Recording mode to OFF");
  }
  if (keyCode == ENTER || keyCode == RETURN) {
    if (animationnumber != 0) {
      if (setGifRecording = true && gifRecordingActive == true) {
        gifRecorder.start(ROOTDIR + "/PlayMeLightSetup" + animationnumber + ".gif");
        for (int i=0;i<gifRecordingFrameRate.size();i++) {
          try {
            gifRecorder.setDelay(int(1000/frameRate));
            PImage image = loadImage("tmp/animation" + animationnumber + "-" + formatNumber(i) + ".jpeg");
            BufferedImage buffer = (BufferedImage) image.getNative();    //Convert PImage to BufferedImage
            gifRecorder.addFrame(buffer);
          }
          catch (Exception e) {println(e);}      
        }
        gifRecorder.finish();  //Flush all data
        gifRecordingActive = false;
      }
      outputLog.println("Writing GIF file for animation " + animationnumber + "...");
    }
  }
  if (key == CODED) {
    if (keyCode == RIGHT) {
      if (keyRegistered == false) {
        //Reset the flag to prevent any nullpointer exception
        setupcomplete = false;
        
        //Go to the next animation
        drawAnimation = 1;
        drawImage = 0;
        if (animationnumber == 99) {
          animationnumber = 102;
        }
        else {
          if (animationnumber < totalNumberOfAnimations) {
            animationnumber += 1;
          }
          else { 
            animationnumber = 1;
          }
        }
        specificActions();
        
        if (animationnumber != 0) {
          if (setGifRecording = true) {
            gifRecordingActive = true;
            gifRecordingFrameNumber = 0;
            gifRecordingFrameRate = new ArrayList();
          }
        }
      }
    }
    if (keyCode == LEFT) {
      if (keyRegistered == false) {
        //Reset the flag to prevent any nullpointer exception
        setupcomplete = false;
  
        //Go to the previous animation
        drawAnimation = 1;
        drawImage = 0;
        if (animationnumber > 1) {
          animationnumber -= 1;
        }
        else {
          animationnumber = totalNumberOfAnimations;
        }
        specificActions();
        
        if (animationnumber != 0) {
          if (setGifRecording = true) {
            gifRecordingActive = true;
            gifRecordingFrameNumber = 0;
            gifRecordingFrameRate = new ArrayList();
          }
        }
      }
    }
  }

}


void folderSelected(File selection) {
  if (selection == null) {
    outputLog.println("Gif recording was cancelled");
    setGifRecording = false;
  } else {
    outputLog.println("User selected GIF folder : " + selection.getAbsolutePath());
    ROOTDIR = selection.getAbsolutePath();
  }
}

String formatNumber(int input) {
  String output = "";
  if (input < 10) {
     output = "00000" + str(input);
  }
  else if (input < 100) {
     output = "0000" + str(input);
  }
  else if (input < 1000) {
     output = "000" + str(input);
  }
  else if (input < 10000) {
     output = "00" + str(input);
  }
  else if (input < 100000) {
     output = "0" + str(input);
  }
  else if (input < 1000000) {
     output = str(input);
  }
  else {
    outputLog.println("Error - input value is too high"); 
  }
  
  return output;
}
