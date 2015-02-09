//////////////////////////////////////////////////////////////
// Create a GUI to allow easy management of the application //
//////////////////////////////////////////////////////////////


import java.awt.Frame;
import java.awt.BorderLayout;
import java.util.List;
import controlP5.*;

public ControlP5 cp5;                     //GUI controller
public ControlFrame auxControlFrame;      //Second window to display the GUI into

ControlFrame controlFrame;
PFont minimlFont;
PFont minimlFontMedium;
PFont minimlFontBig;

boolean gui_activateSimulator = false;
boolean gui_activateAudioMonitoring = false;
boolean gui_initComplete = false;

boolean gui_changePanelMappingActive = false;
int tempLEDPanelMapping_counter = 0;
int[] tempLEDPanelMapping_array;

PImage gui_blackLogo, gui_whiteLogo, gui_glitchWhiteLogo, gui_glitchBlackLogo;
ArrayList<PanelSimulator> gui_panelSimulatorList;
ArrayList<RackLight> gui_rackLightList;
ArrayList<LEDTube> gui_LEDTubeList;

final int gui_width                      = 900;
final int gui_height                     = 750;

int gui_backgroundBrightness             = 45;
final int gui_simulatorPosX              = 10;
final int gui_simulatorPosY              = 100;
final int gui_simulatorWidth             = 576;
final int gui_panelsimuWidth             = 430;
final int gui_simulatorHeight            = 350;
final int gui_informationsAccordionPosY  = 10;
final int gui_spacing                    = 10;
final int gui_simulatorTextCenterX       = 300;
final int gui_simulatorTextMainY         = 170;
final int gui_simulatorTextSubY          = 210;

final int gui_audioMonitoringGroupOffsetX = (gui_simulatorPosX + gui_simulatorWidth + gui_spacing);
final int gui_audioMonitoringGroupWidth   = gui_width - (gui_simulatorPosX + gui_simulatorWidth + 2*gui_spacing);
final int gui_audioMonitoringToggleWidth  = 140;
final int gui_audioMonitoringToggleHeight = 20;    

//Attributes for the LED Panel animations
final int GUI_ATTR_LEDPANEL_GEOMETRIC   = 0;
final int GUI_ATTR_LEDPANEL_ATMOSPHERIC = 1;
final int GUI_ATTR_LEDPANEL_FADE_IN_OUT = 2;
final int GUI_ATTR_LEDPANEL_RANDOM      = 3;
final int GUI_ATTR_LEDPANEL_VERY_BRIGHT = 4;
final int GUI_ATTR_LEDPANEL_VERY_DARK   = 5;
final int GUI_ATTR_LEDPANEL_RED         = 6;
final int GUI_ATTR_LEDPANEL_B_W         = 7;
final int GUI_ATTR_LEDPANEL_BLUE        = 8;
final int GUI_ATTR_LEDPANEL_COLORFUL    = 9;   
final int GUI_ATTR_LEDPANEL_ROTATING    = 10;       
final int GUI_ATTR_LEDPANEL_SIMPLE      = 11;
final int GUI_ATTR_LEDPANEL_COMPLEX     = 12;
final int GUI_ATTR_LEDPANEL_EVOLVING    = 13;
final int GUI_ATTR_LEDPANEL_SMOOTH      = 14;
final int GUI_ATTR_LEDPANEL_VIOLENT     = 15;
final int GUI_ATTR_LEDPANEL_RHYTHMIC    = 16;
final int GUI_ATTR_LEDPANEL_FAST        = 17;
final int GUI_ATTR_LEDPANEL_SLOW        = 18;
final int GUI_ATTR_LEDPANEL_STILL       = 19;
final int GUI_ATTR_LEDPANEL_LINES       = 20;
final int GUI_ATTR_LEDPANEL_CURVES      = 21;
final int GUI_ATTR_LEDPANEL_TRIANGLES   = 22;
final int GUI_ATTR_LEDPANEL_SQUARES     = 23;
final int GUI_ATTR_LEDPANEL_CIRCLES     = 24;
final int GUI_ATTR_LEDPANEL_SPIRAL      = 25;       
final int GUI_ATTR_LEDPANEL_NOISE       = 26;
final int GUI_ATTR_LEDPANEL_OBJECTS     = 27;   
final int GUI_ATTR_LEDPANEL_SPECIAL     = 28;
final int GUI_ATTR_LEDPANEL_AUDIO       = 29;
final int GUI_ATTR_LEDPANEL_GAME        = 30;
final int GUI_ATTR_LEDPANEL_3D          = 31;

//Attributes for the Custom device animations
final int GUI_ATTR_CUSTOMDEV_ALLDEVICES    = 0;
final int GUI_ATTR_CUSTOMDEV_RACKLIGHTS    = 1;
final int GUI_ATTR_CUSTOMDEV_LEDTUBES      = 2;
final int GUI_ATTR_CUSTOMDEV_BLACK         = 3;
final int GUI_ATTR_CUSTOMDEV_WHITE         = 4;
final int GUI_ATTR_CUSTOMDEV_RED           = 5;
final int GUI_ATTR_CUSTOMDEV_BLUE          = 6;
final int GUI_ATTR_CUSTOMDEV_RAINBOW       = 7;
final int GUI_ATTR_CUSTOMDEV_RANDOM        = 8;
final int GUI_ATTR_CUSTOMDEV_FAST          = 9;
final int GUI_ATTR_CUSTOMDEV_MEDUM         = 10;
final int GUI_ATTR_CUSTOMDEV_SLOW          = 11;
final int GUI_ATTR_CUSTOMDEV_VERYSLOW      = 12;
final int GUI_ATTR_CUSTOMDEV_LONG          = 13;
final int GUI_ATTR_CUSTOMDEV_SHORT         = 14;
final int GUI_ATTR_CUSTOMDEV_PLAIN         = 15;
final int GUI_ATTR_CUSTOMDEV_FLASH         = 16;
final int GUI_ATTR_CUSTOMDEV_SMOOTHSINE    = 17;
final int GUI_ATTR_CUSTOMDEV_STROBOSCOPE   = 18;
final int GUI_ATTR_CUSTOMDEV_GROWINGSTROBE = 19;
final int GUI_ATTR_CUSTOMDEV_WAVE          = 20;
final int GUI_ATTR_CUSTOMDEV_BUILDUP       = 21;
final int GUI_ATTR_CUSTOMDEV_NOISE         = 22;
final int GUI_ATTR_CUSTOMDEV_SMOOTHNOISE   = 23;

//Attributes for the DMX animations
final int GUI_ATTR_DMX_ALL       = 0;
final int GUI_ATTR_DMX_RIGHT     = 1;
final int GUI_ATTR_DMX_LEFT      = 2;
final int GUI_ATTR_DMX_CENTER    = 3;
final int GUI_ATTR_DMX_RHYTHMIC  = 4;
final int GUI_ATTR_DMX_STROBE    = 5;
final int GUI_ATTR_DMX_PAR       = 6;
final int GUI_ATTR_DMX_VERYSLOW  = 7;
final int GUI_ATTR_DMX_SLOW      = 8;
final int GUI_ATTR_DMX_MEDIUM    = 9;
final int GUI_ATTR_DMX_FAST      = 10;
final int GUI_ATTR_DMX_VERYFAST  = 11;
final int GUI_ATTR_DMX_AUDIO     = 12;
final int GUI_ATTR_DMX_ATOMIC    = 13;


final int audioMonitoring_barWidth         = 90;
final int audioMonitoring_barHeight        = 10;
final float audioMonitoring_maxSignalLevel_Kick    = 1.0;
final float audioMonitoring_maxSignalLevel_Snare   = 0.3;
final float audioMonitoring_maxSignalLevel_Cymbals = 0.3;
final float audioMonitoring_maxSignalLevel_Bass    = 3.0;
final float audioMonitoring_maxSignalLevel_Keys    = 1.2;
final float audioMonitoring_maxSignalLevel_Guitar  = 1.2;


void setup_gui() {
  
  //Initialize images which shall be used by the control frame
  gui_blackLogo  = loadImage("GUI/logo_black.png");
  gui_whiteLogo  = loadImage("GUI/logo_white.png");
  gui_glitchWhiteLogo = loadImage("GUI/logo_glitchwhite.png");
  gui_glitchBlackLogo = loadImage("GUI/logo_glitchblack.png");
  
  //Initialize the font used for text areas
  minimlFont       = loadFont("Miniml-Standard0757-8.vlw");
  minimlFontMedium = loadFont("Miniml-Standard0757-20.vlw");
  minimlFontBig    = loadFont("Miniml-Standard0757-48.vlw");
  
  cp5 = new ControlP5(this);
  // Create a controlFrame by using addControlFrame, this creates a new separate frame
  controlFrame = addControlFrame("Strobot - Controls", gui_width, gui_height);
  
}


ControlFrame addControlFrame(String _name, int _width, int _height) {
  Frame auxFrame = new Frame(_name);
  auxControlFrame = new ControlFrame(this, _width, _height);
  auxFrame.add(auxControlFrame);
  auxControlFrame.init();
  auxFrame.setTitle(_name);
  auxFrame.setSize(auxControlFrame.w, auxControlFrame.h);
  auxFrame.setLocation(0, 0);
  auxFrame.setResizable(false);
  auxFrame.setVisible(true);
  return auxControlFrame;
}


