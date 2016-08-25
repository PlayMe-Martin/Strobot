
//////////////////////////////////////////////////////////////////////////////////////////
// Output Config - Declaration of the usually used ucons, and their automatic detection //
//////////////////////////////////////////////////////////////////////////////////////////

import java.util.Hashtable;

final static int PANEL_RESOLUTION_X = 8;        //Resolution for each individual panel - width
final static int PANEL_RESOLUTION_Y = 16;       //Resolution for each individual panel - height 
final static String LED_COLOR_FORMAT = "RGB";   //LED color arrangement


//Define the serial ports for the microcontrollers
//String[] TEENSY_SERIAL_PORT_LIST_3 = {"NONSTATIC", "/dev/tty.usbmodem11331", "/dev/tty.usbmodem17031"};
//All the devices in the 3 panel configuration need to be nonstatic : we don't know what panels we will be taking
String DMX_MICROCONTROLLER_NAME = "/dev/tty.usbmodem12341";
String CUSTOMDEVICES_MICROCONTROLLER_NAME = "/dev/tty.usbserial-A961L7NJ";

String[] TEENSY_SERIAL_PORT_LIST_3 = {"NONSTATIC", "NONSTATIC", "NONSTATIC"};
String[] TEENSY_SERIAL_PORT_LIST_5 = {"/dev/tty.usbmodem113361", "/dev/tty.usbmodem479061", "/dev/tty.usbmodem479101", "/dev/tty.usbmodem707701", "/dev/tty.usbmodem814421"}; // 707701 to add

Hashtable RF_TX_Teensy_List;                // The following hashtables contain the different microcontrollers used by Strobot
Hashtable Panel_Main_Teensy_List;           // Either the RF ones - used by default -, the main panel LED controllers, when there is a direct connection to the
Hashtable Panel_Backup_Teensy_List;         // panel, or the backup ones - which are usually disconnected, but which may be reconnected should any hazard fry the main Teensys
Hashtable RF_RX_Teensy_List;                // This last one only exists for reference purpose - it is not used per se, but might as well know what are the RX Teensys

// All the microcontrollers used by Strobot are recognized as usb devices - either usbmodem, or usbserial, and as such the following string can matched against their name
final static String MICROCONTROLLER_NAME_PATTERN = "/dev/tty.usb";


//String[] devicesToParse;
ArrayList<String> chosenMicrocontrollers;

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


//Used to change on the fly the panel order (LED remapping), using MIDI commands
int[] screen_order_configuration = new int [NUMBER_OF_PANELS];

