
///////////////////////////////////////
/// Execute the requested animation ///
///////////////////////////////////////

//Parameters used for manual animations (similar to the ones used in auto mode, but individually switchable using the configuration file)
boolean authorizeGeneralManualMode       = true;
boolean authorizeStrobeManualMode4th     = true;
boolean authorizeStrobeManualMode8th     = true;
boolean authorizeStrobeManualMode16th    = true;
boolean authorizeStrobeManualMode32nd    = true;
boolean authorizeStrobeManualMode64th    = true;
boolean authorizeKillLedPanelManualMode  = true;
boolean authorizeBlackOutManualMode      = true;
boolean authorizeWhiteOutManualMode      = true;
boolean authorizeShredderManualMode      = true; 
boolean authorizeWhiteJamaMonoManualMode = false;
boolean authorizeColorChangeManualMode   = true;
boolean authorizeWhiteNoiseManualMode    = true;
boolean authorizeDMXStrobe               = true;
boolean authorizePanelStrobe             = true;

boolean setStrobeManualMode4th           = false;
boolean setStrobeManualMode8th           = false;
boolean setStrobeManualMode16th          = false;
boolean setStrobeManualMode32nd          = false;
boolean setStrobeManualMode64th          = false;
boolean setKillLedPanelManualMode        = false;
boolean setBlackOutManualMode            = false;
int blackoutPowerManualMode              = 0;
boolean setWhiteOutManualMode            = false;
int whiteoutPowerManualMode              = 0;
boolean setShredderManualMode            = false; 
int shredderPowerManualMode              = 0;
boolean setWhiteJamaMonoManualMode       = false;
int whiteJamaMonoPowerManualMode         = 0;
boolean setColorChangeManualMode         = false;
int colorChangePowerManualMode           = 0;
boolean setWhiteNoiseManualMode          = false;
int whiteNoisePowerManualMode            = 0;

//Boolean set when an effect is to be drawn (as part of the classic manual mode)
boolean effectToBeDrawn = false;
int currentEffectNumber = -1;
int effectNumberToDeactivateEffects = -1;

void actionControlled_preSpecificDraw() {
  if (authorizeGeneralManualMode == true) {
    if (setShredderManualMode == true) {
      draw_AutoModeShredder(shredderPowerManualMode);
    }
  }
}

void actionControlled_postSpecificDraw() {
  if (authorizeStrobeManualMode4th == true) {
    if (setStrobeManualMode4th == true) {
      draw_stroboAutoPad(COLORSET_BLACK, 120, 1);
    }
  }
  if (authorizeStrobeManualMode8th == true) {
    if (setStrobeManualMode8th == true) {
      draw_stroboAutoPad(COLORSET_BLACK, 120, 2);
    }
  }
  if (authorizeStrobeManualMode16th == true) {
    if (setStrobeManualMode16th == true) {
      draw_stroboAutoPad(COLORSET_BLACK, 120, 4);        
    }
  }
  if (authorizeStrobeManualMode32nd == true) {
    if (setStrobeManualMode32nd == true) {
      draw_stroboAutoPad(COLORSET_BLACK, 120, 8);
    }
  }
  if (authorizeStrobeManualMode64th == true) {
    if (setStrobeManualMode64th == true) {
      draw_stroboAutoPad(COLORSET_BLACK, 120, 8);
    }
  }
    
  if (authorizeBlackOutManualMode == true) {
    if (setBlackOutManualMode == true) {
      draw_AutoModeBlackOut(blackoutPowerManualMode);
    }
  }
  if (authorizeWhiteOutManualMode == true) {
    if (setWhiteOutManualMode == true) {
      draw_AutoModeWhiteOut(whiteoutPowerManualMode);
    }
  }
  if (authorizeColorChangeManualMode == true) {  
    if (setColorChangeManualMode == true) {
      draw_AutoModeColorChange();
    }
  }
  if (authorizeWhiteJamaMonoManualMode == true) {
    if (setWhiteJamaMonoManualMode == true) {
      draw_whiteJamaMono(whiteJamaMonoPowerManualMode);
    }
  }
  if (authorizeWhiteNoiseManualMode == true) {
    if (setWhiteNoiseManualMode == true) {
      draw_whiteNoiseEffect(whiteNoisePowerManualMode);
    }
  }
  if (authorizeKillLedPanelManualMode == true) {
    if (setKillLedPanelManualMode == true) {
      draw_killLedPanels();
    }
  }
}