// the ControlFrame class extends PApplet : we are creating a new processing applet inside a new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;

  ControlP5 cp5;

  Object parent;
  
  
  controlP5.Button gui_mainLogo;
  controlP5.Accordion generalInfoAccordion;
  controlP5.Accordion customDevicesDMXAnimationListsAccordion;
  controlP5.Toggle changeLEDPanelMappingToggle;
  controlP5.Toggle setAutomaticModeToggle;
  controlP5.Toggle setAudioMonitoringToggle;
  ArrayList<Bang> changeLEDPanelMappingBangList;
  
  controlP5.Textlabel resetExpectedTextLabel;
  controlP5.Textlabel inactiveAudioMonitoringTextLabel;
  controlP5.Textlabel audioMonitoringKickTextLabel;
  controlP5.Textlabel audioMonitoringSnareTextLabel;
  controlP5.Textlabel audioMonitoringCymbalsTextLabel;
  controlP5.Textlabel audioMonitoringBassTextLabel;
  controlP5.Textlabel audioMonitoringKeysTextLabel;
  controlP5.Textlabel audioMonitoringGuitarTextLabel;

  controlP5.Button add_FrontLeftStrobo;
  controlP5.Button add_FrontRightStrobo;
  controlP5.Button add_LEDTube;
  controlP5.Button add_RackLight;
  controlP5.Button add_BackStrobo;
 
  controlP5.CheckBox LEDPanelAnimations_animationListCheckBox;
  controlP5.CheckBox CustomDeviceAnimations_animationListCheckBox;
  controlP5.CheckBox DMXAnimations_animationListCheckBox;
  controlP5.Button LEDPanelAnimations_reinitButton;
  controlP5.Button CustomDeviceAnimations_reinitButton;
  controlP5.Button DMXAnimations_reinitButton;
  controlP5.ListBox LEDPanelAnimations_animationListBox;
  controlP5.ListBox CustomDeviceAnimations_animationListBox;
  controlP5.ListBox DMXAnimations_animationListBox;
  controlP5.Textarea LEDPanelAnimations_currentAnimationDescription;
  controlP5.Textarea CustomDeviceAnimations_currentAnimationDescription;
  controlP5.Textarea DMXAnimations_currentAnimationDescription;
  
  Group effectsInfo;
  
  ControlGroup GUIMessageBox;
  int GUIMessageBoxResult = -1;
  String GUIMessageBoxString = "";
  
  public ControlFrame(Object theParent, int _width, int _height) {
    parent = theParent;
    w = _width;
    h = _height;
  }


  public ControlP5 control() {
    return cp5;
  }
  
  public void setup() {
    size(w, h);
    frameRate(60);
    
    cp5 = new ControlP5(this);    
    
    createGuiHeaderElements();
    createGeneralInfoAccordion();
    createLEDPanelAnimationListGroup();
    //createCustomDeviceAnimationListGroup();
    
    createCustomDeviceAndDMXAccordion();
    
    createAudioMonitoringGroup();
    
    init_panelSimulatorList();
    init_customDevicesSimulatorList();
    
    gui_initComplete = true;
    
  }

  public void draw() {
    background(color(gui_backgroundBrightness));
    if (gui_activateSimulator) {
      draw_simulator(gui_simulatorPosX,gui_simulatorPosY);
    }
    else {
      fill(255);
      textAlign(CENTER, CENTER);
      textFont(minimlFontBig, 48);
      text("SIMULATOR DEACTIVATED", gui_simulatorTextCenterX, gui_simulatorTextMainY);
      textFont(minimlFontMedium, 20);
      text("ACTIVATE THE SIMULATOR BY CLICKING ON THE PLAYME LOGO", gui_simulatorTextCenterX, gui_simulatorTextSubY);
    }
    
    if (gui_activateAudioMonitoring) {
      draw_audioMonitoring(gui_audioMonitoringGroupOffsetX + gui_spacing, 22*gui_height/30 + 4*gui_spacing, 10);
    }
  }
  

  
  //Add mouse wheel support for all elements on the control panel
  void mouseWheel(MouseEvent event) {
    cp5.setMouseWheelRotation(event.getCount());
  }
  
  //If an effect is currently active, release it (important for the effect bangs)
  void mouseReleased() {
    deactivateAdditionalEffect(1);
  }
  
  ////////////////////////////////////////////////////////////////
  // Create the header GUI elements
  //  
  
  void createGuiHeaderElements() {
    
    int autoModeToggleWidth  = 180;
    int autoModeToggleHeight = 36;
    
    gui_mainLogo = cp5.addButton("Activate Simulator")
                      .setSwitch(true)
                      .setPosition(gui_spacing,gui_spacing)
                      .setImages(gui_whiteLogo, gui_glitchWhiteLogo, gui_glitchBlackLogo, gui_blackLogo)
                      .updateSize();
    
    
    //Add a toggle to set the automatic mode
    setAutomaticModeToggle = cp5.addToggle("Auto Mode")
                                .setValue(0)
                                .setCaptionLabel("Auto Mode")
                                .setPosition(gui_simulatorWidth - autoModeToggleWidth, 15)
                                .setSize(autoModeToggleWidth, autoModeToggleHeight)
                                .setColorBackground(color(100,0,0))
                                .setColorForeground(color(130,0,0))
                                .setColorActive(color(160,0,0))
                                ;
    setAutomaticModeToggle.getCaptionLabel().setFont(minimlFontMedium);
    //setAutomaticModeToggle.getCaptionLabel().setColor(255);
    setAutomaticModeToggle.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
  }

  ////////////////////////////////////////////////////////////////
  // Create the General Informations accordion
  //  


  Accordion createGeneralInfoAccordion() {

    int textfieldHeight   = 10;
    int textfieldWidth    = 25;
    int bigTextfieldWidth = 100;
    int spacingRow        = 3;
    int leftOffset        = 6;
    int toggleHeight      = 9;
    int toggleWidth       = 100;
    
    
    int accordionWidth    = width - (gui_simulatorPosX + gui_simulatorWidth + 2*gui_spacing);
    int generalInformationsHeight   = 477;
    
    int nbrOfPanelsTextFieldPosY = gui_spacing + 0*spacingRow;
    int DMXTextLabelPosY = 150;
    int CustomDevicesTextLabelPosY = 320; 
    int warningTextLabelPosY = generalInformationsHeight - 2*textfieldHeight - 2*spacingRow;
    int panelConfigBangPosY = nbrOfPanelsTextFieldPosY + toggleHeight + spacingRow;
    int panelConfigBangSize = 15;
    
    
    // group number 1, contains information on the current hardware 
    Group hardwareInfo = cp5.addGroup("Hardware Informations")
                            .setBackgroundColor(color(0, 64))
                            .setBackgroundHeight(generalInformationsHeight)
                            ;
    
    
       
    changeLEDPanelMappingToggle = cp5.addToggle("Change Panel Mapping")
                                         .setValue(0)
                                         .setCaptionLabel("Change Panel Mapping")
                                         .setPosition(leftOffset, nbrOfPanelsTextFieldPosY)
                                         .setSize(toggleWidth, toggleHeight)
                                         .setColorBackground(color(110,0,0))
                                         .setColorForeground(color(150,0,0))
                                         .setColorActive(color(190,0,0))
                                         .moveTo(hardwareInfo)
                                         ;
    changeLEDPanelMappingToggle.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    
    changeLEDPanelMappingBangList = new ArrayList<Bang>();
    for (int i=0; i<NUMBER_OF_PANELS;i++) {
      Bang temp = cp5.addBang("Mapping Config Bang - Panel " + i)
                                           .setPosition((i+1)*leftOffset + i*panelConfigBangSize,panelConfigBangPosY)
                                           .setSize(panelConfigBangSize,panelConfigBangSize)
                                           .moveTo(hardwareInfo)
                                           //.setColorForeground(color(4,104,154))    //Shall be set to this color once active
                                           //.setColorActive(color(0,180,234))        //Shall be set to this color once active
                                           .setColorForeground(color(150))
                                           .setColorActive(color(150))
                                           .setCaptionLabel(str(i+1));
      temp.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
      changeLEDPanelMappingBangList.add(temp);
    }
    
    cp5.addTextfield("Number Of Panels")
       .setPosition(accordionWidth - textfieldWidth - leftOffset,nbrOfPanelsTextFieldPosY)
       .setSize(textfieldWidth,textfieldHeight)
       .setValue(str(NUMBER_OF_PANELS))
       .setCaptionLabel("Number Of Panels:    ")
       .setAutoClear(false)
       .moveTo(hardwareInfo)
       .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
       ;
     
     
    cp5.addTextfield("DMX Microcontroller")
       .setPosition(accordionWidth - bigTextfieldWidth - leftOffset,nbrOfPanelsTextFieldPosY + 3*spacingRow + 3*textfieldHeight)
       .setSize(bigTextfieldWidth,textfieldHeight)
       .setValue(DMX_MICROCONTROLLER_NAME.substring(5, DMX_MICROCONTROLLER_NAME.length()))
       .setCaptionLabel("DMX Microcontroller:    ")
       .setAutoClear(false)
       .setFont(minimlFont)
       .moveTo(hardwareInfo)
       .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
       ;
     
    cp5.addTextfield("Custom Devices Microcontroller")
       .setPosition(accordionWidth - bigTextfieldWidth - leftOffset,nbrOfPanelsTextFieldPosY + 4*spacingRow + 4*textfieldHeight)
       .setSize(bigTextfieldWidth,textfieldHeight)
       .setValue(CUSTOMDEVICES_MICROCONTROLLER_NAME.substring(5, CUSTOMDEVICES_MICROCONTROLLER_NAME.length()))
       .setCaptionLabel("Custom Devices Microcontroller:    ")
       .setAutoClear(false)
       .setFont(minimlFont)
       .moveTo(hardwareInfo)
       .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
       ;
    

    int offsetY_2 = nbrOfPanelsTextFieldPosY + 5*spacingRow + 5*textfieldHeight; 
    for (int i=0; i<NUMBER_OF_PANELS; i++) {
      cp5.addTextfield("LED Panel Microcontroller " + i)
         .setPosition(accordionWidth - bigTextfieldWidth - leftOffset,offsetY_2)
         .setSize(bigTextfieldWidth,textfieldHeight)
         .setValue(devicesToParse[i].substring(5, devicesToParse[i].length()))
         .setCaptionLabel("LED Panel Microcontroller " + (i+1) + ":    ")
         .setAutoClear(false)
         .setFont(minimlFont)
         .moveTo(hardwareInfo)
         .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
         ;
      offsetY_2 += spacingRow + textfieldHeight;
    }
    
    
    int offsetY = DMXTextLabelPosY;
    cp5.addTextlabel("DMX Info")
       .setText("DMX STROBE CHANNELS : (SPD, INTSTY) OR (INTSTY, LNGTH, SPD, SFX)")
       .setPosition(leftOffset,offsetY)
       .setFont(minimlFont)
       .moveTo(hardwareInfo)
       ;
    offsetY += textfieldHeight;
    cp5.addTextlabel("DMX Info 2")
       .setText("REMOVE A DEVICE BY SETTING IT TO (0,0,0,0) or (0,0)")
       .setPosition(leftOffset,offsetY)
       .setFont(minimlFont)
       .moveTo(hardwareInfo)
       ;
    offsetY += textfieldHeight + 2*spacingRow;
    
    for (int i=0; i<DMXList_FrontLeftStroboscopes.size(); i++) {
      DMX_Stroboscope stroboscope = DMXList_FrontLeftStroboscopes.get(i);
      String fieldValue;
      if (stroboscope.numberOfChannels == 2) {
        fieldValue = "(" + stroboscope.DMXAddress_stroboscopeSpeed + "," + stroboscope.DMXAddress_stroboscopeBrightness + ")";
      } 
      else {
        fieldValue = "(" + stroboscope.DMXAddress_stroboscopeBrightness + "," + stroboscope.DMXAddress_stroboscopeFlashLength + "," + stroboscope.DMXAddress_stroboscopeSpeed + "," + stroboscope.DMXAddress_stroboscopeSpecialFX + ")";
      }
      cp5.addTextfield("Left Strobe " + i)
         .setPosition(accordionWidth - bigTextfieldWidth - leftOffset, offsetY)
         .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
         .setValue(fieldValue)
         .setFont(minimlFont)
         .setCaptionLabel("Left Strobe " + (i+1) + " :    ")
         .setAutoClear(false)
         .moveTo(hardwareInfo)
         .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
         ;
      cp5.addToggle("Test FrontLeftStroboscope " + i)
         .setValue(0)
         .setLabelVisible(false)
         .setPosition(accordionWidth - 2*textfieldHeight, offsetY)
         .setSize(2*textfieldHeight - leftOffset, textfieldHeight)
         .setColorForeground(color(4,104,154))
         .setColorActive(color(0,180,234))
         .setColorActive(color(120,0,0))
         .moveTo(hardwareInfo)
         .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
         ;
      offsetY += textfieldHeight + spacingRow;
    }
    for (int i=0; i<DMXList_FrontRightStroboscopes.size(); i++) {
      DMX_Stroboscope stroboscope = DMXList_FrontRightStroboscopes.get(i);
      String fieldValue;
      if (stroboscope.numberOfChannels == 2) {
        fieldValue = "(" + stroboscope.DMXAddress_stroboscopeSpeed + "," + stroboscope.DMXAddress_stroboscopeBrightness + ")";
      } 
      else {
        fieldValue = "(" + stroboscope.DMXAddress_stroboscopeBrightness + "," + stroboscope.DMXAddress_stroboscopeFlashLength + "," + stroboscope.DMXAddress_stroboscopeSpeed + "," + stroboscope.DMXAddress_stroboscopeSpecialFX + ")";
      }
      cp5.addTextfield("Right Strobe " + i)
         .setPosition(accordionWidth - bigTextfieldWidth - leftOffset, offsetY)
         .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
         .setValue(fieldValue)
         .setFont(minimlFont)
         .setCaptionLabel("Right Strobe " + (i+1) + " :    ")
         .setAutoClear(false)
         .moveTo(hardwareInfo)
         .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
         ;
      cp5.addToggle("Test FrontRightStroboscope " + i)
         .setValue(0)
         .setLabelVisible(false)
         .setPosition(accordionWidth - 2*textfieldHeight, offsetY)
         .setSize(2*textfieldHeight - leftOffset, textfieldHeight)
         .setColorForeground(color(4,104,154))
         .setColorActive(color(0,180,234))
         .setColorActive(color(120,0,0))
         .moveTo(hardwareInfo)
         .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
         ;
      offsetY += textfieldHeight + spacingRow;
    }
    for (int i=0; i<DMXList_BackStroboscopes.size(); i++) {
      DMX_Stroboscope stroboscope = DMXList_BackStroboscopes.get(i);
      String fieldValue;
      if (stroboscope.numberOfChannels == 2) {
        fieldValue = "(" + stroboscope.DMXAddress_stroboscopeSpeed + "," + stroboscope.DMXAddress_stroboscopeBrightness + ")";
      } 
      else {
        fieldValue = "(" + stroboscope.DMXAddress_stroboscopeBrightness + "," + stroboscope.DMXAddress_stroboscopeFlashLength + "," + stroboscope.DMXAddress_stroboscopeSpeed + "," + stroboscope.DMXAddress_stroboscopeSpecialFX + ")";
      }
      cp5.addTextfield("Back Strobe " + i)
         .setPosition(accordionWidth - bigTextfieldWidth - leftOffset, offsetY)
         .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
         .setValue(fieldValue)
         .setFont(minimlFont)
         .setCaptionLabel("Back Strobe " + (i+1) + " :    ")
         .setAutoClear(false)
         .moveTo(hardwareInfo)
         .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
         ;
      cp5.addToggle("Test BackStroboscope " + i)
         .setValue(0)
         .setLabelVisible(false)
         .setPosition(accordionWidth - 2*textfieldHeight, offsetY)
         .setSize(2*textfieldHeight - leftOffset, textfieldHeight)
         .setColorForeground(color(4,104,154))
         .setColorActive(color(0,180,234))
         .setColorActive(color(120,0,0))
         .moveTo(hardwareInfo)
         .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
         ;         
      offsetY += textfieldHeight + spacingRow;
    }
    
    
    add_FrontLeftStrobo = cp5.addButton("Add Front Left Strobe")
                         .setValue(0)
                         .setCaptionLabel("Add Front Left Strobe")
                         .setPosition(leftOffset, DMXTextLabelPosY + 2*textfieldHeight + 2*spacingRow)
                         .setSize(toggleWidth, toggleHeight)
                         .setColorBackground(color(110,0,0))
                         .setColorForeground(color(150,0,0))
                         .setColorActive(color(190,0,0))
                         .moveTo(hardwareInfo)
                         ;
    add_FrontLeftStrobo.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    add_FrontRightStrobo = cp5.addButton("Add Front Right Strobe")
                         .setValue(0)
                         .setCaptionLabel("Add Front Right Strobe")
                         .setPosition(leftOffset, DMXTextLabelPosY + 3*textfieldHeight + 3*spacingRow)
                         .setSize(toggleWidth, toggleHeight)
                         .setColorBackground(color(110,0,0))
                         .setColorForeground(color(150,0,0))
                         .setColorActive(color(190,0,0))
                         .moveTo(hardwareInfo)
                         ;
    add_FrontRightStrobo.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    add_BackStrobo = cp5.addButton("Add Back Strobe")
                         .setValue(0)
                         .setCaptionLabel("Add Back Strobe")
                         .setPosition(leftOffset, DMXTextLabelPosY + 4*textfieldHeight + 4*spacingRow)
                         .setSize(toggleWidth, toggleHeight)
                         .setColorBackground(color(110,0,0))
                         .setColorForeground(color(150,0,0))
                         .setColorActive(color(190,0,0))
                         .moveTo(hardwareInfo)
                         ;
    add_BackStrobo.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

    
    
    
    
    offsetY = CustomDevicesTextLabelPosY;
    cp5.addTextlabel("Custom devices Info")
       .setText("CUSTOM DEVICES : DEVICE NUMBER")
       .setPosition(leftOffset,offsetY)
       .setFont(minimlFont)
       .moveTo(hardwareInfo)
       ;
    offsetY += textfieldHeight;
    cp5.addTextlabel("Custom devices Info 2")
       .setText("REMOVE A DEVICE BY SETTING IT TO -1")
       .setPosition(leftOffset,offsetY)
       .setFont(minimlFont)
       .moveTo(hardwareInfo)
       ;
    offsetY += textfieldHeight + 2*spacingRow;

    for (int i=0; i<CustomDeviceList_LEDTubes.size(); i++) {
      CustomDevice_LEDTube ledTube = CustomDeviceList_LEDTubes.get(i);
      String fieldValue = str(ledTube.CustomDevice_deviceNumber);
      cp5.addTextfield("LED Tube " + i)
         .setPosition(accordionWidth - bigTextfieldWidth - leftOffset, offsetY)
         .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
         .setValue(fieldValue)
         .setFont(minimlFont)
         .setCaptionLabel("LED Tube " + (i+1) + " :    ")
         .setAutoClear(false)
         .moveTo(hardwareInfo)
         .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
         ;
      cp5.addToggle("Test LEDTube " + i)
         .setValue(0)
         .setLabelVisible(false)
         .setPosition(accordionWidth - 2*textfieldHeight, offsetY)
         .setSize(2*textfieldHeight - leftOffset, textfieldHeight)
         .setColorForeground(color(4,104,154))
         .setColorActive(color(0,180,234))
         .setColorActive(color(120,0,0))
         .moveTo(hardwareInfo)
         .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
         ;         
      offsetY += textfieldHeight + spacingRow;
    }
    
    for (int i=0; i<CustomDeviceList_RackLights.size(); i++) {
      CustomDevice_RackLight rackLight = CustomDeviceList_RackLights.get(i);
      String fieldValue = str(rackLight.CustomDevice_deviceNumber);
      cp5.addTextfield("Rack Light " + i)
         .setPosition(accordionWidth - bigTextfieldWidth - leftOffset, offsetY)
         .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
         .setValue(fieldValue)
         .setFont(minimlFont)
         .setCaptionLabel("Rack Light " + (i+1) + " :    ")
         .setAutoClear(false)
         .moveTo(hardwareInfo)
         .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
         ;
      cp5.addToggle("Test RackLight " + i)
         .setValue(0)
         .setLabelVisible(false)
         .setPosition(accordionWidth - 2*textfieldHeight, offsetY)
         .setSize(2*textfieldHeight - leftOffset, textfieldHeight)
         .setColorForeground(color(4,104,154))
         .setColorActive(color(0,180,234))
         .setColorActive(color(120,0,0))
         .moveTo(hardwareInfo)
         .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
         ;
      offsetY += textfieldHeight + spacingRow;
    }

    add_LEDTube = cp5.addButton("Add LED Tube")
                         .setValue(0)
                         .setCaptionLabel("Add LED Tube")
                         .setPosition(leftOffset, CustomDevicesTextLabelPosY + 2*textfieldHeight + 2*spacingRow)
                         .setSize(toggleWidth, toggleHeight)
                         .setColorBackground(color(110,0,0))
                         .setColorForeground(color(150,0,0))
                         .setColorActive(color(190,0,0))
                         .moveTo(hardwareInfo)
                         ;
    add_LEDTube.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    add_RackLight = cp5.addButton("Add Rack Light")
                         .setValue(0)
                         .setCaptionLabel("Add Rack Light")
                         .setPosition(leftOffset, CustomDevicesTextLabelPosY + 3*textfieldHeight + 3*spacingRow)
                         .setSize(toggleWidth, toggleHeight)
                         .setColorBackground(color(110,0,0))
                         .setColorForeground(color(150,0,0))
                         .setColorActive(color(190,0,0))
                         .moveTo(hardwareInfo)
                         ;
    add_RackLight.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

    //Hidden label which appears only when changes requiring a restart are needed
    resetExpectedTextLabel = cp5.addTextlabel("Reset Expected")
                                .setText("PLEASE RESET THE APP BEFORE MAKING FURTHER CHANGES\nCRITICAL PARAMETERS HAVE BEEN CHANGED")
                                .setPosition(leftOffset,warningTextLabelPosY)
                                .setColorValue(color(210,0,0))
                                .moveTo(hardwareInfo)
                                ;
    resetExpectedTextLabel.setVisible(false);
     
     
     
     
    // Group number 2, contains information regarding MIDI input
    Group midiInfo = cp5.addGroup("MIDI Informations")
                        .setBackgroundColor(color(0, 64))
                        .setBackgroundHeight(generalInformationsHeight)
                        ;    
    
    
    Textfield gui_mainInputTextfield = cp5.addTextfield("Main Input")
       .setPosition(accordionWidth - bigTextfieldWidth - leftOffset,leftOffset)
       .setSize(bigTextfieldWidth,textfieldHeight)
       .setValue(MIDI_BUS_MAIN_INPUT)
       .setFont(minimlFont)
       .setCaptionLabel("Main Input (IAC Bus) :    ")
       .setAutoClear(false)
       .moveTo(midiInfo)
       ;
    
    gui_mainInputTextfield.getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER);
    
    cp5.addTextfield("Keyboard")
       .setPosition(accordionWidth - bigTextfieldWidth - leftOffset,leftOffset + textfieldHeight + spacingRow)
       .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
       .setValue(MIDI_BUS_KEYBOARD_INPUT)
       .setFont(minimlFont)
       .setCaptionLabel("Keyboard :    ")
       .setAutoClear(false)
       .moveTo(midiInfo)
       .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
       ;
   cp5.addTextfield("General FX Controller")
      .setPosition(accordionWidth - bigTextfieldWidth - leftOffset,leftOffset + 2*textfieldHeight + 2*spacingRow)
      .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
      .setValue(MIDI_BUS_CONTROLLER_INPUT)
      .setFont(minimlFont)
      .setCaptionLabel("General FX Controller :    ")
      .setAutoClear(false)
      .moveTo(midiInfo)
      .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
      ;
    
    String gui_incomingMsgList =  "/////////////////////////////\n" +
                                  "// Listening on the Main Input Bus : \n" +
                                  "\n" +
                                  "\n" +
                                  "ACTIVATE AUTOMATIC MODE\n" +
                                  "DISABLE AUTOMATIC MODE\n" +
                                  "\n" +
                                  "PANEL ANIMATION BANK 1\n" +
                                  "PANEL ANIMATION BANK 2\n" +
                                  "PANEL ANIMATION BANK 3\n" +
                                  "PANEL ANIMATION BANK 4\n" +
                                  "PANEL IMAGE BANK 1\n" +
                                  "ACTIVATE PANEL EFFECT\n" +
                                  "DMX ANIMATION BANK 1\n" +
                                  "DMX ANIMATION BANK 2\n" +
                                  "DMX ANIMATION BANK 3\n" +
                                  "CUSTOM DEVICE BANK 1\n" +
                                  "CUSTOM DEVICE BANK 2\n" +
                                  "CUSTOM DEVICE BANK 3\n" +
                                  "\n" +
                                  "START/STOP FRONT RIGHT STROBE\n" +
                                  "START/STOP FRONT LEFT STROBE\n" +
                                  "START/STOP BACK STROBE\n" +
                                  "\n" +
                                  "ENABLE MANUAL INPUT\n" +
                                  "DISABLE MANUAL INPUT\n" +
                                  "ACTIVATE OUTPUT MAPPING CONFIG\n" +
                                  "\n" +
                                  "/////////////////////////////\n" +
                                  "// Listening on the Controller Bus : \n" +
                                  "\n" +
                                  "\n" +
                                  "PAD KILL ALL LIGHTS   \n" + 
                                  "PAD STROBE 4TH        \n" + 
                                  "PAD STROBE 8TH        \n" + 
                                  "PAD STROBE 16TH       \n" + 
                                  "PAD STROBE 32ND       \n" + 
                                  "PAD STROBE 64TH       \n" + 
                                  "KNOB BLACKOUT         \n" + 
                                  "KNOB WHITEOUT         \n" + 
                                  "KNOB SHREDDER         \n" + 
                                  "KNOB AUTO COLOR CHANGE\n" + 
                                  "KNOB WHITE JAMA MONO  \n" +
                                  "\n" +
                                  "/////////////////////////////\n" +
                                  "// Listening on the Keyboard Bus : \n" +
                                  "\n" +
                                  "\n" +
                                  "GAME | P1 - LEFT\n" +
                                  "GAME | P1 - RIGHT\n" + 
                                  "GAME | P2 - LEFT\n" + 
                                  "GAME | P2 - RIGHT"
                                  ;
    
    String gui_incomingMsgValue = "\n" +
                                  "\n" +
                                  "\n" +
                                  "\n" +
                                  
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_SET_AUTOMODE_ON            + " | " + getStringFromNoteInt(PITCH_SET_AUTOMODE_ON           ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_SET_AUTOMODE_OFF           + " | " + getStringFromNoteInt(PITCH_SET_AUTOMODE_OFF          ) + "\n" +
                                  
                                  "\n" +
                                  
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_LOAD_ANIMATION_BANK1       + " | " + getStringFromNoteInt(PITCH_LOAD_ANIMATION_BANK1      ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_LOAD_ANIMATION_BANK2       + " | " + getStringFromNoteInt(PITCH_LOAD_ANIMATION_BANK2      ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_LOAD_ANIMATION_BANK3       + " | " + getStringFromNoteInt(PITCH_LOAD_ANIMATION_BANK3      ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_LOAD_ANIMATION_BANK4       + " | " + getStringFromNoteInt(PITCH_LOAD_ANIMATION_BANK4      ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_LOAD_IMAGE_BANK1           + " | " + getStringFromNoteInt(PITCH_LOAD_IMAGE_BANK1          ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_DISPLAY_EFFECT             + " | " + getStringFromNoteInt(PITCH_DISPLAY_EFFECT            ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_DMX_ANIMATION_BANK1        + " | " + getStringFromNoteInt(PITCH_DMX_ANIMATION_BANK1       ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_DMX_ANIMATION_BANK2        + " | " + getStringFromNoteInt(PITCH_DMX_ANIMATION_BANK2       ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_DMX_ANIMATION_BANK3        + " | " + getStringFromNoteInt(PITCH_DMX_ANIMATION_BANK3       ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_CUSTOM_DEVICE_BANK1        + " | " + getStringFromNoteInt(PITCH_CUSTOM_DEVICE_BANK1       ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_CUSTOM_DEVICE_BANK2        + " | " + getStringFromNoteInt(PITCH_CUSTOM_DEVICE_BANK2       ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_CUSTOM_DEVICE_BANK3        + " | " + getStringFromNoteInt(PITCH_CUSTOM_DEVICE_BANK3       ) + "\n" +
                                  "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_GENERAL_STROBO_FRONT_RIGHT + " | " + getStringFromNoteInt(PITCH_GENERAL_STROBO_FRONT_RIGHT) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_GENERAL_STROBO_FRONT_LEFT  + " | " + getStringFromNoteInt(PITCH_GENERAL_STROBO_FRONT_LEFT ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_GENERAL_STROBO_BACK        + " | " + getStringFromNoteInt(PITCH_GENERAL_STROBO_BACK       ) + "\n" +
                                  "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_ENABLE_MAN_INPUT           + " | " + getStringFromNoteInt(PITCH_ENABLE_MAN_INPUT          ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_DISABLE_MAN_INPUT          + " | " + getStringFromNoteInt(PITCH_DISABLE_MAN_INPUT         ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_CHANGE_OUTPUTMAPPING       + " | " + getStringFromNoteInt(PITCH_CHANGE_OUTPUTMAPPING      ) + "\n" +
                                  "\n" +
                                  "\n" +
                                  "\n" +
                                  "\n" +
                                  "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_PAD_KILL_LED_PANELS        + " | " + getStringFromNoteInt(PITCH_PAD_KILL_LED_PANELS       ) + "\n" + 
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_PAD_STROBE_4TH             + " | " + getStringFromNoteInt(PITCH_PAD_STROBE_4TH            ) + "\n" + 
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_PAD_STROBE_8TH             + " | " + getStringFromNoteInt(PITCH_PAD_STROBE_8TH            ) + "\n" + 
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_PAD_STROBE_16TH            + " | " + getStringFromNoteInt(PITCH_PAD_STROBE_16TH           ) + "\n" + 
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_PAD_STROBE_32ND            + " | " + getStringFromNoteInt(PITCH_PAD_STROBE_32ND           ) + "\n" + 
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_PAD_STROBE_64TH            + " | " + getStringFromNoteInt(PITCH_PAD_STROBE_64TH           ) + "\n" + 
                                  "INPUT MIDI (CC VAL)     : " + PITCH_KNOB_BLACKOUT              + "\n" + 
                                  "INPUT MIDI (CC VAL)     : " + PITCH_KNOB_WHITEOUT              + "\n" + 
                                  "INPUT MIDI (CC VAL)     : " + PITCH_KNOB_SHREDDER              + "\n" + 
                                  "INPUT MIDI (CC VAL)     : " + PITCH_KNOB_COLORCHANGE           + "\n" + 
                                  "INPUT MIDI (CC VAL)     : " + PITCH_KNOB_WHITEJAMAMONO         + "\n" + 
                                  "\n" +
                                  "\n" +
                                  "\n" +
                                  "\n" +
                                  "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_P1_LEFT                    + " | " + getStringFromNoteInt(PITCH_P1_LEFT                   ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_P1_RIGHT                   + " | " + getStringFromNoteInt(PITCH_P1_RIGHT                  ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_P2_LEFT                    + " | " + getStringFromNoteInt(PITCH_P2_LEFT                   ) + "\n" +
                                  "INPUT MIDI (VAL | NOTE) : " + PITCH_P2_RIGHT                   + " | " + getStringFromNoteInt(PITCH_P2_RIGHT                  ) + "\n"
                                  ;
                                  
    
    cp5.addTextarea("Accepted incoming messages")
       .setPosition(leftOffset,leftOffset + 4*textfieldHeight + 3*spacingRow)
       .setSize(2*bigTextfieldWidth,generalInformationsHeight - 2*leftOffset - 3*textfieldHeight - 3*spacingRow)
       .setFont(minimlFont)
       .setColor(color(220))
       .setText(gui_incomingMsgList)
       .moveTo(midiInfo)
       ;
    cp5.addTextarea("Accepted incoming value")
       .setPosition(leftOffset + accordionWidth/2,leftOffset + 4*textfieldHeight + 3*spacingRow)
       .setSize(bigTextfieldWidth*2,generalInformationsHeight - 2*leftOffset - 3*textfieldHeight - 3*spacingRow)
       .setFont(minimlFont)
       .setColor(color(220))
       .setText(gui_incomingMsgValue)
       .moveTo(midiInfo)
       ;

                             
    /////////////////////////////////////////////////////////////////////////////////////
    
    effectsInfo = cp5.addGroup("Effects")
                     .setBackgroundColor(color(0, 64))
                     .setBackgroundHeight(generalInformationsHeight)
                     ;

    cp5.addTextarea("Effect List Label")
       .setPosition(leftOffset,leftOffset)
       .setFont(minimlFont)
       .setColor(color(220))
       .setText("List of the available effects :")
       .moveTo(effectsInfo)
       ;
       
    createEffectsBangList();
    
    /////////////////////////////////////////////////////////////////////////////////////
    
    Group audioSignalConfiguration = cp5.addGroup("Audio Signal Configuration")
                                        .setBackgroundColor(color(0, 64))
                                        .setBackgroundHeight(generalInformationsHeight)
                                        ;
    int signalTextFieldOffset = 80;
    int bassThresholdTextFieldOffset = signalTextFieldOffset + 7*spacingRow + 6*textfieldHeight;
    
    cp5.addTextfield("Kick - Audio Signal ID")
       .setPosition(accordionWidth - bigTextfieldWidth - leftOffset, spacingRow + signalTextFieldOffset)
       .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
       .setValue(str(SIGNAL_ID_KICK))
       .setFont(minimlFont)
       .setCaptionLabel("Kick - Audio Signal ID# :    ")
       .setAutoClear(false)
       .moveTo(audioSignalConfiguration)
       .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
       ;
    cp5.addTextfield("Snare - Audio Signal ID")
       .setPosition(accordionWidth - bigTextfieldWidth - leftOffset, 2*spacingRow + textfieldHeight + signalTextFieldOffset)
       .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
       .setValue(str(SIGNAL_ID_SNARE))
       .setFont(minimlFont)
       .setCaptionLabel("Snare - Audio Signal ID# :    ")
       .setAutoClear(false)
       .moveTo(audioSignalConfiguration)
       .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
       ;
    cp5.addTextfield("Cymbals - Audio Signal ID")
       .setPosition(accordionWidth - bigTextfieldWidth - leftOffset, 3*spacingRow + 2*textfieldHeight + signalTextFieldOffset)
       .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
       .setValue(str(SIGNAL_ID_CYMBALS))
       .setFont(minimlFont)
       .setCaptionLabel("Cymbals - Audio Signal ID# :    ")
       .setAutoClear(false)
       .moveTo(audioSignalConfiguration)
       .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
       ;
    cp5.addTextfield("Bass - Audio Signal ID")
       .setPosition(accordionWidth - bigTextfieldWidth - leftOffset, 4*spacingRow + 3*textfieldHeight + signalTextFieldOffset)
       .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
       .setValue(str(SIGNAL_ID_BASS))
       .setFont(minimlFont)
       .setCaptionLabel("Bass - Audio Signal ID# :    ")
       .setAutoClear(false)
       .moveTo(audioSignalConfiguration)
       .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
       ;
    cp5.addTextfield("Keys - Audio Signal ID")
       .setPosition(accordionWidth - bigTextfieldWidth - leftOffset, 5*spacingRow + 4*textfieldHeight + signalTextFieldOffset)
       .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
       .setValue(str(SIGNAL_ID_KEYS))
       .setFont(minimlFont)
       .setCaptionLabel("Keys - Audio Signal ID# :    ")
       .setAutoClear(false)
       .moveTo(audioSignalConfiguration)
       .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
       ;
    cp5.addTextfield("Guitar - Audio Signal ID")
       .setPosition(accordionWidth - bigTextfieldWidth - leftOffset, 6*spacingRow + 5*textfieldHeight + signalTextFieldOffset)
       .setSize(bigTextfieldWidth - 2*textfieldHeight - spacingRow,textfieldHeight)
       .setValue(str(SIGNAL_ID_GUITAR))
       .setFont(minimlFont)
       .setCaptionLabel("Guitar - Audio Signal ID# :    ")
       .setAutoClear(false)
       .moveTo(audioSignalConfiguration)
       .getCaptionLabel().align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER)
       ;


    String idNumberExplanation = "The values set for each function needs to be\n" +
                                 "coherent with the configuration of the Signal\n" +
                                 "Processor plugin instances used inside your DAW\n" +
                                 "\n" +
                                 "Do not forget to also set only one instance to\n" +
                                 "send the transport data (timecode / tempo),\n" +
                                 "more than one could mess up the analysis\n"
                                 ;
    cp5.addTextarea("ID# Explanation 1")
       .setPosition(leftOffset,leftOffset)
       .setFont(minimlFont)
       .setColor(color(220))
       .setText("ID numbers of the incoming signal messages")
       .moveTo(audioSignalConfiguration)
       ;
     cp5.addTextarea("ID# Explanation 2")
       .setPosition(leftOffset,leftOffset + textfieldHeight + spacingRow)
       .setFont(minimlFont)
       .setColor(color(220))
       .setText(idNumberExplanation)
       .moveTo(audioSignalConfiguration)
       ;
       
       
     String bassFilterExplanation = "Set the value for the ratio between the high\n" +
                                    "and the low frequencies after which the bass\n" +
                                    "is considered to be filtered\n" +
                                    "This parameter is used by the auto mode\n" +
                                    "algorithm, to detect when the bass is alone\n" +
                                    "and filtered (special scenario in which the\n" +
                                    "right stroboscope is on, and the panels off)\n"
                                    ;
       
     cp5.addTextarea("Bass Filter Explanation")
       .setPosition(leftOffset,leftOffset + textfieldHeight + spacingRow + bassThresholdTextFieldOffset)
       .setFont(minimlFont)
       .setColor(color(220))
       .setText(bassFilterExplanation)
       .moveTo(audioSignalConfiguration)
       ;
       
     cp5.addSlider("Bass Hi-Lo Ratio Threshold")
        .setPosition(leftOffset, 7*spacingRow + 6*textfieldHeight + bassThresholdTextFieldOffset)
        .setRange(5,200)
        .setValue(HI_LO_RATIO_THRESHOLD)
        .moveTo(audioSignalConfiguration)
        ;

    /////////////////////////////////////////////////////////////////////////////////////
       
    // Create the sidebar accordion, with all the previous subgroups
    generalInfoAccordion = cp5.addAccordion("General Informations")
                              .setPosition(gui_simulatorPosX + gui_simulatorWidth + gui_spacing, gui_informationsAccordionPosY)
                              .setWidth(accordionWidth)
                              .addItem(hardwareInfo)
                              .addItem(midiInfo)
                              .addItem(effectsInfo)
                              .addItem(audioSignalConfiguration)
                              ;
                   
        
    // when in SINGLE mode, only 1 accordion  
    // group can be open at a time.  
    generalInfoAccordion.open(0);
    generalInfoAccordion.setCollapseMode(Accordion.SINGLE);

    return generalInfoAccordion;
    
  }

  
  ////////////////////////////////////////////////////////////////
  // Create the LED Panel filter group
  //  
  
  Group createLEDPanelAnimationListGroup() {
    int toggleWidth   = 12;
    int toggleHeight  = 9;
    int spacingRow    = 3;
    int spacingColumn = 60;
    int leftOffset    = 6;
    
    int groupWidth = 576;
    
    
    Group LEDPanelAnimations_animListGroup = cp5.addGroup("Animation list - LED panels")
                                                .setPosition(gui_spacing,5*height/10 - 15)
                                                .setWidth(groupWidth)
                                                .activateEvent(true)
                                                .disableCollapse() 
                                                .setBackgroundColor(color(255,80))
                                                .setBackgroundHeight(height/4-20)
                                                .setLabel("Animation list - LED panels")
                                                ;

    LEDPanelAnimations_reinitButton = cp5.addButton("Reinit LED Panel list")
                                         .setValue(0)
                                         .setCaptionLabel("Reinit")
                                         .setPosition(leftOffset + 7*spacingColumn + 7*toggleWidth, 5*toggleHeight + 4*spacingRow)
                                         .setSize(60, toggleHeight)
                                         .setColorBackground(color(110,0,0))
                                         .setColorForeground(color(160,0,0))
                                         .setColorActive(color(255,0,0))
                                         .setGroup(LEDPanelAnimations_animListGroup)
                                         ;
    // Center the label
    LEDPanelAnimations_reinitButton.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    LEDPanelAnimations_animationListCheckBox = cp5.addCheckBox("Attributes - LED Panel animations")
                                                  .setPosition(leftOffset,toggleHeight)
                                                  .setSize(toggleWidth,toggleHeight)
                                                  .setItemsPerRow(8)
                                                  .setSpacingColumn(spacingColumn)
                                                  .setSpacingRow(spacingRow)
                                                  .setColorForeground(color(120,0,0))
                                                  .setColorActive(color(160,0,0))
                                                  .setColorLabel(color(255))
                                                  .addItem("Geometric",0)
                                                  .addItem("Atmospheric",1)
                                                  .addItem("Fade In/Out",2)
                                                  .addItem("Random",3)
                                                  .addItem("Very Bright",4)
                                                  .addItem("Very Dark",5)
                                                  .addItem("Red",6)
                                                  .addItem("B&W",7)
                                                  .addItem("Blue",8)
                                                  .addItem("Colorful",9)   
                                                  .addItem("Rotating",10)       
                                                  .addItem("Simple",11)
                                                  .addItem("Complex",12)
                                                  .addItem("Evolving",13)
                                                  .addItem("Smooth",14)
                                                  .addItem("Violent",15)
                                                  .addItem("Rhythmic",16)
                                                  .addItem("Fast",17)
                                                  .addItem("Slow",18)
                                                  .addItem("Still",19)
                                                  .addItem("Lines",20)
                                                  .addItem("Curves",21)
                                                  .addItem("Triangles",22)
                                                  .addItem("Squares",23)
                                                  .addItem("Circles",24)
                                                  .addItem("Spiral",25)       
                                                  .addItem("Noise",26)
                                                  .addItem("Objects",27)   
                                                  .addItem("Special",28)
                                                  .addItem("Audio",29)
                                                  .addItem("Game",30)
                                                  .addItem("3D",31)
                                                  .setGroup(LEDPanelAnimations_animListGroup)
                                                  ;
        
    List<String> filteredAnimationsStringList = new ArrayList<String>();
    for (Attribute attr: animationAttributes) {
      filteredAnimationsStringList.add(attr.animationNbr + ": " + attr.name);
    }
    //Initialize the filtered animation list with all the available animations
    LEDPanelAnimations_animationListBox = cp5.addListBox("Filtered LED Panel Animation List")
                                             .setPosition(leftOffset, 5*toggleHeight + 6*spacingRow )
                                             .setSize(3*LEDPanelAnimations_animListGroup.getWidth()/5 - 2*leftOffset, LEDPanelAnimations_animListGroup.getBackgroundHeight() - (6*toggleHeight + 5*spacingRow) + 3)
                                             .addItems(filteredAnimationsStringList)
                                             .hideBar() 
                                             .disableCollapse()
                                             .moveTo(LEDPanelAnimations_animListGroup)
                                             ;
    
    LEDPanelAnimations_currentAnimationDescription = cp5.addTextarea("Current Animation Description - LED Panels")
                                                        .setPosition(3*LEDPanelAnimations_animListGroup.getWidth()/5, 6*toggleHeight + 6*spacingRow)
                                                        .setSize(LEDPanelAnimations_animListGroup.getWidth() - LEDPanelAnimations_animationListBox.getWidth() - 3*leftOffset, LEDPanelAnimations_animListGroup.getBackgroundHeight() - (7*toggleHeight + 6*spacingRow) + 2)
                                                        .setColor(color(255))
                                                        //.setFont(createFont("",8,true))
                                                        .setFont(minimlFont)
                                                        .hideScrollbar()
                                                        .setColorBackground(color(255,90))
                                                        .setColorForeground(color(255,90))
                                                        .moveTo(LEDPanelAnimations_animListGroup)
                                                        ;
    String textDescription = "Current animation description \n"
                                      + "Select an animation in the list\n"
                                      + "\n"
                                      + "Animation number : \n"
                                      + "Corresponding note/velocity : \n"
                                      + "Attributes: \n";
    LEDPanelAnimations_currentAnimationDescription.setText(textDescription.toUpperCase());    
        
    return LEDPanelAnimations_animListGroup;
  } 
  
  
  void createCustomDeviceAndDMXAccordion(){

    int accordionPosX  = gui_spacing;
    int accordionPosY  = 22*height/30 - 10;
    int accordionWidth = 576;
    
    Group CustomDevices = createCustomDeviceAnimationListGroup();
    Group DMX = createDMXAnimationListGroup();
    
    // Create an accordion containing two elements : the DMX and the Custom Device animation lists
    customDevicesDMXAnimationListsAccordion = cp5.addAccordion("Animation Lists")
                                                 .setPosition(accordionPosX, accordionPosY)
                                                 .setWidth(accordionWidth)
                                                 .addItem(CustomDevices)
                                                 .addItem(DMX)
                                                 ;
                   
        
    // when in SINGLE mode, only 1 accordion  
    // group can be open at a time.  
    customDevicesDMXAnimationListsAccordion.open(0);
    customDevicesDMXAnimationListsAccordion.setCollapseMode(Accordion.SINGLE);    
  }
  
  ////////////////////////////////////////////////////////////////
  // Create the custom device filter group
  //
  
  Group createCustomDeviceAnimationListGroup() {
    int toggleWidth   = 12;
    int toggleHeight  = 9;
    int spacingRow    = 3;
    int spacingColumn = 75;
    int leftOffset    = 6;
    
    int groupWidth = 576;
    
    Group CustomDeviceAnimations_animListGroup = cp5.addGroup("Animation list - Custom Devices")
//                                                    .setPosition(gui_spacing,22*height/30 )
                                                    .setWidth(groupWidth)
                                                    .activateEvent(true)
//                                                    .disableCollapse() 
                                                    .setBackgroundColor(color(255,80))
                                                    .setBackgroundHeight(height/4-30)
                                                    .setLabel("Animation list - Custom devices")
                                                    ;

    CustomDeviceAnimations_reinitButton = cp5.addButton("Reinit CustomDevice list")
                                             .setValue(0)
                                             .setCaptionLabel("Reinit")
                                             .setPosition(leftOffset + 6*spacingColumn + 6*toggleWidth, 4*toggleHeight + 3*spacingRow)
                                             .setSize(40, toggleHeight)
                                             .setColorBackground(color(110,0,0))
                                             .setColorForeground(color(160,0,0))
                                             .setColorActive(color(255,0,0))
                                             .setGroup(CustomDeviceAnimations_animListGroup)
                                             ;
    // Center the label
    CustomDeviceAnimations_reinitButton.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    CustomDeviceAnimations_animationListCheckBox = cp5.addCheckBox("Attributes - Custom Device animations")
                                                  .setPosition(leftOffset,toggleHeight)
                                                  .setSize(toggleWidth,toggleHeight)
                                                  .setItemsPerRow(7)
                                                  .setSpacingColumn(spacingColumn)
                                                  .setSpacingRow(spacingRow)
                                                  .setColorForeground(color(120,0,0))
                                                  .setColorActive(color(160,0,0))
                                                  .setColorLabel(color(255))
                                                  .addItem("All Devices",     0)
                                                  .addItem("Rack Lights",     1)
                                                  .addItem("LED Tubes",       2)
                                                  .addItem("black",           3)      //Small trick : controlp5 doesn't allow more than 1 "Black" item,
                                                  .addItem("white",           4)      //work around this by setting some letters to lowercase
                                                  .addItem("red",             5)
                                                  .addItem("blue",            6)
                                                  .addItem("rainbow",         7)
                                                  .addItem("random",          8)
                                                  .addItem("fast",            9)
                                                  .addItem("medium",         10)
                                                  .addItem("slow",           11)
                                                  .addItem("very slow",      12)
                                                  .addItem("long",           13)
                                                  .addItem("short",          14)
                                                  .addItem("plain",          15)
                                                  .addItem("flash",          16)
                                                  .addItem("smooth sine",    17)
                                                  .addItem("stroboscope",    18)
                                                  .addItem("growing strobe", 19)
                                                  .addItem("wave",           20)
                                                  .addItem("buildup",        21)
                                                  .addItem("noise",          22)
                                                  .addItem("smooth noise",   23)
                                                  .setGroup(CustomDeviceAnimations_animListGroup)
                                                  ;

    
    List<String> filteredAnimationsStringList = new ArrayList<String>();
    for (Attribute attr: customDevicesAttributes) {
      filteredAnimationsStringList.add(attr.animationNbr + ": " + attr.name);
    }
    //Initialize the filtered animation list with all the available animations
    CustomDeviceAnimations_animationListBox = cp5.addListBox("Filtered Custom Device Animation List")
                                                 .setPosition(leftOffset, 5*toggleHeight + 6*spacingRow)
                                                 .setSize(3*CustomDeviceAnimations_animListGroup.getWidth()/5 - 2*leftOffset, CustomDeviceAnimations_animListGroup.getBackgroundHeight() - (6*toggleHeight + 5*spacingRow) + 1)
                                                 .addItems(filteredAnimationsStringList)
                                                 .hideBar() 
                                                 .disableCollapse()
                                                 .moveTo(CustomDeviceAnimations_animListGroup)
                                                 ;
    
    CustomDeviceAnimations_currentAnimationDescription = cp5.addTextarea("Current Custom Device Animation Description")
                                                            .setPosition(3*CustomDeviceAnimations_animListGroup.getWidth()/5, 5*toggleHeight + 6*spacingRow)
                                                            .setSize(CustomDeviceAnimations_animListGroup.getWidth() - CustomDeviceAnimations_animationListBox.getWidth() - 3*leftOffset, CustomDeviceAnimations_animationListBox.getBackgroundHeight())
                                                            .setColor(color(255))
                                                            //.setFont(createFont("",8,true))
                                                            .setFont(minimlFont)
                                                            .hideScrollbar()
                                                            .setColorBackground(color(255,90))
                                                            .setColorForeground(color(255,90))
                                                            .moveTo(CustomDeviceAnimations_animListGroup)
                                                            ;
    String textDescription = "Current animation description \n"
                                      + "Select an animation in the list\n"
                                      + "\n"
                                      + "Animation number : \n"
                                      + "Corresponding note/velocity : \n"
                                      + "Attributes: \n";
    CustomDeviceAnimations_currentAnimationDescription.setText(textDescription.toUpperCase());    
        
    return CustomDeviceAnimations_animListGroup;
  }
  
  
  ////////////////////////////////////////////////////////////////
  // Now do the same for the DMX animations
  //
  
  Group createDMXAnimationListGroup() {
    int toggleWidth   = 12;
    int toggleHeight  = 9;
    int spacingRow    = 3;
    int spacingColumn = 75;
    int leftOffset    = 6;
    
    int groupWidth = 576;
    
    Group DMXAnimations_animListGroup = cp5.addGroup("Animation list - DMX Devices")
                                                    .setWidth(groupWidth)
                                                    .activateEvent(true) 
                                                    .setBackgroundColor(color(255,80))
                                                    .setBackgroundHeight(height/4-30)
                                                    .setLabel("Animation list - DMX devices")
                                                    ;

    DMXAnimations_reinitButton = cp5.addButton("Reinit DMX list")
                                             .setValue(0)
                                             .setCaptionLabel("Reinit")
                                             .setPosition(leftOffset + 6*spacingColumn + 6*toggleWidth, 4*toggleHeight + 3*spacingRow)
                                             .setSize(40, toggleHeight)
                                             .setColorBackground(color(110,0,0))
                                             .setColorForeground(color(160,0,0))
                                             .setColorActive(color(255,0,0))
                                             .setGroup(DMXAnimations_animListGroup)
                                             ;
    // Center the label
    DMXAnimations_reinitButton.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    DMXAnimations_animationListCheckBox = cp5.addCheckBox("Attributes - DMX animations")
                                                  .setPosition(leftOffset,toggleHeight)
                                                  .setSize(toggleWidth,toggleHeight)
                                                  .setItemsPerRow(7)
                                                  .setSpacingColumn(spacingColumn)
                                                  .setSpacingRow(spacingRow)
                                                  .setColorForeground(color(120,0,0))
                                                  .setColorActive(color(160,0,0))
                                                  .setColorLabel(color(255))
                                                  .addItem("All",         0)
                                                  .addItem("Right",       1)
                                                  .addItem("Left",        2)
                                                  .addItem("Center",      3)
                                                  .addItem("rhythmic",    4)
                                                  .addItem("Strobe",      5)
                                                  .addItem("Par",         6)
                                                  .addItem("very slow ",  7)    //Small trick, controlP5 does not allow two elements with the same name
                                                  .addItem("slow ",       8)
                                                  .addItem("medium ",     9)
                                                  .addItem("fast ",       10)
                                                  .addItem("very fast ",  11)
                                                  .addItem("audio",       12)
                                                  .addItem("Atomic",      13)
                                                  .setGroup(DMXAnimations_animListGroup)
                                                  ;

    
    List<String> filteredAnimationsStringList = new ArrayList<String>();
    for (Attribute attr: DMXAttributes) {
      filteredAnimationsStringList.add(attr.animationNbr + ": " + attr.name);
    }
    //Initialize the filtered animation list with all the available animations
    DMXAnimations_animationListBox = cp5.addListBox("Filtered DMX Animation List")
                                                 .setPosition(leftOffset, 3*toggleHeight + 4*spacingRow)
                                                 .setSize(3*DMXAnimations_animListGroup.getWidth()/5 - 2*leftOffset, DMXAnimations_animListGroup.getBackgroundHeight() - (4*toggleHeight + 3*spacingRow) + 1)
                                                 .addItems(filteredAnimationsStringList)
                                                 .hideBar() 
                                                 .disableCollapse()
                                                 .moveTo(DMXAnimations_animListGroup)
                                                 ;
    
    DMXAnimations_currentAnimationDescription = cp5.addTextarea("Current DMX Animation Description")
                                                            .setPosition(3*DMXAnimations_animListGroup.getWidth()/5, 5*toggleHeight + 6*spacingRow)
                                                            .setSize(DMXAnimations_animListGroup.getWidth() - DMXAnimations_animationListBox.getWidth() - 3*leftOffset, DMXAnimations_animationListBox.getBackgroundHeight() - toggleHeight - spacingRow)
                                                            .setColor(color(255))
                                                            .setFont(minimlFont)
                                                            .hideScrollbar()
                                                            .setColorBackground(color(255,90))
                                                            .setColorForeground(color(255,90))
                                                            .moveTo(DMXAnimations_animListGroup)
                                                            ;
    String textDescription = "Current DMX animation description \n"
                                      + "Select an animation in the list\n"
                                      + "\n"
                                      + "Animation number : \n"
                                      + "Corresponding note/velocity : \n"
                                      + "Attributes: \n";
    DMXAnimations_currentAnimationDescription.setText(textDescription.toUpperCase());    
        
    return DMXAnimations_animListGroup;
  }
  
  void rebuildFilteredLEDPanelAnimationList(float[] checkBoxArrayValue) {
    String[] wantedAttributes = createLEDPanelAnimationListFilter(checkBoxArrayValue);
    List<String> filteredAnimationsStringList = new ArrayList<String>();
    boolean init = false;
    if (wantedAttributes.length == 0) {
      init = true;
    }

    if (init == false) {
      String[] unwantedAttributes = {};
      ArrayList<Attribute> gui_LEDPanelFilteredAttributes = new ArrayList<Attribute>();
      gui_LEDPanelFilteredAttributes = filterAnimationsByAttributes(animationAttributes, wantedAttributes, unwantedAttributes);
      for (Attribute attr: gui_LEDPanelFilteredAttributes) {
        filteredAnimationsStringList.add(attr.animationNbr + ": " + attr.name);
      }
    }
    else {
      for (Attribute attr: animationAttributes) {
        filteredAnimationsStringList.add(attr.animationNbr + ": " + attr.name);
      }
    }

    for (String item[]: LEDPanelAnimations_animationListBox.getListBoxItems()) {
      LEDPanelAnimations_animationListBox.removeItem(item[0]);
    }
    LEDPanelAnimations_animationListBox.addItems(filteredAnimationsStringList);
  }
  
  void rebuildFilteredCustomDeviceAnimationList(float[] checkBoxArrayValue) {
    String[] wantedAttributes = createCustomDeviceAnimationListFilter(checkBoxArrayValue);
    List<String> filteredAnimationsStringList = new ArrayList<String>();
    boolean init = false;
    if (wantedAttributes.length == 0) {
      init = true;
    }

    if (init == false) {
      String[] unwantedAttributes = {};
      ArrayList<Attribute> gui_CustomDeviceFilteredAttributes = new ArrayList<Attribute>();
      gui_CustomDeviceFilteredAttributes = filterAnimationsByAttributes(customDevicesAttributes, wantedAttributes, unwantedAttributes);
      for (Attribute attr: gui_CustomDeviceFilteredAttributes) {
        filteredAnimationsStringList.add(attr.animationNbr + ": " + attr.name);
      }
    }
    else {
      for (Attribute attr: customDevicesAttributes) {
        filteredAnimationsStringList.add(attr.animationNbr + ": " + attr.name);
      }
    }

    for (String item[]: CustomDeviceAnimations_animationListBox.getListBoxItems()) {
      CustomDeviceAnimations_animationListBox.removeItem(item[0]);
    }
    CustomDeviceAnimations_animationListBox.addItems(filteredAnimationsStringList);
  }
  
  
  void rebuildFilteredDMXAnimationList(float[] checkBoxArrayValue) {
    String[] wantedAttributes = createDMXAnimationListFilter(checkBoxArrayValue);
    List<String> filteredAnimationsStringList = new ArrayList<String>();
    boolean init = false;
    if (wantedAttributes.length == 0) {
      init = true;
    }

    if (init == false) {
      String[] unwantedAttributes = {};
      ArrayList<Attribute> gui_DMXFilteredAttributes = new ArrayList<Attribute>();
      gui_DMXFilteredAttributes = filterAnimationsByAttributes(DMXAttributes, wantedAttributes, unwantedAttributes);
      for (Attribute attr: gui_DMXFilteredAttributes) {
        filteredAnimationsStringList.add(attr.animationNbr + ": " + attr.name);
      }
    }
    else {
      for (Attribute attr: DMXAttributes) {
        filteredAnimationsStringList.add(attr.animationNbr + ": " + attr.name);
      }
    }

    for (String item[]: DMXAnimations_animationListBox.getListBoxItems()) {
      DMXAnimations_animationListBox.removeItem(item[0]);
    }
    DMXAnimations_animationListBox.addItems(filteredAnimationsStringList);
  }
  
  ////////////////////////////////////////////////////////
  
  void gui_loadLEDPanelAnimation(int animNbr) {
    setupcomplete = false;
    drawAnimation = 1;
    drawImage = 0;
    animationnumber = animNbr;
    specificActions();
  }
  
  void gui_loadDMXAnimation(int animNbr) {
    dmxAutomaticControl = true;
    dmxAnimationNumber  = animNbr;
    setupDMXAnimation();
  }
  
  ////////////////////////////////////////////////////////
  
  void gui_activateMappingBangs() {
    for (Bang temp: changeLEDPanelMappingBangList) {
      temp.setColorForeground(color(4,104,154))
          .setColorActive(color(0,180,234));
    }
  }
  
  void gui_disableMappingBangs() {
    for (Bang temp: changeLEDPanelMappingBangList) {
      temp.setColorForeground(color(150))
          .setColorActive(color(150));
    }
  }
  
  void initLEDPanelMappingArray() {
    tempLEDPanelMapping_counter = 0;
    tempLEDPanelMapping_array = new int[NUMBER_OF_PANELS];
    for (int i = 0; i<NUMBER_OF_PANELS; i++) {
      tempLEDPanelMapping_array[i] = -1;
    }
    
    //Display an image lighting only the current panel to map to inform the user 
    drawImage = 1;
    drawAnimation = 0;
    imagenumber = -1;
  }
  
  void registerBangForLEDPanelMapping(int panelNbr) {     
    boolean panelValueInsideMappingArray = false;
    for(int i: tempLEDPanelMapping_array) {
      if (i == panelNbr) {
        panelValueInsideMappingArray = true;
        break;
      }
    }
    if (!panelValueInsideMappingArray) {
      tempLEDPanelMapping_array[tempLEDPanelMapping_counter] = panelNbr;
      tempLEDPanelMapping_counter += 1;
      //Display an image lighting only the current panel to map to inform the user
      imagenumber -=1;
    }

    if (tempLEDPanelMapping_counter == NUMBER_OF_PANELS) {
      gui_disableMappingBangs();
      changeLEDPanelMappingToggle.setState(false);
      
      //Display an image lighting all the panels to map to inform the user that reinit is over
      imagenumber = 0;
      
      gui_updateLEDMapping();
      
      tempLEDPanelMapping_counter = 0;
    }
  }
  
  void createEffectsBangList() {
    addEffectBang("1 - Classic Glitch", 1);
    addEffectBang("2 - RGB Glitch", 2);
    addEffectBang("3 - 180 Flip", 3);
    addEffectBang("4 - Red Shift", 4);
    addEffectBang("5 - General Flicker", 5);
    addEffectBang("6 - Random White Stripes", 6);
    addEffectBang("7 - Random Red Stripes", 7);
    addEffectBang("8 - Random Blue Stripes", 8);
    addEffectBang("9 - Random White Lines", 9);
    addEffectBang("10 - Random Red Lines", 10);
    addEffectBang("11 - Random Blue Lines", 11);
    addEffectBang("12 - Flicker - Panel 1", 12);
    addEffectBang("13 - Flicker - Panel 2", 13);
    addEffectBang("14 - Flicker - Panel 3", 14);
    addEffectBang("15 - Flicker - Panel 4", 15);
    addEffectBang("16 - Flicker - Panel 5", 16);
    addEffectBang("17 - Flutter", 17);
    addEffectBang("18 - Monochrome Filter", 18);
    addEffectBang("19 - Invert Filter", 19);
    addEffectBang("20 - Only Left", 20);
    addEffectBang("21 - Only Right", 21);
    addEffectBang("22 - General Random Panel Flicker", 22);
    addEffectBang("23 - Rainbow Color", 23);
    addEffectBang("24 - Fadeout", 24);
    addEffectBang("25 - Fadein", 25);
    addEffectBang("26 - Fadeout", 26);
    addEffectBang("27 - Fadein", 27);

  }
  
  void addEffectBang(String name, int i) {
    
    int toggleWidth   = 12;
    int toggleHeight  = 9;
    int spacingRow    = 3;
    int spacingColumn = 75;
    int leftOffset    = 6;
    int upOffset      = 10;
    
    cp5.addBang("Effect Bang - " + name)
         .setPosition(leftOffset, upOffset + i*(toggleHeight + spacingRow))
         .setSize(toggleWidth, toggleHeight)
         .setCaptionLabel("  " + name)
         .moveTo(effectsInfo)
         .getCaptionLabel().align(ControlP5.RIGHT_OUTSIDE, ControlP5.CENTER)
         ;    
  }
  
  //Note : this function is similar to finalizeLEDPanelRemappingProcedure inside MidiControl,
  //but there is a reason to have two different remapping procedure : the person behind the
  //GUI and the person behind the keyboard could be different people, don't want parasite
  // keyboard input during the GUI remapping
  void gui_updateLEDMapping() {
    
    // Most critical part : update the panelNumber directly inside the Output objects !
    for (int i=0; i<outputDevices.length; i++) {
      outputDevices[i].panelNumber = tempLEDPanelMapping_array[i];
      screen_order_configuration[i] = tempLEDPanelMapping_array[i];
    }
    
    //Make the configuration change persistant
    writeScreenOrderInConfigurationFile();
  }


  void createMessageBox(String device, String[] explanationText) {
    // create a group to store the messageBox elements
    int messageBoxWidth = width/2;
    int messageBoxPosX = width/2 - messageBoxWidth/2;
    int messageBoxPosY = height/5;
    int messageBoxInputFieldWidth = 410;
    int messageBoxInputFieldHeight = 14;
    
    GUIMessageBox = cp5.addGroup("messageBox",messageBoxPosX,messageBoxPosY,messageBoxWidth);
    GUIMessageBox.setBackgroundColor(color(0,200));
    GUIMessageBox.hideBar();
    
    // add a TextLabel to the messageBox.
    int nbLines=0;
    for (nbLines=0; nbLines<explanationText.length; nbLines++) {
      Textlabel txt = cp5.addTextlabel("Input label " + nbLines, explanationText[nbLines], 20, 20 + nbLines*10);
      txt.moveTo(GUIMessageBox);
    }
    
    int marginY = (nbLines-1)*10;
    GUIMessageBox.setBackgroundHeight(120 + marginY);
    
    Textfield f = cp5.addTextfield("inputbox_" + device,20,45+marginY,messageBoxInputFieldWidth,messageBoxInputFieldHeight);
    f.captionLabel().setVisible(false);
    f.setFocus(true);
    f.moveTo(GUIMessageBox);
    f.setColorActive(color(100));
    controlP5.Button b1 = cp5.addButton("buttonOK_" + device,0,65,80 + marginY,80,24);
    b1.moveTo(GUIMessageBox);
    b1.setColorBackground(color(40));
    b1.setColorActive(color(20));
    // by default setValue would trigger function buttonOK, 
    // therefore we disable the broadcasting before setting
    // the value and enable broadcasting again afterwards.
    // same applies to the cancel button below.
    b1.setBroadcast(false); 
    b1.setValue(1);
    b1.setBroadcast(true);
    b1.setCaptionLabel("OK");
    // centering of a label needs to be done manually with marginTop and marginLeft
    b1.captionLabel().style().marginTop = 0;
    b1.captionLabel().style().marginLeft = 30;
    
    // add the Cancel button to the messageBox. 
    controlP5.Button b2 = cp5.addButton("buttonCancel_" + device,0,155,80 + marginY,80,24);
    b2.moveTo(GUIMessageBox);
    b2.setBroadcast(false);
    b2.setValue(0);
    b2.setBroadcast(true);
    b2.setCaptionLabel("Cancel");
    b2.setColorBackground(color(40));
    b2.setColorActive(color(20));
    // centering of a label needs to be done manually with marginTop and marginLeft
    b2.captionLabel().style().marginTop = 0;
    b2.captionLabel().style().marginLeft = 22;
  }
  
  // buttonOK will be triggered when pressing the OK button of the messageBox.
  void buttonOK_FrontLeftStrobe(int theValue) {
    GUIMessageBoxString = ((Textfield)cp5.controller("inputbox_FrontLeftStrobe")).getText();
    GUIMessageBoxResult = theValue;
    gui_parseMessageBoxFrontLeftStrobe(GUIMessageBoxString);
    GUIMessageBox.hide();
  }
  
  void buttonOK_FrontRightStrobe(int theValue) {
    GUIMessageBoxString = ((Textfield)cp5.controller("inputbox_FrontRightStrobe")).getText();
    GUIMessageBoxResult = theValue;
    gui_parseMessageBoxFrontRightStrobe(GUIMessageBoxString);
    GUIMessageBox.hide();
  }
  
  // function buttonCancel will be triggered when pressing the Cancel button of the messageBox.
  void buttonCancel_FrontLeftStrobe(int theValue) {
    GUIMessageBoxResult = theValue;
    GUIMessageBox.hide();
  }
  
  void buttonCancel_FrontRightStrobe(int theValue) {
    GUIMessageBoxResult = theValue;
    GUIMessageBox.hide();
  }
  
  // inputbox is called whenever RETURN has been pressed in textfield-controller inputbox 
  void inputbox_FrontLeftStrobe(String theString) {
    GUIMessageBoxString = theString;
    gui_parseMessageBoxFrontLeftStrobe(GUIMessageBoxString);    
    GUIMessageBox.hide();
  }
  
  void inputbox_FrontRightStrobe(String theString) {
    GUIMessageBoxString = theString;
    gui_parseMessageBoxFrontRightStrobe(GUIMessageBoxString);    
    GUIMessageBox.hide();
  }

  void buttonOK_BackStrobe(int theValue) {
    GUIMessageBoxString = ((Textfield)cp5.controller("inputbox_BackStrobe")).getText();
    GUIMessageBoxResult = theValue;
    gui_parseMessageBoxBackStrobe(GUIMessageBoxString);
    GUIMessageBox.hide();
  }
  void buttonCancel_BackStrobe(int theValue) {
    GUIMessageBoxResult = theValue;
    GUIMessageBox.hide();
  }
  void inputbox_BackStrobe(String theString) {
    GUIMessageBoxString = theString;
    gui_parseMessageBoxBackStrobe(GUIMessageBoxString);    
    GUIMessageBox.hide();
  }

  void buttonOK_LEDTube(int theValue) {
    GUIMessageBoxString = ((Textfield)cp5.controller("inputbox_LEDTube")).getText();
    GUIMessageBoxResult = theValue;
    gui_parseMessageBoxLEDTube(GUIMessageBoxString);
    GUIMessageBox.hide();
  }
  void buttonCancel_LEDTube(int theValue) {
    GUIMessageBoxResult = theValue;
    GUIMessageBox.hide();
  }
  void inputbox_LEDTube(String theString) {
    GUIMessageBoxString = theString;
    gui_parseMessageBoxLEDTube(GUIMessageBoxString);    
    GUIMessageBox.hide();
  }
  
  void buttonOK_RackLight(int theValue) {
    GUIMessageBoxString = ((Textfield)cp5.controller("inputbox_LEDTube")).getText();
    GUIMessageBoxResult = theValue;
    gui_parseMessageBoxRackLight(GUIMessageBoxString);
    GUIMessageBox.hide();
  }
  void buttonCancel_RackLight(int theValue) {
    GUIMessageBoxResult = theValue;
    GUIMessageBox.hide();
  }
  void inputbox_RackLight(String theString) {
    GUIMessageBoxString = theString;
    gui_parseMessageBoxRackLight(GUIMessageBoxString);    
    GUIMessageBox.hide();
  }
  
  void gui_parseMessageBoxFrontLeftStrobe(String result) {
    int[] parsedResult = gui_parseStringGenericDMX(result, 4);
    if (parsedResult[2] < 0) {
      DMXList_FrontLeftStroboscopes.add(new DMX_Stroboscope(parsedResult[0], parsedResult[1]));
      resetExpectedTextLabel.setText("PLEASE RESET THE APP BEFORE MAKING FURTHER CHANGES\nNEW DEVICE REGISTERED : FRONT LEFT STROBOSCOPE ("+parsedResult[0]+" | "+parsedResult[1]+")");
    }
    else {
      DMXList_FrontLeftStroboscopes.add(new DMX_Stroboscope(parsedResult[0], parsedResult[1], parsedResult[2], parsedResult[3]));
      resetExpectedTextLabel.setText("PLEASE RESET THE APP BEFORE MAKING FURTHER CHANGES\nNEW DEVICE REGISTERED : FRONT LEFT STROBOSCOPE ("+parsedResult[0]+" | "+parsedResult[1]+" | "+parsedResult[2]+" | "+parsedResult[3]+")");
    }
    
    resetExpectedTextLabel.setVisible(true);
    createConfigFile();
  }
  void gui_parseMessageBoxFrontRightStrobe(String result) {
    int[] parsedResult = gui_parseStringGenericDMX(result, 4);
    if (parsedResult[2] < 0) {
      DMXList_FrontRightStroboscopes.add(new DMX_Stroboscope(parsedResult[0], parsedResult[1]));
      resetExpectedTextLabel.setText("PLEASE RESET THE APP BEFORE MAKING FURTHER CHANGES\nNEW DEVICE REGISTERED : FRONT RIGHT STROBOSCOPE ("+parsedResult[0]+" | "+parsedResult[1]+")");
    }
    else {
      DMXList_FrontRightStroboscopes.add(new DMX_Stroboscope(parsedResult[0], parsedResult[1], parsedResult[2], parsedResult[3]));
      resetExpectedTextLabel.setText("PLEASE RESET THE APP BEFORE MAKING FURTHER CHANGES\nNEW DEVICE REGISTERED : FRONT RIGHT STROBOSCOPE ("+parsedResult[0]+" | "+parsedResult[1]+" | "+parsedResult[2]+" | "+parsedResult[3]+")");
    }
    
    resetExpectedTextLabel.setVisible(true);
    createConfigFile();
  }
  void gui_parseMessageBoxBackStrobe(String result) {
    int[] parsedResult = gui_parseStringGenericDMX(result, 4);
    if (parsedResult[2] < 0) {
      DMXList_BackStroboscopes.add(new DMX_Stroboscope(parsedResult[0], parsedResult[1]));
      resetExpectedTextLabel.setText("PLEASE RESET THE APP BEFORE MAKING FURTHER CHANGES\nNEW DEVICE REGISTERED : BACK STROBOSCOPE ("+parsedResult[0]+" | "+parsedResult[1]+")");
    }
    else {
      DMXList_BackStroboscopes.add(new DMX_Stroboscope(parsedResult[0], parsedResult[1], parsedResult[2], parsedResult[3]));
      resetExpectedTextLabel.setText("PLEASE RESET THE APP BEFORE MAKING FURTHER CHANGES\nNEW DEVICE REGISTERED : BACK STROBOSCOPE ("+parsedResult[0]+" | "+parsedResult[1]+" | "+parsedResult[2]+" | "+parsedResult[3]+")");
    }
    resetExpectedTextLabel.setVisible(true);
    createConfigFile();
  }
  void gui_parseMessageBoxLEDTube(String result) {
    int parsedResult = -1;
    try {
      parsedResult = Integer.parseInt(result);
    }
    catch (Exception e) {
      outputLog.println("Caught an exception while trying to parse the following string : " + result + " (in order to create a new LED Tube device) : " + e);
    }
    if (parsedResult >= 0) {
      CustomDeviceList_LEDTubes.add(new CustomDevice_LEDTube(parsedResult));
      resetExpectedTextLabel.setText("PLEASE RESET THE APP BEFORE MAKING FURTHER CHANGES\nNEW DEVICE REGISTERED : LED TUBE (ID "+parsedResult+")");
    }    
    resetExpectedTextLabel.setVisible(true);
    createConfigFile();
  }
  void gui_parseMessageBoxRackLight(String result) {
    int parsedResult = -1;
    try {
      parsedResult = Integer.parseInt(result);
    }
    catch (Exception e) {
      outputLog.println("Caught an exception while trying to parse the following string : " + result + " (in order to create a new Rack Light device) : " + e);
    }
    if (parsedResult >= 0) {
      CustomDeviceList_RackLights.add(new CustomDevice_RackLight(parsedResult));
      resetExpectedTextLabel.setText("PLEASE RESET THE APP BEFORE MAKING FURTHER CHANGES\nNEW DEVICE REGISTERED : RACK LIGHT (ID "+parsedResult+")");
    }    
    resetExpectedTextLabel.setVisible(true);
    createConfigFile();
  }
  
  //Parse strings like "(2,3,5)", to return {2,3,5}
  int[] gui_parseStringGenericDMX(String string, int numberOfChannels) {
    
    int[] result = new int[numberOfChannels];
    for (int i=0; i<numberOfChannels; i++) {result[i] = -1;}
    
    try {
      boolean rejectLine = false;
      if (string.indexOf("(") != 0) {
        rejectLine = true;
        outputLog.println("Bad string formatting for new DMX device declaration : " + string);
      }
      if (string.indexOf(")") != string.length() - 1) {
        rejectLine = true;
        outputLog.println("Bad string formatting for new DMX device declaration : " + string);
      }
      
      String[] subStringSplit = split(string.substring(1, string.length() - 1), ",");
      
      if (subStringSplit.length != numberOfChannels) {
        rejectLine = true;
        outputLog.println("Bad string formatting for new DMX device declaration : " + string);
      }
      if (rejectLine == false) {
        for (int i=0; i<numberOfChannels; i++) {
          result[i] = Integer.parseInt(subStringSplit[i]);
        }
      }
      return result;
    }
    catch (Exception e) {
      outputLog.println("Caught an exception while trying to parse the following string : " + string + " (in order to create a new DMX device) : " + e);
      return result;
    }
  }


    

  void controlEvent(ControlEvent theEvent) {
    if (gui_initComplete) {

      if (theEvent.getName() == "Activate Simulator") {
        gui_activateSimulator = !gui_activateSimulator;
      }
      else if (theEvent.getName() == "Auto Mode") {
        AUTOMATIC_MODE = setAutomaticModeToggle.getState();
      }
      else if (theEvent.getName() == "Activate audio monitoring") {
        gui_activateAudioMonitoring = setAudioMonitoringToggle.getState();
        inactiveAudioMonitoringTextLabel.setVisible(!(setAudioMonitoringToggle.getState()));
        audioMonitoringKickTextLabel.setVisible((setAudioMonitoringToggle.getState()));
        audioMonitoringSnareTextLabel.setVisible((setAudioMonitoringToggle.getState()));
        audioMonitoringCymbalsTextLabel.setVisible((setAudioMonitoringToggle.getState()));
        audioMonitoringBassTextLabel.setVisible((setAudioMonitoringToggle.getState()));
        audioMonitoringKeysTextLabel.setVisible((setAudioMonitoringToggle.getState()));
        audioMonitoringGuitarTextLabel.setVisible((setAudioMonitoringToggle.getState()));
        
      }
      else if (theEvent.getName() == "Change Panel Mapping") {
        gui_changePanelMappingActive = changeLEDPanelMappingToggle.getState();
        if (gui_changePanelMappingActive) { gui_activateMappingBangs(); initLEDPanelMappingArray(); resetLEDPanelMapping();} 
                                     else { gui_disableMappingBangs();  }
      }
      else if (theEvent.getName().contains("Mapping Config Bang - Panel")) {
        if (gui_changePanelMappingActive) {
          registerBangForLEDPanelMapping(Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length())));
        }
      }
      else if (theEvent.getName() == "Number Of Panels") {
        NUMBER_OF_PANELS = Integer.parseInt(cp5.getController("Number Of Panels").getStringValue());
        resetExpectedTextLabel.setVisible(true);
        createConfigFile();
        //Prevent any further frame sending
        debug_without_panels = true;
      }
      else if (theEvent.getName().contains("LED Panel Microcontroller ")) {
        int devNumber = Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length()));
        devicesToParse[devNumber] = "/dev/" + cp5.getController(theEvent.getName()).getStringValue();
        resetExpectedTextLabel.setVisible(true);
        createConfigFile();
      }
      else if (theEvent.getName() == "DMX Microcontroller") {
        DMX_MICROCONTROLLER_NAME = "/dev/" + cp5.getController("DMX Microcontroller").getStringValue();
        resetExpectedTextLabel.setVisible(true);
        createConfigFile();
      }
      else if (theEvent.getName() == "Custom Devices Microcontroller") {
        CUSTOMDEVICES_MICROCONTROLLER_NAME = "/dev/" + cp5.getController("Custom Devices Microcontroller").getStringValue();
        resetExpectedTextLabel.setVisible(true);
        createConfigFile();
      }
      
      ////////////////////
      // DMX events
      
      else if (theEvent.getName() == "Add Front Left Strobe") {
        String [] explanation = {"Input new DMX device's channel info using the following syntax : ",
                                 "            For a 2-channel strobe : (Speed, Brightness)",
                                 "            For a 4-channel strobe : (Intensity, Duration, Speed, Special FX)",
                                 "For example, for a 2-channel stroboscope working on channels 4 and 5, input: (4,5)"};
        createMessageBox("FrontLeftStrobe", explanation);
        //The Reset flag is raised in case of successful parsing
      }
      else if (theEvent.getName() == "Add Front Right Strobe") {
        String [] explanation = {"Input new DMX device's channel info using the following syntax : ",
                                 "            For a 2-channel strobe : (Speed, Brightness)",
                                 "            For a 4-channel strobe : (Intensity, Duration, Speed, Special FX)",
                                 "For example, for a 2-channel stroboscope working on channels 4 and 5, input: (4,5)"};
        createMessageBox("FrontRightStrobe", explanation);
        //The Reset flag is raised in case of successful parsing
      }
      else if (theEvent.getName() == "Add Back Strobe") {
        String [] explanation = {"Input new DMX device's channel info using the following syntax : ",
                                 "            For a 2-channel strobe : (Speed, Brightness)",
                                 "            For a 4-channel strobe : (Intensity, Duration, Speed, Special FX)",
                                 "For example, for a 2-channel stroboscope working on channels 4 and 5, input: (4,5)"};
        createMessageBox("BackStrobe", explanation);
        //The Reset flag is raised in case of successful parsing
      }
      
      else if (theEvent.getName().contains("Front Left Strobe ")) {
        int devNumber = Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length()));
        //Check if the user wants to delete the device

        if (cp5.getController(theEvent.getName()).getStringValue().equals("(0,0,0,0)") ||
            cp5.getController(theEvent.getName()).getStringValue().equals("(0,0)")) {
          DMXList_FrontLeftStroboscopes.remove(DMXList_FrontLeftStroboscopes.get(devNumber));
          outputLog.println("IMPORTANT : Removed front left stroboscope device #" + devNumber);
          resetExpectedTextLabel.setVisible(true);
          createConfigFile();
          
          //Rebuild the GUI !
          createGeneralInfoAccordion();
        }
        //The user only wants to change the DMX settings
        else {
          int[] parseResult = gui_parseStringGenericDMX(cp5.getController(theEvent.getName()).getStringValue(), 3);

          //Check if the values returned are coherent - ie do not contain any negative values
          int voidOccurence = 0;
          int posOccurence  = 0;
          for (int i: parseResult) {
            if (i < 0) {voidOccurence += 1;}
                  else {posOccurence  += 1;}
          }
          if (voidOccurence == 0) {
            if (posOccurence == 2) {
              DMXList_FrontLeftStroboscopes.get(devNumber).DMXAddress_stroboscopeSpeed        = parseResult[0];
              DMXList_FrontLeftStroboscopes.get(devNumber).DMXAddress_stroboscopeBrightness   = parseResult[1];

              outputLog.println("IMPORTANT : Modified front left stroboscope device #" + devNumber + " with the values : " + parseResult[0] + "," + parseResult[1] + "," + parseResult[2]);
              resetExpectedTextLabel.setVisible(true);
              createConfigFile();
              
              //Rebuild the GUI !
              createGeneralInfoAccordion();
            }
            else if (posOccurence == 4) {
              DMXList_FrontLeftStroboscopes.get(devNumber).DMXAddress_stroboscopeBrightness   = parseResult[0];
              DMXList_FrontLeftStroboscopes.get(devNumber).DMXAddress_stroboscopeFlashLength  = parseResult[1];
              DMXList_FrontLeftStroboscopes.get(devNumber).DMXAddress_stroboscopeSpeed        = parseResult[2];
              DMXList_FrontLeftStroboscopes.get(devNumber).DMXAddress_stroboscopeSpecialFX    = parseResult[3];
              outputLog.println("IMPORTANT : Modified front left stroboscope device #" + devNumber + " with the values : " + parseResult[0] + "," + parseResult[1] + "," + parseResult[2] + "," + parseResult[3]);
              resetExpectedTextLabel.setVisible(true);
              createConfigFile();
              
              //Rebuild the GUI !
              createGeneralInfoAccordion();
            }
            else {
              outputLog.println("ERROR : Could not parse a modification for a left stroboscope");
            }
          }
        }
      }
      else if (theEvent.getName().contains("Front Right Strobe ")) {
        int devNumber = Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length()));
        //Check if the user wants to delete the device

        if (cp5.getController(theEvent.getName()).getStringValue().equals("(0,0,0,0)") ||
            cp5.getController(theEvent.getName()).getStringValue().equals("(0,0)")) {
          DMXList_FrontRightStroboscopes.remove(DMXList_FrontRightStroboscopes.get(devNumber));
          outputLog.println("IMPORTANT : Removed front right stroboscope device #" + devNumber);
          resetExpectedTextLabel.setVisible(true);
          createConfigFile();
          
          //Rebuild the GUI !
          createGeneralInfoAccordion();
        }
        //The user only wants to change the DMX settings
        else {
          int[] parseResult = gui_parseStringGenericDMX(cp5.getController(theEvent.getName()).getStringValue(), 3);

          //Check if the values returned are coherent - ie do not contain more than once "-1"
          int voidOccurence = 0;
          for (int i: parseResult) {
            if (i == -1) {voidOccurence += 1;}
          }
          if (voidOccurence <= 1) {
            DMXList_FrontRightStroboscopes.get(devNumber).DMXAddress_stroboscopeSpeed        = parseResult[0];
            DMXList_FrontRightStroboscopes.get(devNumber).DMXAddress_stroboscopeBrightness   = parseResult[1];
            DMXList_FrontRightStroboscopes.get(devNumber).DMXAddress_stroboscopeFlashLength  = parseResult[2];
            outputLog.println("IMPORTANT : Modified front left stroboscope device #" + devNumber + " with the values : " + parseResult[0] + "," + parseResult[1] + "," + parseResult[2]);
            resetExpectedTextLabel.setVisible(true);
            createConfigFile();
            
            //Rebuild the GUI !
            createGeneralInfoAccordion();
          }
        }
      }
      else if (theEvent.getName().contains("Back Strobe ")) {
        int devNumber = Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length()));
        //Check if the user wants to delete the device

        if (cp5.getController(theEvent.getName()).getStringValue().equals("(0,0,0,0)") ||
            cp5.getController(theEvent.getName()).getStringValue().equals("(0,0)")) {
          DMXList_BackStroboscopes.remove(DMXList_BackStroboscopes.get(devNumber));
          outputLog.println("IMPORTANT : Removed back stroboscope device #" + devNumber);
          resetExpectedTextLabel.setVisible(true);
          createConfigFile();
          
          //Rebuild the GUI !
          createGeneralInfoAccordion();
        }
        //The user only wants to change the DMX settings
        else {
          int[] parseResult = gui_parseStringGenericDMX(cp5.getController(theEvent.getName()).getStringValue(), 3);

          //Check if the values returned are coherent - ie do not contain more than once "-1"
          int voidOccurence = 0;
          for (int i: parseResult) {
            if (i == -1) {voidOccurence += 1;}
          }
          if (voidOccurence <= 1) {
            DMXList_BackStroboscopes.get(devNumber).DMXAddress_stroboscopeSpeed        = parseResult[0];
            DMXList_BackStroboscopes.get(devNumber).DMXAddress_stroboscopeBrightness   = parseResult[1];
            DMXList_BackStroboscopes.get(devNumber).DMXAddress_stroboscopeFlashLength  = parseResult[2];
            outputLog.println("IMPORTANT : Modified back stroboscope device #" + devNumber + " with the values : " + parseResult[0] + "," + parseResult[1] + "," + parseResult[2]);
            resetExpectedTextLabel.setVisible(true);
            createConfigFile();
            
            //Rebuild the GUI !
            createGeneralInfoAccordion();
          }
        }
      }
      
      
      /////////////////////////
      // Custom devices
      
      else if (theEvent.getName() == "Add LED Tube") {
        String [] explanation = {"Input new LED Tube's ID info using the following syntax : ID",
                                 "For example, for a led tube defined with an ID equal to 3, input: 3"};
        createMessageBox("LEDTube", explanation);
        //The Reset flag is raised in case of successful parsing
      }
      else if (theEvent.getName() == "Add Rack Light") {
        String [] explanation = {"Input new Rack Light's ID info using the following syntax : ID",
                                 "For example, for a rack light defined with an ID equal to 3, input: 3"};
        createMessageBox("RackLight", explanation);
        //The Reset flag is raised in case of successful parsing
      }
      else if (theEvent.getName().contains("LED Tube ")) {
        int devNumber = Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length()));
        //Check if the user wants to delete the device
        int parsedResult = -1;
        try {
          parsedResult = Integer.parseInt(cp5.getController(theEvent.getName()).getStringValue());
        }
        catch (Exception e) {
          outputLog.println("Caught an exception while trying to parse the following string : " + cp5.getController(theEvent.getName()).getStringValue() + " (in order to parse a LED Tube device modification) : " + e);
        }
        //Valid modification
        if (parsedResult >= 0) {
          CustomDeviceList_LEDTubes.get(devNumber).CustomDevice_deviceNumber  = parsedResult;
          outputLog.println("IMPORTANT : Modified LED Tube device #" + devNumber + " with the value : " + parsedResult);
          resetExpectedTextLabel.setVisible(true);
          createConfigFile();
        }
        //Delete the device
        else {
          CustomDeviceList_LEDTubes.remove(CustomDeviceList_LEDTubes.get(devNumber));
          outputLog.println("IMPORTANT : Removed LED tube device #" + devNumber);
          resetExpectedTextLabel.setVisible(true);
          createConfigFile();
          
          //Rebuild the GUI !
          createGeneralInfoAccordion();
        }
      }
      else if (theEvent.getName().contains("Rack Light ")) {
        int devNumber = Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length()));
        //Check if the user wants to delete the device
        int parsedResult = -1;
        try {
          parsedResult = Integer.parseInt(cp5.getController(theEvent.getName()).getStringValue());
        }
        catch (Exception e) {
          outputLog.println("Caught an exception while trying to parse the following string : " + cp5.getController(theEvent.getName()).getStringValue() + " (in order to parse a Rack Light device modification) : " + e);
        }
        //Valid modification
        if (parsedResult >= 0) {
          CustomDeviceList_RackLights.get(devNumber).CustomDevice_deviceNumber  = parsedResult;
          outputLog.println("IMPORTANT : Modified Rack Light device #" + devNumber + " with the value : " + parsedResult);
          resetExpectedTextLabel.setVisible(true);
          createConfigFile();
        }
        //Delete the device
        else {
          CustomDeviceList_RackLights.remove(CustomDeviceList_RackLights.get(devNumber));
          outputLog.println("IMPORTANT : Removed Rack Light device #" + devNumber);
          resetExpectedTextLabel.setVisible(true);
          createConfigFile();
          
          //Rebuild the GUI !
          createGeneralInfoAccordion();
        }
      }
      
      /////////////////////////
      // MIDI Configuration
      
      else if (theEvent.getName() == "Main Input") {
        MIDI_BUS_MAIN_INPUT = cp5.getController("Main Input").getStringValue();
        resetExpectedTextLabel.setVisible(true);
        createConfigFile();
      }
      else if (theEvent.getName() == "Keyboard") {
        MIDI_BUS_KEYBOARD_INPUT = cp5.getController("Keyboard").getStringValue();
        resetExpectedTextLabel.setVisible(true);
        createConfigFile();
      }
      else if (theEvent.getName() == "General FX Controller") {
        MIDI_BUS_CONTROLLER_INPUT = cp5.getController("DMX Microcontroller").getStringValue();
        resetExpectedTextLabel.setVisible(true);
        createConfigFile();
      }
      
      
      /////////////////////////
      // Audio input configuration
      
      else if (theEvent.getName() == "Kick - Audio Signal ID") {
        SIGNAL_ID_KICK = Integer.parseInt(cp5.getController(theEvent.getName()).getStringValue());
        createConfigFile();
      }
      else if (theEvent.getName() == "Snare - Audio Signal ID") {
        SIGNAL_ID_SNARE = Integer.parseInt(cp5.getController(theEvent.getName()).getStringValue());
        createConfigFile();
      }
      else if (theEvent.getName() == "Cymbals - Audio Signal ID") {
        SIGNAL_ID_CYMBALS = Integer.parseInt(cp5.getController(theEvent.getName()).getStringValue());
        createConfigFile();
      }
      else if (theEvent.getName() == "Bass - Audio Signal ID") {
        SIGNAL_ID_BASS = Integer.parseInt(cp5.getController(theEvent.getName()).getStringValue());
        createConfigFile();
      }
      else if (theEvent.getName() == "Keys - Audio Signal ID") {
        SIGNAL_ID_KEYS = Integer.parseInt(cp5.getController(theEvent.getName()).getStringValue());
        createConfigFile();
      }
      else if (theEvent.getName() == "Guitar - Audio Signal ID") {
        SIGNAL_ID_GUITAR = Integer.parseInt(cp5.getController(theEvent.getName()).getStringValue());
        createConfigFile();
      }
      else if (theEvent.getName() == "Bass Hi-Lo Ratio Threshold") {
        HI_LO_RATIO_THRESHOLD = Float.parseFloat(cp5.getController(theEvent.getName()).getStringValue());
        createConfigFile();
      }
      
      
      
      
      /////////////////////////
      // Device test : using the corresponding buttons, light up the devices to check proper connection
      // For DMX devices, it's normal the simulator won't light up
      
      else if (theEvent.getName().contains("Test FrontLeftStroboscope ")) {
        int devNumber = Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length()));
        float toggleValue =  cp5.getController(theEvent.getName()).getValue();
        if (toggleValue == 1.0) {
          //Start the corresponding stroboscope, full power
          DMXList_FrontLeftStroboscopes.get(devNumber).startDMX(100);
        }
        else {
          //Stop it once we're done
          DMXList_FrontLeftStroboscopes.get(devNumber).stopDMX();
        }
      }
      else if (theEvent.getName().contains("Test FrontRightStroboscope ")) {
        int devNumber = Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length()));
        float toggleValue =  cp5.getController(theEvent.getName()).getValue();
        if (toggleValue == 1.0) {
          //Start the corresponding stroboscope, full power
          DMXList_FrontRightStroboscopes.get(devNumber).startDMX(100);
        }
        else {
          //Stop it once we're done
          DMXList_FrontRightStroboscopes.get(devNumber).stopDMX();
        }
      }
      else if (theEvent.getName().contains("Test BackStroboscope ")) {
        int devNumber = Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length()));
        float toggleValue =  cp5.getController(theEvent.getName()).getValue();
        if (toggleValue == 1.0) {
          //Start the corresponding stroboscope, full power
          DMXList_BackStroboscopes.get(devNumber).startDMX(100);
        }
        else {
          //Stop it once we're done
          DMXList_BackStroboscopes.get(devNumber).stopDMX();
        }
      }
      else if (theEvent.getName().contains("Test LEDTube ")) {
        int devNumber = Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length()));
        float toggleValue =  cp5.getController(theEvent.getName()).getValue();
        if (toggleValue == 1.0) {
          //Light up the corresponding LED Tube
          CustomDeviceList_LEDTubes.get(devNumber).setDeviceAnimation(CUSTOMDEV_ANIM_WHITEOUT);
        }
        else {
          //Stop it once we're done
          CustomDeviceList_LEDTubes.get(devNumber).setDeviceAnimation(CUSTOMDEV_ANIM_BLACKOUT);
        }
      }
      else if (theEvent.getName().contains("Test RackLight ")) {
        int devNumber = Integer.parseInt(theEvent.getName().substring(theEvent.getName().length() - 1, theEvent.getName().length()));
        float toggleValue =  cp5.getController(theEvent.getName()).getValue();
        if (toggleValue == 1.0) {
          //Light up the corresponding Rack light
          CustomDeviceList_RackLights.get(devNumber).setDeviceAnimation(CUSTOMDEV_ANIM_WHITEOUT);
        }
        else {
          //Stop it once we're done
          CustomDeviceList_RackLights.get(devNumber).setDeviceAnimation(CUSTOMDEV_ANIM_BLACKOUT);
        }
      }
       
      
      /////////////////////////
      // Animation control
      
      else if (theEvent.getName() == "Reinit LED Panel list") {
        LEDPanelAnimations_animationListCheckBox.deactivateAll();
      }
      else if (theEvent.getName() == "Reinit CustomDevice list") {
        CustomDeviceAnimations_animationListCheckBox.deactivateAll();
      }
      else if (theEvent.getName() == "Reinit DMX list") {
        DMXAnimations_animationListCheckBox.deactivateAll();
      }
      else if (theEvent.getName() == "Attributes - LED Panel animations") {
        rebuildFilteredLEDPanelAnimationList(LEDPanelAnimations_animationListCheckBox.getArrayValue());        
      }
      else if (theEvent.getName() == "Attributes - Custom Device animations") {
        rebuildFilteredCustomDeviceAnimationList(CustomDeviceAnimations_animationListCheckBox.getArrayValue());        
      }
      else if (theEvent.getName() == "Attributes - DMX animations") {
        rebuildFilteredDMXAnimationList(DMXAnimations_animationListCheckBox.getArrayValue());        
      }
      //With listBoxes, it is necessary to also check if theEvent.isGroup()
      else if (theEvent.getName() == "Filtered LED Panel Animation List" && theEvent.isGroup()) {
        int selectedVal = int(LEDPanelAnimations_animationListBox.getValue());
        String selectedItem =  LEDPanelAnimations_animationListBox.getListBoxItems()[selectedVal][0];
        String[] selectedItemSplit = split(selectedItem, ":");
        int animNbr = Integer.parseInt(selectedItemSplit[0]);
        
        
        //Update the description
        String textDescription = "Current animation description \n"
                                      + animationAttributes.get(animNbr).name + "\n"
                                      + "\n"
                                      + "Animation number : " + animationAttributes.get(animNbr).animationNbr + "\n"
                                      + "Corresponding note/velocity : " + getStringFromAnimationNumber(animationAttributes.get(animNbr).animationNbr) + "\n"
                                      + "Attributes:\n"
                                      + animationAttributes.get(animNbr).attributes;
        LEDPanelAnimations_currentAnimationDescription.setText(textDescription);
        
        gui_loadLEDPanelAnimation(animNbr);
      }
      else if (theEvent.getName() == "Filtered Custom Device Animation List") {
        int selectedVal = int(CustomDeviceAnimations_animationListBox.getValue());
        String selectedItem =  CustomDeviceAnimations_animationListBox.getListBoxItems()[selectedVal][0];
        String[] selectedItemSplit = split(selectedItem, ":");
        int animNbr = Integer.parseInt(selectedItemSplit[0]);
        
        
        //Update the description
        //Note : get animNbr - 1, because unlike for the LED Panel animations, there is no 0
        String textDescription = "Current animation description \n"
                                      + customDevicesAttributes.get(animNbr - 1).name + "\n"
                                      + "\n"
                                      + "Animation number : " + customDevicesAttributes.get(animNbr - 1).animationNbr + "\n"
                                      + "Corresponding note/velocity : " + getStringFromCustomDeviceAnimationNumber(customDevicesAttributes.get(animNbr - 1).animationNbr) + "\n"
                                      + "Attributes:\n"
                                      + customDevicesAttributes.get(animNbr - 1).attributes;
        CustomDeviceAnimations_currentAnimationDescription.setText(textDescription);
        
        //Load the animation
        customDeviceAnimation(animNbr);

      }
      else if (theEvent.getName() == "Filtered DMX Animation List") {
        int selectedVal = int(DMXAnimations_animationListBox.getValue());
        String selectedItem =  DMXAnimations_animationListBox.getListBoxItems()[selectedVal][0];
        String[] selectedItemSplit = split(selectedItem, ":");
        int animNbr = Integer.parseInt(selectedItemSplit[0]);
        
        
        //Update the description
        //Note : get animNbr - 1, because unlike for the LED Panel animations, there is no 0
        String textDescription = "Current animation description \n"
                                      + DMXAttributes.get(animNbr - 1).name + "\n"
                                      + "\n"
                                      + "Animation number : " + DMXAttributes.get(animNbr - 1).animationNbr + "\n"
                                      + "Corresponding note/velocity : " + getStringFromDMXAnimationNumber(DMXAttributes.get(animNbr - 1).animationNbr) + "\n"
                                      + "Attributes:\n"
                                      + DMXAttributes.get(animNbr - 1).attributes;
        DMXAnimations_currentAnimationDescription.setText(textDescription);
        
        //Load the animation
        gui_loadDMXAnimation(animNbr);

      }
      else if (theEvent.getName().contains("Effect Bang")) {
        String[] eventNameSplit = split(theEvent.getName(), " ");
        int effectNumber = int(eventNameSplit[3]);
        activateAdditionalEffect(effectNumber);
      }
    }
  }
  
  //////////////////////////////////////////
  // Create a small interface to monitor the incoming audio
  
  void createAudioMonitoringGroup() {
        
    Group AudioMonitoringGroup = cp5.addGroup("Audio monitoring")
                                    .setPosition(gui_audioMonitoringGroupOffsetX,22*height/30 )
                                    .setWidth(gui_audioMonitoringGroupWidth)
                                    .activateEvent(true)
                                    .disableCollapse() 
                                    .setBackgroundColor(color(255,40))
                                    .setBackgroundHeight(height/4-20)
                                    .setLabel("Audio monitoring")
                                    ;
    
    setAudioMonitoringToggle = cp5.addToggle("Activate audio monitoring")
                                  .setValue(0)
                                  .setCaptionLabel("Activate Audio Monitoring")
                                  .setPosition(gui_spacing, gui_spacing)
                                  .setSize(gui_audioMonitoringToggleWidth, gui_audioMonitoringToggleHeight)
                                  .setColorBackground(color(100,0,0))
                                  .setColorForeground(color(130,0,0))
                                  .setColorActive(color(160,0,0))
                                  .setGroup(AudioMonitoringGroup)
                                  ;
    setAudioMonitoringToggle.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
    
    //Label which gets hidden when audio monitoring is activated
    inactiveAudioMonitoringTextLabel = cp5.addTextlabel("Inactive Audio Monitoring")
                                          .setText("AUDIO MONITORING IS CURRENTLY INACTIVE\nACTIVATE ONLY IF YOU NEED TO CHECK CORRECT INPUT \nROUTING THROUGH THE GUI AS ALL INCOMING AUDIO DATA \nWILL BE PROCESSED, REGARDLESS THIS TOGGLE")
                                          .setPosition(gui_spacing, gui_spacing*5)
                                          .setColorValue(color(255))
                                          .moveTo(AudioMonitoringGroup)
                                          ;
    inactiveAudioMonitoringTextLabel.setVisible(true);
    
    //Labels which gets hidden when audio monitoring is deactivated
    audioMonitoringKickTextLabel = cp5.addTextlabel("Audio Monitoring - Kick")
                                      .setText("KICK")
                                      .setPosition(2*gui_spacing + audioMonitoring_barWidth, 4*gui_spacing + 0*(10 + audioMonitoring_barHeight))
                                      .setColorValue(color(255))
                                      .moveTo(AudioMonitoringGroup)
                                      ;
    audioMonitoringSnareTextLabel = cp5.addTextlabel("Audio Monitoring - Snare")
                                      .setText("SNARE")
                                      .setPosition(2*gui_spacing + audioMonitoring_barWidth, 4*gui_spacing + 1*(10 + audioMonitoring_barHeight))
                                      .setColorValue(color(255))
                                      .moveTo(AudioMonitoringGroup)
                                      ;
    audioMonitoringCymbalsTextLabel = cp5.addTextlabel("Audio Monitoring - Cymbals")
                                      .setText("CYMBALS")
                                      .setPosition(2*gui_spacing + audioMonitoring_barWidth, 4*gui_spacing + 2*(10 + audioMonitoring_barHeight))
                                      .setColorValue(color(255))
                                      .moveTo(AudioMonitoringGroup)
                                      ;
    audioMonitoringBassTextLabel = cp5.addTextlabel("Audio Monitoring - Bass")
                                      .setText("BASS")
                                      .setPosition(2*gui_spacing + audioMonitoring_barWidth, 4*gui_spacing + 3*(10 + audioMonitoring_barHeight))
                                      .setColorValue(color(255))
                                      .moveTo(AudioMonitoringGroup)
                                      ;
    audioMonitoringKeysTextLabel = cp5.addTextlabel("Audio Monitoring - Keys")
                                      .setText("KEYS")
                                      .setPosition(2*gui_spacing + audioMonitoring_barWidth, 4*gui_spacing + 4*(10 + audioMonitoring_barHeight))
                                      .setColorValue(color(255))
                                      .moveTo(AudioMonitoringGroup)
                                      ;
    audioMonitoringGuitarTextLabel = cp5.addTextlabel("Audio Monitoring - Guitar")
                                      .setText("GUITAR")
                                      .setPosition(2*gui_spacing + audioMonitoring_barWidth, 4*gui_spacing + 5*(10 + audioMonitoring_barHeight))
                                      .setColorValue(color(255))
                                      .moveTo(AudioMonitoringGroup)
                                      ;
    audioMonitoringKickTextLabel.setVisible(false);
    audioMonitoringSnareTextLabel.setVisible(false);
    audioMonitoringCymbalsTextLabel.setVisible(false);
    audioMonitoringBassTextLabel.setVisible(false);
    audioMonitoringKeysTextLabel.setVisible(false);
    audioMonitoringGuitarTextLabel.setVisible(false);
    
  }
  
  // Draw the actual audio info
  void draw_audioMonitoring(int offsetX, int offsetY, int spacing) {
    draw_singleAudioBar(offsetX, offsetY + 0*(spacing + audioMonitoring_barHeight), automaticSequencer.globalIntensity_Kick,    audioMonitoring_maxSignalLevel_Kick);
    draw_singleAudioBar(offsetX, offsetY + 1*(spacing + audioMonitoring_barHeight), automaticSequencer.globalIntensity_Snare,   audioMonitoring_maxSignalLevel_Snare);
    draw_singleAudioBar(offsetX, offsetY + 2*(spacing + audioMonitoring_barHeight), automaticSequencer.globalIntensity_Cymbals, audioMonitoring_maxSignalLevel_Cymbals);
    draw_singleAudioBar(offsetX, offsetY + 3*(spacing + audioMonitoring_barHeight), automaticSequencer.globalIntensity_Bass,    audioMonitoring_maxSignalLevel_Bass);
    draw_singleAudioBar(offsetX, offsetY + 4*(spacing + audioMonitoring_barHeight), automaticSequencer.globalIntensity_Keys,    audioMonitoring_maxSignalLevel_Keys);
    draw_singleAudioBar(offsetX, offsetY + 5*(spacing + audioMonitoring_barHeight), automaticSequencer.globalIntensity_Guitar,  audioMonitoring_maxSignalLevel_Guitar);
    
    draw_timeInfoText();
    draw_autoModeInfo();
  }

  void draw_singleAudioBar(int x, int y, float val, float maxVal) {
    noStroke();
    fill(80);
    rect(x, y, audioMonitoring_barWidth, audioMonitoring_barHeight);
    fill(160);
    rect(x, y, map(constrain(val,0,maxVal),0,maxVal, 0, audioMonitoring_barWidth), audioMonitoring_barHeight);
  }  
  
  void draw_timeInfoText() {
    textFont(minimlFont, 8);
    textAlign(LEFT, TOP);
    fill(255);
    text(formatTimeInfoPositionText(), gui_audioMonitoringGroupOffsetX + 175,22*gui_height/30 + 4*gui_spacing + 0);
    text(formatTimeInfoBPMText(),      gui_audioMonitoringGroupOffsetX + 175,22*gui_height/30 + 4*gui_spacing + 13);
    text(formatTimeInfoPlayingText(),  gui_audioMonitoringGroupOffsetX + 175,22*gui_height/30 + 4*gui_spacing + 26);
    
  }
  
  String formatTimeInfoPositionText() {
    int bar    = (((int) automaticSequencer.currentPosition) / 4) + 1;
    int beat   = ((int) (automaticSequencer.currentPosition % 4.0)) + 1;
    int ticks  = ((int) ( (automaticSequencer.currentPosition % 1.0) * 960.0 + 0.5));
    return "POSITION: " + bar + "|" + beat + "|" + ticks;
  }
  
  String formatTimeInfoBPMText() {
    return "TEMPO: " + automaticSequencer.currentBPM + " BPM";
  }
  
  String formatTimeInfoPlayingText() {
    
    if (automaticSequencer.isPlaying) {
      return "PLAYBACK: ON";
    }
    else {
      return "PLAYBACK: OFF";
    }
  }
  
  void draw_autoModeInfo() {
    textFont(minimlFont, 8);
    textAlign(LEFT, TOP);
    fill(255);
    text(formatCurrentIntensityText(),  gui_audioMonitoringGroupOffsetX + 175,22*gui_height/30 + 4*gui_spacing + 39);
  }
  
  String formatCurrentIntensityText() {
    if (automaticSequencer.onlyGuitarIsPlaying) {
      return "INTENSITY: SOLO GUITAR";
    }
    else if (automaticSequencer.onlyFilteredBassIsPlaying) {
      return "INTENSITY: SOLO HPF BASS";
    }
    else if (automaticSequencer.currentIntensity == INTENSITY_DEFAULT) {
      return "INTENSITY: DEFAULT";
    }
    else if (automaticSequencer.currentIntensity == INTENSITY_LOW) {
      return "INTENSITY: LOW";
    }
    else if (automaticSequencer.currentIntensity == INTENSITY_MEDIUM) {
      return "INTENSITY: MEDIUM";
    }
    else if (automaticSequencer.currentIntensity == INTENSITY_HIGH) {
      return "INTENSITY: HIGH";
    }
    else if (automaticSequencer.currentIntensity == INTENSITY_MAX) {
      return "INTENSITY: MAX";
    }
    return "INTENSITY: ";
  }
}