void detectPanelOutputs() {

  // Define the controllers used by Strobot
  RF_TX_Teensy_List        = new Hashtable();
  RF_RX_Teensy_List        = new Hashtable();
  Panel_Main_Teensy_List   = new Hashtable();
  Panel_Backup_Teensy_List = new Hashtable();

  // Map the controller to the hardware device ID - this ID is hard-coded inside the Teensy firmware
  // This is useful to make the link between the RF TX microcontroller and its physical panel RX counterpart
  RF_TX_Teensy_List.put(0, "/dev/tty.usbmodem1845651");
  RF_TX_Teensy_List.put(1, "/dev/tty.usbmodem812721");
  RF_TX_Teensy_List.put(2, "/dev/tty.usbmodem1846011");
  RF_TX_Teensy_List.put(3, "/dev/tty.usbmodem1870121");
  RF_TX_Teensy_List.put(4, "/dev/tty.usbmodem1847751");

  Panel_Main_Teensy_List.put(0, "/dev/tty.usbmodem1870061");
  Panel_Main_Teensy_List.put(1, "/dev/tty.usbmodem1870171");
  Panel_Main_Teensy_List.put(2, "/dev/tty.usbmodem1869771");
  Panel_Main_Teensy_List.put(3, "/dev/tty.usbmodem1848511");
  Panel_Main_Teensy_List.put(4, "/dev/tty.usbmodem1870671");
  
  Panel_Backup_Teensy_List.put(0, "/dev/tty.usbmodem707701");
  Panel_Backup_Teensy_List.put(1, "/dev/tty.usbmodem479061");
  Panel_Backup_Teensy_List.put(2, "/dev/tty.usbmodem479101");
  Panel_Backup_Teensy_List.put(3, "/dev/tty.usbmodem113361");
  Panel_Backup_Teensy_List.put(4, "/dev/tty.usbmodem814421");

  RF_RX_Teensy_List.put(0, "/dev/tty.usbmodem1845881");
  RF_RX_Teensy_List.put(1, "/dev/tty.usbmodem1845891");
  RF_RX_Teensy_List.put(2, "/dev/tty.usbmodem1847801");
  RF_RX_Teensy_List.put(3, "/dev/tty.usbmodem1847011");
  RF_RX_Teensy_List.put(4, "/dev/tty.usbmodem1845951");


  // First, check all the connected microcontrollers, create a list containing all the devices
  // All the microcontrollers used by Strobot have one thing in common
  ArrayList<String> availableMicrocontrollers = new ArrayList<String>();
      
  try {
    String devicePath = "/dev/";
    File dir = new File(devicePath);
    String[] children = dir.list();
    for (String child : children) {
      if ((devicePath + child).contains(MICROCONTROLLER_NAME_PATTERN)) {
        availableMicrocontrollers.add(devicePath + child);
      }
    }
  }
  catch (Exception e) {
    outputLog.println("Exception while trying to check the /dev/ folder, in order to map the available microcontrollers : " + e);
  }


  // Now let's decide which microcontrollers will actually be used as output devices
  // The priority is put on the main USB connection, the backup USB comes second, and the RF comes last
  chosenMicrocontrollers = new ArrayList<String>();  
  int nbPairs = RF_TX_Teensy_List.size();   //Might not exist
  outputLog.println("--- Choosing the microcontrollers to use as output devices ----");

  for (int devID = 0; devID<nbPairs; devID++) {

    try {
      String main_controller   = (String) Panel_Main_Teensy_List.get(devID);
      String backup_controller = (String) Panel_Backup_Teensy_List.get(devID);
      String rf_tx_controller  = (String) RF_TX_Teensy_List.get(devID);
      String rf_rx_controller  = (String) RF_RX_Teensy_List.get(devID);

      if (availableMicrocontrollers.contains(main_controller)) {
        chosenMicrocontrollers.add(main_controller);
        outputLog.println("Device ID " + devID + " - Main USB microcontroller, direct connection to the panel: " + main_controller);
      }
      else if (availableMicrocontrollers.contains(backup_controller)) {
        chosenMicrocontrollers.add(backup_controller);
        outputLog.println("Device ID " + devID + " - Backup USB microcontroller, direct connection to the panel: " + backup_controller);
      }
      else if (availableMicrocontrollers.contains(rf_tx_controller)) {
        chosenMicrocontrollers.add(rf_tx_controller);
        outputLog.println("Device ID " + devID + " - RF TX microcontroller, wireless connection to the panel: " + rf_tx_controller);
      }
      else if (availableMicrocontrollers.contains(rf_rx_controller)) {
        outputLog.println("Device ID " + devID + " - Error: detected a RF RX microcontroller, if you want to send wireless, use a TX microcontroller (or if it is indeed a TX controller, check the HW definitions inside Strobot): " + rf_tx_controller);
      }
      else {
        outputLog.println("Device ID " + devID + " - Error: could not detect an appropriate microcontroller for this communication ID");
      }

    }
    catch (Exception e) {
      outputLog.println("Error while trying to parse the available microcontrollers (probably a key error, check that all the devices are correctly declared along with their device index) : " + e);
    }
  }



  if (chosenMicrocontrollers.size() == 0) {
    outputLog.println("--- Found no microcontroller which can be used as an output device (as defined in the configuration) ---");
  }
  // else if (chosenMicrocontrollers.size() == 3) {
  //   NUMBER_OF_PANELS = 3;
  //   outputLog.println("--- Found 3 microcontrollers usable as output - entering 3-panel mode ---");
  // }
  // else if (chosenMicrocontrollers.size() == 5) {
  //   NUMBER_OF_PANELS = 5;
  //   outputLog.println("--- Found 5 microcontrollers usable as output - using the regular 5 panel mode ---");
  // }
    else {
      outputLog.println("--- Found " + chosenMicrocontrollers.size() + " microcontrollers usable as an output device ---");
    }


  // A voir ce qu'on fait avec ca - utilisable du cote de la conf
  // if (NUMBER_OF_PANELS == 3) {
  //   TEENSY_SERIAL_PORT_LIST_3 = devicesToParse;
  // }
  // else if (NUMBER_OF_PANELS == 5) {
  //   TEENSY_SERIAL_PORT_LIST_5 = devicesToParse;
  // }
  
  
  // Finally, initialize the actual output objects with the associated output device
  // Create as many objects as what would be ideal, and define the associated serial port if possible
  outputDevices = new Tpm2[Panel_Main_Teensy_List.size()];
  for (int i=0; i<Panel_Main_Teensy_List.size(); i++) {

    String serialPort = "";
    if (i<chosenMicrocontrollers.size()) {
      serialPort = chosenMicrocontrollers.get(i);
    }
    println("------------------------------");
    println(serialPort);
    outputDevices[i] = new Tpm2(i, serialPort);
  }



  // devicesToParse = TEENSY_SERIAL_PORT_LIST_3;
  // if (NUMBER_OF_PANELS == 3) {
  //   devicesToParse = TEENSY_SERIAL_PORT_LIST_3;
  // }
  // else if (NUMBER_OF_PANELS == 5) {
  //   devicesToParse = TEENSY_SERIAL_PORT_LIST_5;
  // }
  // IntList nonstaticDeviceArrayNumber = new IntList();  
  // ArrayList<String> candidateDevices = new ArrayList<String>();
  // registeredDevices = new ArrayList<String>();
  // if (DMX_MICROCONTROLLER_NAME.equals("NONSTATIC") == false) {
  //   registeredDevices.add(DMX_MICROCONTROLLER_NAME);
  // }
  // for (int i = 0; i < devicesToParse.length; i++) {
  //   if (devicesToParse[i].equals("NONSTATIC") == false) {
  //     registeredDevices.add(devicesToParse[i]);
  //   }
  //   else {
  //     nonstaticDeviceArrayNumber.append(i);
  //   }
  // }
  // if (nonstaticDeviceArrayNumber.size() == 0) {
  //   outputLog.println("All USB serial devices are defined statically, no guesswork is needed"); 
  // }
  // else {
  //   outputLog.println(nonstaticDeviceArrayNumber.size() + " non static USB serial device configured, trying to guess the mystery Teensy...");
  // }
  
  // //Find out which microcontrollers of the configuration list are defined as non-static
  // for (int i = 0; i < devicesToParse.length; i++) {
  //   if (devicesToParse[i].equals("NONSTATIC") == true) {
  //     nonstaticDeviceArrayNumber.append(i);
  //   }
  // }  
  
  // boolean nameExceptionFound = false;
  // if (nonstaticDeviceArrayNumber.size() >= 1) {
  //   String rootName = "/dev/tty.usbmodem";
  //   for (int i =0; i < nonstaticDeviceArrayNumber.size();i++) {
  //     for (String portName: Serial.list()) {

  //       if (portName.contains(rootName) == true) {
  //         for (String registeredDevice: registeredDevices) {

  //           if (registeredDevice.contains(portName.substring(5, portName.length())) == false || portName.equals("/dev/tty.usbmodem1")) {
  //             boolean newCandidate = true;
  //             for (int j = 0; j<candidateDevices.size();j++) {
  //               for (String registered: registeredDevices) {
  //                 if (portName.contains(registered) || registered.contains(portName)) {
  //                   newCandidate = false;
  //                 }
  //                 if (portName.equals("/dev/tty.usbmodem1")) {
  //                   newCandidate = true;
  //                 }
  //               }
  //               if (candidateDevices.get(j).equals(portName)) {
  //                 newCandidate = false;
  //               }
  //             }
  //             if (newCandidate) {
  //               if (portName.equals("/dev/tty.usbmodem1")) {
  //                 if (nameExceptionFound == false) {
  //                   outputLog.println("--- Found possible candidate for the non static device : " + portName);
  //                   candidateDevices.add(portName);
  //                   nameExceptionFound = true;
  //                 }
  //               }
  //               else { 
  //                 outputLog.println("--- Found possible candidate for the non static device : " + portName);
  //                 candidateDevices.add(portName);
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }
  // }
  // for (int i = 0; i<candidateDevices.size();i++) {
  //   registeredDevices.add(candidateDevices.get(i));
  // }
  // for (int i = 0; i<candidateDevices.size();i++) {
  //   devicesToParse[nonstaticDeviceArrayNumber.get(i)] = candidateDevices.get(i);
  // }
  

  
  // for (int i = 0; i<devicesToParse.length;i++) {
  //   if (devicesToParse[i].contains("NONSTATIC")) {
  //       outputLog.println("!!!!! -------------------------------------- !!!!!");
  //       outputLog.println("!!!!! Error - Among the serial devices registered by the OS, couldn't find a possible candidate for non static device number " + i + ", the corresponding panel will not be initialised");
  //       outputLog.println("!!!!! For information, the only available serial devices are :");
  //       for (String portName: Serial.list()) { 
  //           outputLog.println("!!!!! --- " + portName);
  //       }
  //       outputLog.println("!!!!! -------------------------------------- !!!!!");
  //   }
  // }
  
  // if (NUMBER_OF_PANELS == 3) {
  //   TEENSY_SERIAL_PORT_LIST_3 = devicesToParse;
  // }
  // else if (NUMBER_OF_PANELS == 5) {
  //   TEENSY_SERIAL_PORT_LIST_5 = devicesToParse;
  // }
  
  
  // //Initialize the output objects
  // outputDevices = new Tpm2[NUMBER_OF_PANELS];
  // for (int i=0; i<NUMBER_OF_PANELS; i++) {
  //   outputDevices[i] = new Tpm2(i);
  // }
  
  //Map the output objects to their respective panel
  for (int i=0; i<outputDevices.length; i++) {
    outputDevices[i].panelNumber = screen_order_configuration[i];
    outputLog.println("Microcontroller init - device " + outputDevices[i].serialPort + " is affected to output #" + outputDevices[i].panelNumber);
  }

}