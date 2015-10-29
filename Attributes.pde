
//////////////////////////////////////////////////////////////////
// Register attributes to the animations, for better management //
//////////////////////////////////////////////////////////////////


//Arraylist of Attribute objects, one for every animation 
ArrayList<Attribute> animationAttributes;
//Arraylist of strings, containing the different existing attributes
StringList registeredAttributes;

//Same goes for custom devices actions 
ArrayList<Attribute> customDevicesAttributes;
StringList registeredAttributes_customDevices;

//And again for the DMX animations 
ArrayList<Attribute> DMXAttributes;
StringList registeredAttributes_DMX;

//Register attributes to an animation, given its number, its name, and a list of attributes
ArrayList<Attribute> registerAttribute(ArrayList<Attribute> attributesArray, int animationNbr, String attributeName, String[] attributeList) {
  boolean alreadyRegistered = false;

  for (Attribute animationAttr : attributesArray) {
    if (animationAttr.animationNbr == animationNbr) {
      alreadyRegistered = true;
      attributesArray.remove(animationAttr);
      break;
    } 
  }
  if (alreadyRegistered == true) {
    outputLog.println("--- Attributes already registed to animation no " + animationNbr + " - overwriting attributes");
  }
  String printattributes = "";
  for (int i = 0; i < attributeList.length; i++) {
    printattributes += attributeList[i] + ", ";
  }
  
  //outputLog.println("Registering attributes for animation #" + animationNbr + " -- " + printattributes);
  attributesArray.add(new Attribute(animationNbr, attributeName, attributeList));
  
  return attributesArray;
}

//Return a list of animation numbers, corresponding to animations matching all the specified attributes given as argument
ArrayList<Attribute> filterAnimationsByAttributes(ArrayList<Attribute> attributesArray, String[] attributeList) {
  return filterAnimationsByAttributes(attributesArray, attributeList, new String[] {});
}

ArrayList<Attribute> filterAnimationsByAttributes(ArrayList<Attribute> attributesArray, String[] attributeList, String[] unwantedAttributeList) {
  ArrayList<ArrayList<Attribute>> listsPerAttribute = new ArrayList<ArrayList<Attribute>>();
  for (int i = 0; i < attributeList.length; i++) {
    listsPerAttribute.add(new ArrayList<Attribute>());
  }
  for (int i = 0; i < attributeList.length; i++) {
    for (Attribute animation: attributesArray) {
      //Do not consider animations whose length is set as -1 : unfit for automatic mode
      if (animation.attributes.contains(attributeList[i])) {
        listsPerAttribute.get(i).add(animation);
      }
    }
  }
  ArrayList<Attribute> temp = new ArrayList<Attribute>();
  //It is only useful to check the first list (corresponding to the first specified attribute)
  //Only animations present in all of the lists shall be added to the final filtered list
  for (int i = 0; i < listsPerAttribute.get(0).size(); i++) {
    boolean allListsContainAnimation = true;
    for (int j = 0; j < listsPerAttribute.size(); j++) {
      boolean thisListContainsTheAnimation = false;
      for (Attribute animation: listsPerAttribute.get(j)) {
        if (animation.animationNbr == listsPerAttribute.get(0).get(i).animationNbr) {
          thisListContainsTheAnimation = true;
          break;
        }
      }
      allListsContainAnimation = allListsContainAnimation && thisListContainsTheAnimation;
    }
    if (allListsContainAnimation == true) {
      temp.add(listsPerAttribute.get(0).get(i));
    }
  }
  

  ArrayList<Attribute> temp2 = new ArrayList<Attribute>();
  //Check if the animations' attributes contain the unwanted attributes, and remove them
  //This is useful to remove animations coming from a set, in order not to consider them as individual animations
  if (unwantedAttributeList.length > 0) {
    //Limitation for now : only one attribute can be inside the unwanted attribute list
    String unwantedAttribute = unwantedAttributeList[0];
    for (int i = 0; i < temp.size(); i++) {
      Attribute animationFromTempList = temp.get(i);
      boolean containsUnwantedAttr = false;
      for (String attribute : animationFromTempList.attributes) {
        if (attribute.contains(unwantedAttribute) == true) {
          containsUnwantedAttr = true;
          break;
        }
      }
      if (containsUnwantedAttr == false) {
        temp2.add(temp.get(i));
      }
    }
  }
  else {    //unwantedAttributeList length is 0 -> no unwanted attribute !
    temp2 = temp;
  }  

  return temp2;
}


