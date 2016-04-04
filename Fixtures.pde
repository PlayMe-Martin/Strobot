
//////////////////////////////////////////////////////////////
//   DMX Fixture library based on the available XML files   //
//////////////////////////////////////////////////////////////

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.*;
import java.io.IOException;
import org.xml.sax.SAXException;

final String XMLDESC_ROOTNAME                   = "Fixture";

final String XMLDESC_NAME                       = "Name";
final String XMLDESC_MANUFACTURER               = "Manufacturer";
final String XMLDESC_TYPE                       = "Type";
final String XMLDESC_COMMENT                    = "Comment";
final String XMLDESC_NBCHANNELS                 = "NbChannels";
final String XMLDESC_CHANNELTYPE                = "ChannelType";
final String XMLDESC_CHANNELTYPE_INDEX          = "index";
final String XMLDESC_CHANNELTYPE_ATTRIBUTE      = "attribute";
final String XMLDESC_CHANNELSET                 = "ChannelSet";
final String XMLDESC_CHANNELSET_NAME            = "name";
final String XMLDESC_CHANNELSET_FROM_DMX        = "from_dmx";
final String XMLDESC_CHANNELSET_TO_DMX          = "to_dmx";
final String XMLDESC_CHANNELSET_TO_PROPORTIONAL = "proportional";

ArrayList<Fixture> fixtureLibrary;

void readFixtureFiles() {
  
  fixtureLibrary = new ArrayList<Fixture>();
  
  //Parse all data folders, and create Fixture objects
  //String[] fixtureTypes   = { "Strobe", "Moving Head", "PAR", "Scanner", "Laser", "Blinder", "LED Strip", "Fog"};
  String[] fixtureTypes   = { "Strobe"};

    
  for (String directoryToParse: fixtureTypes) {
    try {
      String fullDirectoryPath = dataPath("") + "/Fixtures/" + directoryToParse;

      File dir = new File(fullDirectoryPath);
      String[] children = dir.list();
      
      for (String child : children) {
        // Only check for XML files, disregard OSX's Finder cookie
        if (child.contains(".xml")) {
          println(fullDirectoryPath + "/" + child);
          parseFixtureXML(fullDirectoryPath + "/" + child);
        }
      }
    }
    catch (Exception e) {
      outputLog.println("Exception while parsing fixture XMLs : " + e);
      println("Exception while parsing fixture XMLs : " + e);
    }
  }
}