String[] createLEDPanelAnimationListFilter(float[] checkBoxArrayvalue) {
  StringList temp = new StringList();
  for (int i = 0; i<checkBoxArrayvalue.length; i++) {
    if (checkBoxArrayvalue[i] == 1.0) {
      switch(i) {
        case GUI_ATTR_LEDPANEL_GEOMETRIC   : temp.append("Geometric"  );break;
        case GUI_ATTR_LEDPANEL_ATMOSPHERIC : temp.append("Atmospheric");break;
        case GUI_ATTR_LEDPANEL_FADE_IN_OUT : temp.append("Fade In/Out");break;
        case GUI_ATTR_LEDPANEL_RANDOM      : temp.append("Random"     );break;
        case GUI_ATTR_LEDPANEL_VERY_BRIGHT : temp.append("Very Bright");break;
        case GUI_ATTR_LEDPANEL_VERY_DARK   : temp.append("Very Dark"  );break;
        case GUI_ATTR_LEDPANEL_RED         : temp.append("Red"        );break;
        case GUI_ATTR_LEDPANEL_B_W         : temp.append("B&W"        );break;
        case GUI_ATTR_LEDPANEL_BLUE        : temp.append("Blue"       );break;
        case GUI_ATTR_LEDPANEL_COLORFUL    : temp.append("Colorful"   );break;
        case GUI_ATTR_LEDPANEL_ROTATING    : temp.append("Rotating"   );break;
        case GUI_ATTR_LEDPANEL_SIMPLE      : temp.append("Simple"     );break;
        case GUI_ATTR_LEDPANEL_COMPLEX     : temp.append("Complex"    );break;
        case GUI_ATTR_LEDPANEL_EVOLVING    : temp.append("Evolving"   );break;
        case GUI_ATTR_LEDPANEL_SMOOTH      : temp.append("Smooth"     );break;
        case GUI_ATTR_LEDPANEL_VIOLENT     : temp.append("Violent"    );break;
        case GUI_ATTR_LEDPANEL_RHYTHMIC    : temp.append("Rhythmic"   );break;
        case GUI_ATTR_LEDPANEL_FAST        : temp.append("Fast"       );break;
        case GUI_ATTR_LEDPANEL_SLOW        : temp.append("Slow"       );break;
        case GUI_ATTR_LEDPANEL_STILL       : temp.append("Still"      );break;
        case GUI_ATTR_LEDPANEL_LINES       : temp.append("Lines"      );break;
        case GUI_ATTR_LEDPANEL_CURVES      : temp.append("Curves"     );break;
        case GUI_ATTR_LEDPANEL_TRIANGLES   : temp.append("Triangles"  );break;
        case GUI_ATTR_LEDPANEL_SQUARES     : temp.append("Squares"    );break;
        case GUI_ATTR_LEDPANEL_CIRCLES     : temp.append("Circles"    );break;
        case GUI_ATTR_LEDPANEL_SPIRAL      : temp.append("Spiral"     );break;
        case GUI_ATTR_LEDPANEL_NOISE       : temp.append("Noise"      );break;
        case GUI_ATTR_LEDPANEL_OBJECTS     : temp.append("Objects"    );break;
        case GUI_ATTR_LEDPANEL_SPECIAL     : temp.append("Special"    );break;
        case GUI_ATTR_LEDPANEL_AUDIO       : temp.append("AudioInput" );break;
        case GUI_ATTR_LEDPANEL_GAME        : temp.append("Game"       );break;
        case GUI_ATTR_LEDPANEL_3D          : temp.append("3D"         );break;
        default: break;
      }
    }
  }
  
  String[] filter = new String[temp.size()];
  for (int i = 0; i<temp.size(); i++) {
    filter[i] = temp.get(i);
  }
  return filter;
}