void specific_draw() {
    
  specific_draw_dmx();                    //Send commands to DMX devices (useful to have in the draw because the values may evolve when dealing with complex stuff)
  
  if (drawImage == 1)                     //Draw the image whose filename is specified by imagenumber
  {
    draw_image();
  }
    
  if (drawAnimation == 1) 
  {
    switch(animationnumber) {      
      case 1: draw_spiraluality();break;                           //Spiraluality
      case 2: draw_shadows();break;                                //Shadows
      case 3: draw_carglass();break;                               //Carglass        
      case 4: draw_va_et_vient_1();break;                          //Va et vient - Vertical
      case 5: draw_va_et_vient_2();break;                          //Va et vient - Horizontal
      case 6: draw_initFlasher();break;                            //Intro - initFlasher
      case 7: draw_redGlowingBalls();break;                        //RedWhiteGlowingBalls
      case 8: draw_redGlowingBalls2();break;                       //RedWhiteGlowingBalls - 2
      case 9: draw_flashextremeleft();break;                       //FlashExtremeLeft
      case 10: draw_flashextremeright();break;                     //FlashExtremeRight
      case 11: draw_rotating_circles();break;                      //Rotating Circles
      case 12: draw_waveform();break;                              //Waveform
      case 13: draw_fadeout();break;                               //Fadeout
      case 14: draw_fadeoutleft();break;                           //FadeoutLeft
      case 15: draw_fadeoutcenter();break;                         //FadeoutCenter
      case 16: draw_fadeoutright();break;                          //FadeoutRight
      case 17: draw_fadein();break;                                //Fadein
      case 18: draw_worms();break;                                 //Worms
      case 19: draw_upwards_line();break;                          //Upwards Line
      case 20: draw_wind_particles();break;                        //Wind particles
      case 21: draw_strobonormal();break;                          //Strobonormal
      case 22: draw_panelfillline();break;                         //PanelFillLine
      case 23: draw_symmetry();break;                              //Symmetry
      case 24: draw_flashleft();break;                             //FlashLeft
      case 25: draw_flashcenter();break;                           //FlashCenter
      case 26: draw_flashright();break;                            //FlashRight
      case 27: draw_rhombus();break;                               //Rhombus
      case 28: draw_kaleidotriangle();break;                       //KaleidoTriangle
      case 29: draw_glitch();break;                                //GlitchTriangle
      case 30: draw_glitch();break;                                //GlitchLine
      case 31: draw_snow();break;                                  //Snow
      case 32: draw_mechaniclines();break;                         //MechanicLines
      case 33: draw_redvsblackvswhite();break;                     //RedvsBlackvsWhite
      case 34: draw_rotatingsquare();break;                        //RotatingSquare
      case 35: draw_movingsine();break;                            //MovingSine
      case 36: draw_sinefuckedup(0);break;                         //FuckedUpSine1
      case 37: draw_sinefuckedup(1);break;                         //FuckedUpSine2
      case 38: draw_sinefuckedup(2);break;                         //FuckedUpSine3
      case 39: draw_manualcircle();break;                          //ManualCircle
      case 40: draw_automaticcircle();break;                       //AutomaticCircle
      case 41: draw_rain();break;                                  //Rain
      case 42: draw_pulsestar();break;                             //PulseStar
      case 43: draw_arrowshape();break;                            //ArrowShape
      case 44: draw_star(2);break;                                 //Star - 2 sides
      case 45: draw_star(3);break;                                 //Star - 3 sides
      case 46: draw_star(4);break;                                 //Star - 4 sides
      case 47: draw_star(6);break;                                 //Star - 6 sides
      case 48: draw_star(8);break;                                 //Star - 8 sides
      case 49: draw_movinglines();break;                           //MovingLines
      case 50: draw_movingsquares();break;                         //MovingSquares
      case 51: draw_upwardsglitchlines();break;                    //UpwardsGlitchLines
      case 52: draw_diagonalglitchlines();break;                   //DiagonalGlitchLines
      case 53: draw_compressedlines();break;                       //CompressedLines
      case 54: draw_panelfillleft();break;                         //PanelFillLeft
      case 55: draw_panelfillcenter();break;                       //PanelFillCenter
      case 56: draw_panelfillright();break;                        //PanelFillRight
      case 57: draw_flashleftred();break;                          //FlashLeftRed
      case 58: draw_flashcenterred();break;                        //FlashCenterRed
      case 59: draw_flashrightred();break;                         //FlashRightRed
      case 60: draw_mixedlines(0,2,0);break;                       //MixedLines1
      case 61: draw_mixedlines(2,0,0);break;                       //MixedLines2
      case 62: draw_mixedlines(1,3,0);break;                       //MixedLines3
      case 63: draw_mixedlines(3,1,0);break;                       //MixedLines4
      case 64: draw_mixedlines(1,2,0);break;                       //MixedLines5
      case 65: draw_mixedlines(2,3,0);break;                       //MixedLines6
      case 66: draw_mixedlines(1,3,2);break;                       //MixedLines7
      case 67: draw_mixedlines(3,1,2);break;                       //MixedLines8
      case 68: draw_mixedlines(0,0,1);break;                       //MixedLines9
      case 69: draw_mixedlines(0,0,2);break;                       //MixedLines10
      case 70: draw_mixedlines(0,0,3);break;                       //MixedLines11
      case 71: draw_mixedlines(0,0,4);break;                       //MixedLines12
      case 72: draw_mixedlines(0,0,5);break;                       //MixedLines13
      case 73: draw_mixedlines(0,0,6);break;                       //MixedLines14
      case 74: draw_stroboX();break;                               //StroboX
      case 75: draw_doublegradient();break;                        //DoubleGradient transition
      case 76: draw_carremarshall();break;                         //CarreMarshall
      case 77: draw_fusee_up();break;                              //FuseeUp
      case 78: draw_fusee_down();break;                            //FuseeDown
      case 79: draw_fusee_left();break;                            //FuseeLeft
      case 80: draw_fusee_right();break;                           //FuseeRight
      case 81: draw_fusee_centerhorizontal();break;                //FuseeCenterHorizontal
      case 82: draw_fusee_centervertical();break;                  //FuseeCenterVertical
      case 83: draw_spots();break;                                 //Spots
      case 84: draw_marshallstrobo();break;                        //MarshallStrobo
      case 85: draw_stroboline();break;                            //StroboLine
      case 86: draw_upwardsglitchmixedlines();break;               //UpwardsGlitchMixedLines
      case 87: draw_upwardsglitchmixedlines2();break;              //UpwardsGlitchMixedLines2
      case 88: draw_wideflash();break;                             //WideFlash
      case 89: draw_scope();break;                                 //Scope
      case 90: draw_squarewavegenerator();break;                   //SquareWaveGenerator
      case 91: draw_pixellines();break;                            //PixelLines
      case 92: draw_spiraltriangle();break;                        //SpiralTriangle
      case 93: draw_sonar(false);break;                            //Sonar
      case 94: draw_sonar(true);break;                             //SonarAllWhite
      case 95: draw_rorschach();break;                             //Rorschach 1
      case 96: draw_rorschach();break;                             //Rorschach 2
      case 97: draw_rorschach();break;                             //Rorschach 3
      case 98: draw_rorschach();break;                             //Rorschach 4
      case 99: draw_rorschach();break;                             //Rorschach 5
      case 100:                                                    //RorschachSetColor - special action, draw function shall not be called !
      case 101:                                                    //RorschachSetBlack&White - special action, draw function shall not be called !
      case 102: draw_strobored();break;                            //StroboRed
      case 103: draw_filllowleft();break;                          //LowLeft
      case 104: draw_fillhileft();break;                           //HiLeft
      case 105: draw_filllowmid();break;                           //LowMid
      case 106: draw_fillhimid();break;                            //HiMid
      case 107: draw_filllowright();break;                         //LowRight
      case 108: draw_fillhiright();break;                          //HiRight
      case 109: draw_whiteout();break;                             //WhiteOut
      case 110: draw_blackout();break;                             //BlackOut
      case 111: draw_upwards_line_whiteout();break;                //Upwards Line White Out
      case 112: draw_lines1();break;                               //Lines 1
      case 113: draw_lines2();break;                               //Lines 2
      case 114: draw_lines3();break;                               //Lines 3
      case 115: draw_lines4();break;                               //Lines 4
      case 116: draw_lines5();break;                               //Lines 5
      case 117: draw_lines6();break;                               //Lines 6
      case 118: draw_lines7();break;                               //Lines 7
      case 119: draw_lines8();break;                               //Lines 8
      case 120: draw_lines9();break;                               //Lines 9
      case 121: draw_lines10();break;                              //Lines 10
      case 122: draw_unfoldinglines();break;                       //Unfolding Lines
      case 123: draw_superformula();break;                         //Superformula
      case 124: draw_growingtriangles();break;                     //GrowingTriangles
      case 125: draw_moire();break;                                //Moire
      case 126: draw_tetris();break;                               //Tetris - 1 player game
      case 127: draw_pong();break;                                 //Pong - 2 player game

      /////////START OF ANIMATION BANK 2//////////////
      
      case 128: draw_responsivecirclesbw();break;                  //ResponsiveCirclesBW  - 1
      case 129: draw_responsivecircles();break;                    //ResponsiveCircles - 2
      case 130: draw_particlesexplode();break;                     //ParticlesExplode - 3
      case 131: draw_progressivered();break;                       //ProgressiveRed - 4
      case 132: draw_colorvertex();break;                          //ColorVertex - 5
      case 133: draw_particlesflow();break;                        //ParticlesFlow - 6
      case 134: draw_bezierflowers();break;                        //BezierFlowers - 7
      case 135: draw_jointcircles();break;                         //JointCircles - 8
      case 136: draw_tunnel();break;                               //TunnelWhite - 9
      case 137: draw_tunnel();break;                               //TunnelRed - 10
      case 138: draw_cosmocurve();break;                           //CosmoCurve - 11
      case 139: draw_perlincolor();break;                          //PerlinColor - 12
      case 140: draw_linewideflash();break;                        //LineWideFlash - 13
      case 141: draw_lineleftflash();break;                        //LineLeftFlash - 14
      case 142: draw_linecenterflash();break;                      //LineCenterFlash - 15
      case 143: draw_linerightflash();break;                       //LineRightFlash - 16
      case 144: draw_longwideflash();break;                        //LongWideFlash - 17
      case 145: draw_oppositelinesnobackground();break;            //OppositeLinesNoBackground - 18
      case 146: draw_openinglines();break;                         //OpeningLines - 19
      case 147: draw_openinglines();break;                         //OpeningLinesReinit - 20
      case 148: draw_whitenoise();break;                           //WhiteNoise - 21
      case 149: draw_singlesquarespiral();break;                   //SingleSquareSpiral - 22
      case 150: draw_dualsquarespiral();break;                     //DualSquareSpiral - 23
      case 151: draw_complexspiral();break;                        //ComplexSpiralReinit - 24
      case 152: draw_complexspiral();break;                        //ComplexSpiral - 25
      case 153: draw_beatcircle();break;                           //BeatCircle - 26
      case 154: draw_beatcirclelines();break;                      //BeatCircleLinesReinit - 27
      case 155: draw_beatcirclelines();break;                      //BeatCircleLines - 28
      case 156: draw_beatcirclecolorlines(1);break;                //BeatCircleColorLines1 - 29
      case 157: draw_beatcirclecolorlines(2);break;                //BeatCircleColorLines2 - 30
      case 158: draw_cosmocurve();break;                           //CosmoCurveReinit - 31
      case 159: draw_reddiagonallines();break;                     //RedDiagonalLines - 32
      case 160: draw_bluediagonallines();break;                    //BlueDiagonalLines - 33
      case 161: draw_whitenoisecrescendo();break;                  //WhiteNoiseCrescendo - 34
      case 162: draw_trianglestrobo();break;                       //TriangleStrobo - 35
      case 163: draw_bluediagonallines2();break;                   //BlueDiagonalLines2 - 36
      case 164: draw_bluediagonallines3();break;                   //BlueDiagonalLines3 - 37
      case 165: draw_reddiagonallines2();break;                    //RedDiagonalLines2 - 38
      case 166: draw_whitediagonallines();break;                   //WhiteDiagonalLines - 39
      case 167: draw_whitediagonallines2();break;                  //WhiteDiagonalLines2 - 40
      case 168: draw_whitestraightlines();break;                   //WhiteStraightLines - 41
      case 169: draw_inwardsspiral();break;                        //InwardsSpiral - 42
      case 170: draw_inwardsspiralreverse();break;                 //InwardsSpiralReverse - 43
      case 171: draw_explodingcircle();break;                      //ExplodingCircle - 44
      case 172: draw_rotozoomblue();break;                         //RotozoomWhite - 45
      case 173: draw_newtonpendulum();break;                       //NewtonPendulum - 46
      case 174: draw_hypnopendulum();break;                        //HypnoPendulum - 47
      case 175: draw_largewheelpendulum();break;                   //LargeWheelPendulum - 48
      case 176: draw_mugen();break;                                //Mugen - 49
      case 177: draw_arcwave();break;                              //ArcWave - 50
      case 178: draw_whiteoutwardspiral();break;                   //OutwardSpiralWhite - 51
      case 179: draw_blueoutwardspiral();break;                    //OutwardSpiralBlue - 52
      case 180: draw_redoutwardspiral();break;                     //OutwardSpiralRed - 53
      case 181: draw_columns();break;                              //ColumnsWhite - 54
      case 182: draw_columns();break;                              //ColumnsBlack - 55
      case 183: draw_circlecontour();break;                        //CircleContour - 56
      case 184: draw_colorexplode();break;                         //ColorExplode - 57
      case 185: draw_colorrain();break;                            //ColorRain - 58
      case 186: draw_warpspeed();break;                            //WarpSpeed - 59
      case 187: draw_bwtriangles();break;                          //BWTriangles - 60
      case 188: draw_glitchdiagonallines();break;                  //GlitchDiagonalLines - 61
      case 189: draw_flashingdotsborder();break;                   //FlashingDotsBorder - 62
      case 190: draw_fallingcircles();break;                       //FallingCircles - 63
      case 191: draw_explodingparticles();break;                   //SetExplodingParticles - 64
      case 192: draw_explodingparticles();break;                   //ReleaseExplodingParticles - 65
      case 193: draw_randombwflow();break;                         //RandomBWFlow - 66
      case 194: draw_tesselate();break;                            //Tesselate - 67
      case 195: draw_digitalhexparticles();break;                  //DigitalHexParticles - 68
      case 196: draw_redarctransition();break;                     //RedArcTransition - 69
      case 197: draw_redarctransition();break;                     //BlueArcTransition - 70
      case 198: draw_lightblobs();break;                           //LightBlobs - 71
      case 199: draw_randomsmokeparticles();break;                 //RandomSmokeParticles - 72
      case 200: draw_redmetaballs();break;                         //RedMetaBalls - 73
      case 201: draw_butterfly();break;                            //Butterfly - 74
      case 202: draw_circlepusher();break;                         //CirclePusherRotate - 75
      case 203: draw_circlepusher();break;                         //CirclePusherStraight - 76
      case 204: draw_shutter();break;                              //Shutter - 77
      case 205: draw_orbitingparticles();break;                    //OrbitingParticles - 78
      case 206: draw_vines();break;                                //Vines - 79
      case 207: draw_arrowstyle();break;                           //ArrowStyle - 80
      case 208: draw_singlearrow();break;                          //SingleArrow - Up-Down White - 81
      case 209: draw_singlearrow();break;                          //SingleArrow - Left-Right White - 82
      case 210: draw_singlearrow();break;                          //SingleArrow - Right-Left White - 83
      case 211: draw_singlearrow();break;                          //SingleArrow - Down-Up White - 84
      case 212: draw_singlearrow();break;                          //SingleArrow - Up-Down Red - 85
      case 213: draw_singlearrow();break;                          //SingleArrow - Left-Right Red - 86
      case 214: draw_singlearrow();break;                          //SingleArrow - Right-Left Red - 87
      case 215: draw_singlearrow();break;                          //SingleArrow - Down-Up Red - 88
      case 216: draw_rotozoom();break;                             //Rotozoom 1 - 89
      case 217: draw_rotozoom();break;                             //Rotozoom 2 - 90
      case 218: draw_rotozoom();break;                             //Rotozoom 3 - 91
      case 219: draw_milktank();break;                             //Milktank - 92
      case 220: draw_firenoisesquares();break;                     //FireNoiseSquares - 93
      case 221: draw_slasher();break;                              //Slasher - 94
      case 222: draw_nekojiru();break;                             //NekoJiru - 95
      case 223: draw_letterexplode();break;                        //LetterExplode - 96
      case 224: draw_trianglestrobocolor();break;                  //TriangleStrobo - 97
      case 225: draw_explodingcircleleft();break;                  //ExplodingCircleLeft - 98
      case 226: draw_explodingcircleright();break;                 //ExplodingCircleRight - 99
      case 227: draw_thunderlines();break;                         //ThunderLinesInit - 100
      case 228: draw_thunderlines();break;                         //ThunderLines - More Lines - 101
      case 229: draw_thunderlines();break;                         //ThunderLines - Less Lines - 102
      case 230: draw_doublefusee();break;                          //Double Fusee - 103
      case 231: draw_discostar();break;                            //DiscoStar - 104
      case 232: draw_wormhole();break;                             //WormHole - 105
      case 233: draw_atoms();break;                                //Atoms - One Electron - 106
      case 234: draw_atoms();break;                                //Atoms - Two Electrons - 107
      case 235: draw_atoms();break;                                //Atoms - Three Electrons - 108
      case 236: draw_perfectcircle();break;                        //PerfectCircle - 109
      case 237: draw_hyperspeed();break;                           //HyperSpeed - 110
      case 238: draw_colorwaves();break;                           //ColorWaves - Regular - 111 
      case 239: draw_colorwaves();break;                           //ColorWaves - Strong - 112
      case 240: draw_continuoustriangles();break;                  //ContinuousTrianglesResync - 113 
      case 241: draw_continuoustriangles();break;                  //ContinuousTrianglesResyncInvert - 114
      case 242: draw_continuoustriangles();break;                  //ContinuousTrianglesDrift - 115
      case 243: draw_continuoustriangles();break;                  //ContinuousTrianglesDriftInvert - 116
      case 244: draw_mandala();break;                              //Mandala - 117
      case 245: draw_mandala();break;                              //Mandala - change shape - 118
      case 246: draw_kaleido();break;                              //Kaleido - 119
      case 247: draw_kaleidoinverse();break;                       //KaleidoInverse - 120
      case 248: draw_flower();break;                               //Flower - 121
      case 249: draw_electricspiral();break;                       //ElectricSpiral - 122
      case 250: draw_smallsquareleft();break;                      //SmallSquareLeft - 123
      case 251: draw_smallsquarecenter();break;                    //SmallSquareCenter - 124
      case 252: draw_smallsquareright();break;                     //SmallSquareRight - 125
      case 253: draw_smallsquares();break;                         //SmallSquares - 126
      case 254: draw_fastspiral();break;                           //FastSpiral - 127

      /////////START OF ANIMATION BANK 3//////////////
      
      case 255: draw_weirdsquare();break;                          //WeirdSquare - 1
      case 256: draw_columnsred();break;                           //ColumnsWhiteRed - 2
      case 257: draw_columnsred();break;                           //ColumnsBlackRed - 3
      case 258: draw_spotsmulticolor();break;                      //SpotsMultiColor - 4
      case 259: draw_strobolinecolor();break;                      //StroboLineColor - 5
      case 260: draw_strobocolor();break;                          //Strobocolor - 6
      case 261: draw_fusee_up_red();break;                         //FuseeUp - 7
      case 262: draw_fusee_down_red();break;                       //FuseeDown - 8
      case 263: draw_fusee_left_red();break;                       //FuseeLeft - 9
      case 264: draw_fusee_right_red();break;                      //FuseeRight - 10
      case 265: draw_fusee_centerhorizontal_red();break;           //FuseeCenterHorizontal - 11
      case 266: draw_fusee_centervertical_red();break;             //FuseeCenterVertical - 12
      case 267: draw_wideflashred();break;                         //WideFlashRed - 13
      case 268: draw_doubleflowers();break;                        //DoubleFlowers - 14
      case 269: draw_thirdDimension_bigasscube();break;            //3D BigAssCube - 15
      case 270: draw_thirdDimension_cornercube();break;            //3D CornerCube - 16
      case 271: draw_thirdDimension_glitchcube();break;            //3D GlitchCube - 17
      case 272: draw_thirdDimension_noglitchcube();break;          //3D NoGlitchCube - 18
      case 273: draw_thirdDimension_jerkycube();break;             //3D JerkyCube - 19
      case 274: draw_thirdDimension_movingjerkycube();break;       //3D MovingJerkyCube - 20
      case 275: draw_thirdDimension_doublecube();break;            //3D DoubleCube - 21
      case 276: draw_thirdDimension_singlepyramid();break;         //3D SinglePyramid - 22
      case 277: draw_thirdDimension_multiplepyramids();break;      //3D MultiplePyramids - 23
      case 278: draw_bloodski();break;                             //BloodSki - 24
      case 279: draw_gloubiboulga();break;                         //Gloubiboulga - 25
      case 280: draw_revolutionlines();break;                      //RevolutionLines - 26
      case 281: draw_rednoiseshape1();break;                       //RedNoiseShape 1 - 27
      case 282: draw_rednoiseshape2();break;                       //RedNoiseShape 2 - 28
      case 283: draw_rednoiseshape3();break;                       //RedNoiseShape 3 - 29
      case 284: draw_rednoiseshape4();break;                       //RedNoiseShape 4 - 30
      case 285: draw_rednoiseshape5();break;                       //RedNoiseShape 5 - 31
      case 286: draw_rednoiseshape6();break;                       //RedNoiseShape 6 - 32
      case 287: draw_turningsinglelines();break;                   //TurningSingleLines - 33
      case 288: draw_randomappearinglines();break;                 //RandomAppearingLines - 34
      case 289: draw_horizontal_impulsewhiterectangle();break;     //ImpulseWhiteRectangle - Horizontal - 35
      case 290: draw_vertical_impulsewhiterectangle();break;       //ImpulseWhiteRectangle - Vertical - 36
      case 291: draw_horizontal_impulseredrectangle();break;       //ImpulseRedRectangle - Horizontal - 37
      case 292: draw_vertical_impulseredrectangle();break;         //ImpulseRedRectangle - Vertical - 38
      case 293: draw_crescent();break;                             //Crescent - 39
      case 294: draw_clock();break;                                //Clock - 40
      case 295: draw_colorbeat();break;                            //ColorBeat - 41
      case 296: draw_colorbeatstroboline();break;                  //ColorBeatStroboline - 42
      case 297: draw_colorbeatwhitestrobotriangle();break;         //ColorBeatWhiteStroboTriangle - 43
      case 298: draw_colorbeattransition();break;                  //ColorBeatTransition - 44
      case 299: draw_invertexplode();break;                        //InvertExplode - 45
      case 300: draw_particlesflow();break;                        //ParticlesFlowRed - 46
      case 301: draw_darksnakes();break;                           //DarkSnakes - 47
      case 302: draw_brightsnakes();break;                         //BrightSnakes - 48
      case 303: draw_lightpainting();break;                        //LightPainting - 49
      case 304: draw_shiftpixelsup();break;                        //ShiftPixelsUp / Slow - 50
      case 305: draw_shiftpixelsdown();break;                      //ShiftPixelsDown / Slow - 51
      case 306: draw_shiftpixelsleft();break;                      //ShiftPixelsLeft / Slow - 52
      case 307: draw_shiftpixelsright();break;                     //ShiftPixelsRight / Slow - 53
      case 308: draw_shiftpixelsup();break;                        //ShiftPixelsUp / Fast - 54
      case 309: draw_shiftpixelsdown();break;                      //ShiftPixelsDown / Fast - 55
      case 310: draw_shiftpixelsleft();break;                      //ShiftPixelsLeft / Fast - 56
      case 311: draw_shiftpixelsright();break;                     //ShiftPixelsRight / Fast - 57
      case 312: draw_shredpixelsvertical();break;                  //ShredPixelsVertical / Slow - 58
      case 313: draw_shredpixelshorizontal();break;                //ShredPixelsHorizontal / Slow - 59
      case 314: draw_shredpixelsvertical();break;                  //ShredPixelsVertical / Slow - 60
      case 315: draw_shredpixelshorizontal();break;                //ShredPixelsHorizontal / Slow - 61
      case 316: draw_lightfusion();break;                          //LightFusion - 62
      case 317: draw_randompaint();break;                          //RandomPaint - 63
      case 318: draw_redwave();break;                              //RedWave - 64
      case 319: draw_diagonalcolor();break;                        //DiagonalColor - 65
      case 320: draw_hypnospiralred();break;                       //HypnoSpiralRed - 66
      case 321: draw_nightroad();break;                            //NightRoad - 67
      case 322: draw_hypnoflashtriangle();break;                   //HypnoFlashTriangle - 68
      case 323: draw_rotatingcut_black();break;                    //RotatingCut - B&W - 69
      case 324: draw_rotatingcut_blue();break;                     //RotatingCut - Blue - 70
      case 325: draw_greenArcRot();break;                          //ArcRot - Green - 71
      case 326: draw_redArcRot();break;                            //ArcRot - Red - 72
      case 327: draw_energyGrid();break;                           //EnergyGrid - 73
      case 328: draw_patchwork();break;                            //Patchwork - 74
      case 329: draw_reverseTriangles();break;                     //ReverseTriangles - 75
      case 330: draw_trigoShapes();break;                          //TrigoShapes - 76
      case 331: draw_nonotak_1();break;                            //Nonotak 1 - 77
      case 332: draw_nonotak_2();break;                            //Nonotak 2 - 78
      case 333: draw_nonotak_3();break;                            //Nonotak 3 - 79
      case 334: draw_nonotak_4();break;                            //Nonotak 4 - 80
      case 335: draw_nonotak_5();break;                            //Nonotak 5 - 81
      case 336: draw_nonotakPanelFill();break;                     //NonotakPanelFill - Left - 82
      case 337: draw_nonotakPanelFill();break;                     //NonotakPanelFill - Center - 83
      case 338: draw_nonotakPanelFill();break;                     //NonotakPanelFill - Right - 84
      case 339: draw_randomWhiteLineFlash();break;                 //RandomWhiteLineFlash - 85
      case 340: draw_nonotakWoosh();break;                         //NonotakWoosh 1 - 86
      case 341: draw_nonotakWoosh();break;                         //NonotakWoosh 2 - 87
      case 342: draw_nonotakWoosh();break;                         //NonotakWoosh 3 - 88
      case 343: draw_nonotakWoosh();break;                         //NonotakWoosh 4 - 89
      case 344: draw_rotatingcut_black_fast();break;               //RotatingCutFast - B&W - 90
      case 345: draw_patatap();break;                              //Patatap - 91
      case 346: draw_patatap();break;                              //Patatap - 92
      case 347: draw_patatap();break;                              //Patatap - 93
      case 348: draw_patatap();break;                              //Patatap - 94
      case 349: draw_patatap();break;                              //Patatap - 95
      case 350: draw_patatap();break;                              //Patatap - 96
      case 351: draw_patatap();break;                              //Patatap - 97
      case 352: draw_patatap();break;                              //Patatap - 98
      case 353: draw_patatap();break;                              //Patatap - 99
      case 354: draw_patatap();break;                              //Patatap - 100
      case 355: draw_patatap();break;                              //Patatap - 101
      case 356: draw_patatap();break;                              //Patatap - 102
      case 357: draw_patatap();break;                              //Patatap - 103
      case 358: draw_patatap();break;                              //Patatap - 104
      case 359: draw_patatap();break;                              //Patatap - 105
      case 360: draw_patatap();break;                              //Patatap - 106
      case 361: draw_parallelworlds();break;                       //ParallelWorlds - Regular - 107
      case 362: draw_parallelworlds();break;                       //ParallelWorlds - Slow - 108
      case 363: draw_parallelworlds();break;                       //ParallelWorlds - RedFlash - 109
      case 364: draw_parallelworlds();break;                       //ParallelWorlds - Reverse - 110
      case 365: draw_fireflies();break;                            //Fireflies - 111
      case 366: draw_multicrecy();break;                           //MultiCrecy - Low Intensity - 112
      case 367: draw_multicrecy();break;                           //MultiCrecy - Medium Intensity - 113
      case 368: draw_multicrecy();break;                           //MultiCrecy - High Intensity - 114
      case 369: draw_multicrecy();break;                           //MultiCrecy - Hardcore Intensity - 115
      case 370: draw_snake1();break;                               //Snake - 1 - 116
      case 371: draw_snake2();break;                               //Snake - 2 - 117
      case 372: draw_snake3();break;                               //Snake - 3 - 118
      case 373: draw_snake4();break;                               //Snake - 4 - 119
      case 374: draw_snake5();break;                               //Snake - 5 - 120
      case 375: draw_snake6();break;                               //Snake - 6 - 121      
      case 376: draw_periodicNoise();break;                        //PeriodicNoise - 122
      case 377: draw_sweepingBallsAndArrow();break;                //SweepingBallsAndArrows - 123
      case 378: draw_rotatingHalfCircle();break;                   //RotatingHalfCircle - 124
      case 379: draw_sinefuckedup(2);break;                        //FuckedUpSine3 - NO REINIT - 125
      case 380: draw_multicrecy();break;                           //MultiCrecy - Very low Intensity - 126
      case 381: draw_multicrecy();break;                           //MultiCrecy - Double Intensity - 127
      
      /////////START OF ANIMATION BANK 4//////////////
      
      case 382: draw_multicrecy();break;                           //MultiCrecy - Refrain - 1
      case 383: draw_nonotakPanelFill();break;                     //NonotakPanelFill - ExtremeLeft - 2
      case 384: draw_nonotakPanelFill();break;                     //NonotakPanelFill - ExtremeRight - 3
      case 385: draw_tumbler();break;                              //Tumbler - 4
      case 386: draw_dynamicAngleLinesWhite();break;               //Dynamic Angle Lines - White - 5
      case 387: draw_dynamicAngleLinesHalfRed();break;             //Dynamic Angle Lines - Half Red - 6
      case 388: draw_dynamicAngleLinesRed();break;                 //Dynamic Angle Lines - Red - 7
      case 389: draw_fauveRandomFlash();break;                     //FauveRandomFlash - 8
      case 390: draw_barWavesWhite();break;                        //BarWaves - White - 9
      case 391: draw_barWavesRed();break;                          //BarWaves - Red - 10
      case 392: draw_barWavesBlue();break;                         //BarWaves - Blue - 11
      case 393: draw_redSun();break;                               //RedSun - 12
      case 394: draw_slicedWaveWhite();break;                      //SlicedWave - White - 13
      case 395: draw_slicedWaveRed();break;                        //SlicedWave - Red - 14
      case 396: draw_dirtyAudioProcessing();break;                 //Audio Monitoring - 15
      case 397: draw_patatapWithAudioInput();break;                //Patatap with audio input - 16
      case 398: draw_hypnoAudio();break;                           //HypnoAudio - 17
      case 399: draw_hypnoAudio();break;                           //HypnoAudio - Without Audio (manual mode) - 18
      default: break;                                              //Default animation : do nothing, the screen will not be updated
    }
  }
  
  //At the end of every draw cycle, reset the impulse flags to prevent processing old audio data
  resetImpulseFlags();
}

void specific_draw_dmx() {
  if (drawStrobe_FrontLeft == 0) {                            //Stop the front stroboscopes
    myDMX.stopStrobe_FrontLeft();
  }
  if (drawStrobe_FrontRight == 0) {                           //Stop the front stroboscopes
    myDMX.stopStrobe_FrontRight();
  }
  if (drawStrobe_FrontLeft == 1) {                            //Start the front stroboscopes
    myDMX.setStrobePreset_FrontLeft(strobepreset_frontleft);
  }
  if (drawStrobe_FrontRight == 1) {                           //Start the front stroboscopes
    myDMX.setStrobePreset_FrontRight(strobepreset_frontright);
  }
  if (drawStrobe_Back == 0) {                                 //Stop the back stroboscopes
    myDMX.stopStrobe_Back();
  }
  if (drawStrobe_Back == 1) {                                 //Start the back stroboscopes
    myDMX.setStrobePreset_Back(strobepreset_back);
  }
}