void parseFixtureXML(String path) {
  
  final DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
          
  try {
    
    final DocumentBuilder builder = factory.newDocumentBuilder();
    Document document= builder.parse(new File(path));
    final Element root = document.getDocumentElement();
    String rootName = root.getNodeName();
    
    if (rootName.equals(XMLDESC_ROOTNAME)) {
    
      Fixture newFixture = new Fixture();
    
      final NodeList rootNodes = root.getChildNodes();
      final int nbRootNodes = rootNodes.getLength();
      
      for (int i = 0; i<nbRootNodes; i++) {
          if(rootNodes.item(i).getNodeType() == Node.ELEMENT_NODE) {
              final Element elem = (Element) rootNodes.item(i);

              if (elem.getNodeName().equals(XMLDESC_NAME)) {
                newFixture.setName(elem.getTextContent());
              }
              if (elem.getNodeName().equals(XMLDESC_MANUFACTURER)) {
                newFixture.setManufacturer(elem.getTextContent());
              }
              if (elem.getNodeName().equals(XMLDESC_TYPE)) {
                newFixture.setType(elem.getTextContent());
              }
              if (elem.getNodeName().equals(XMLDESC_NBCHANNELS)) {
                newFixture.setNbChannels(int(elem.getTextContent()));
              }
              if (elem.getNodeName().equals(XMLDESC_COMMENT)) {
                newFixture.setComment(elem.getTextContent());
              }
              if (elem.getNodeName().equals(XMLDESC_CHANNELTYPE)) {
                // Basic checks on the channel type declaration
                checkIfAttrDefinedInElement(elem, XMLDESC_CHANNELTYPE_INDEX,     "Bad Fixture XML description - channel type index is not defined");
                checkIfAttrDefinedInElement(elem, XMLDESC_CHANNELTYPE_ATTRIBUTE, "Bad Fixture XML description - channel type attribute is not defined");

                ChannelDesc newChannelDesc = new ChannelDesc( int(elem.getAttribute(XMLDESC_CHANNELTYPE_INDEX), elem.getAttribute(XMLDESC_CHANNELTYPE_ATTRIBUTE) );

                println("Device channelType index : " + int(elem.getAttribute(XMLDESC_CHANNELTYPE_INDEX)));
                println("Device channelType index : " + elem.getAttribute(XMLDESC_CHANNELTYPE_ATTRIBUTE));
                final NodeList channelTypeNodes = elem.getChildNodes();
                final int nbChannelTypeNodes = channelTypeNodes.getLength();
                println("Number of channel type nodes : " + nbChannelTypeNodes);
                
                for (int j = 0; j<nbChannelTypeNodes; j++) {
                  if(channelTypeNodes.item(j).getNodeType() == Node.ELEMENT_NODE) {
                    final Element subElem = (Element) channelTypeNodes.item(j);
                    if (subElem.getNodeName().equals(XMLDESC_CHANNELSET)) {
                      
                      println(subElem.getAttribute(XMLDESC_CHANNELSET_NAME) + " - " + subElem.getAttribute(XMLDESC_CHANNELSET_FROM_DMX) + " - " + subElem.getAttribute(XMLDESC_CHANNELSET_TO_DMX));
                    }
                  }
                }
                if (nbChannelTypeNodes > 1000) {
                  throw new FixtureDescriptionParseException("Bad Fixture XML description - channel type index is not defined");
                }
                

              }
              

          
          }
        }

        // Very last step : once the file has been parsed, if no exception has been raised up until now, the description is valid
        // Add the new fixture to the library
        fixtureLibrary.add(newFixture);
    }


    
  }
  catch (final FixtureDescriptionParseException e) {
      println("bloub");
      e.printStackTrace();
      println(e);
  }
  catch (final ParserConfigurationException e) {
      e.printStackTrace();
      println(e);
  }
  catch (final SAXException e) {
      e.printStackTrace();
      println(e);
  }
  catch (final IOException e) {
      e.printStackTrace();
      println(e);
  }        
}

void checkIfAttrDefinedInElement(Element elem, String attribute, String assertion) throws FixtureDescriptionParseException {
  if (elem.getAttribute(attribute) == "") {
    throw new FixtureDescriptionParseException(assertion);
  }
}


class Fixture {
  
  String Name;
  String Manufacturer;
  String Type;                          //Family of the fixture: Strobe, Moving Head, PAR, Scanner, Laser, Blinder, LED Strip or Fog Machine
  String Comment;
  int NbChannels;
  ArrayList<ChannelDesc> Channels;

  Fixture() {
    this.Name  = "";
    this.Manufacturer = "";
    this.Type = "";
    this.Comment = "";
    this.NbChannels = 0;
    this.Channels = new ArrayList<ChannelDesc>();
  }

  
  
  void setName(String name) {
    this.Name = name;
  }

  void setManufacturer(String manufacturer) {
    this.Manufacturer = manufacturer;
  }

  void setType(String type) {
    this.Type = type;
  }

  void setComment(String comment) {
    this.Comment = comment;
  }

  void setNbChannels(int nbchannels) {
    this.NbChannels = nbchannels;
  }

  void addChannel(ChannelDesc channel) {
    // TBIL
  }

  void addValueSetToChannel(int index, ChannelSet set) {
    //TBIL
  }
  
  String toString() {
    //return "DMX Fixture (" + type + ") with " + nbModes + " modes - " + name;
    return "";
  }
  


}

class ChannelDesc {
  
  int index;    // Current channel's index -> chaddress = initial device's address + index
  String channelDescription;
  ArrayList<ChannelSet> channelSets;
  
  ChannelDesc(int index, String desc) {
    this.index = index;
    this.channelDescription = desc;
    this.channelSets = new ArrayList<ChannelSet>();
  }
  
    
  
}

// The name could use some work - class used to describe an individual fixture's channel
// Most channels will be simple (dimmer), without a subfunction - but some channels require a rather complex description, with subfunctions which need to be named
class ChannelSet {
  int from_dmx;
  int to_dmx;
  String subfunction;
  boolean proportional = false;
  boolean proportional_increasing = false;    // Not used if proportional is not set to true
  boolean recommended_val_defined = false;
  
  ChannelSet(int rangeMin, int rangeMax, String subfunction) {
    this.from_dmx = rangeMin;
    this.to_dmx = rangeMax;
    this.subfunction = subfunction;
  }
  
  ChannelSet(int rangeMin, int rangeMax) {
    rangeMin = rangeMin;
    rangeMax = rangeMax;
    subfunction = "";
  }
}