String[] createCustomDeviceAnimationListFilter(float[] checkBoxArrayvalue) {
  StringList temp = new StringList();
  for (int i = 0; i<checkBoxArrayvalue.length; i++) {
    if (checkBoxArrayvalue[i] == 1.0) {
      switch(i) {
        case GUI_ATTR_CUSTOMDEV_ALLDEVICES    : temp.append("All Devices");break;
        case GUI_ATTR_CUSTOMDEV_RACKLIGHTS    : temp.append("Rack Lights");break;
        case GUI_ATTR_CUSTOMDEV_LEDTUBES      : temp.append("LED Tubes");break;
        case GUI_ATTR_CUSTOMDEV_BLACK         : temp.append("Black");break;
        case GUI_ATTR_CUSTOMDEV_WHITE         : temp.append("White");break;
        case GUI_ATTR_CUSTOMDEV_RED           : temp.append("Red");break;
        case GUI_ATTR_CUSTOMDEV_BLUE          : temp.append("Blue");break;
        case GUI_ATTR_CUSTOMDEV_RAINBOW       : temp.append("Rainbow");break;
        case GUI_ATTR_CUSTOMDEV_RANDOM        : temp.append("Random");break;
        case GUI_ATTR_CUSTOMDEV_FAST          : temp.append("Fast");break;
        case GUI_ATTR_CUSTOMDEV_MEDUM         : temp.append("Medium");break;
        case GUI_ATTR_CUSTOMDEV_SLOW          : temp.append("Slow");break;
        case GUI_ATTR_CUSTOMDEV_VERYSLOW      : temp.append("Very Slow");break;
        case GUI_ATTR_CUSTOMDEV_LONG          : temp.append("Long");break;
        case GUI_ATTR_CUSTOMDEV_SHORT         : temp.append("Short");break;
        case GUI_ATTR_CUSTOMDEV_PLAIN         : temp.append("Plain");break;
        case GUI_ATTR_CUSTOMDEV_FLASH         : temp.append("Flash");break;
        case GUI_ATTR_CUSTOMDEV_SMOOTHSINE    : temp.append("Smooth Sine");break;
        case GUI_ATTR_CUSTOMDEV_STROBOSCOPE   : temp.append("Stroboscope");break;
        case GUI_ATTR_CUSTOMDEV_GROWINGSTROBE : temp.append("Growing Strobe");break;
        case GUI_ATTR_CUSTOMDEV_WAVE          : temp.append("Wave");break;
        case GUI_ATTR_CUSTOMDEV_BUILDUP       : temp.append("BuildUp");break;
        case GUI_ATTR_CUSTOMDEV_NOISE         : temp.append("Noise");break;
        case GUI_ATTR_CUSTOMDEV_SMOOTHNOISE   : temp.append("Smooth Noise");break;
        default: break;
      }
    }
  }
  
  String[] filter = new String[temp.size()];
  for (int i = 0; i<temp.size(); i++) {
    filter[i] = temp.get(i);
  }
  return filter;
}