/*
List of the attributes to use :
Red, Slow, Fast, Video, Noise, Very Dark, Very Bright
Simple, Complex, Atmospheric, Fade In/Out, Objects
Geometric, Rotating, Circles, Lines, Curves, Triangles, Spiral
Atmospheric, Evolving, Smooth, Violent, Rhythmic, Random, Game

*/
void setAnimationAttributes() {
  //register attributes : animation number | animation name | attributes as a table of strings | indicative animation length (in number of beats)
  animationAttributes = registerAttribute(animationAttributes,   0, "Init"                                , new String[] {"Special"}                                                                            );
  animationAttributes = registerAttribute(animationAttributes,   1, "BlackOut"                            , new String[] {"Still", "Rhythmic", "B&W", "Very Dark"}                                              );
  animationAttributes = registerAttribute(animationAttributes,   2, "WhiteOut"                            , new String[] {"Still", "Rhythmic", "B&W", "Very Bright"}                                            );
  animationAttributes = registerAttribute(animationAttributes,   3, "WideFlash"                           , new String[] {"Fade In/Out", "Lines", "Slow", "Smooth", "B&W"}                                      );
  animationAttributes = registerAttribute(animationAttributes,   4, "Long Wide Flash "                    , new String[] {"Fade In/Out", "Slow", "B&W"}                                                         );
  animationAttributes = registerAttribute(animationAttributes,   5, "Flash Extreme Left"                  , new String[] {"Fade In/Out", "B&W", "Smooth"}                                                       );
  animationAttributes = registerAttribute(animationAttributes,   6, "Flash Left"                          , new String[] {"Fade In/Out", "B&W", "Smooth"}                                                       );
  animationAttributes = registerAttribute(animationAttributes,   7, "Flash Center"                        , new String[] {"Fade In/Out", "B&W", "Smooth"}                                                       );
  animationAttributes = registerAttribute(animationAttributes,   8, "Flash Right"                         , new String[] {"Fade In/Out", "B&W", "Smooth"}                                                       );
  animationAttributes = registerAttribute(animationAttributes,   9, "Flash Extreme Right"                 , new String[] {"Fade In/Out", "B&W", "Smooth"}                                                       );
  animationAttributes = registerAttribute(animationAttributes,  10, "Wide Flash Red"                      , new String[] {"Fade In/Out", "Slow", "Red"}                                                         );
  animationAttributes = registerAttribute(animationAttributes,  11, "Flash Extreme Left Red"              , new String[] {"Fade In/Out", "Red", "Smooth"}                                                       );
  animationAttributes = registerAttribute(animationAttributes,  12, "Flash Left Red"                      , new String[] {"Fade In/Out", "Red", "Smooth"}                                                       );
  animationAttributes = registerAttribute(animationAttributes,  13, "Flash Center Red"                    , new String[] {"Fade In/Out", "Red", "Smooth"}                                                       );
  animationAttributes = registerAttribute(animationAttributes,  14, "Flash Right Red"                     , new String[] {"Fade In/Out", "Red", "Smooth"}                                                       );
  animationAttributes = registerAttribute(animationAttributes,  15, "Flash Extreme Right Red"             , new String[] {"Fade In/Out", "Red", "Smooth"}                                                       );
  animationAttributes = registerAttribute(animationAttributes,  16, "Fadeout ExtremeLeft"                 , new String[] {"Fade In/Out", "Very Dark"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  17, "Fadeout Left"                        , new String[] {"Fade In/Out", "Very Dark"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  18, "Fadeout Center"                      , new String[] {"Fade In/Out", "Very Dark"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  19, "Fadeout Right"                       , new String[] {"Fade In/Out", "Very Dark"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  20, "Fadeout ExtremeRight"                , new String[] {"Fade In/Out", "Very Dark"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  21, "Fadeout"                             , new String[] {"Fade In/Out", "Very Dark", "B&W"}                                                    );
  animationAttributes = registerAttribute(animationAttributes,  22, "Fadein"                              , new String[] {"Fade In/Out", "Very Bright"}                                                         );
  animationAttributes = registerAttribute(animationAttributes,  23, "ExtremeLowLeft"                      , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  24, "ExtremeHiLeft"                       , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  25, "LowLeft"                             , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  26, "HiLeft"                              , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  27, "LowMid"                              , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  28, "HiMid"                               , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  29, "LowRight"                            , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  30, "HiRight"                             , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  31, "ExtremeLowRight"                     , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  32, "ExtremeHiRight"                      , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  33, "PanelFill Left"                      , new String[] {"Geometric", "Rhythmic", "Fast", "Simple", "B&W"}                                     );
  animationAttributes = registerAttribute(animationAttributes,  34, "PanelFill Center"                    , new String[] {"Geometric", "Rhythmic", "Fast", "Simple", "B&W"}                                     );
  animationAttributes = registerAttribute(animationAttributes,  35, "PanelFill Right"                     , new String[] {"Geometric", "Rhythmic", "Fast", "Simple", "B&W"}                                     );
  animationAttributes = registerAttribute(animationAttributes,  36, "PanelFill Line"                      , new String[] {"Geometric", "Lines", "Red"}                                                          );
  animationAttributes = registerAttribute(animationAttributes,  37, "Opposite Lines No Background"        , new String[] {"Geometric", "Simple", "Lines", "Slow", "B&W"}                                        );
  animationAttributes = registerAttribute(animationAttributes,  38, "Opening Lines"                       , new String[] {"Geometric", "Simple", "Lines", "B&W"}                                                );
  animationAttributes = registerAttribute(animationAttributes,  39, "Opening Lines Reinit"                , new String[] {"Geometric", "Simple", "Lines", "B&W"}                                                );
  animationAttributes = registerAttribute(animationAttributes,  40, "Line Wide Flash "                    , new String[] {"Fade In/Out", "Simple", "Fast", "Rhythmic", "B&W"}                                   );
  animationAttributes = registerAttribute(animationAttributes,  41, "Line Left Flash "                    , new String[] {"Fade In/Out", "Simple", "Fast", "Rhythmic", "B&W"}                                   );
  animationAttributes = registerAttribute(animationAttributes,  42, "Line Center Flash "                  , new String[] {"Fade In/Out", "Simple", "Fast", "Rhythmic", "B&W"}                                   );
  animationAttributes = registerAttribute(animationAttributes,  43, "Line Right Flash "                   , new String[] {"Fade In/Out", "Simple", "Slow", "Rhythmic", "B&W"}                                   );
  animationAttributes = registerAttribute(animationAttributes,  44, "Upwards Line White Out"              , new String[] {"Geometric", "Lines", "Slow", "B&W"}                                                  );
  animationAttributes = registerAttribute(animationAttributes,  45, "Upwards Line"                        , new String[] {"Geometric", "Lines", "Very Dark", "Simple", "B&W", "Rhythmic"}                       );
  animationAttributes = registerAttribute(animationAttributes,  46, "Lines 1"                             , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  47, "Lines 2"                             , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  48, "Lines 3"                             , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  49, "Lines 4"                             , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  50, "Lines 5"                             , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  51, "Lines 6"                             , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  52, "Lines 7"                             , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  53, "Lines 8"                             , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  54, "Lines 9"                             , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  55, "Lines 10"                            , new String[] {"Still", "Rhythmic", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes,  56, "Unfolding Lines"                     , new String[] {"Lines", "Slow", "B&W"}                                                               );
  animationAttributes = registerAttribute(animationAttributes,  57, "Mugen"                               , new String[] {"Simple", "Lines", "Geometric", "B&W"}                                                );
  animationAttributes = registerAttribute(animationAttributes,  58, "Turning Single Lines"                , new String[] {"Geometric", "Lines", "Simple", "B&W", "Slow", "Rotating"}                            );
  animationAttributes = registerAttribute(animationAttributes,  59, "Random Appearing Lines"              , new String[] {"Geometric", "Lines", "B&W", "Slow", "Rotating"}                                      );
  animationAttributes = registerAttribute(animationAttributes,  60, "Nonotak 1"                           , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  61, "Nonotak 2"                           , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  62, "Nonotak 3"                           , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  63, "Nonotak 4"                           , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  64, "Nonotak 5"                           , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  65, "Nonotak PanelFill Extreme Left"      , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  66, "Nonotak PanelFill Left"              , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  67, "Nonotak PanelFill Center"            , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  68, "Nonotak PanelFill Right"             , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  69, "Nonotak PanelFill Extreme Right"     , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  70, "Nonotak Woosh 1"                     , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  71, "Nonotak Woosh 2"                     , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  72, "Nonotak Woosh 3"                     , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  73, "Nonotak Woosh 4"                     , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  74, "Rotating Cut Black"                  , new String[] {"Atmospheric", "Fast", "B&W", "Rotating"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  75, "Rotating Cut Blue"                   , new String[] {"Atmospheric", "Fast", "Blue", "Rotating"}                                            );
  animationAttributes = registerAttribute(animationAttributes,  76, "Rotating Cut - Fast"                 , new String[] {"Atmospheric", "Fast", "B&W", "Rotating"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  77, "Red Diagonal Lines"                  , new String[] {"Still", "Lines", "Rhythmic", "Red"}                                                  );
  animationAttributes = registerAttribute(animationAttributes,  78, "Blue Diagonal Lines"                 , new String[] {"Still", "Lines", "Rhythmic", "Blue"}                                                 );
  animationAttributes = registerAttribute(animationAttributes,  79, "Blue Diagonal Lines2"                , new String[] {"Still", "Lines", "Rhythmic", "Blue"}                                                 );
  animationAttributes = registerAttribute(animationAttributes,  80, "Blue Diagonal Lines3"                , new String[] {"Still", "Lines", "Rhythmic", "Blue"}                                                 );
  animationAttributes = registerAttribute(animationAttributes,  81, "Red Diagonal Lines2"                 , new String[] {"Still", "Lines", "Rhythmic", "Red"}                                                  );
  animationAttributes = registerAttribute(animationAttributes,  82, "White Diagonal Lines"                , new String[] {"Still", "Lines", "Rhythmic", "B&W"}                                                  );
  animationAttributes = registerAttribute(animationAttributes,  83, "White Diagonal Lines2"               , new String[] {"Still", "Lines", "Rhythmic", "B&W"}                                                  );
  animationAttributes = registerAttribute(animationAttributes,  84, "White Straight Lines"                , new String[] {"Still", "Lines", "Rhythmic", "B&W"}                                                  );
  animationAttributes = registerAttribute(animationAttributes,  85, "Star - 2 sides"                      , new String[] {"Geometric", "Lines", "Slow", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes,  86, "Star - 3 sides"                      , new String[] {"Geometric", "Lines", "Slow", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes,  87, "Star - 4 sides"                      , new String[] {"Geometric", "Lines", "Slow", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes,  88, "Star - 6 sides"                      , new String[] {"Geometric", "Lines", "Slow", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes,  89, "Star - 8 sides"                      , new String[] {"Geometric", "Lines", "Slow", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes,  90, "Rotating Circles"                    , new String[] {"Geometric", "Circles", "Simple", "Rotating", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes,  91, "Joint Circles"                       , new String[] {"Atmospheric", "Slow", "B&W", "Simple"}                                               );
  animationAttributes = registerAttribute(animationAttributes,  92, "Parallel Worlds - Regular"           , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  93, "Parallel Worlds - Slow"              , new String[] {"Geometric", "B&W", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  94, "Parallel Worlds - Red Flash"         , new String[] {"Geometric", "Red", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  95, "Parallel Worlds - Reverse"           , new String[] {"Geometric", "Red", "Simple", "Rhythmic"}                                             );
  animationAttributes = registerAttribute(animationAttributes,  96, "MultiCrecy - Very Low Intensity"     , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic", "Very Dark"}                           );
  animationAttributes = registerAttribute(animationAttributes,  97, "MultiCrecy - Low Intensity"          , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic", "Violent"}                             );
  animationAttributes = registerAttribute(animationAttributes,  98, "MultiCrecy - Medium Intensity"       , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic", "Violent"}                             );
  animationAttributes = registerAttribute(animationAttributes,  99, "MultiCrecy - High Intensity"         , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic", "Violent"}                             );
  animationAttributes = registerAttribute(animationAttributes, 100, "MultiCrecy - Hardcore Intensity"     , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic", "Violent"}                             );
  animationAttributes = registerAttribute(animationAttributes, 101, "MultiCrecy - Double Intensity"       , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic", "Violent"}                             );
  animationAttributes = registerAttribute(animationAttributes, 102, "MultiCrecy - Refrain"                , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic", "Violent"}                             );
  animationAttributes = registerAttribute(animationAttributes, 103, "Snake - Single"                      , new String[] {"Geometric", "Red", "Simple"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 104, "Snake - Double"                      , new String[] {"Geometric", "Red", "Simple"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 105, "Snake - Triple"                      , new String[] {"Geometric", "Red", "Simple"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 106, "Snake - Four"                        , new String[] {"Geometric", "Red", "Simple"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 107, "Snake - Five"                        , new String[] {"Geometric", "Red", "Simple"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 108, "Snake - Six"                         , new String[] {"Geometric", "Red", "Simple"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 109, "Moving Sine"                         , new String[] {"Geometric", "B&W", "Fast", "Simple"}                                                 );
  animationAttributes = registerAttribute(animationAttributes, 110, "Carglass"                            , new String[] {"Geometric", "Slow", "B&W"}                                                           );
  animationAttributes = registerAttribute(animationAttributes, 111, "Va-et-vient 1"                       , new String[] {"Geometric", "Fast", "B&W", "Rhythmic"}                                               );
  animationAttributes = registerAttribute(animationAttributes, 112, "Va-et-vient 2"                       , new String[] {"Geometric", "Fast", "B&W", "Rhythmic"}                                               );
  animationAttributes = registerAttribute(animationAttributes, 113, "Impulse White Rectangle - Horizontal", new String[] {"Geometric", "Squares", "B&W", "Fast", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 114, "Impulse White Rectangle - Vertical"  , new String[] {"Geometric", "Squares", "B&W", "Fast", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 115, "Impulse Red Rectangle - Horizontal"  , new String[] {"Geometric", "Squares", "Red", "Fast", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 116, "Impulse Red Rectangle - Vertical"    , new String[] {"Geometric", "Squares", "Red", "Fast", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 117, "Mixed Lines 1"                       , new String[] {"Geometric", "Lines", "Fast", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes, 118, "Mixed Lines 2"                       , new String[] {"Geometric", "Lines", "Fast", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes, 119, "Mixed Lines 3"                       , new String[] {"Geometric", "Lines", "Fast", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes, 120, "Mixed Lines 4"                       , new String[] {"Geometric", "Lines", "Fast", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes, 121, "Mixed Lines 5"                       , new String[] {"Geometric", "Lines", "Fast", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes, 122, "Mixed Lines 6"                       , new String[] {"Geometric", "Lines", "Fast", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes, 123, "Mixed Lines 7"                       , new String[] {"Geometric", "Lines", "Circles", "Fast", "Simple", "B&W", "Rhythmic"}                 );
  animationAttributes = registerAttribute(animationAttributes, 124, "Mixed Lines 8"                       , new String[] {"Geometric", "Lines", "Circles", "Fast", "Simple", "B&W", "Rhythmic"}                 );
  animationAttributes = registerAttribute(animationAttributes, 125, "Mixed Lines 9"                       , new String[] {"Geometric", "Circles", "Fast", "Simple", "B&W", "Rhythmic"}                          );
  animationAttributes = registerAttribute(animationAttributes, 126, "Mixed Lines 10"                      , new String[] {"Geometric", "Circles", "Fast", "Simple", "B&W", "Rhythmic"}                          );
  animationAttributes = registerAttribute(animationAttributes, 127, "Mixed Lines 11"                      , new String[] {"Geometric", "Circles", "Fast", "Simple", "B&W", "Rhythmic"}                          );
  animationAttributes = registerAttribute(animationAttributes, 128, "Mixed Lines 12"                      , new String[] {"Geometric", "Circles", "Fast", "Simple", "B&W", "Rhythmic"}                          );
  animationAttributes = registerAttribute(animationAttributes, 129, "Mixed Lines 13"                      , new String[] {"Geometric", "Circles", "Fast", "Simple", "B&W", "Rhythmic"}                          );
  animationAttributes = registerAttribute(animationAttributes, 130, "Mixed Lines 14"                      , new String[] {"Geometric", "Circles", "Fast", "Simple", "B&W", "Rhythmic"}                          );
  animationAttributes = registerAttribute(animationAttributes, 131, "Upwards Glitch Lines"                , new String[] {"Geometric", "Lines", "Slow", "Simple", "Red", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes, 132, "Diagonal Glitch Lines"               , new String[] {"Geometric", "Lines", "Fast", "Simple", "Red", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes, 133, "Compressed Lines"                    , new String[] {"Geometric", "Lines", "Fast", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes, 134, "UpwardsGlitchMixedLines"             , new String[] {"Geometric", "Lines", "Fast", "B&W"}                                                  );
  animationAttributes = registerAttribute(animationAttributes, 135, "UpwardsGlitchMixedLines2"            , new String[] {"Geometric", "Lines", "Fast", "B&W"}                                                  );
  animationAttributes = registerAttribute(animationAttributes, 136, "Growing Triangles"                   , new String[] {"Geometric", "Triangles", "Rhythmic", "Slow", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 137, "Small Square Left"                   , new String[] {"Geometric", "Squares", "Violent", "Fast", "B&W", "Rhythmic"}                         );
  animationAttributes = registerAttribute(animationAttributes, 138, "Small Square Center"                 , new String[] {"Geometric", "Squares", "Violent", "Fast", "B&W", "Rhythmic"}                         );
  animationAttributes = registerAttribute(animationAttributes, 139, "Small Square Right"                  , new String[] {"Geometric", "Squares", "Violent", "Fast", "B&W", "Rhythmic"}                         );
  animationAttributes = registerAttribute(animationAttributes, 140, "Small Squares"                       , new String[] {"Geometric", "Squares", "Violent", "Fast", "B&W", "Rhythmic"}                         );
  animationAttributes = registerAttribute(animationAttributes, 141, "Moving Lines"                        , new String[] {"Geometric", "Lines", "Fast", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes, 142, "Moving Squares"                      , new String[] {"Objects", "Squares", "Slow", "Simple", "B&W", "Rhythmic"}                            );
  animationAttributes = registerAttribute(animationAttributes, 143, "Orbiting Particles"                  , new String[] {"Objects", "Circles", "Fast", "B&W", "Rhythmic"}                                      );
  animationAttributes = registerAttribute(animationAttributes, 144, "Arrow Style"                         , new String[] {"Geometric", "Lines", "Fast", "B&W"}                                                  );
  animationAttributes = registerAttribute(animationAttributes, 145, "Single Arrow - Up-Down White"        , new String[] {"Geometric", "Objects", "Rhythmic", "Lines", "Fast", "B&W"}                           );
  animationAttributes = registerAttribute(animationAttributes, 146, "Single Arrow - Left-Right White"     , new String[] {"Geometric", "Objects", "Rhythmic", "Lines", "Fast", "B&W"}                           );
  animationAttributes = registerAttribute(animationAttributes, 147, "Single Arrow - Right-Left White"     , new String[] {"Geometric", "Objects", "Rhythmic", "Lines", "Fast", "B&W"}                           );
  animationAttributes = registerAttribute(animationAttributes, 148, "Single Arrow - Down-Up White"        , new String[] {"Geometric", "Objects", "Rhythmic", "Lines", "Fast", "B&W"}                           );
  animationAttributes = registerAttribute(animationAttributes, 149, "Single Arrow - Up-Down Red"          , new String[] {"Geometric", "Objects", "Rhythmic", "Lines", "Fast", "Red"}                           );
  animationAttributes = registerAttribute(animationAttributes, 150, "Single Arrow - Left-Right Red"       , new String[] {"Geometric", "Objects", "Rhythmic", "Lines", "Fast", "Red"}                           );
  animationAttributes = registerAttribute(animationAttributes, 151, "Single Arrow - Right-Left Red"       , new String[] {"Geometric", "Objects", "Rhythmic", "Lines", "Fast", "Red"}                           );
  animationAttributes = registerAttribute(animationAttributes, 152, "Single Arrow - Down-Up Red"          , new String[] {"Geometric", "Objects", "Rhythmic", "Lines", "Fast", "Red"}                           );
  animationAttributes = registerAttribute(animationAttributes, 153, "Sweeping Balls And Arrows"           , new String[] {"Geometric", "B&W", "Complex", "Rhythmic"}                                            );
  animationAttributes = registerAttribute(animationAttributes, 154, "Columns White"                       , new String[] {"Geometric", "Lines", "Slow", "Rhythmic", "B&W"}                                      );
  animationAttributes = registerAttribute(animationAttributes, 155, "Columns Black"                       , new String[] {"Geometric", "Lines", "Slow", "Rhythmic", "B&W"}                                      );
  animationAttributes = registerAttribute(animationAttributes, 156, "Columns White Red"                   , new String[] {"Geometric", "Slow", "Red", "Rhythmic"}                                               );
  animationAttributes = registerAttribute(animationAttributes, 157, "Columns Black Red"                   , new String[] {"Geometric", "Slow", "Red", "Rhythmic"}                                               );
  animationAttributes = registerAttribute(animationAttributes, 158, "Continuous Triangles Resync "        , new String[] {"Geometric", "Triangles", "Slow", "Rhythmic", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 159, "Continuous Triangles Resync Invert"  , new String[] {"Geometric", "Triangles", "Slow", "Rhythmic", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 160, "Continuous Triangles Drift"          , new String[] {"Geometric", "Triangles", "Slow", "Rhythmic", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 161, "Continuous Triangles Drift Invert"   , new String[] {"Geometric", "Triangles", "Slow", "Rhythmic", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 162, "Beat Circle"                         , new String[] {"Geometric", "Fast", "Circles", "Simple", "Rhythmic", "Red"}                          );
  animationAttributes = registerAttribute(animationAttributes, 163, "Beat Circle Lines Reinit"            , new String[] {"Geometric", "Fast", "Circles", "Lines", "Simple", "Rhythmic", "Red"}                 );
  animationAttributes = registerAttribute(animationAttributes, 164, "Beat Circle Lines"                   , new String[] {"Geometric", "Fast", "Circles", "Lines", "Simple", "Rhythmic", "Red"}                 );
  animationAttributes = registerAttribute(animationAttributes, 165, "Beat Circle Color Lines 1"           , new String[] {"Geometric", "Fast", "Circles", "Lines", "Simple", "Rhythmic", "Red"}                 );
  animationAttributes = registerAttribute(animationAttributes, 166, "Beat Circle Color Lines 2"           , new String[] {"Geometric", "Fast", "Circles", "Lines", "Simple", "Rhythmic", "Colorful"}            );
  animationAttributes = registerAttribute(animationAttributes, 167, "Atoms - One Electron"                , new String[] {"Geometric", "Circles", "Fast", "Rhythmic", "Red"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 168, "Atoms - Two Electrons"               , new String[] {"Geometric", "Circles", "Fast", "Rhythmic", "Red"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 169, "Atoms - Three Electrons"             , new String[] {"Geometric", "Circles", "Fast", "Rhythmic", "Red"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 170, "Perfect Circle"                      , new String[] {"Geometric", "Circles", "Fast", "Rhythmic", "Red"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 171, "Tunnel White"                        , new String[] {"Atmospheric", "Fast", "B&W", "Violent", "Rhythmic"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 172, "Tunnel Red "                         , new String[] {"Atmospheric", "Fast", "Red", "Violent", "Rhythmic"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 173, "Exploding Circle"                    , new String[] {"Geometric", "Simple", "Circles", "Fast", "Rhythmic", "B&W"}                          );
  animationAttributes = registerAttribute(animationAttributes, 174, "Exploding Circle Left"               , new String[] {"Geometric", "Circles", "Fast", "B&W", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 175, "Exploding Circle Right"              , new String[] {"Geometric", "Circles", "Fast", "Red", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 176, "Color Waves - Regular"               , new String[] {"Atmospheric", "Circles", "Fast", "Red", "Rhythmic"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 177, "Color Waves - Strong"                , new String[] {"Atmospheric", "Circles", "Fast", "Red", "Rhythmic"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 178, "Glitch Triangle"                     , new String[] {"Geometric", "Triangles", "B&W", "Violent"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 179, "Glitch Line"                         , new String[] {"Geometric", "Lines", "B&W", "Violent"}                                               );
  animationAttributes = registerAttribute(animationAttributes, 180, "Bar Waves - White"                   , new String[] {"Geometric", "B&W", "Lines"}                                                          );
  animationAttributes = registerAttribute(animationAttributes, 181, "Bar Waves - Red"                     , new String[] {"Geometric", "Red", "Lines"}                                                          );
  animationAttributes = registerAttribute(animationAttributes, 182, "Bar Waves - Blue"                    , new String[] {"Geometric", "Blue", "Lines"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 183, "Fucked Up Sine - 1"                  , new String[] {"Curves", "B&W", "Complex", "Fast", "Evolving"}                                       );
  animationAttributes = registerAttribute(animationAttributes, 184, "Fucked Up Sine - 2"                  , new String[] {"Curves", "B&W", "Complex", "Fast", "Evolving"}                                       );
  animationAttributes = registerAttribute(animationAttributes, 185, "Fucked Up Sine - 2 - No Reinit"      , new String[] {"Curves", "B&W", "Complex", "Fast", "Evolving"}                                       );
  animationAttributes = registerAttribute(animationAttributes, 186, "Fucked Up Sine - 3"                  , new String[] {"Curves", "B&W", "Complex", "Fast", "Evolving"}                                       );
  animationAttributes = registerAttribute(animationAttributes, 187, "Rotating Square"                     , new String[] {"Geometric", "Squares", "Rotating", "Complex", "Curves"}                              );
  animationAttributes = registerAttribute(animationAttributes, 188, "Mandala"                             , new String[] {"Geometric", "Circles", "Fast", "Rhythmic", "Red", "Complex"}                         );
  animationAttributes = registerAttribute(animationAttributes, 189, "Mandala - change shape"              , new String[] {"Geometric", "Circles", "Fast", "Rhythmic", "Red", "Complex"}                         );
  animationAttributes = registerAttribute(animationAttributes, 190, "Clock"                               , new String[] {"Geometric", "Lines", "Red", "Rhythmic"}                                              );
  animationAttributes = registerAttribute(animationAttributes, 191, "Invert Explode"                      , new String[] {"Geometric", "Circles", "Rotating", "Lines", "Colorful", "Fast", "Rhythmic"}          );
  animationAttributes = registerAttribute(animationAttributes, 192, "Crescent"                            , new String[] {"Atmospheric", "Lines", "Red", "Slow", "Colorful"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 193, "Trigo Shapes"                        , new String[] {"Geometric", "Smooth", "Red", "Rhythmic", "Rotating"}                                 );
  animationAttributes = registerAttribute(animationAttributes, 194, "Newton Pendulum"                     , new String[] {"Geometric", "Evolving", "Simple", "Circles", "Lines", "Fast", "B&W"}                 );
  animationAttributes = registerAttribute(animationAttributes, 195, "Circle Pusher Rotate"                , new String[] {"Geometric", "Evolving", "Circles", "Rotating", "B&W", "Rhythmic"}                    );
  animationAttributes = registerAttribute(animationAttributes, 196, "Circle Pusher Straight"              , new String[] {"Geometric", "Evolving", "Circles", "B&W", "Rhythmic"}                                );
  animationAttributes = registerAttribute(animationAttributes, 197, "Patatap 1"                           , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 198, "Patatap 2"                           , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 199, "Patatap 3"                           , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 200, "Patatap 4"                           , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 201, "Patatap 5"                           , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 202, "Patatap 6"                           , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 203, "Patatap 7"                           , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 204, "Patatap 8"                           , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 205, "Patatap 9"                           , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 206, "Patatap 10"                          , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 207, "Patatap 11"                          , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 208, "Patatap 12"                          , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 209, "Patatap 13"                          , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 210, "Patatap 14"                          , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 211, "Patatap 15"                          , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 212, "Patatap 16"                          , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 213, "Patatap with audio"                  , new String[] {"Geometric", "Colorful", "Simple", "Rhythmic", "AudioInput"}                          );
  animationAttributes = registerAttribute(animationAttributes, 214, "Shadows"                             , new String[] {"Rotating", "Fast", "B&W"}                                                            );
  animationAttributes = registerAttribute(animationAttributes, 215, "SpiralTriangle"                      , new String[] {"Geometric", "Spiral", "B&W", "Slow"}                                                 );
  animationAttributes = registerAttribute(animationAttributes, 216, "Pulse Star"                          , new String[] {"Geometric", "Circles", "B&W", "Slow"}                                                );
  animationAttributes = registerAttribute(animationAttributes, 217, "Arrow Shape"                         , new String[] {"Geometric", "Triangles", "Slow", "B&W"}                                              );
  animationAttributes = registerAttribute(animationAttributes, 218, "Moire"                               , new String[] {"Atmospheric", "Complex", "Slow", "B&W"}                                              );
  animationAttributes = registerAttribute(animationAttributes, 219, "Tumbler"                             , new String[] {"Geometric", "B&W", "Simple", "Lines", "Rotating"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 220, "Super formula"                       , new String[] {"Complex", "Evolving", "Atmospheric", "Rhythmic", "B&W"}                              );
  animationAttributes = registerAttribute(animationAttributes, 221, "HypnoAudio"                          , new String[] {"Geometric", "Red", "Evolving", "Rhythmic", "AudioInput"}                             );
  animationAttributes = registerAttribute(animationAttributes, 222, "HypnoAudio - without audio (manual)" , new String[] {"Geometric", "Red", "Evolving", "Rhythmic"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 223, "Snow"                                , new String[] {"Atmospheric", "Noise", "B&W", "Very Dark"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 224, "Noise : InitFlasher"                 , new String[] {"Video", "Noise", "B&W"}                                                              );
  animationAttributes = registerAttribute(animationAttributes, 225, "Rain"                                , new String[] {"Atmospheric", "Noise", "B&W", "Very Dark"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 226, "White Noise"                         , new String[] {"Noise", "B&W"}                                                                       );
  animationAttributes = registerAttribute(animationAttributes, 227, "White Noise Crescendo"               , new String[] {"Noise", "B&W"}                                                                       );
  animationAttributes = registerAttribute(animationAttributes, 228, "Hyper Speed"                         , new String[] {"Atmospheric", "Lines", "Fast", "B&W"}                                                );
  animationAttributes = registerAttribute(animationAttributes, 229, "Random BW Flow"                      , new String[] {"Noise", "Complex", "B&W"}                                                            );
  animationAttributes = registerAttribute(animationAttributes, 230, "Random Smoke Particles"              , new String[] {"Noise", "Evolving", "Atmospheric", "B&W"}                                            );
  animationAttributes = registerAttribute(animationAttributes, 231, "Periodic Noise"                      , new String[] {"Atmospheric", "B&W", "Noise"}                                                        );
  animationAttributes = registerAttribute(animationAttributes, 232, "DoubleGradient transition"           , new String[] {"Fade In/Out", "Atmospheric", "B&W", "Smooth", "Slow"}                                );
  animationAttributes = registerAttribute(animationAttributes, 233, "Sonar"                               , new String[] {"Fade In/Out", "Slow", "Smooth", "B&W"}                                               );
  animationAttributes = registerAttribute(animationAttributes, 234, "SonarAllWhite"                       , new String[] {"Fade In/Out", "Slow", "Smooth", "B&W"}                                               );
  animationAttributes = registerAttribute(animationAttributes, 235, "Thunder Lines Init"                  , new String[] {"Atmospheric", "Lines", "Fast", "B&W", "Smooth"}                                      );
  animationAttributes = registerAttribute(animationAttributes, 236, "Thunder Lines - More Lines"          , new String[] {"Atmospheric", "Lines", "Fast", "B&W", "Smooth"}                                      );
  animationAttributes = registerAttribute(animationAttributes, 237, "Opening Whiteout"                    , new String[] {"Fade In/Out", "Simple", "Slow", "B&W", "Smooth"}                                     );
  animationAttributes = registerAttribute(animationAttributes, 238, "Dark Snakes"                         , new String[] {"Fade In/Out", "Slow", "Smooth"}                                                      );
  animationAttributes = registerAttribute(animationAttributes, 239, "Bright Snakes"                       , new String[] {"Fade In/Out", "Slow", "Smooth"}                                                      );
  animationAttributes = registerAttribute(animationAttributes, 240, "Milktank"                            , new String[] {"Atmospheric", "Objects", "Fast", "B&W", "Evolving"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 241, "Flashing Dots Border"                , new String[] {"Atmospheric", "Circles", "Slow", "B&W"}                                              );
  animationAttributes = registerAttribute(animationAttributes, 242, "Light Fusion"                        , new String[] {"Atmospheric", "Fast", "B&W", "Violent"}                                              );
  animationAttributes = registerAttribute(animationAttributes, 243, "BW Triangles"                        , new String[] {"Geometric", "Evolving", "B&W"}                                                       );
  animationAttributes = registerAttribute(animationAttributes, 244, "Color Vertex"                        , new String[] {"Atmospheric", "Fast", "Rhythmic", "Colorful", "Complex", "Evolving"}                 );
  animationAttributes = registerAttribute(animationAttributes, 245, "Gloubiboulga"                        , new String[] {"Geometric", "Atmospheric", "Complex", "Colorful", "Fast"}                            );
  animationAttributes = registerAttribute(animationAttributes, 246, "CarreMarshall"                       , new String[] {"Geometric", "Squares", "B&W", "Smooth", "Slow"}                                      );
  animationAttributes = registerAttribute(animationAttributes, 247, "MarshallStrobo"                      , new String[] {"Violent", "Geometric", "Squares", "B&W", "Smooth", "Slow", "B&W"}                    );
  animationAttributes = registerAttribute(animationAttributes, 248, "Strobo normal"                       , new String[] {"Violent", "B&W", "Fast"}                                                             );
  animationAttributes = registerAttribute(animationAttributes, 249, "StroboX"                             , new String[] {"Fade In/Out", "Violent", "Lines", "Fast", "B&W"}                                     );
  animationAttributes = registerAttribute(animationAttributes, 250, "Dynamic Angle Lines - White"         , new String[] {"Geometric", "B&W", "Simple", "Lines", "Rotating", "Rhythmic"}                        );
  animationAttributes = registerAttribute(animationAttributes, 251, "Dynamic Angle Lines - Half Red"      , new String[] {"Geometric", "Red", "Simple", "Lines", "Rotating", "Rhythmic"}                        );
  animationAttributes = registerAttribute(animationAttributes, 252, "Dynamic Angle Lines - Red"           , new String[] {"Geometric", "Red", "Simple", "Lines", "Rotating", "Rhythmic"}                        );
  animationAttributes = registerAttribute(animationAttributes, 253, "Spots"                               , new String[] {"Violent", "Geometric", "Lines", "Fast", "B&W"}                                       );
  animationAttributes = registerAttribute(animationAttributes, 254, "StroboLine"                          , new String[] {"Violent", "Geometric", "Lines", "Fast", "B&W"}                                       );
  animationAttributes = registerAttribute(animationAttributes, 255, "Random White Line Flash"             , new String[] {"Geometric", "B&W", "Simple", "Rhythmic", "Violent"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 256, "StroboRed"                           , new String[] {"Violent", "Fast", "Red"}                                                             );
  animationAttributes = registerAttribute(animationAttributes, 257, "Spots Multi Color"                   , new String[] {"Geometric", "Lines", "Blue", "Colorful", "Violent"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 258, "Strobo Line Color"                   , new String[] {"Geometric", "Lines", "Blue", "Colorful", "Violent"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 259, "Strobo Color"                        , new String[] {"Geometric", "Simple", "Blue", "Violent"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 260, "Triangle Strobo"                     , new String[] {"Geometric", "Lines", "Violent", "Fast", "B&W"}                                       );
  animationAttributes = registerAttribute(animationAttributes, 261, "Triangle Strobo 2"                   , new String[] {"Geometric", "Triangles", "Fast", "Red", "Blue", "Violent"}                           );
  animationAttributes = registerAttribute(animationAttributes, 262, "Hypno Flash Triangle"                , new String[] {"Geometric", "Triangles", "Rhythmic", "Red", "Violent"}                               );
  animationAttributes = registerAttribute(animationAttributes, 263, "Fauve Random Flash"                  , new String[] {"Atmospheric", "Red", "Simple"}                                                       );
  animationAttributes = registerAttribute(animationAttributes, 264, "Red Noise Shape 1"                   , new String[] {"Noise", "Red", "Fast"}                                                               );
  animationAttributes = registerAttribute(animationAttributes, 265, "Red Noise Shape 2"                   , new String[] {"Geometric", "Lines", "Noise", "Red", "Fast"}                                         );
  animationAttributes = registerAttribute(animationAttributes, 266, "Red Noise Shape 3"                   , new String[] {"Geometric", "Lines", "Noise", "Red", "Fast", "Violent"}                              );
  animationAttributes = registerAttribute(animationAttributes, 267, "Red Noise Shape 4"                   , new String[] {"Geometric", "Triangles", "Noise", "Red", "Fast", "Violent"}                          );
  animationAttributes = registerAttribute(animationAttributes, 268, "Red Noise Shape 5"                   , new String[] {"Geometric", "Circles", "Noise", "Red", "Fast"}                                       );
  animationAttributes = registerAttribute(animationAttributes, 269, "Red Noise Shape 6"                   , new String[] {"Geometric", "Lines", "Noise", "Red", "Fast", "Violent"}                              );
  animationAttributes = registerAttribute(animationAttributes, 270, "Fusee Up"                            , new String[] {"Fade In/Out", "B&W", "Fast"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 271, "Fusee Down"                          , new String[] {"Fade In/Out", "B&W", "Fast"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 272, "Fusee Left"                          , new String[] {"Fade In/Out", "B&W", "Fast"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 273, "Fusee Right"                         , new String[] {"Fade In/Out", "B&W", "Fast"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 274, "FuseeCenterHorizontal"               , new String[] {"Fade In/Out", "B&W", "Fast"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 275, "FuseeCenterVertical"                 , new String[] {"Fade In/Out", "B&W", "Fast"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 276, "Double Fusee"                        , new String[] {"Fade In/Out", "Fast", "B&W"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 277, "Fusee Up Red"                        , new String[] {"Fade In/Out", "Fast", "Red"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 278, "Fusee Down Red"                      , new String[] {"Fade In/Out", "Fast", "Red"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 279, "Fusee Left Red"                      , new String[] {"Fade In/Out", "Fast", "Red"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 280, "Fusee Right Red"                     , new String[] {"Fade In/Out", "Fast", "Red"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 281, "Fusee Center Horizontal Red"         , new String[] {"Fade In/Out", "Fast", "Red"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 282, "Fusee Center Vertical Red"           , new String[] {"Fade In/Out", "Fast", "Red"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 283, "Responsive Circles BW"               , new String[] {"Atmospheric", "Slow", "B&W"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 284, "Responsive Circles"                  , new String[] {"Atmospheric", "Slow", "Blue"}                                                        );
  animationAttributes = registerAttribute(animationAttributes, 285, "Manual Circle"                       , new String[] {"Fade In/Out", "Geometric", "Circles", "Simple", "Slow", "Blue"}                      );
  animationAttributes = registerAttribute(animationAttributes, 286, "Automatic Circle"                    , new String[] {"Geometric", "Circles", "Simple", "Slow", "Blue"}                                     );
  animationAttributes = registerAttribute(animationAttributes, 287, "Waveform"                            , new String[] {"Atmospheric", "Colorful"}                                                            );
  animationAttributes = registerAttribute(animationAttributes, 288, "Worms"                               , new String[] {"Objects", "Circles", "Smooth", "Blue", "Slow"}                                       );
  animationAttributes = registerAttribute(animationAttributes, 289, "Kaleido Triangle"                    , new String[] {"Geometric", "Blue", "Complex", "Evolving"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 290, "Rhombus"                             , new String[] {"Geometric", "Colorful", "Smooth", "Slow"}                                            );
  animationAttributes = registerAttribute(animationAttributes, 291, "Glitch Diagonal Lines"               , new String[] {"Atmospheric", "Lines", "Rhythmic", "Blue"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 292, "Particles Explode"                   , new String[] {"Fade In/Out", "Fast", "Rhythmic", "Blue"}                                            );
  animationAttributes = registerAttribute(animationAttributes, 293, "Symmetry"                            , new String[] {"Atmospheric", "Smooth", "Complex", "Colorful"}                                       );
  animationAttributes = registerAttribute(animationAttributes, 294, "PixelLines"                          , new String[] {"Atmospheric", "Colorful", "Smooth"}                                                  );
  animationAttributes = registerAttribute(animationAttributes, 295, "Circle Contour"                      , new String[] {"Atmospheric", "Circles", "Slow", "Very Dark", "Blue"}                                );
  animationAttributes = registerAttribute(animationAttributes, 296, "Color Explode"                       , new String[] {"Atmospheric", "Objects", "Slow", "Colorful"}                                         );
  animationAttributes = registerAttribute(animationAttributes, 297, "Color Rain"                          , new String[] {"Atmospheric", "Lines", "Fast", "Colorful"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 298, "Warp Speed"                          , new String[] {"Fade In/Out", "Fast", "Colorful"}                                                    );
  animationAttributes = registerAttribute(animationAttributes, 299, "Digital Hex Particles"               , new String[] {"Fade In/Out", "Colorful", "Very Dark", "Lines", "Slow"}                              );
  animationAttributes = registerAttribute(animationAttributes, 300, "Red Arc Transition"                  , new String[] {"Fade In/Out", "Red", "Circles", "Fast"}                                              );
  animationAttributes = registerAttribute(animationAttributes, 301, "Blue Arc Transition"                 , new String[] {"Fade In/Out", "Blue", "Circles", "Fast"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 302, "Shutter"                             , new String[] {"Geometric", "Atmospheric", "Red", "Slow"}                                            );
  animationAttributes = registerAttribute(animationAttributes, 303, "Butterfly"                           , new String[] {"Atmospheric", "Evolving", "Slow", "Very Dark", "Blue"}                               );
  animationAttributes = registerAttribute(animationAttributes, 304, "Bezier Flowers"                      , new String[] {"Geometric", "Lines", "Complex", "Rhythmic", "Colorful"}                              );
  animationAttributes = registerAttribute(animationAttributes, 305, "Light Painting"                      , new String[] {"3D", "Fast", "Objects", "Colorful", "Rhythmic"}                                      );
  animationAttributes = registerAttribute(animationAttributes, 306, "Particles Flow"                      , new String[] {"Atmospheric", "Slow", "Blue"}                                                        );
  animationAttributes = registerAttribute(animationAttributes, 307, "Particles Flow Red"                  , new String[] {"Atmospheric", "Slow", "Red", "Smooth"}                                               );
  animationAttributes = registerAttribute(animationAttributes, 308, "Flower"                              , new String[] {"Atmospheric", "Circles", "Evolving", "Colorful", "Rhythmic"}                         );
  animationAttributes = registerAttribute(animationAttributes, 309, "Double Flowers"                      , new String[] {"Atmospheric", "Slow", "Red"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 310, "Fireflies"                           , new String[] {"Atmospheric", "Red", "Complex", "Slow"}                                              );
  animationAttributes = registerAttribute(animationAttributes, 311, "Fire Noise Squares"                  , new String[] {"Atmospheric", "Noise", "Red", "Evolving", "Smooth"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 312, "Blood Ski"                           , new String[] {"Atmospheric", "Fast", "Red"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 313, "Mechanic Lines"                      , new String[] {"Geometric", "Lines", "Red", "Slow"}                                                  );
  animationAttributes = registerAttribute(animationAttributes, 314, "Red Glowing Balls 1"                 , new String[] {"Geometric", "Red", "Slow"}                                                           );
  animationAttributes = registerAttribute(animationAttributes, 315, "Red Glowing Balls 2"                 , new String[] {"Geometric", "Red", "Slow"}                                                           );
  animationAttributes = registerAttribute(animationAttributes, 316, "Red vs Black vs White"               , new String[] {"Fade In/Out", "Circles", "Red", "Slow"}                                              );
  animationAttributes = registerAttribute(animationAttributes, 317, "Perlin Color "                       , new String[] {"Geometric", "Circles", "Red", "Random", "Slow"}                                      );
  animationAttributes = registerAttribute(animationAttributes, 318, "Wind particles"                      , new String[] {"Atmospheric", "Smooth", "Red", "Evolving"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 319, "Rorschach 1"                         , new String[] {"Random", "Complex", "Fast", "Smooth", "Red", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 320, "Rorschach 2"                         , new String[] {"Random", "Complex", "Fast", "Smooth", "Red", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 321, "Rorschach 3"                         , new String[] {"Random", "Complex", "Fast", "Smooth", "Red", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 322, "Rorschach 4"                         , new String[] {"Random", "Complex", "Fast", "Smooth", "Red", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 323, "Rorschach 5"                         , new String[] {"Random", "Complex", "Fast", "Smooth", "Red", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 324, "RorschachSetColor"                   , new String[] {"Special", "Random", "Complex", "Fast", "Smooth", "Red", "B&W"}                       );
  animationAttributes = registerAttribute(animationAttributes, 325, "RorschachSetBlack&White"             , new String[] {"Special", "Random", "Complex", "Fast", "Smooth", "Red", "B&W"}                       );
  animationAttributes = registerAttribute(animationAttributes, 326, "Progressive Red"                     , new String[] {"Fade In/Out", "Atmospheric", "Slow", "Red"}                                          );
  animationAttributes = registerAttribute(animationAttributes, 327, "Weird Square"                        , new String[] {"Atmospheric", "Slow", "Red"}                                                         );
  animationAttributes = registerAttribute(animationAttributes, 328, "Light Blobs"                         , new String[] {"Objects", "Circles", "Atmospheric", "Red"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 329, "Red Meta Balls"                      , new String[] {"Objects", "Circles", "Atmospheric", "Red"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 330, "Reverse Triangles"                   , new String[] {"Geometric", "Fast", "Red", "Rhythmic", "Violent"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 331, "3D Big Ass Cube"                     , new String[] {"3D", "Slow", "Red", "Rhythmic"}                                                      );
  animationAttributes = registerAttribute(animationAttributes, 332, "3D Corner Cube"                      , new String[] {"3D", "Slow", "Red", "Rhythmic"}                                                      );
  animationAttributes = registerAttribute(animationAttributes, 333, "3D Glitch Cube"                      , new String[] {"3D", "Slow", "Red", "Rhythmic", "Violent"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 334, "3D No Glitch Cube"                   , new String[] {"3D", "Slow", "Red", "Rhythmic"}                                                      );
  animationAttributes = registerAttribute(animationAttributes, 335, "3D Jerky Cube"                       , new String[] {"3D", "Slow", "B&W", "Rhythmic", "Violent"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 336, "3D Moving Jerky Cube"                , new String[] {"3D", "Slow", "B&W", "Rhythmic", "Violent"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 337, "3D Double Cube"                      , new String[] {"3D", "Slow", "Red", "Rhythmic", "Violent"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 338, "3D Single Pyramid"                   , new String[] {"3D", "Slow", "B&W", "Rhythmic"}                                                      );
  animationAttributes = registerAttribute(animationAttributes, 339, "3D Multiple Pyramids"                , new String[] {"3D", "Slow", "Red", "Rhythmic"}                                                      );
  animationAttributes = registerAttribute(animationAttributes, 340, "Energy Grid"                         , new String[] {"Atmospheric", "Rhythmic", "Geometric", "Triangles", "Red", "Fast", "Rotating"}       );
  animationAttributes = registerAttribute(animationAttributes, 341, "Random Paint"                        , new String[] {"Atmospheric", "Smooth", "Random", "Red"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 342, "Red Wave"                            , new String[] {"Atmospheric", "Smooth", "Slow", "Red"}                                               );
  animationAttributes = registerAttribute(animationAttributes, 343, "Diagonal Color"                      , new String[] {"Atmospheric", "Geometric", "Smooth", "Slow", "Colorful"}                             );
  animationAttributes = registerAttribute(animationAttributes, 344, "Scope"                               , new String[] {"Geometric", "Circles", "Fast", "Rotating", "Evolving", "Red"}                        );
  animationAttributes = registerAttribute(animationAttributes, 345, "SquareWaveGenerator"                 , new String[] {"Lines", "Rhythmic", "Smooth", "Red"}                                                 );
  animationAttributes = registerAttribute(animationAttributes, 346, "Falling Circles"                     , new String[] {"Atmospheric", "Circles", "Slow", "Blue"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 347, "Set Exploding Particles"             , new String[] {"Geometric", "Circles", "Evolving", "Rhythmic", "Blue"}                               );
  animationAttributes = registerAttribute(animationAttributes, 348, "Release Exploding Particles"         , new String[] {"Geometric", "Circles", "Evolving", "Rhythmic", "Blue"}                               );
  animationAttributes = registerAttribute(animationAttributes, 349, "Tesselate"                           , new String[] {"Geometric", "Squares", "Red", "Blue"}                                                );
  animationAttributes = registerAttribute(animationAttributes, 350, "Patchwork"                           , new String[] {"Atmospheric", "Fast", "Rectangles", "Colorful", "Fast"}                              );
  animationAttributes = registerAttribute(animationAttributes, 351, "Vines"                               , new String[] {"Objects", "Lines", "Fast", "Red", "Evolving"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 352, "Night Road"                          , new String[] {"Geometric", "Lines", "Rhythmic", "Blue"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 353, "Slasher"                             , new String[] {"Geometric", "Lines", "Objects", "Fast", "Colorful", "Rhythmic"}                      );
  animationAttributes = registerAttribute(animationAttributes, 354, "Color Beat"                          , new String[] {"Geometric", "Lines", "Colorful", "Fast", "Rhythmic"}                                 );
  animationAttributes = registerAttribute(animationAttributes, 355, "Color Beat Stroboline"               , new String[] {"Geometric", "Lines", "Colorful", "Fast", "Violent"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 356, "Color Beat White Strobo Triangle"    , new String[] {"Geometric", "Triangles", "B&W", "Fast", "Violent"}                                   );
  animationAttributes = registerAttribute(animationAttributes, 357, "Color Beat Transition"               , new String[] {"Fade In/Out", "Lines", "Colorful", "Fast"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 358, "Neko Jiru"                           , new String[] {"Special", "Video", "Simple", "Colorful"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 359, "Letter Explode"                      , new String[] {"Special", "Objects", "Fast", "B&W", "Red"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 360, "Rotozoom White"                      , new String[] {"Atmospheric", "Complex", "Fast", "Rotating", "B&W"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 361, "Rotozoom 1"                          , new String[] {"Atmospheric", "Rotating", "Complex", "Red"}                                          );
  animationAttributes = registerAttribute(animationAttributes, 362, "Rotozoom 2"                          , new String[] {"Atmospheric", "Rotating", "Complex", "Red"}                                          );
  animationAttributes = registerAttribute(animationAttributes, 363, "Rotozoom 3"                          , new String[] {"Atmospheric", "Rotating", "Complex", "Red"}                                          );
  animationAttributes = registerAttribute(animationAttributes, 364, "Spiraluality"                        , new String[] {"Rotating", "Smooth", "Slow", "Red", "Spiral", "Evolving"}                            );
  animationAttributes = registerAttribute(animationAttributes, 365, "Rotating Half Circle"                , new String[] {"Atmospheric", "Red", "Complex", "Slow", "Smooth", "Rotating"}                        );
  animationAttributes = registerAttribute(animationAttributes, 366, "Sliced Wave - White"                 , new String[] {"Atmospheric", "White", "Circles", "Rhythmic"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 367, "Sliced Wave - Red"                   , new String[] {"Atmospheric", "Red", "Circles", "Rhythmic"}                                          );
  animationAttributes = registerAttribute(animationAttributes, 368, "Arc Wave"                            , new String[] {"Objects", "Circles", "Geometric", "B&W"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 369, "Red Sun"                             , new String[] {"Atmospheric", "Red", "Circles", "Rhythmic"}                                          );
  animationAttributes = registerAttribute(animationAttributes, 370, "Arc Rot Green"                       , new String[] {"Atmospheric", "Rhythmic", "Geometric", "Circles", "Slow", "Colorful", "Rotating"}    );
  animationAttributes = registerAttribute(animationAttributes, 371, "Arc Rot Red"                         , new String[] {"Atmospheric", "Rhythmic", "Geometric", "Circles", "Slow", "Red", "Rotating"}         );
  animationAttributes = registerAttribute(animationAttributes, 372, "Hypno Pendulum"                      , new String[] {"Spiral", "Red", "Lines", "Geometric"}                                                );
  animationAttributes = registerAttribute(animationAttributes, 373, "LargeWheel Pendulum"                 , new String[] {"Spiral", "Red", "Lines", "Geometric"}                                                );
  animationAttributes = registerAttribute(animationAttributes, 374, "Single Square Spiral"                , new String[] {"Geometric", "Spiral", "Rotating", "Red"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 375, "Dual Square Spiral"                  , new String[] {"Geometric", "Spiral", "Rotating", "Red"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 376, "Complex Spiral Reinit"               , new String[] {"Atmospheric", "Spiral", "Rotating", "Complex", "Red"}                                );
  animationAttributes = registerAttribute(animationAttributes, 377, "Complex Spiral"                      , new String[] {"Atmospheric", "Spiral", "Rotating", "Complex", "Red"}                                );
  animationAttributes = registerAttribute(animationAttributes, 378, "Outward Spiral White"                , new String[] {"Fade In/Out", "Spiral", "Slow", "Evolving", "B&W"}                                   );
  animationAttributes = registerAttribute(animationAttributes, 379, "Outward Spiral Blue"                 , new String[] {"Fade In/Out", "Spiral", "Slow", "Evolving", "Blue"}                                  );
  animationAttributes = registerAttribute(animationAttributes, 380, "Outward Spiral Red"                  , new String[] {"Fade In/Out", "Spiral", "Slow", "Evolving", "Red"}                                   );
  animationAttributes = registerAttribute(animationAttributes, 381, "Fast Outward Spiral Red"             , new String[] {"Spiral", "Circles", "Slow", "Red"}                                                   );
  animationAttributes = registerAttribute(animationAttributes, 382, "Inwards Spiral"                      , new String[] {"Spiral", "Blue", "Lines", "Red", "Geometric"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 383, "Inwards Spiral Reverse"              , new String[] {"Spiral", "Blue", "Lines", "Red", "Geometric"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 384, "Hypno Spiral Red"                    , new String[] {"Spiral", "Fast", "Red"}                                                              );
  animationAttributes = registerAttribute(animationAttributes, 385, "Electric Spiral"                     , new String[] {"Geometric", "Spiral", "Evolving", "Red"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 386, "Cosmo Curve "                        , new String[] {"Geometric", "Spiral", "Red", "Evolving"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 387, "Cosmo Curve Reinit"                  , new String[] {"Spiral", "Red", "Lines", "Complex", "Evolving"}                                      );
  animationAttributes = registerAttribute(animationAttributes, 388, "Kaleido"                             , new String[] {"Geometric", "Circles", "Evolving", "Random", "Red", "Blue", "Complex"}               );
  animationAttributes = registerAttribute(animationAttributes, 389, "Kaleido Inverse"                     , new String[] {"Geometric", "Circles", "Evolving", "Random", "Red", "Blue", "Complex"}               );
  animationAttributes = registerAttribute(animationAttributes, 390, "Revolution Lines"                    , new String[] {"Geometric", "Atmospheric", "Circles", "Colorful", "Fast"}                            );
  animationAttributes = registerAttribute(animationAttributes, 391, "Disco Star"                          , new String[] {"Atmospheric", "Rotating", "Slow", "Colorful"}                                        );
  animationAttributes = registerAttribute(animationAttributes, 392, "Worm Hole"                           , new String[] {"Atmospheric", "Rotating", "Circles", "Lines", "Slow", "Blue", "Evolving", "Rhythmic"});
  animationAttributes = registerAttribute(animationAttributes, 393, "Tetris - 1 player game"              , new String[] {"Game"}                                                                               );
  animationAttributes = registerAttribute(animationAttributes, 394, "Pong - 2 player game"                , new String[] {"Game"}                                                                               );
  animationAttributes = registerAttribute(animationAttributes, 395, "Shift Pixels Up / Slow"              , new String[] {"Special", "Slow", "Rhythmic"}                                                        );
  animationAttributes = registerAttribute(animationAttributes, 396, "Shift Pixels Down / Slow"            , new String[] {"Special", "Slow", "Rhythmic"}                                                        );
  animationAttributes = registerAttribute(animationAttributes, 397, "Shift Pixels Left / Slow"            , new String[] {"Special", "Slow", "Rhythmic"}                                                        );
  animationAttributes = registerAttribute(animationAttributes, 398, "Shift Pixels Right / Slow"           , new String[] {"Special", "Slow", "Rhythmic"}                                                        );
  animationAttributes = registerAttribute(animationAttributes, 399, "Shift Pixels Up / Fast"              , new String[] {"Special", "Fast", "Rhythmic"}                                                        );
  animationAttributes = registerAttribute(animationAttributes, 400, "Shift Pixels Down / Fast"            , new String[] {"Special", "Fast", "Rhythmic"}                                                        );
  animationAttributes = registerAttribute(animationAttributes, 401, "Shift Pixels Left / Fast"            , new String[] {"Special", "Fast", "Rhythmic"}                                                        );
  animationAttributes = registerAttribute(animationAttributes, 402, "Shift Pixels Right / Fast"           , new String[] {"Special", "Fast", "Rhythmic"}                                                        );
  animationAttributes = registerAttribute(animationAttributes, 403, "Shred Pixels Vertical / Slow"        , new String[] {"Special", "Slow", "Rhythmic", "Violent"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 404, "Shred Pixels Horizontal / Slow"      , new String[] {"Special", "Slow", "Rhythmic", "Violent"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 405, "Shred Pixels Vertical / Slow"        , new String[] {"Special", "Fast", "Rhythmic", "Violent"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 406, "Shred Pixels Horizontal / Slow"      , new String[] {"Special", "Fast", "Rhythmic", "Violent"}                                             );
  animationAttributes = registerAttribute(animationAttributes, 407, "Spider Web - White - Manual"         , new String[] {"Geometric", "Simple", "Lines", "B&W", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 408, "Spider Web - Red - Manual"           , new String[] {"Geometric", "Simple", "Lines", "Red", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 409, "Spider Web - White Fade - Manual"    , new String[] {"Geometric", "Simple", "Lines", "B&W", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 410, "Spider Web - Red Fade - Manual"      , new String[] {"Geometric", "Simple", "Lines", "Red", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 411, "Spider Web - White - Audio"          , new String[] {"Geometric", "Simple", "Lines", "B&W", "Rhythmic", "AudioInput"}                      );
  animationAttributes = registerAttribute(animationAttributes, 412, "Woublines - White Inwards"           , new String[] {"Geometric", "Simple", "Lines", "B&W", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 413, "Woublines - White Outwards"          , new String[] {"Geometric", "Simple", "Lines", "B&W", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 414, "Woublines - Red Inwards"             , new String[] {"Geometric", "Simple", "Lines", "Red", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 415, "Woublines - Red Outwards"            , new String[] {"Geometric", "Simple", "Lines", "Red", "Rhythmic"}                                    );
  animationAttributes = registerAttribute(animationAttributes, 416, "Woublines - Audio"                   , new String[] {"Geometric", "Simple", "Lines", "B&W", "Red", "AudioInput"}                           );
  animationAttributes = registerAttribute(animationAttributes, 417, "Audio instant signal - Kick - White" , new String[] {"B&W", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 418, "Audio instant signal - Kick - Red"   , new String[] {"Red", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 419, "Audio instant signal - Snare - White", new String[] {"B&W", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 420, "Audio instant signal - Snare - Red"  , new String[] {"Red", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 421, "Audio instant signal - Cymbals - White",new String[]{"B&W", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 422, "Audio instant signal - Cymbals - Red", new String[] {"Red", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 423, "Audio instant signal - Bass - White" , new String[] {"B&W", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 424, "Audio instant signal - Bass - Red"   , new String[] {"Red", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 425, "Audio instant signal - Keys - White" , new String[] {"B&W", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 426, "Audio instant signal - Keys - Red"   , new String[] {"Red", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 427, "Audio instant signal - Guitar - White",new String[] {"B&W", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 428, "Audio instant signal - Guitar - Red" , new String[] {"Red", "AudioInput"}                                                                  );
  animationAttributes = registerAttribute(animationAttributes, 429, "Simple Spiral - White"               , new String[] {"Circles", "Spiral", "B&W", "Fast"}                                                   );
  animationAttributes = registerAttribute(animationAttributes, 430, "Simple Spiral - Red"                 , new String[] {"Circles", "Spiral", "Red", "Fast"}                                                   );
  animationAttributes = registerAttribute(animationAttributes, 431, "Single Square Spiral - White"        , new String[] {"Geometric", "Spiral", "Rotating", "White"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 432, "Dual Square Spiral - White"          , new String[] {"Geometric", "Spiral", "Rotating", "White"}                                           );
  animationAttributes = registerAttribute(animationAttributes, 433, "TV Power Off"                        , new String[] {"Simple", "Fade In/Out", "White"}                                                     );
  animationAttributes = registerAttribute(animationAttributes, 434, "White Spread - Start"                , new String[] {"Simple", "Fade In/Out", "White"}                                                     );
  animationAttributes = registerAttribute(animationAttributes, 435, "White Spread - End"                  , new String[] {"Simple", "Fade In/Out", "White"}                                                     );  
  animationAttributes = registerAttribute(animationAttributes, 509, "Audio Monitoring"                    , new String[] {"Atmospheric", "Red", "Circles", "Rhythmic", "AudioInput"}                            );
  animationAttributes = registerAttribute(animationAttributes, 510, "Display FFT - Bass"                  , new String[] {"Geometric", "Simple", "AudioInput"}                                                  );  
}


void setCustomDevicesActionsAttributes() {
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 1,   "All Devices - Blackout"                             , new String[] { "All Devices", "Black", "Plain"                          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 2,   "Rack Lights - Blackout"                             , new String[] { "Rack Lights", "Black", "Plain"                          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 3,   "LED Tubes   - Blackout"                             , new String[] { "LED Tubes",   "Black", "Plain"                          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 4,   "All Devices - Whiteout"                             , new String[] { "All Devices", "White", "Plain"                          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 5,   "Rack Lights - Whiteout"                             , new String[] { "Rack Lights", "White", "Plain"                          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 6,   "LED Tubes   - Whiteout"                             , new String[] { "LED Tubes",   "White", "Plain"                          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 7,   "All Devices - Redout"                               , new String[] { "All Devices", "Red", "Plain"                            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 8,   "Rack Lights - Redout"                               , new String[] { "Rack Lights", "Red", "Plain"                            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 9,   "LED Tubes   - Redout"                               , new String[] { "LED Tubes",   "Red", "Plain"                            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 10,  "All Devices - Blueout"                              , new String[] { "All Devices", "Blue", "Plain"                           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 11,  "Rack Lights - Blueout"                              , new String[] { "Rack Lights", "Blue", "Plain"                           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 12,  "LED Tubes   - Blueout"                              , new String[] { "LED Tubes",   "Blue", "Plain"                           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 13,  "All Devices - Rainbowout"                           , new String[] { "All Devices", "Rainbow", "Plain"                        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 14,  "Rack Lights - Rainbowout"                           , new String[] { "Rack Lights", "Rainbow", "Plain"                        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 15,  "LED Tubes   - Rainbowout"                           , new String[] { "LED Tubes",   "Rainbow", "Plain"                        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 16,  "All Devices - Single WhiteOut"                      , new String[] { "All Devices", "Random", "White", "Plain"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 17,  "LED Tubes   - Single WhiteOut"                      , new String[] { "LED Tubes",   "Random", "White", "Plain"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 18,  "All Devices - Single RedOut"                        , new String[] { "All Devices", "Random", "Red", "Plain"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 19,  "LED Tubes   - Single RedOut"                        , new String[] { "LED Tubes",   "Random", "Red", "Plain"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 20,  "All Devices - Single BlueOut"                       , new String[] { "All Devices", "Random", "Blue", "Plain"                 } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 21,  "LED Tubes   - Single BlueOut"                       , new String[] { "LED Tubes",   "Random", "Blue", "Plain"                 } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 22,  "All Devices - Single RainbowOut"                    , new String[] { "All Devices", "Random", "Rainbow", "Plain"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 23,  "LED Tubes   - Single RainbowOut"                    , new String[] { "LED Tubes",   "Random", "Rainbow", "Plain"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 24,  "All Devices - Fast White Flash"                     , new String[] { "All Devices", "Fast", "White", "Flash"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 25,  "LED Tubes   - Fast White Flash"                     , new String[] { "LED Tubes",   "Fast", "White", "Flash"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 26,  "Rack Lights - Fast White Flash"                     , new String[] { "Rack Lights", "Fast", "White", "Flash"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 27,  "All Devices - Fast Red Flash"                       , new String[] { "All Devices", "Fast", "Red", "Flash"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 28,  "LED Tubes   - Fast Red Flash"                       , new String[] { "LED Tubes",   "Fast", "Red", "Flash"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 29,  "Rack Lights - Fast Red Flash"                       , new String[] { "Rack Lights", "Fast", "Red", "Flash"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 30,  "All Devices - Fast Blue Flash"                      , new String[] { "All Devices", "Fast", "Blue", "Flash"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 31,  "LED Tubes   - Fast Blue Flash"                      , new String[] { "LED Tubes",   "Fast", "Blue", "Flash"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 32,  "Rack Lights - Fast Blue Flash"                      , new String[] { "Rack Lights", "Fast", "Blue", "Flash"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 33,  "All Devices - Fast Rainbow Flash"                   , new String[] { "All Devices", "Fast", "Rainbow", "Flash"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 34,  "LED Tubes   - Fast Rainbow Flash"                   , new String[] { "LED Tubes",   "Fast", "Rainbow", "Flash"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 35,  "Rack Lights - Fast Rainbow Flash"                   , new String[] { "Rack Lights", "Fast", "Rainbow", "Flash"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 36,  "All Devices - Single Fast White Flash"              , new String[] { "All Devices", "Random", "Fast", "White", "Flash"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 37,  "LED Tubes   - Single Fast White Flash"              , new String[] { "LED Tubes",   "Random", "Fast", "White", "Flash"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 38,  "All Devices - Single Fast Red Flash"                , new String[] { "All Devices", "Random", "Fast", "Red", "Flash"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 39,  "LED Tubes   - Single Fast Red Flash"                , new String[] { "LED Tubes",   "Random", "Fast", "Red", "Flash"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 40,  "All Devices - Single Fast Blue Flash"               , new String[] { "All Devices", "Random", "Fast", "Blue", "Flash"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 41,  "LED Tubes   - Single Fast Blue Flash"               , new String[] { "LED Tubes",   "Random", "Fast", "Blue", "Flash"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 42,  "All Devices - Single Fast Rainbow Flash"            , new String[] { "All Devices", "Random", "Fast", "Rainbow", "Flash"      } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 43,  "LED Tubes   - Single Fast Rainbow Flash"            , new String[] { "LED Tubes",   "Random", "Fast", "Rainbow", "Flash"      } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 44,  "All Devices - Slow White Flash"                     , new String[] { "All Devices", "Slow", "White", "Flash"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 45,  "LED Tubes   - Slow White Flash"                     , new String[] { "LED Tubes",   "Slow", "White", "Flash"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 46,  "Rack Lights - Slow White Flash"                     , new String[] { "Rack Lights", "Slow", "White", "Flash"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 47,  "All Devices - Slow Red Flash"                       , new String[] { "All Devices", "Slow", "Red", "Flash"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 48,  "LED Tubes   - Slow Red Flash"                       , new String[] { "LED Tubes",   "Slow", "Red", "Flash"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 49,  "Rack Lights - Slow Red Flash"                       , new String[] { "Rack Lights", "Slow", "Red", "Flash"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 50,  "All Devices - Slow Blue Flash"                      , new String[] { "All Devices", "Slow", "Blue", "Flash"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 51,  "LED Tubes   - Slow Blue Flash"                      , new String[] { "LED Tubes",   "Slow", "Blue", "Flash"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 52,  "Rack Lights - Slow Blue Flash"                      , new String[] { "Rack Lights", "Slow", "Blue", "Flash"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 53,  "All Devices - Slow Rainbow Flash"                   , new String[] { "All Devices", "Slow", "Rainbow", "Flash"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 54,  "LED Tubes   - Slow Rainbow Flash"                   , new String[] { "LED Tubes",   "Slow", "Rainbow", "Flash"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 55,  "Rack Lights - Slow Rainbow Flash"                   , new String[] { "Rack Lights", "Slow", "Rainbow", "Flash"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 56,  "All Devices - Single Slow White Flash"              , new String[] { "All Devices", "Random", "Slow", "White", "Flash"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 57,  "LED Tubes   - Single Slow White Flash"              , new String[] { "LED Tubes",   "Random", "Slow", "White", "Flash"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 58,  "All Devices - Single Slow Red Flash"                , new String[] { "All Devices", "Random", "Slow", "Red", "Flash"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 59,  "LED Tubes   - Single Slow Red Flash"                , new String[] { "LED Tubes",   "Random", "Slow", "Red", "Flash"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 60,  "All Devices - Single Slow Blue Flash"               , new String[] { "All Devices", "Random", "Slow", "Blue", "Flash"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 61,  "LED Tubes   - Single Slow Blue Flash"               , new String[] { "LED Tubes",   "Random", "Slow", "Blue", "Flash"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 62,  "All Devices - Single Slow Rainbow Flash"            , new String[] { "All Devices", "Random", "Slow", "Rainbow", "Flash"      } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 63,  "LED Tubes   - Single Slow Rainbow Flash"            , new String[] { "LED Tubes",   "Random", "Slow", "Rainbow", "Flash"      } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 64,  "All Devices - Slow White Smooth Sine"               , new String[] { "All Devices", "Slow", "White", "Smooth Sine"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 65,  "Rack Lights - Slow White Smooth Sine"               , new String[] { "Rack Lights", "Slow", "White", "Smooth Sine"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 66,  "LED Tubes   - Slow White Smooth Sine"               , new String[] { "LED Tubes",   "Slow", "White", "Smooth Sine"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 67,  "All Devices - Slow Red Smooth Sine"                 , new String[] { "All Devices", "Slow", "Red", "Smooth Sine"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 68,  "Rack Lights - Slow Red Smooth Sine"                 , new String[] { "Rack Lights", "Slow", "Red", "Smooth Sine"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 69,  "LED Tubes   - Slow Red Smooth Sine"                 , new String[] { "LED Tubes",   "Slow", "Red", "Smooth Sine"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 70,  "All Devices - Slow Blue Smooth Sine"                , new String[] { "All Devices", "Slow", "Blue", "Smooth Sine"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 71,  "Rack Lights - Slow Blue Smooth Sine"                , new String[] { "Rack Lights", "Slow", "Blue", "Smooth Sine"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 72,  "LED Tubes   - Slow Blue Smooth Sine"                , new String[] { "LED Tubes",   "Slow", "Blue", "Smooth Sine"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 73,  "All Devices - Slow Rainbow Smooth Sine"             , new String[] { "All Devices", "Slow", "Rainbow", "Smooth Sine"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 74,  "Rack Lights - Slow Rainbow Smooth Sine"             , new String[] { "Rack Lights", "Slow", "Rainbow", "Smooth Sine"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 75,  "LED Tubes   - Slow Rainbow Smooth Sine"             , new String[] { "LED Tubes",   "Slow", "Rainbow", "Smooth Sine"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 76,  "All Devices - Single Slow White Smooth Sine"        , new String[] { "All Devices", "Random", "Slow", "White", "Smooth Sine"  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 77,  "LED Tubes   - Single Slow White Smooth Sine"        , new String[] { "LED Tubes",   "Random", "Slow", "White", "Smooth Sine"  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 78,  "All Devices - Single Slow Red Smooth Sine"          , new String[] { "All Devices", "Random", "Slow", "Red", "Smooth Sine"    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 79,  "LED Tubes   - Single Slow Red Smooth Sine"          , new String[] { "LED Tubes",   "Random", "Slow", "Red", "Smooth Sine"    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 80,  "All Devices - Single Slow Blue Smooth Sine"         , new String[] { "All Devices", "Random", "Slow", "Blue", "Smooth Sine"   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 81,  "LED Tubes   - Single Slow Blue Smooth Sine"         , new String[] { "LED Tubes",   "Random", "Slow", "Blue", "Smooth Sine"   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 82,  "All Devices - Single Slow Rainbow Smooth Sine"      , new String[] { "All Devices", "Random", "Slow", "Rainbow", "Smooth Sine"} );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 83,  "LED Tubes   - Single Slow Rainbow Smooth Sine"      , new String[] { "LED Tubes",   "Random", "Slow", "Rainbow", "Smooth Sine"} );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 84,  "All Devices - Fast White Smooth Sine"               , new String[] { "All Devices", "Fast", "White", "Smooth Sine"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 85,  "Rack Lights - Fast White Smooth Sine"               , new String[] { "Rack Lights", "Fast", "White", "Smooth Sine"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 86,  "LED Tubes   - Fast White Smooth Sine"               , new String[] { "LED Tubes",   "Fast", "White", "Smooth Sine"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 87,  "All Devices - Fast Red Smooth Sine"                 , new String[] { "All Devices", "Fast", "Red", "Smooth Sine"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 88,  "Rack Lights - Fast Red Smooth Sine"                 , new String[] { "Rack Lights", "Fast", "Red", "Smooth Sine"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 89,  "LED Tubes   - Fast Red Smooth Sine"                 , new String[] { "LED Tubes",   "Fast", "Red", "Smooth Sine"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 90,  "All Devices - Fast Blue Smooth Sine"                , new String[] { "All Devices", "Fast", "Blue", "Smooth Sine"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 91,  "Rack Lights - Fast Blue Smooth Sine"                , new String[] { "Rack Lights", "Fast", "Blue", "Smooth Sine"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 92,  "LED Tubes   - Fast Blue Smooth Sine"                , new String[] { "LED Tubes",   "Fast", "Blue", "Smooth Sine"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 93,  "All Devices - Fast Rainbow Smooth Sine"             , new String[] { "All Devices", "Fast", "Rainbow", "Smooth Sine"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 94,  "Rack Lights - Fast Rainbow Smooth Sine"             , new String[] { "Rack Lights", "Fast", "Rainbow", "Smooth Sine"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 95,  "LED Tubes   - Fast Rainbow Smooth Sine"             , new String[] { "LED Tubes",   "Fast", "Rainbow", "Smooth Sine"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 96,  "All Devices - Single Fast White Smooth Sine"        , new String[] { "All Devices", "Random", "Fast", "White", "Smooth Sine"  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 97,  "LED Tubes   - Single Fast White Smooth Sine"        , new String[] { "LED Tubes",   "Random", "Fast", "White", "Smooth Sine"  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 98,  "All Devices - Single Fast Red Smooth Sine"          , new String[] { "All Devices", "Random", "Fast", "Red", "Smooth Sine"    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 99,  "LED Tubes   - Single Fast Red Smooth Sine"          , new String[] { "LED Tubes",   "Random", "Fast", "Red", "Smooth Sine"    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 100, "All Devices - Single Fast Blue Smooth Sine"         , new String[] { "All Devices", "Random", "Fast", "Blue", "Smooth Sine"   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 101, "LED Tubes   - Single Fast Blue Smooth Sine"         , new String[] { "LED Tubes",   "Random", "Fast", "Blue", "Smooth Sine"   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 102, "All Devices - Single Fast Rainbow Smooth Sine"      , new String[] { "All Devices", "Random", "Fast", "Rainbow", "Smooth Sine"} );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 103, "LED Tubes   - Single Fast Rainbow Smooth Sine"      , new String[] { "LED Tubes",   "Random", "Fast", "Rainbow", "Smooth Sine"} );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 104, "All Devices - Fast White Stroboscope"               , new String[] { "All Devices", "Fast", "White", "Stroboscope"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 105, "LED Tubes   - Fast White Stroboscope"               , new String[] { "LED Tubes",   "Fast", "White", "Stroboscope"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 106, "Rack Lights - Fast White Stroboscope"               , new String[] { "Rack Lights", "Fast", "White", "Stroboscope"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 107, "All Devices - Fast Red Stroboscope"                 , new String[] { "All Devices", "Fast", "Red", "Stroboscope"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 108, "LED Tubes   - Fast Red Stroboscope"                 , new String[] { "LED Tubes",   "Fast", "Red", "Stroboscope"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 109, "Rack Lights - Fast Red Stroboscope"                 , new String[] { "Rack Lights", "Fast", "Red", "Stroboscope"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 110, "All Devices - Fast Blue Stroboscope"                , new String[] { "All Devices", "Fast", "Blue", "Stroboscope"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 111, "LED Tubes   - Fast Blue Stroboscope"                , new String[] { "LED Tubes",   "Fast", "Blue", "Stroboscope"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 112, "Rack Lights - Fast Blue Stroboscope"                , new String[] { "Rack Lights", "Fast", "Blue", "Stroboscope"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 113, "All Devices - Fast Random Color Stroboscope"        , new String[] { "All Devices", "Fast", "Rainbow", "Stroboscope"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 114, "LED Tubes   - Fast Random Color Stroboscope"        , new String[] { "LED Tubes",   "Fast", "Rainbow", "Stroboscope"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 115, "Rack Lights - Fast Random Color Stroboscope"        , new String[] { "Rack Lights", "Fast", "Rainbow", "Stroboscope"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 116, "All Devices - Medium White Stroboscope"             , new String[] { "All Devices", "Medium", "White", "Stroboscope"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 117, "LED Tubes   - Medium White Stroboscope"             , new String[] { "LED Tubes",   "Medium", "White", "Stroboscope"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 118, "Rack Lights - Medium White Stroboscope"             , new String[] { "Rack Lights", "Medium", "White", "Stroboscope"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 119, "All Devices - Medium Red Stroboscope"               , new String[] { "All Devices", "Medium", "Red", "Stroboscope"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 120, "LED Tubes   - Medium Red Stroboscope"               , new String[] { "LED Tubes",   "Medium", "Red", "Stroboscope"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 121, "Rack Lights - Medium Red Stroboscope"               , new String[] { "Rack Lights", "Medium", "Red", "Stroboscope"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 122, "All Devices - Medium Blue Stroboscope"              , new String[] { "All Devices", "Medium", "Blue", "Stroboscope"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 123, "LED Tubes   - Medium Blue Stroboscope"              , new String[] { "LED Tubes",   "Medium", "Blue", "Stroboscope"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 124, "Rack Lights - Medium Blue Stroboscope"              , new String[] { "Rack Lights", "Medium", "Blue", "Stroboscope"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 125, "All Devices - Medium Random Color Stroboscope"      , new String[] { "All Devices", "Medium", "Rainbow", "Stroboscope"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 126, "LED Tubes   - Medium Random Color Stroboscope"      , new String[] { "LED Tubes",   "Medium", "Rainbow", "Stroboscope"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 127, "Rack Lights - Medium Random Color Stroboscope"      , new String[] { "Rack Lights", "Medium", "Rainbow", "Stroboscope"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 128, "All Devices - Slow White Stroboscope"               , new String[] { "All Devices", "Slow", "White", "Stroboscope"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 129, "LED Tubes   - Slow White Stroboscope"               , new String[] { "LED Tubes",   "Slow", "White", "Stroboscope"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 130, "Rack Lights - Slow White Stroboscope"               , new String[] { "Rack Lights", "Slow", "White", "Stroboscope"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 131, "All Devices - Slow Red Stroboscope"                 , new String[] { "All Devices", "Slow", "Red", "Stroboscope"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 132, "LED Tubes   - Slow Red Stroboscope"                 , new String[] { "LED Tubes",   "Slow", "Red", "Stroboscope"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 133, "Rack Lights - Slow Red Stroboscope"                 , new String[] { "Rack Lights", "Slow", "Red", "Stroboscope"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 134, "All Devices - Slow Blue Stroboscope"                , new String[] { "All Devices", "Slow", "Blue", "Stroboscope"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 135, "LED Tubes   - Slow Blue Stroboscope"                , new String[] { "LED Tubes",   "Slow", "Blue", "Stroboscope"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 136, "Rack Lights - Slow Blue Stroboscope"                , new String[] { "Rack Lights", "Slow", "Blue", "Stroboscope"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 137, "All Devices - Slow Random Color Stroboscope"        , new String[] { "All Devices", "Slow", "Rainbow", "Stroboscope"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 138, "LED Tubes   - Slow Random Color Stroboscope"        , new String[] { "LED Tubes",   "Slow", "Rainbow", "Stroboscope"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 139, "Rack Lights - Slow Random Color Stroboscope"        , new String[] { "Rack Lights", "Slow", "Rainbow", "Stroboscope"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 140, "All Devices - Very Slow White Stroboscope"          , new String[] { "All Devices", "Very Slow", "White", "Stroboscope"       } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 141, "LED Tubes   - Very Slow White Stroboscope"          , new String[] { "LED Tubes",   "Very Slow", "White", "Stroboscope"       } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 142, "Rack Lights - Very Slow White Stroboscope"          , new String[] { "Rack Lights", "Very Slow", "White", "Stroboscope"       } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 143, "All Devices - Very Slow Red Stroboscope"            , new String[] { "All Devices", "Very Slow", "Red", "Stroboscope"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 144, "LED Tubes   - Very Slow Red Stroboscope"            , new String[] { "LED Tubes",   "Very Slow", "Red", "Stroboscope"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 145, "Rack Lights - Very Slow Red Stroboscope"            , new String[] { "Rack Lights", "Very Slow", "Red", "Stroboscope"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 146, "All Devices - Very Slow Blue Stroboscope"           , new String[] { "All Devices", "Very Slow", "Blue", "Stroboscope"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 147, "LED Tubes   - Very Slow Blue Stroboscope"           , new String[] { "LED Tubes",   "Very Slow", "Blue", "Stroboscope"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 148, "Rack Lights - Very Slow Blue Stroboscope"           , new String[] { "Rack Lights", "Very Slow", "Blue", "Stroboscope"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 149, "All Devices - Very Slow Random Color Stroboscope"   , new String[] { "All Devices", "Very Slow", "Rainbow", "Stroboscope"     } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 150, "LED Tubes   - Very Slow Random Color Stroboscope"   , new String[] { "LED Tubes",   "Very Slow", "Rainbow", "Stroboscope"     } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 151, "Rack Lights - Very Slow Random Color Stroboscope"   , new String[] { "Rack Lights", "Very Slow", "Rainbow", "Stroboscope"     } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 152, "All Devices - Fast White Growing Stroboscope"       , new String[] { "All Devices", "Fast", "White", "Growing Strobe"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 153, "LED Tubes   - Fast White Growing Stroboscope"       , new String[] { "LED Tubes",   "Fast", "White", "Growing Strobe"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 154, "Rack Lights - Fast White Growing Stroboscope"       , new String[] { "Rack Lights", "Fast", "White", "Growing Strobe"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 155, "All Devices - Fast Red Growing Stroboscope"         , new String[] { "All Devices", "Fast", "Red", "Growing Strobe"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 156, "LED Tubes   - Fast Red Growing Stroboscope"         , new String[] { "LED Tubes",   "Fast", "Red", "Growing Strobe"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 157, "Rack Lights - Fast Red Growing Stroboscope"         , new String[] { "Rack Lights", "Fast", "Red", "Growing Strobe"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 158, "All Devices - Medium White Growing Stroboscope"     , new String[] { "All Devices", "Medium", "White", "Growing Strobe"       } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 159, "LED Tubes   - Medium White Growing Stroboscope"     , new String[] { "LED Tubes",   "Medium", "White", "Growing Strobe"       } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 160, "Rack Lights - Medium White Growing Stroboscope"     , new String[] { "Rack Lights", "Medium", "White", "Growing Strobe"       } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 161, "All Devices - Medium Red Growing Stroboscope"       , new String[] { "All Devices", "Medium", "Red", "Growing Strobe"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 162, "LED Tubes   - Medium Red Growing Stroboscope"       , new String[] { "LED Tubes",   "Medium", "Red", "Growing Strobe"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 163, "Rack Lights - Medium Red Growing Stroboscope"       , new String[] { "Rack Lights", "Medium", "Red", "Growing Strobe"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 164, "All Devices - Slow White Growing Stroboscope"       , new String[] { "All Devices", "Slow", "White", "Growing Strobe"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 165, "LED Tubes   - Slow White Growing Stroboscope"       , new String[] { "LED Tubes",   "Slow", "White", "Growing Strobe"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 166, "Rack Lights - Slow White Growing Stroboscope"       , new String[] { "Rack Lights", "Slow", "White", "Growing Strobe"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 167, "All Devices - Slow Red Growing Stroboscope"         , new String[] { "All Devices", "Slow", "Red", "Growing Strobe"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 168, "LED Tubes   - Slow Red Growing Stroboscope"         , new String[] { "LED Tubes",   "Slow", "Red", "Growing Strobe"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 169, "Rack Lights - Slow Red Growing Stroboscope"         , new String[] { "Rack Lights", "Slow", "Red", "Growing Strobe"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 170, "All Devices - Very Slow White Growing Stroboscope"  , new String[] { "All Devices", "Very Slow", "White", "Growing Strobe"    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 171, "LED Tubes   - Very Slow White Growing Stroboscope"  , new String[] { "LED Tubes",   "Very Slow", "White", "Growing Strobe"    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 172, "Rack Lights - Very Slow White Growing Stroboscope"  , new String[] { "Rack Lights", "Very Slow", "White", "Growing Strobe"    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 173, "All Devices - Very Slow Red Growing Stroboscope"    , new String[] { "All Devices", "Very Slow", "Red", "Growing Strobe"      } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 174, "LED Tubes   - Very Slow Red Growing Stroboscope"    , new String[] { "LED Tubes",   "Very Slow", "Red", "Growing Strobe"      } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 175, "Rack Lights - Very Slow Red Growing Stroboscope"    , new String[] { "Rack Lights", "Very Slow", "Red", "Growing Strobe"      } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 176, "All Devices - Long White Upward Single Wave"        , new String[] { "All Devices", "Long", "White", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 177, "LED Tubes   - Long White Upward Single Wave"        , new String[] { "LED Tubes",   "Long", "White", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 178, "Rack Lights - Long White Upward Single Wave"        , new String[] { "Rack Lights", "Long", "White", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 179, "All Devices - Long Red Upward Single Wave"          , new String[] { "All Devices", "Long", "Red", "Wave"                     } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 180, "LED Tubes   - Long Red Upward Single Wave"          , new String[] { "LED Tubes",   "Long", "Red", "Wave"                     } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 181, "Rack Lights - Long Red Upward Single Wave"          , new String[] { "Rack Lights", "Long", "Red", "Wave"                     } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 182, "All Devices - Long Blue Upward Single Wave"         , new String[] { "All Devices", "Long", "Blue", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 183, "LED Tubes   - Long Blue Upward Single Wave"         , new String[] { "LED Tubes",   "Long", "Blue", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 184, "Rack Lights - Long Blue Upward Single Wave"         , new String[] { "Rack Lights", "Long", "Blue", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 185, "All Devices - Short White Upward Single Wave"       , new String[] { "All Devices", "Short", "White", "Wave"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 186, "LED Tubes   - Short White Upward Single Wave"       , new String[] { "LED Tubes",   "Short", "White", "Wave"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 187, "Rack Lights - Short White Upward Single Wave"       , new String[] { "Rack Lights", "Short", "White", "Wave"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 188, "All Devices - Short Red Upward Single Wave"         , new String[] { "All Devices", "Short", "Red", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 189, "LED Tubes   - Short Red Upward Single Wave"         , new String[] { "LED Tubes",   "Short", "Red", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 190, "Rack Lights - Short Red Upward Single Wave"         , new String[] { "Rack Lights", "Short", "Red", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 191, "All Devices - Short Blue Upward Single Wave"        , new String[] { "All Devices", "Short", "Blue", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 192, "LED Tubes   - Short Blue Upward Single Wave"        , new String[] { "LED Tubes",   "Short", "Blue", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 193, "Rack Lights - Short Blue Upward Single Wave"        , new String[] { "Rack Lights", "Short", "Blue", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 194, "All Devices - Long White Downward Single Wave"      , new String[] { "All Devices", "Long", "White", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 195, "LED Tubes   - Long White Downward Single Wave"      , new String[] { "LED Tubes",   "Long", "White", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 196, "Rack Lights - Long White Downward Single Wave"      , new String[] { "Rack Lights", "Long", "White", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 197, "All Devices - Long Red Downward Single Wave"        , new String[] { "All Devices", "Long", "Red", "Wave"                     } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 198, "LED Tubes   - Long Red Downward Single Wave"        , new String[] { "LED Tubes",   "Long", "Red", "Wave"                     } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 199, "Rack Lights - Long Red Downward Single Wave"        , new String[] { "Rack Lights", "Long", "Red", "Wave"                     } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 200, "All Devices - Long Blue Downward Single Wave"       , new String[] { "All Devices", "Long", "Blue", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 201, "LED Tubes   - Long Blue Downward Single Wave"       , new String[] { "LED Tubes",   "Long", "Blue", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 202, "Rack Lights - Long Blue Downward Single Wave"       , new String[] { "Rack Lights", "Long", "Blue", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 203, "All Devices - Short White Downward Single Wave"     , new String[] { "All Devices", "Short", "White", "Wave"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 204, "LED Tubes   - Short White Downward Single Wave"     , new String[] { "LED Tubes",   "Short", "White", "Wave"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 205, "Rack Lights - Short White Downward Single Wave"     , new String[] { "Rack Lights", "Short", "White", "Wave"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 206, "All Devices - Short Red Downward Single Wave"       , new String[] { "All Devices", "Short", "Red", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 207, "LED Tubes   - Short Red Downward Single Wave"       , new String[] { "LED Tubes",   "Short", "Red", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 208, "Rack Lights - Short Red Downward Single Wave"       , new String[] { "Rack Lights", "Short", "Red", "Wave"                    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 209, "All Devices - Short Blue Downward Single Wave"      , new String[] { "All Devices", "Short", "Blue", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 210, "LED Tubes   - Short Blue Downward Single Wave"      , new String[] { "LED Tubes",   "Short", "Blue", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 211, "Rack Lights - Short Blue Downward Single Wave"      , new String[] { "Rack Lights", "Short", "Blue", "Wave"                   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 212, "All Devices - Fast White BuildUp"                   , new String[] { "All Devices", "Fast", "White", "BuildUp"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 213, "LED Tubes   - Fast White BuildUp"                   , new String[] { "LED Tubes",   "Fast", "White", "BuildUp"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 214, "Rack Lights - Fast White BuildUp"                   , new String[] { "Rack Lights", "Fast", "White", "BuildUp"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 215, "All Devices - Fast Red BuildUp"                     , new String[] { "All Devices", "Fast", "Red", "BuildUp"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 216, "LED Tubes   - Fast Red BuildUp"                     , new String[] { "LED Tubes",   "Fast", "Red", "BuildUp"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 217, "Rack Lights - Fast Red BuildUp"                     , new String[] { "Rack Lights", "Fast", "Red", "BuildUp"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 218, "All Devices - Fast Blue BuildUp"                    , new String[] { "All Devices", "Fast", "Blue", "BuildUp"                 } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 219, "LED Tubes   - Fast Blue BuildUp"                    , new String[] { "LED Tubes",   "Fast", "Blue", "BuildUp"                 } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 220, "Rack Lights - Fast Blue BuildUp"                    , new String[] { "Rack Lights", "Fast", "Blue", "BuildUp"                 } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 221, "All Devices - Fast Rainbow BuildUp"                 , new String[] { "All Devices", "Fast", "Rainbow", "BuildUp"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 222, "LED Tubes   - Fast Rainbow BuildUp"                 , new String[] { "LED Tubes",   "Fast", "Rainbow", "BuildUp"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 223, "Rack Lights - Fast Rainbow BuildUp"                 , new String[] { "Rack Lights", "Fast", "Rainbow", "BuildUp"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 224, "All Devices - Medium White BuildUp"                 , new String[] { "All Devices", "Medium", "White", "BuildUp"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 225, "LED Tubes   - Medium White BuildUp"                 , new String[] { "LED Tubes",   "Medium", "White", "BuildUp"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 226, "Rack Lights - Medium White BuildUp"                 , new String[] { "Rack Lights", "Medium", "White", "BuildUp"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 227, "All Devices - Medium Red BuildUp"                   , new String[] { "All Devices", "Medium", "Red", "BuildUp"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 228, "LED Tubes   - Medium Red BuildUp"                   , new String[] { "LED Tubes",   "Medium", "Red", "BuildUp"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 229, "Rack Lights - Medium Red BuildUp"                   , new String[] { "Rack Lights", "Medium", "Red", "BuildUp"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 230, "All Devices - Medium Blue BuildUp"                  , new String[] { "All Devices", "Medium", "Blue", "BuildUp"               } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 231, "LED Tubes   - Medium Blue BuildUp"                  , new String[] { "LED Tubes",   "Medium", "Blue", "BuildUp"               } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 232, "Rack Lights - Medium Blue BuildUp"                  , new String[] { "Rack Lights", "Medium", "Blue", "BuildUp"               } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 233, "All Devices - Medium Rainbow BuildUp"               , new String[] { "All Devices", "Medium", "Rainbow", "BuildUp"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 234, "LED Tubes   - Medium Rainbow BuildUp"               , new String[] { "LED Tubes",   "Medium", "Rainbow", "BuildUp"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 235, "Rack Lights - Medium Rainbow BuildUp"               , new String[] { "Rack Lights", "Medium", "Rainbow", "BuildUp"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 236, "All Devices - Slow White BuildUp"                   , new String[] { "All Devices", "Slow", "White", "BuildUp"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 237, "LED Tubes   - Slow White BuildUp"                   , new String[] { "LED Tubes",   "Slow", "White", "BuildUp"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 238, "Rack Lights - Slow White BuildUp"                   , new String[] { "Rack Lights", "Slow", "White", "BuildUp"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 239, "All Devices - Slow Red BuildUp"                     , new String[] { "All Devices", "Slow", "Red", "BuildUp"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 240, "LED Tubes   - Slow Red BuildUp"                     , new String[] { "LED Tubes",   "Slow", "Red", "BuildUp"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 241, "Rack Lights - Slow Red BuildUp"                     , new String[] { "Rack Lights", "Slow", "Red", "BuildUp"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 242, "All Devices - Slow Blue BuildUp"                    , new String[] { "All Devices", "Slow", "Blue", "BuildUp"                 } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 243, "LED Tubes   - Slow Blue BuildUp"                    , new String[] { "LED Tubes",   "Slow", "Blue", "BuildUp"                 } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 244, "Rack Lights - Slow Blue BuildUp"                    , new String[] { "Rack Lights", "Slow", "Blue", "BuildUp"                 } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 245, "All Devices - Slow Rainbow BuildUp"                 , new String[] { "All Devices", "Slow", "Rainbow", "BuildUp"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 246, "LED Tubes   - Slow Rainbow BuildUp"                 , new String[] { "LED Tubes",   "Slow", "Rainbow", "BuildUp"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 247, "Rack Lights - Slow Rainbow BuildUp"                 , new String[] { "Rack Lights", "Slow", "Rainbow", "BuildUp"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 248, "All Devices - Very Slow White BuildUp"              , new String[] { "All Devices", "Very Slow", "White", "BuildUp"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 249, "LED Tubes   - Very Slow White BuildUp"              , new String[] { "LED Tubes",   "Very Slow", "White", "BuildUp"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 250, "Rack Lights - Very Slow White BuildUp"              , new String[] { "Rack Lights", "Very Slow", "White", "BuildUp"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 251, "All Devices - Very Slow Red BuildUp"                , new String[] { "All Devices", "Very Slow", "Red", "BuildUp"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 252, "LED Tubes   - Very Slow Red BuildUp"                , new String[] { "LED Tubes",   "Very Slow", "Red", "BuildUp"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 253, "Rack Lights - Very Slow Red BuildUp"                , new String[] { "Rack Lights", "Very Slow", "Red", "BuildUp"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 254, "All Devices - Very Slow Blue BuildUp"               , new String[] { "All Devices", "Very Slow", "Blue", "BuildUp"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 255, "LED Tubes   - Very Slow Blue BuildUp"               , new String[] { "LED Tubes",   "Very Slow", "Blue", "BuildUp"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 256, "Rack Lights - Very Slow Blue BuildUp"               , new String[] { "Rack Lights", "Very Slow", "Blue", "BuildUp"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 257, "All Devices - Very Slow Rainbow BuildUp"            , new String[] { "All Devices", "Very Slow", "Rainbow", "BuildUp"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 258, "LED Tubes   - Very Slow Rainbow BuildUp"            , new String[] { "LED Tubes",   "Very Slow", "Rainbow", "BuildUp"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 259, "Rack Lights - Very Slow Rainbow BuildUp"            , new String[] { "Rack Lights", "Very Slow", "Rainbow", "BuildUp"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 260, "All Devices - White Noise"                          , new String[] { "All Devices", "White", "Noise"                          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 261, "Rack Lights - White Noise"                          , new String[] { "Rack Lights", "White", "Noise"                          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 262, "LED Tubes   - White Noise"                          , new String[] { "LED Tubes",   "White", "Noise"                          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 263, "All Devices - Red Noise"                            , new String[] { "All Devices", "Red", "Noise"                            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 264, "Rack Lights - Red Noise"                            , new String[] { "Rack Lights", "Red", "Noise"                            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 265, "LED Tubes   - Red Noise"                            , new String[] { "LED Tubes",   "Red", "Noise"                            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 266, "All Devices - Blue Noise"                           , new String[] { "All Devices", "Blue", "Noise"                           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 267, "Rack Lights - Blue Noise"                           , new String[] { "Rack Lights", "Blue", "Noise"                           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 268, "LED Tubes   - Blue Noise"                           , new String[] { "LED Tubes",   "Blue", "Noise"                           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 269, "All Devices - Rainbow Noise"                        , new String[] { "All Devices", "Rainbow", "Noise"                        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 270, "Rack Lights - Rainbow Noise"                        , new String[] { "Rack Lights", "Rainbow", "Noise"                        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 271, "LED Tubes   - Rainbow Noise"                        , new String[] { "LED Tubes",   "Rainbow", "Noise"                        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 272, "All Devices - Fast White Smooth Noise"              , new String[] { "All Devices", "Fast", "White", "Smooth Noise"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 273, "Rack Lights - Fast White Smooth Noise"              , new String[] { "Rack Lights", "Fast", "White", "Smooth Noise"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 274, "LED Tubes   - Fast White Smooth Noise"              , new String[] { "LED Tubes",   "Fast", "White", "Smooth Noise"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 275, "All Devices - Fast Red Smooth Noise"                , new String[] { "All Devices", "Fast", "Red", "Smooth Noise"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 276, "Rack Lights - Fast Red Smooth Noise"                , new String[] { "Rack Lights", "Fast", "Red", "Smooth Noise"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 277, "LED Tubes   - Fast Red Smooth Noise"                , new String[] { "LED Tubes",   "Fast", "Red", "Smooth Noise"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 278, "All Devices - Fast Blue Smooth Noise"               , new String[] { "All Devices", "Fast", "Blue", "Smooth Noise"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 279, "Rack Lights - Fast Blue Smooth Noise"               , new String[] { "Rack Lights", "Fast", "Blue", "Smooth Noise"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 280, "LED Tubes   - Fast Blue Smooth Noise"               , new String[] { "LED Tubes",   "Fast", "Blue", "Smooth Noise"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 281, "All Devices - Fast Rainbow Smooth Noise"            , new String[] { "All Devices", "Fast", "Rainbow", "Smooth Noise"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 282, "Rack Lights - Fast Rainbow Smooth Noise"            , new String[] { "Rack Lights", "Fast", "Rainbow", "Smooth Noise"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 283, "LED Tubes   - Fast Rainbow Smooth Noise"            , new String[] { "LED Tubes",   "Fast", "Rainbow", "Smooth Noise"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 284, "All Devices - Slow White Smooth Noise"              , new String[] { "All Devices", "Slow", "White", "Smooth Noise"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 285, "Rack Lights - Slow White Smooth Noise"              , new String[] { "Rack Lights", "Slow", "White", "Smooth Noise"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 286, "LED Tubes   - Slow White Smooth Noise"              , new String[] { "LED Tubes",   "Slow", "White", "Smooth Noise"           } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 287, "All Devices - Slow Red Smooth Noise"                , new String[] { "All Devices", "Slow", "Red", "Smooth Noise"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 288, "Rack Lights - Slow Red Smooth Noise"                , new String[] { "Rack Lights", "Slow", "Red", "Smooth Noise"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 289, "LED Tubes   - Slow Red Smooth Noise"                , new String[] { "LED Tubes",   "Slow", "Red", "Smooth Noise"             } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 290, "All Devices - Slow Blue Smooth Noise"               , new String[] { "All Devices", "Slow", "Blue", "Smooth Noise"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 291, "Rack Lights - Slow Blue Smooth Noise"               , new String[] { "Rack Lights", "Slow", "Blue", "Smooth Noise"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 292, "LED Tubes   - Slow Blue Smooth Noise"               , new String[] { "LED Tubes",   "Slow", "Blue", "Smooth Noise"            } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 293, "All Devices - Slow Rainbow Smooth Noise"            , new String[] { "All Devices", "Slow", "Rainbow", "Smooth Noise"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 294, "Rack Lights - Slow Rainbow Smooth Noise"            , new String[] { "Rack Lights", "Slow", "Rainbow", "Smooth Noise"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 295, "LED Tubes   - Slow Rainbow Smooth Noise"            , new String[] { "LED Tubes",   "Slow", "Rainbow", "Smooth Noise"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 296, "LED Tubes   - Random Whiteout"                      , new String[] { "LED Tubes",   "Random", "White", "Plain"                } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 297, "LED Tubes   - Random Redout"                        , new String[] { "LED Tubes",   "Random", "Red", "Plain"                  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 298, "LED Tubes   - Random Blueout"                       , new String[] { "LED Tubes",   "Random", "Blue", "Plain"                 } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 299, "LED Tubes   - Random Rainbowout"                    , new String[] { "LED Tubes",   "Random", "Rainbow", "Plain"              } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 300, "LED Tubes   - Random Fast White Stroboscope"        , new String[] { "LED Tubes",   "Random", "White", "Fast", "Stroboscope"  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 301, "LED Tubes   - Random Fast Red Stroboscope"          , new String[] { "LED Tubes",   "Random", "Red", "Fast", "Stroboscope"    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 302, "LED Tubes   - Random Fast Blue Stroboscope"         , new String[] { "LED Tubes",   "Random", "Blue", "Fast", "Stroboscope"   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 303, "LED Tubes   - Random Medium White Stroboscope"      , new String[] { "LED Tubes",   "Random", "White", "Medium", "Stroboscope"} );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 304, "LED Tubes   - Random Medium Red Stroboscope"        , new String[] { "LED Tubes",   "Random", "Red", "Medium", "Stroboscope"  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 305, "LED Tubes   - Random Medium Blue Stroboscope"       , new String[] { "LED Tubes",   "Random", "Blue", "Medium", "Stroboscope" } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 306, "LED Tubes   - Random Slow White Stroboscope"        , new String[] { "LED Tubes",   "Random", "White", "Slow", "Stroboscope"  } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 307, "LED Tubes   - Random Slow Red Stroboscope"          , new String[] { "LED Tubes",   "Random", "Red", "Slow", "Stroboscope"    } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 308, "LED Tubes   - Random Slow Blue Stroboscope"         , new String[] { "LED Tubes",   "Random", "Blue", "Slow", "Stroboscope"   } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 309, "LED Tubes   - Random Slow White Flash"              , new String[] { "LED Tubes",   "Random", "White", "Slow", "Flash"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 310, "LED Tubes   - Random Slow Red Flash"                , new String[] { "LED Tubes",   "Random", "Red", "Slow", "Flash"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 311, "LED Tubes   - Random Slow Blue Flash"               , new String[] { "LED Tubes",   "Random", "Blue", "Slow", "Flash"         } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 312, "LED Tubes   - Random Fast White Flash"              , new String[] { "LED Tubes",   "Random", "White", "Fast", "Flash"        } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 313, "LED Tubes   - Random Fast Red Flash"                , new String[] { "LED Tubes",   "Random", "Red", "Fast", "Flash"          } );
  customDevicesAttributes = registerAttribute(customDevicesAttributes, 314, "LED Tubes   - Random Fast Blue Flash"               , new String[] { "LED Tubes",   "Random", "Blue", "Fast", "Flash"         } );
}

void setDMXAnimationsAttributes() {
  DMXAttributes = registerAttribute(DMXAttributes, 1,   "All Devices - Blackout"                              , new String[] { "Strobe", "PAR", "All"                                                      } );
  DMXAttributes = registerAttribute(DMXAttributes, 2,   "Full Strobe - Very Slow"                             , new String[] { "Strobe", "All", "Very Slow"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 3,   "Full Strobe - Slow"                                  , new String[] { "Strobe", "All", "Slow"                                                     } );
  DMXAttributes = registerAttribute(DMXAttributes, 4,   "Full Strobe - Medium"                                , new String[] { "Strobe", "All", "Medium"                                                   } );
  DMXAttributes = registerAttribute(DMXAttributes, 5,   "Full Strobe - Fast"                                  , new String[] { "Strobe", "All", "Fast"                                                     } );
  DMXAttributes = registerAttribute(DMXAttributes, 6,   "Full Strobe - Very Fast"                             , new String[] { "Strobe", "All", "Very Fast"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 7,   "Left Strobe - Very Slow"                             , new String[] { "Strobe", "Left", "Very Slow"                                               } );
  DMXAttributes = registerAttribute(DMXAttributes, 8,   "Left Strobe - Slow"                                  , new String[] { "Strobe", "Left", "Slow"                                                    } );
  DMXAttributes = registerAttribute(DMXAttributes, 9,   "Left Strobe - Medium"                                , new String[] { "Strobe", "Left", "Medium"                                                  } );
  DMXAttributes = registerAttribute(DMXAttributes, 10,  "Left Strobe - Fast"                                  , new String[] { "Strobe", "Left", "Fast"                                                    } );
  DMXAttributes = registerAttribute(DMXAttributes, 11,  "Left Strobe - Very Fast"                             , new String[] { "Strobe", "Left", "Very Fast"                                               } );
  DMXAttributes = registerAttribute(DMXAttributes, 12,  "Right Strobe - Very Slow"                            , new String[] { "Strobe", "Right", "Very Slow"                                              } );
  DMXAttributes = registerAttribute(DMXAttributes, 13,  "Right Strobe - Slow"                                 , new String[] { "Strobe", "Right", "Slow"                                                   } );
  DMXAttributes = registerAttribute(DMXAttributes, 14,  "Right Strobe - Medium"                               , new String[] { "Strobe", "Right", "Medium"                                                 } );
  DMXAttributes = registerAttribute(DMXAttributes, 15,  "Right Strobe - Fast"                                 , new String[] { "Strobe", "Right", "Fast"                                                   } );
  DMXAttributes = registerAttribute(DMXAttributes, 16,  "Right Strobe - Very Fast"                            , new String[] { "Strobe", "Right", "Very Fast"                                              } );
  DMXAttributes = registerAttribute(DMXAttributes, 17,  "Center Strobe - Very Slow"                           , new String[] { "Strobe", "Center", "Very Slow"                                             } );
  DMXAttributes = registerAttribute(DMXAttributes, 18,  "Center Strobe - Slow"                                , new String[] { "Strobe", "Center", "Slow"                                                  } );
  DMXAttributes = registerAttribute(DMXAttributes, 19,  "Center Strobe - Medium"                              , new String[] { "Strobe", "Center", "Medium"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 20,  "Center Strobe - Fast"                                , new String[] { "Strobe", "Center", "Fast"                                                  } );
  DMXAttributes = registerAttribute(DMXAttributes, 21,  "Center Strobe - Very Fast"                           , new String[] { "Strobe", "Center", "Very Fast"                                             } );
  DMXAttributes = registerAttribute(DMXAttributes, 22,  "Left/Right Strobe - Very Slow"                       , new String[] { "Strobe", "Left", "Right", "Very Slow"                                      } );
  DMXAttributes = registerAttribute(DMXAttributes, 23,  "Left/Right Strobe - Slow"                            , new String[] { "Strobe", "Left", "Right", "Slow"                                           } );
  DMXAttributes = registerAttribute(DMXAttributes, 24,  "Left/Right Strobe - Medium"                          , new String[] { "Strobe", "Left", "Right", "Medium"                                         } );
  DMXAttributes = registerAttribute(DMXAttributes, 25,  "Left/Right Strobe - Fast"                            , new String[] { "Strobe", "Left", "Right", "Fast"                                           } );
  DMXAttributes = registerAttribute(DMXAttributes, 26,  "Left/Right Strobe - Very Fast"                       , new String[] { "Strobe", "Left", "Right", "Very Fast"                                      } );
  DMXAttributes = registerAttribute(DMXAttributes, 27,  "Alternate Strobe - 2/4"                              , new String[] { "Strobe", "Left", "Right", "Rhythmic", "Slow"                               } );
  DMXAttributes = registerAttribute(DMXAttributes, 28,  "Alternate Strobe - 1/4"                              , new String[] { "Strobe", "Left", "Right", "Rhythmic", "Medium"                             } );
  DMXAttributes = registerAttribute(DMXAttributes, 29,  "Alternate Strobe - 1/8"                              , new String[] { "Strobe", "Left", "Right", "Rhythmic", "Fast"                               } );
  DMXAttributes = registerAttribute(DMXAttributes, 30,  "Alternate Strobe - 1/16"                             , new String[] { "Strobe", "Left", "Right", "Rhythmic", "Very Fast"                          } );
  DMXAttributes = registerAttribute(DMXAttributes, 31,  "Rotating Strobe - 2/4"                               , new String[] { "Strobe", "All", "Rhythmic", "Slow"                                         } );
  DMXAttributes = registerAttribute(DMXAttributes, 32,  "Rotating Strobe - 1/4"                               , new String[] { "Strobe", "All", "Rhythmic", "Medium"                                       } );
  DMXAttributes = registerAttribute(DMXAttributes, 33,  "Rotating Strobe - 1/8"                               , new String[] { "Strobe", "All", "Rhythmic", "Fast"                                         } );
  DMXAttributes = registerAttribute(DMXAttributes, 34,  "Rotating Strobe - 1/16"                              , new String[] { "Strobe", "All", "Rhythmic", "Very Fast"                                    } );
  DMXAttributes = registerAttribute(DMXAttributes, 35,  "Growing Strobe - Full"                               , new String[] { "Strobe", "All"                                                             } );
  DMXAttributes = registerAttribute(DMXAttributes, 36,  "Growing Strobe - Left"                               , new String[] { "Strobe", "Left"                                                            } );
  DMXAttributes = registerAttribute(DMXAttributes, 37,  "Growing Strobe - Right"                              , new String[] { "Strobe", "Right"                                                           } );
  DMXAttributes = registerAttribute(DMXAttributes, 38,  "Growing Strobe - Center"                             , new String[] { "Strobe", "Center"                                                          } );
  DMXAttributes = registerAttribute(DMXAttributes, 39,  "Growing Strobe - Left/Right"                         , new String[] { "Strobe", "Left", "Right"                                                   } );
  DMXAttributes = registerAttribute(DMXAttributes, 40,  "Growing Strobe - Alternate Left/Right - 2/4"         , new String[] { "Strobe", "Left", "Right", "Rhythmic", "Slow"                               } );
  DMXAttributes = registerAttribute(DMXAttributes, 41,  "Growing Strobe - Alternate Left/Right - 1/4"         , new String[] { "Strobe", "Left", "Right", "Rhythmic", "Medium"                             } );
  DMXAttributes = registerAttribute(DMXAttributes, 42,  "Growing Strobe - Alternate Left/Right - 1/8"         , new String[] { "Strobe", "Left", "Right", "Rhythmic", "Fast"                               } );
  DMXAttributes = registerAttribute(DMXAttributes, 43,  "Growing Strobe - Alternate Left/Right - 1/16"        , new String[] { "Strobe", "Left", "Right", "Rhythmic", "Very Fast"                          } );
  DMXAttributes = registerAttribute(DMXAttributes, 44,  "Growing Strobe - Rotating Left/Center/Right - 2/4"   , new String[] { "Strobe", "All", "Rhythmic", "Slow"                                         } );
  DMXAttributes = registerAttribute(DMXAttributes, 45,  "Growing Strobe - Rotating Left/Center/Right - 1/4"   , new String[] { "Strobe", "All", "Rhythmic", "Medium"                                       } );
  DMXAttributes = registerAttribute(DMXAttributes, 46,  "Growing Strobe - Rotating Left/Center/Right - 1/8"   , new String[] { "Strobe", "All", "Rhythmic", "Fast"                                         } );
  DMXAttributes = registerAttribute(DMXAttributes, 47,  "Growing Strobe - Rotating Left/Center/Right - 1/16"  , new String[] { "Strobe", "All", "Rhythmic", "Very Fast"                                    } );
  DMXAttributes = registerAttribute(DMXAttributes, 48,  "Martin Atomic - Short Single Flash"                  , new String[] { "Strobe", "Center", "Rhythmic"                                              } );
  DMXAttributes = registerAttribute(DMXAttributes, 49,  "Martin Atomic - Long Single Flash"                   , new String[] { "Strobe", "Center", "Rhythmic"                                              } );
  DMXAttributes = registerAttribute(DMXAttributes, 50,  "Impulse Flasher - Kick"                              , new String[] { "Strobe", "Center", "Rhythmic", "AudioInput"                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 51,  "Impulse Flasher - Snare"                             , new String[] { "Strobe", "Center", "Rhythmic", "AudioInput"                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 52,  "Impulse Flasher - Cymbals"                           , new String[] { "Strobe", "Center", "Rhythmic", "AudioInput"                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 53,  "Impulse Flasher - Bass"                              , new String[] { "Strobe", "Center", "Rhythmic", "AudioInput"                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 54,  "Impulse Flasher - Keys"                              , new String[] { "Strobe", "Center", "Rhythmic", "AudioInput"                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 55,  "Impulse Flasher - Guitar"                            , new String[] { "Strobe", "Center", "Rhythmic", "AudioInput"                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 56,  "Atomic FX - Ramp up - Slow Flash"                    , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 57,  "Atomic FX - Ramp up - Medium Flash"                  , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 58,  "Atomic FX - Ramp up - Fast Flash"                    , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 59,  "Atomic FX - Ramp up - Slow Continuous"               , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 60,  "Atomic FX - Ramp up - Medium Continuous"             , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 61,  "Atomic FX - Ramp up - Fast Continuous"               , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 62,  "Atomic FX - Ramp down - Slow Flash"                  , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 63,  "Atomic FX - Ramp down - Medium Flash"                , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 64,  "Atomic FX - Ramp down - Fast Flash"                  , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 65,  "Atomic FX - Ramp down - Slow Continuous"             , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 66,  "Atomic FX - Ramp down - Medium Continuous"           , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 67,  "Atomic FX - Ramp down - Fast Continuous"             , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 68,  "Atomic FX - Ramp up/down - Slow Flash"               , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 69,  "Atomic FX - Ramp up/down - Medium Flash"             , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 70,  "Atomic FX - Ramp up/down - Fast Flash"               , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 71,  "Atomic FX - Ramp up/down - Slow Continuous"          , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 72,  "Atomic FX - Ramp up/down - Medium Continuous"        , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 73,  "Atomic FX - Ramp up/down - Fast Continuous"          , new String[] { "Strobe", "Center", "Atomic"                                                } );  
  DMXAttributes = registerAttribute(DMXAttributes, 74,  "Atomic FX - Random"                                  , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 75,  "Atomic FX - Lightning"                               , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 76,  "Atomic FX - Slow Spikes"                             , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 77,  "Atomic FX - Medium Spikes"                           , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 78,  "Atomic FX - Fast Spikes"                             , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 79,  "Atomic 3000 SpecialFX - Blinder - Very Weak"         , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 80,  "Atomic 3000 SpecialFX - Blinder - Weak"              , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 81,  "Atomic 3000 SpecialFX - Blinder - Medium"            , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 82,  "Atomic 3000 SpecialFX - Blinder - Strong"            , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 83,  "Atomic 3000 SpecialFX - Blinder - Very Strong"       , new String[] { "Strobe", "Center", "Atomic"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 84,  "Left Strobe - Very Weak / Full speed"                , new String[] { "Strobe", "Left", "Very Fast"                                               } );
  DMXAttributes = registerAttribute(DMXAttributes, 85,  "Right Strobe - Very Weak / Full speed"               , new String[] { "Strobe", "Right", "Very Fast"                                              } );
  DMXAttributes = registerAttribute(DMXAttributes, 86,  "Center Strobe - Very Weak / Full speed"              , new String[] { "Strobe", "Center", "Very Fast"                                             } );
  DMXAttributes = registerAttribute(DMXAttributes, 87,  "Left/Right Strobe - Very Weak / Full speed"          , new String[] { "Strobe", "Left", "Right", "Very Fast"                                      } );
  DMXAttributes = registerAttribute(DMXAttributes, 88,  "Full Strobe - Very Weak / Full speed"                , new String[] { "Strobe", "All", "Very Fast"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 89,  "Left Strobe - Weak / Full speed"                     , new String[] { "Strobe", "Left", "Very Fast"                                               } );
  DMXAttributes = registerAttribute(DMXAttributes, 90,  "Right Strobe - Weak / Full speed"                    , new String[] { "Strobe", "Right", "Very Fast"                                              } );
  DMXAttributes = registerAttribute(DMXAttributes, 91,  "Center Strobe - Weak / Full speed"                   , new String[] { "Strobe", "Center", "Very Fast"                                             } );
  DMXAttributes = registerAttribute(DMXAttributes, 92,  "Left/Right Strobe - Weak / Full speed"               , new String[] { "Strobe", "Left", "Right", "Very Fast"                                      } );
  DMXAttributes = registerAttribute(DMXAttributes, 93,  "Full Strobe - Weak / Full speed"                     , new String[] { "Strobe", "All", "Very Fast"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 94,  "Left Strobe - Moderate / Full speed"                 , new String[] { "Strobe", "Left", "Very Fast"                                               } );
  DMXAttributes = registerAttribute(DMXAttributes, 95,  "Right Strobe - Moderate / Full speed"                , new String[] { "Strobe", "Right", "Very Fast"                                              } );
  DMXAttributes = registerAttribute(DMXAttributes, 96,  "Center Strobe - Moderate / Full speed"               , new String[] { "Strobe", "Center", "Very Fast"                                             } );
  DMXAttributes = registerAttribute(DMXAttributes, 97,  "Left/Right Strobe - Moderate / Full speed"           , new String[] { "Strobe", "Left", "Right", "Very Fast"                                      } );
  DMXAttributes = registerAttribute(DMXAttributes, 98,  "Full Strobe - Moderate / Full speed"                 , new String[] { "Strobe", "All", "Very Fast"                                                } );
  DMXAttributes = registerAttribute(DMXAttributes, 99,  "Left Strobe - Strong / Full speed"                   , new String[] { "Strobe", "Left", "Very Fast"                                               } );
  DMXAttributes = registerAttribute(DMXAttributes, 100, "Right Strobe - Strong / Full speed"                  , new String[] { "Strobe", "Right", "Very Fast"                                              } );
  DMXAttributes = registerAttribute(DMXAttributes, 101, "Center Strobe - Strong / Full speed"                 , new String[] { "Strobe", "Center", "Very Fast"                                             } );
  DMXAttributes = registerAttribute(DMXAttributes, 102, "Left/Right Strobe - Strong / Full speed"             , new String[] { "Strobe", "Left", "Right", "Very Fast"                                      } );
  DMXAttributes = registerAttribute(DMXAttributes, 103, "Full Strobe - Strong / Full speed"                   , new String[] { "Strobe", "All", "Very Fast"                                                } );
}


class Attribute {
  int animationNbr;
  String name;
  ArrayList<String> attributes;
  
  Attribute(int animationNbr, String attributename, String[] attributeList) {
    this.animationNbr = animationNbr;
    this.name = attributename;
    attributes = new ArrayList<String>();
    
    for (int i = 0; i < attributeList.length; i++) {
      attributes.add(attributeList[i]);
      
      //If not already registered, register this attribute as a possibility for the filter
      if (registeredAttributes.hasValue(attributeList[i]) == false) {
        registeredAttributes.append(attributeList[i]);
      }
    }
    
  }
  
  String printAttribute() {
    String tmp = "Animation no " + animationNbr + " : ";
    for (int i=0; i < attributes.size(); i++) {
      String attribute = attributes.get(i);
      tmp += attribute;
      if (i < attributes.size() - 1) {
        tmp += ", ";
      }
    }
    return tmp;
  }
  
  String printAttributePHP() {
    String tmp = "";
    tmp = "        $attributeList[] = array (";
    for (int i=0; i < attributes.size(); i++) {
      String attribute = attributes.get(i);
      tmp += "\'" + attribute + "\'";
      if (i < attributes.size() - 1) {
        tmp += ", ";
      }
    }
    tmp += ");";
    return tmp;
  }
}