String[] createDMXAnimationListFilter(float[] checkBoxArrayvalue) {
  StringList temp = new StringList();
  for (int i = 0; i<checkBoxArrayvalue.length; i++) {
    if (checkBoxArrayvalue[i] == 1.0) {
      switch(i) {
        case GUI_ATTR_DMX_ALL       : temp.append("All");break;
        case GUI_ATTR_DMX_LEFT      : temp.append("Left");break;
        case GUI_ATTR_DMX_RIGHT     : temp.append("Right");break;
        case GUI_ATTR_DMX_CENTER    : temp.append("Center");break;
        case GUI_ATTR_DMX_RHYTHMIC  : temp.append("Rhythmic");break;
        case GUI_ATTR_DMX_STROBE    : temp.append("Strobe");break;
        case GUI_ATTR_DMX_PAR       : temp.append("PAR");break;
        case GUI_ATTR_DMX_VERYSLOW  : temp.append("Very Slow");break;
        case GUI_ATTR_DMX_SLOW      : temp.append("Slow");break;
        case GUI_ATTR_DMX_MEDIUM    : temp.append("Medium");break;
        case GUI_ATTR_DMX_FAST      : temp.append("Fast");break;
        case GUI_ATTR_DMX_VERYFAST  : temp.append("Very Fast");break;
        case GUI_ATTR_DMX_AUDIO     : temp.append("AudioInput");break;
        case GUI_ATTR_DMX_ATOMIC    : temp.append("Atomic");break;
        default: break;
      }
    }
  }
  
  String[] filter = new String[temp.size()];
  for (int i = 0; i<temp.size(); i++) {
    filter[i] = temp.get(i);
  }
  return filter;
}
