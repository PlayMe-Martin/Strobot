
//////////////////////////////////////////////////////////////
// Execute specific init actions according to the animation //
//////////////////////////////////////////////////////////////



void specificActions() {
    
  if (drawAnimation == 1)
  {
    
    //Reset the color mode
    colorMode(RGB);
    //size(PIXELS_X, PIXELS_Y);

    
    if (animationnumber == 1)         //Spiraluality
    {
      noStroke();
      frameRate(25);
    }
  
    else if (animationnumber == 2)    //Shadows
    {
      frameRate(50);
      noStroke();
    }
  
    else if (animationnumber == 3)    //Carglass
    {
      frameRate(50);
      strokeWeight(4);
      carglass_progress = 0;
      carglass_linelength = (width/2)*1.2;
    }
    
    else if (animationnumber == 4)    //Va et vient - 1
    {
      frameRate(100);
      va_et_vient_progress = 0;
      strokeWeight(8);
    }
    
    else if (animationnumber == 5)    //Va et vient - 2
    {
      frameRate(100);
      va_et_vient_progress = 0;
      strokeWeight(8);
    }

    else if (animationnumber == 6)    //Movie - noise
    {
      frameRate(18);
      initFlasher_progress = 0;
    }
    
    else if (animationnumber == 7)    //RedWhiteGlowingBalls
    {
      frameRate(50);
    }
      
    else if (animationnumber == 8)    //RedWhiteGlowingBalls - 2
    {
      frameRate(50);
    }
    
    else if (animationnumber == 9)    //FlashExtremeLeft
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawextremeleft = flash_sustain;
    }
    
    else if (animationnumber == 10)   //FlashExtremeRight
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawextremeright = flash_sustain;
    }
    else if (animationnumber == 11)   //Rotating Circles
    {
      colorMode(RGB, 255);
      ellipseMode(CENTER);
      frameRate(25);
    }
    else if (animationnumber == 12)   //Waveform
    {
      frameRate(25);
      noStroke();
      waveform_y_growing = 32;
    }
    else if (animationnumber == 13)   //Fadeout
    {
      rectMode(CORNER);
      colorMode(RGB, 255);
      frameRate(25);
    }
    else if (animationnumber == 14)   //FadeoutLeft
    {
      rectMode(CORNER);
      colorMode(RGB, 255);
      frameRate(25);
    }
    else if (animationnumber == 15)   //FadeoutCenter
    {
      rectMode(CORNER);
      colorMode(RGB, 255);
      frameRate(25);
    }
    else if (animationnumber == 16)   //FadeoutRight
    {
      rectMode(CORNER);
      colorMode(RGB, 255);
      frameRate(25);
    }

    else if (animationnumber == 17)   //Fadein
    {
      rectMode(CORNER);
      colorMode(RGB, 255);
      frameRate(25);
    }
    else if (animationnumber == 18)   //Worms
    {
      frameRate(25);
      smooth();
      noStroke();
      colorMode(HSB,255);
      worms = new Worm[numWorms];
      for (int i=0; i<numWorms; i++) {
        worms[i] = new Worm(random(0,64),random(0,64),random(0,2*PI));
      }
      pulsed = false;
    }
    else if (animationnumber == 19)   //Upwards Line
    {
        noSmooth();
        colorMode(RGB, 255);
        stroke(255);
        strokeWeight(8);
        line_height = height;
        frameRate(30);
    }
    else if (animationnumber == 20)   //Wind particles
    {
        frameRate(30) ;
        background(0) ;
        particle = new Particle[NUMPARTICLES] ;
        for ( int i = 0 ; i < NUMPARTICLES; i++) {
          particle[i] = new Particle(int(random(0,width)), int(random(0,height)), new PVector(0.0,0.0), color(min(random(210,255),255),0,min(random(0,100),255)));
        }
        wind = new Wind() ;   
        smooth() ;
    }
    else if (animationnumber == 21)   //Strobonormal
    {
      rectMode(CORNER);
      frameRate(25);
      noStroke();
      strokeWeight(8);
      background(0);
      colorMode(RGB);
    }
    else if (animationnumber == 22)   //PanelFillLines
    {
      if (panelFillListInit == false) {
        panelFillList = new ArrayList<PanelFillClass>();
        panelFillListInit = true;
      }
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      panelfilllines_draw = true;  
    }
    else if (animationnumber == 23)   //Symmetry
    {
      strokeWeight(4);
      strokeCap(ROUND);
      resetMatrix();
      frameRate(30);
      background(0);
      smooth();
      incrementMode();
    }
    else if (animationnumber == 24)   //FlashLeft
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawleft = flash_sustain;
    }
    else if (animationnumber == 25)   //FlashCenter
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawcenter = flash_sustain;
    }
    else if (animationnumber == 26)   //FlashRight
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawright = flash_sustain;
    }
    else if (animationnumber == 27)   //Rhombus
    {
      rectMode(CORNER);
      resetMatrix();
      colorMode(RGB);
      frameRate(25);
      rhombus_diaX = width/2;
    }    
    else if (animationnumber == 28)   //KaleidoTriangle
    {
      resetMatrix();
      frameRate(50);
      colorMode(RGB);
      trianglepos = 0;
    }
    else if (animationnumber == 29)   //GlitchTriangle
    {      
      resetMatrix();
      frameRate(25);    
      redImg = createChannel(0xff, 0x00, 0x00, 0);
      greenImg = createChannel(0x00, 0xff, 0x00, 0);
      blueImg = createChannel(0x00, 0x00, 0xff, 0);
    }
    else if (animationnumber == 30)   //GlitchLine
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);    
      redImg = createChannel(0xff, 0x00, 0x00, 1);
      greenImg = createChannel(0x00, 0xff, 0x00, 1);
      blueImg = createChannel(0x00, 0x00, 0xff, 1);
    }
    else if (animationnumber == 31)   //Snow
    {
      background(0);
      frameRate(50);
      for(snowflakecounter=0; snowflakecounter<snowMatrix.length; snowflakecounter=snowflakecounter+1)
      {
        snowMatrix[snowflakecounter]=new Floco(random(width), random(height), random(-snowflakemaxValue, snowflakemaxValue), random(1, 2), color(random(100, 255)));
      }
    }
    else if (animationnumber == 32)   //MechanicLines
    {
      frameRate(50);
      strokeWeight(12);
      strokeCap(SQUARE);
    }
    else if (animationnumber == 33)   //RedvsBlackvsWhite
    {
      smooth();
      frameRate(50);
      background(255);
      noStroke();
      strokeWeight(8);
      redvsblackvswhite_incr = (width/dots_row)*2;
      redvsblackvswhite_frameCount = 0;
      dots = new ArrayList();
     
      for (int y = int(- redvsblackvswhite_incr/2); y < height *1.3; y+= .9*redvsblackvswhite_incr) {
        if (one_off) {
          redvsblackvswhite_start = -redvsblackvswhite_incr/2;
          one_off = false;
        }
        else {
          redvsblackvswhite_start = 0;
          one_off = true;
        }
        for (int x = int(redvsblackvswhite_start); x < width ; x += redvsblackvswhite_incr) {
          dots.add(new Pulse(x, y));
          redvsblackvswhite_i++;
        }
      }    }
    else if (animationnumber == 34)   //RotatingSquare
    {
      rectMode(CORNER);
      frameRate(50);
      stroke(0);
      strokeWeight(rotatingSquare_strokeweight);
      if (rotatingSquare_init == false) {
        int rectangle_x, rectangle_y;
        int rectangle_size = height;
        int rectangle_strokeweight = 6; //strokeWeight
        int col = 255;
        rectangle_x = width/2;
        rectangle_y = height/2 ;
        TriRotElem[0] = new TriRot(rectangle_x, rectangle_y, rectangle_size, rectangle_strokeweight, col);
        rotatingSquare_init = true;
      }
    }
    else if (animationnumber == 35)   //MovingSine
    {
      frameRate(25);
      background(0);
      stroke(255);
      strokeWeight(1);
      movingsine_speed = 0.4;
      float movingsine_x = 0;
      float movingsine_theta = 0;
      for (int i = 0; i < SineElem.length; i++) {
        movingsine_x += width/movingsine_howMany;
        SineElem[i]= new ExLine(movingsine_x, movingsine_theta);
        movingsine_theta += PI/movingsine_howMany;
      }
    }
    else if (animationnumber == 36)   //FuckedUpSine1
    {
      frameRate(50);
      strokeWeight(4);
      noFill();
      smooth();
    }
    else if (animationnumber == 37)   //FuckedUpSine2
    {
      frameRate(50);
      strokeWeight(4);
      noFill();
      smooth();
    }
    else if (animationnumber == 38)   //FuckedUpSine3
    {
      frameRate(50);
      strokeWeight(4);
      noFill();
      smooth();
      sine_fuckedup_counter = 250;
      v = -6.45;
      w = 12.9;
    }
    else if (animationnumber == 39)   //ManualCircle
    {
      frameRate(50);
      smooth();
      noFill();
      strokeWeight(8);
      colorMode(RGB);
      stroke(0,172,255);
     
      dropcircle_x = width/2;
      dropcircle_y = height/2;
      rings.add(new CirclePulse(dropcircle_x, dropcircle_y, dropcircle_sz));    
    }
    else if (animationnumber == 40)   //AutomaticCircle
    {
      frameRate(50);
      smooth();
      noFill();
      strokeWeight(8);
      colorMode(RGB);
      stroke(0,172,255);
     
      dropcircle_x = width/2;
      dropcircle_y = height/2;
      //rings.add(new CirclePulse(dropcircle_x, dropcircle_y, dropcircle_sz));    
    }
    else if (animationnumber == 41)   //Rain
    {
      rectMode(CORNER);
      background(0);
      noStroke();
      smooth();
      frameRate(20);
      colorMode(RGB);

      int raindrops_i = 0;
      while (raindrops_i<howManyRainDrops) {
        raindrops_x[raindrops_i] = random(0, width);
        raindrops_y[raindrops_i] =random(0, height);
        raindrops_speed[raindrops_i] = random(0.3,2);
        raindrops_i +=1;
      }
    }
    else if (animationnumber == 42)    //PulseStar
    {
      pulsestar_R = height;
      pulsestar_N = 9;
      pulsestar_OMEGA = 0.2;
      fill(255);
      stroke(0);
      strokeWeight(4);
      strokeCap(ROUND);
      frameRate(50);
    }
    else if (animationnumber == 43)    //ArrowShape
    {
      frameRate(50);
    }
    else if (animationnumber == 44)    //Star2Sides
    {
      smooth();
      fill(255);
      noStroke();
      frameRate(50);
    }
    else if (animationnumber == 45)    //Star3Sides
    {
      smooth();
      fill(255);
      noStroke();
      frameRate(50);
    }
    else if (animationnumber == 46)    //Star4Sides
    {
      smooth();
      fill(255);
      noStroke();
      frameRate(50);
    }
    else if (animationnumber == 47)    //Star6Sides
    {
      smooth();
      fill(255);
      noStroke();
      frameRate(50);
    }
    else if (animationnumber == 48)    //Star8Sides
    {
      smooth();
      fill(255);
      noStroke();
      frameRate(50);
    }
    else if (animationnumber == 49)    //MovingLines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(6); 
    }
    else if (animationnumber == 50)    //MovingSquares
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke(); 
    }
    else if (animationnumber == 51)    //UpwardsGlitchLines
    {
      stroke(255);
      colorMode(RGB);
      // Line spacing
      upwards_glitchlines_a = 0;
      upwards_glitchlines_b = height/3;
      upwards_glitchlines_c = 2*height/3;
      
      upwards_glitchlines_interligne = height/8;
      upwards_glitchlines_speed = height/(height-1);
      upwards_glitchlines_count = 0;
      upwards_glitchlines_glitch_x = width/16; 
      upwards_glitchlines_glitch_y = height/24;  
      upwards_glitchlines_freq=10;
      strokeWeight(4);
    }
    else if (animationnumber == 52)    //DiagonalGlitchLines
    {
      stroke(255);
      frameRate(50);
      colorMode(RGB);
      // Initialisation des hauteurs des lignes
      diagonal_glitchlines_a = 0;
      diagonal_glitchlines_b = height/3;
      diagonal_glitchlines_c = 2*height/3;
      
      // initialisation des parametres
      diagonal_glitchlines_strokeWidth = 4;
      diagonal_glitchlines_speed = 2;
      diagonal_glitchlines_count = 0;
      strokeWeight(diagonal_glitchlines_strokeWidth);
    }
    else if (animationnumber == 53)    //CompressedLines
    {
      stroke(255);
      strokeWeight(4);
      frameRate(40);
      compressedlines_ratio = height;
    }
    else if (animationnumber == 54)    //PanelFillLeft
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      if (panelFillListInit == false) {
        panelFillList = new ArrayList<PanelFillClass>();
        panelFillListInit = true;
      }
      panelfill_draw = true;
      if (NUMBER_OF_PANELS == 3) {
        panelFillList.add(new PanelFillClass(0*(width/NUMBER_OF_PANELS), height, 0));
      }
      else {
        panelFillList.add(new PanelFillClass(1*(width/NUMBER_OF_PANELS), height, 0));
      }
      
    }
    else if (animationnumber == 55)    //PanelFillCenter
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      
      if (panelFillListInit == false) {
        panelFillList = new ArrayList<PanelFillClass>();
        panelFillListInit = true;
      }
      
      panelfill_draw = true;
      
      if (NUMBER_OF_PANELS == 3) {
        panelFillList.add(new PanelFillClass(1*(width/NUMBER_OF_PANELS), height, 1));
      }
      else {
        panelFillList.add(new PanelFillClass(2*(width/NUMBER_OF_PANELS), height, 1));
      }
    }
    else if (animationnumber == 56)    //PanelFillRight
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      
      if (panelFillListInit == false) {
        panelFillList = new ArrayList<PanelFillClass>();
        panelFillListInit = true;
      }
      
      panelfill_draw = true;
      
      if (NUMBER_OF_PANELS == 3) {
        panelFillList.add(new PanelFillClass(2*(width/NUMBER_OF_PANELS), height, 2));
      }
      else {
        panelFillList.add(new PanelFillClass(3*(width/NUMBER_OF_PANELS), height, 2));
      }
    }

    else if (animationnumber == 57)   //FlashLeftRed
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawleft = flash_sustain;
    }
    else if (animationnumber == 58)   //FlashCenterRed
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawcenter = flash_sustain;
    }
    else if (animationnumber == 59)   //FlashRightRed
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawright = flash_sustain;
    }
    else if (animationnumber == 60)    //MixedLines1
    {
      rectMode(CORNER);
      frameRate(50);
      stroke(255);
      init_mixedlines(0,2,0);
    }
    else if (animationnumber == 61)    //MixedLines2
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(2,0,0);
    }
    else if (animationnumber == 62)    //MixedLines3
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(1,3,0);
    }
    else if (animationnumber == 63)    //MixedLines4
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(3,1,0);
    }
    else if (animationnumber == 64)    //MixedLines5
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(1,2,0);
    }
    else if (animationnumber == 65)    //MixedLines6
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(2,3,0);
    }
    else if (animationnumber == 66)    //MixedLines7
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(1,3,2);
    }
    else if (animationnumber == 67)    //MixedLines8
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(3,1,2);
    }
    else if (animationnumber == 68)    //MixedLines9
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(0,0,1);
    }
    else if (animationnumber == 69)    //MixedLines10
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(0,0,2);
    }
    else if (animationnumber == 70)    //MixedLines11
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(0,0,3);
    }
    else if (animationnumber == 71)    //MixedLines12
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(0,0,4);
    }
    else if (animationnumber == 72)    //MixedLines13
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(0,0,5);
    }
    else if (animationnumber == 73)    //MixedLines14
    {
      frameRate(50);
      stroke(255);
      init_mixedlines(0,0,6);
    }
    else if (animationnumber == 74)    //StroboX
    {
      rectMode(CORNER);
      frameRate(25);
      stroke(255);
      strokeWeight(16);
      background(0);
    }
    else if (animationnumber == 75)    //DoubleGradient
    {
      rectMode(CORNER);
      //No initialization of the variables, as for this particular animation it is easier to play live this way
      //doublegradient_a = 0;
      //doublegradient_b = width;
      //doublegradient_direction = true;
      frameRate(50);
    }
    else if (animationnumber == 76)    //CarreMarshall
    {
      frameRate(13);
      stroke(255);
      fill(255);
      rectMode(CORNER);
      // Initialisation des hauteurs des lignes
      carreMarshall_a = 0;
    
      // initialisation des parametres
      carreMarshall_epaisseurLigne = 4;
      carreMarshall_interligne = 3*carreMarshall_epaisseurLigne/2;
      carreMarshall_vitesseLigne = 1;
      carreMarshall_largeurCarre = width/NUMBER_OF_PANELS;
      strokeWeight(carreMarshall_epaisseurLigne);
    }
    else if (animationnumber == 77)    //Fusee up
    {
      fusee_init(0);
    }
    else if (animationnumber == 78)    //Fusee down
    {
      fusee_init(1);
    }
    else if (animationnumber == 79)    //Fusee left
    {
      fusee_init(2);
    }
    else if (animationnumber == 80)    //Fusee right
    {
      fusee_init(3);
    }
    else if (animationnumber == 81)    //Fusee center Horizontal
    {
      fusee_init(4);
    }
    else if (animationnumber == 82)    //Fusee center Vertical
    {
      fusee_init(5);
    }
    else if (animationnumber == 83)    //Spots
    {
      frameRate(50);
      stroke(255);
      colorMode(RGB);
      spots_tailleCone = 4;
      strokeWeight(4);
    }
    else if (animationnumber == 84)    //MarshallStrobo
    {
      rectMode(CORNER);
      frameRate(25);
      stroke(255);
      fill(255);
      // Initialisation des hauteurs des lignes
      carreMarshall_a = 0;
    
      // initialisation des parametres
      carreMarshall_epaisseurLigne = 4;
      carreMarshall_interligne = 3*carreMarshall_epaisseurLigne/2;
      carreMarshall_vitesseLigne = 1;
      carreMarshall_largeurCarre = width/NUMBER_OF_PANELS;
      strokeWeight(carreMarshall_epaisseurLigne);
    }
    else if (animationnumber == 85)    //StroboLine
    {
      rectMode(CORNER);
      frameRate(50);
      colorMode(RGB);
      fill(255);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 86)    //UpwardsGlitchMixedLines
    {
      background(0);
      frameRate(40);
      stroke(255);
      fill(255);
      colorMode(RGB);
      // initialisation des parametres
      upwards_glitch_mixedlines_epaisseurLigne = 4;
      upwards_glitch_mixedlines_interligne = upwards_glitch_mixedlines_epaisseurLigne*3;
      strokeWeight(upwards_glitch_mixedlines_epaisseurLigne);
      strokeCap(SQUARE);
      upwards_glitch_mixedlines_speed = 1;
      
      // Initialisation des hauteurs des lignes
      upwards_glitch_mixedlines_b = height/2;
      upwards_glitch_mixedlines_c = 3*height/4;   
      upwards_glitch_mixedlines_d = height;
      
      upwards_glitch_mixedlines_e=upwards_glitch_mixedlines_b-upwards_glitch_mixedlines_interligne;
      upwards_glitch_mixedlines_f=upwards_glitch_mixedlines_c-upwards_glitch_mixedlines_interligne;
      upwards_glitch_mixedlines_g=upwards_glitch_mixedlines_d-upwards_glitch_mixedlines_interligne;
      
      upwards_glitch_mixedlines_ac = height/4;  
    }
    else if (animationnumber == 87)    //UpwardsGlitchMixedLines2
    {
      frameRate(40);
      stroke(255);
      
      // initialisation des parametres
      upwards_glitch_mixedlines_epaisseurLigne = 4;
      upwards_glitch_mixedlines_interligne = upwards_glitch_mixedlines_epaisseurLigne*3;
      strokeWeight(upwards_glitch_mixedlines_epaisseurLigne);
      strokeCap(SQUARE);
      upwards_glitch_mixedlines_speed = 1;
      
      // Initialisation des hauteurs des lignes
      upwards_glitch_mixedlines_b = height/2;
      upwards_glitch_mixedlines_c = 3*height/4;   
      upwards_glitch_mixedlines_d = height;
      
      upwards_glitch_mixedlines_e=upwards_glitch_mixedlines_b-upwards_glitch_mixedlines_interligne;
      upwards_glitch_mixedlines_f=upwards_glitch_mixedlines_c-upwards_glitch_mixedlines_interligne;
      upwards_glitch_mixedlines_g=upwards_glitch_mixedlines_d-upwards_glitch_mixedlines_interligne; 
      
      upwards_glitch_mixedlines_ac = 0;
      upwards_glitch_mixedlines_bc = height/4;
      upwards_glitch_mixedlines_cc = height/2;
      upwards_glitch_mixedlines_dc = 3*height/4; 
    }
    else if (animationnumber == 88)   //WideFlash
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawwide = flash_sustain;
    }
    else if (animationnumber == 89)    //Scope
    {
      frameRate(50);
      background(0);
      smooth();
      strokeCap(SQUARE);
    }
    else if (animationnumber == 90)    //SquareWaveGenerator
    {
      frameRate(50);
      strokeCap(ROUND);
      if (squarewave_alreadycalled == false)
        {
        squarewave_button = new int[width];
        for (int i = 1; i < width; i++) {
          squarewave_button[i] = 0;
        } 
        squarewave_timer = new int[width];
        for (int i = 1; i < width; i++) {
          squarewave_timer[i]   = 0;    
        }
      squarewave_alreadycalled = true;
      }
      strokeWeight(4);
      squarewave_signalpulse = true;   
      squarewave_signalframecounter = frameCount;
    }
    else if (animationnumber == 91)    //PixelLines
    {
      pixellines_color1 = new IntList();  
      pixellines_color2 = new IntList();
      pixellines_color1.append(color(236,208,120));
      pixellines_color1.append(color(217,91,67));
      pixellines_color1.append(color(192,41,66));
      pixellines_color1.append(color(84,36,55));
      pixellines_color1.append(color(83,119,122));

      pixellines_color2.append(color(236,208,120));
      pixellines_color2.append(color(217,91,67));
      pixellines_color2.append(color(192,41,66));
      pixellines_color2.append(color(84,36,55));
      pixellines_color2.append(color(83,119,122));  

      frameRate(10);
      noSmooth();
      strokeWeight(pixellines_strokeWidth);
    }
    else if (animationnumber == 92)    //SpiralTriangle
    {
      frameRate(50); 
    }
    else if (animationnumber == 93)    //Sonar
    {
      frameRate(50); 
      smooth();
    }
    else if (animationnumber == 94)    //SonarAllWhite
    {
      frameRate(70); 
      smooth();
    }
    else if (animationnumber == 95)    //Rorschach
    {
      frameRate(50);
      smooth();
      noStroke();
       
      resetParams(0);
      generateCircleImage();
      generateBalls();
    }
    else if (animationnumber == 96)    //Rorschach
    {
      frameRate(50);
      smooth();
      noStroke();
       
      resetParams(1);
      generateCircleImage();
      generateBalls();
    }
    else if (animationnumber == 97)    //Rorschach
    {
      frameRate(50);
      smooth();
      noStroke();
       
      resetParams(2);
      generateCircleImage();
      generateBalls();
    }
    else if (animationnumber == 98)    //Rorschach
    {
      frameRate(50);
      smooth();
      noStroke();
       
      resetParams(3);
      generateCircleImage();
      generateBalls();
    }
    else if (animationnumber == 99)    //Rorschach
    {
      frameRate(50);
      smooth();
      noStroke();
       
      resetParams(4);
      generateCircleImage();
      generateBalls();
    }

    else if (animationnumber == 100)    //RorschachSetColor
    {
      frameRate(50);
      smooth();
      noStroke();
      randomColor = true;
      backgroundColor = color(0);
      ballColor = color(255,0,0);
      switch(movementMode)
      {
        case 0 : animationnumber = 95;break;
        case 1 : animationnumber = 96;break;
        case 2 : animationnumber = 97;break;
        case 3 : animationnumber = 98;break;
        case 4 : animationnumber = 99;break;
      }
      specificActions();
    }
    else if (animationnumber == 101)    //RorschachSetBlack&White
    {
      frameRate(50);
      smooth();
      noStroke();
      randomColor = false;
      backgroundColor = color(0);
      ballColor = color(255);
      switch(movementMode)
      {
        case 0 : animationnumber = 95;break;
        case 1 : animationnumber = 96;break;
        case 2 : animationnumber = 97;break;
        case 3 : animationnumber = 98;break;
        case 4 : animationnumber = 99;break;
      }
      specificActions();
    }
    else if (animationnumber == 102)    //StroboRed
    {
      rectMode(CORNER);
      frameRate(25);
      noStroke();
      background(0);
    }
    else if (animationnumber == 103)    //LowLeft
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      fill(255);
      background(0);
    }
    else if (animationnumber == 104)    //HiLeft
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      fill(255);
      background(0);
    }
    else if (animationnumber == 105)    //LowMid
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      fill(255);
      background(0);
    }
    else if (animationnumber == 106)    //HiMid
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      fill(255);
      background(0);
    }
    else if (animationnumber == 107)    //LowRight
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      fill(255);
      background(0);
    }
    else if (animationnumber == 108)    //HiRight
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      fill(255);
      background(0);
    }
    else if (animationnumber == 109)    //WhiteOut
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      fill(255);
      background(255);
    }
    else if (animationnumber == 110)    //BlackOut
    {
      rectMode(CORNER);
      frameRate(50);
      noStroke();
      fill(0);
      background(0);
    }

    else if (animationnumber == 111)    //Upwards Line White Out
    {
      rectMode(CORNER);
      colorMode(RGB, 255);
      frameRate(30);
      stroke(0);
      strokeWeight(16);
      background(255);
    }
    else if (animationnumber == 112)    //Lines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 113)    //Lines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 114)    //Lines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 115)    //Lines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 116)    //Lines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 117)    //Lines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 118)    //Lines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 119)    //Lines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 120)    //Lines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 121)    //Lines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 122)    //Unfolding Lines
    {
      rectMode(CORNER);
      background(0);
      strokeWeight(4);
      stroke(255);
      frameRate(50);
      smooth();
      supposed_height = 1;  

    }
    else if (animationnumber == 123)    //Superformula
    {
      background(0);
      noStroke();
      frameRate(50);
      smooth();
      strokeWeight(2);
      superformula_change();
    }
    else if (animationnumber == 124)    //GrowingTriangles
    {
      smooth();
      frameRate(50);
      strokeWeight(8);
       
      noFill();
      background(0);
      trianglelist.add(new growingTriangle());
      stroke(255);
    }
    else if (animationnumber == 125)    //Moire
    {
      int divs = 8;
      frameRate(50);
      moireOne = new moire(width/2,height*7/15,0,divs);
      moireTwo = new moire(width/2,height*8/15,0,divs);
    }
    else if (animationnumber == 126)   //Tetris
    {
      frameRate(15);
      textSize(24);
      textAlign(CENTER, CENTER);
      board = new Grid(0, 0, width, height, 8, 4*NUMBER_OF_PANELS);
      setup_tetris();
    }
    else if (animationnumber == 127)   //Pong
    {
      frameRate(35);
      noStroke();
      textSize(28);  
      textAlign(CENTER, CENTER);
      font = loadFont("Gobold-28.vlw");
      textFont(font,64);
      pongball= new Ball();
      bottom=new Paddle();
      top=new Paddle();
      top.y=0;
      gamestart = true;
    }


    /////////START OF ANIMATION BANK 2//////////////
    
    else if (animationnumber == 128)   //ResponsiveCirclesBW
    {
     noStroke();
     smooth();
     frameRate(50);
     if (responsiveCircles_alreadycalled == false) {
       responsiveCircles_x = -48 ;
       responsiveCircles_y = height/2;      
     }
     responsiveCircles_alreadycalled = true;
    }
    else if (animationnumber == 129)   //ResponsiveCircles
    {
     noStroke();
     smooth();
     frameRate(50);
     if (responsiveCircles_alreadycalled == false) {
       responsiveCircles_x = -48 ;
       responsiveCircles_y = height/2;      
     }
     responsiveCircles_alreadycalled = true;
    }
    else if (animationnumber == 130)   //ParticlesExplode
    {
      //colorMode(RGB, 360, 100, 100);
      background(0,100,0); 
      frameRate(50);
      if (particlesexplode_alreadyinitialised == false) {
        arr = new ArrayList<ParticleExplode>();
      }
      particlesexplode_alreadyinitialised = true;
      
      for(int i = 0; i < 3; i++){
        particleColor = color(random(50,100), random(180,220), random(220,250));
        for(int j = 0; j < 10; j++){
          for (int k = 0; k<NUMBER_OF_PANELS; k++) {
            arr.add(new ParticleExplode(new PVector((2*k + 1)*width/(NUMBER_OF_PANELS*2), height/2), particleColor));
          }
        }
      }
    }
   else if (animationnumber == 131)   //ProgressiveRed
    {
      frameRate(50);
      progressivered_color = 0;
      
      /*        //Ex-Starfield
      noStroke();
      smooth();
      frameRate(25);
       
      starfield_initialize(starfield_asteroids1, 0.90, width/16,  #FA4913, 125);
      starfield_initialize(starfield_asteroids2, 0.75, width/16,   #FE8333, 180);
      //starfield_initialize(asteroids3, 0.25, 2,   #B878C6, 150);
      starfield_initialize(starfield_satellite,   0.10, width/4, #E1CAAB, float(5*width/6), float(2*height/6));
      starfield_initialize(starfield_planet,     0.01, width, #17455C, float(width/6), float(5*height/6));
      ¨*/
    }
   else if (animationnumber == 132)   //ColorVertex
    {
      smooth();
      colorvertex_pointarray = new ArrayList();
      for (int i=0;i<30;i++) {
        colorvertex_pointarray.add(new colorvertex_Dots(new PVector(random(-50, 50), random(-50, 50))));
      }
    }
    else if (animationnumber == 133)    //ParticlesFlow
    {
      frameRate(50);
      colorMode(HSB, 255);
     
      particlesflow_currFrame = new int[width*height];
      particlesflow_prevFrame = new int[width*height];
      particlesflow_tempFrame = new int[width*height];
      for(int i=0; i<width*height; i++) {
        particlesflow_currFrame[i] = color(0, 0, 0);
        particlesflow_prevFrame[i] = color(0, 0, 0);
        particlesflow_tempFrame[i] = color(0, 0, 0);
      }
     
      particlesflow_particles = new ParticleFlow[(width+particlesflow_particleMargin*2)/particlesflow_particlesDensity*(height+particlesflow_particleMargin*2)/particlesflow_particlesDensity];
      int i = 0;
      for(int y=-particlesflow_particleMargin; y<height+particlesflow_particleMargin; y+=particlesflow_particlesDensity) {
        for(int x=-particlesflow_particleMargin; x<width+particlesflow_particleMargin; x+=particlesflow_particlesDensity) {
           if (i == particlesflow_particles.length) {
             //println(i);
             break;
           }
           int c = color(100+50*sin(PI*x/width), 127, 255*sin(PI*y/width));
           particlesflow_particles[i++] = new ParticleFlow(x, y, c);
        }
      }
    }
    else if (animationnumber == 134)    //BezierFlowers
    {
      background(0);
      stroke(255);
      strokeWeight(2);
      frameRate(50);
      colorMode(HSB, 255);
       
      for(int i = 0; i < bezierflowers_MAX_POINT; i++){
        bezierflowers_controlpoints[i] = new ControlPoint();
      }
      bezierflowers_initialize();
    }
    else if (animationnumber == 135)    //JointCircles
    {
      frameRate(50);
      fill(255);
      stroke(255);
      strokeWeight(2);
    }
    else if (animationnumber == 136)    //TunnelWhite
    {
      frameRate(50);  
      noStroke();
      strokeWeight(2);
      smooth();
      background(0);
      for (int i=0; i<tunnel_num; i++) {
        float var = map(i, 0, tunnel_num-1, 0, PI);
        tunnel_grises[i]=10+235*sin(var);
      }
      tunnel_color_counter = 0;
    }
    else if (animationnumber == 137)    //TunnelRed
    {
      
      frameRate(50);  
      strokeWeight(2);
      noStroke();
      smooth();
      background(0);
      for (int i=0; i<tunnel_num; i++) {
        float var = map(i, 0, tunnel_num-1, 0, PI);
        tunnel_grises[i]=10+235*sin(var);
      }
      tunnel_color_counter = 1;
    }
    else if (animationnumber == 138)    //CosmoCurve
    {
      cosmoscurve_center = new PVector(width/2,height/2);
      colorMode(RGB);
      frameRate(50);
      background(0);
      smooth();
      noStroke();
    }
    else if (animationnumber == 139)    //PerlinColor
    {
      noiseDetail(10);
      frameRate(50);
      background(255);
      noStroke();
      //colorMode(HSB, 30.0, 255, 1.0, 255);
      colorMode(HSB);
      for(int i=0; i<colorperlin_myAngleThing.length; i++){
        int theLength = colorperlin_myAngleThing[0].length;
        for(int j=0; j<theLength; j++){
          int tempX = (int)(width/(colorperlin_numX-10.0)*(i-4));
          int tempY = (int)(height/(colorperlin_numY-10.0)*(j-4));
          //float theHue = PI+atan2((float)tempY-(float)colorperlin_height/2.0, (float)tempX-(float)colorperlin_width/2.0);
          colorperlin_myAngleThing[i][j] = new AngleThing(tempX, tempY);
          colorperlin_myAngleThing[i][j].render();
        }
      }
    }
    else if (animationnumber == 140)   //LineWideFlash
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawwide = flash_sustain;
    }
    else if (animationnumber == 141)   //LineLeftFlash
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawwide = flash_sustain;
    }
    else if (animationnumber == 142)   //LineCenterFlash
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawwide = flash_sustain;
    }
    else if (animationnumber == 143)   //LineRightFlash
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawwide = flash_sustain;
    }
    else if (animationnumber == 144)    //LongWideFlash
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawwide = flash_sustain*4;
    }
    else if (animationnumber == 145)    //OppositeLinesNoBackground
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      noStroke() ;
      fill(255) ;
    }
    else if (animationnumber == 146)    //OpeningLines
    {
      frameRate(50);
      background(0);
      stroke(255);
      strokeWeight(8); 
    }
    else if (animationnumber == 147)    //OpeningLinesReinit
    {
      frameRate(50);
      background(0);
      stroke(255);
      strokeWeight(8); 
      openinglines_x = 0;
    }
    else if (animationnumber == 148)    //WhiteNoise
    {
      frameRate(50);
      noStroke();
      noFill(); 
      rectMode(CORNER);
    }
    else if (animationnumber == 149)    //SingleSquareSpiral
    {
      frameRate(50);
      noStroke();
      rectMode(CORNER);
    }
    else if (animationnumber == 150)    //DualSquareSpiral
    {
      frameRate(50);
      noStroke();
      rectMode(CORNER);
    }
    else if (animationnumber == 151)    //ComplexSpiralReinit
    {
      colorMode(HSB);
      frameRate(50);
      stroke(0,0,0);
      fill(0);
      strokeWeight(6);
      rectMode(CORNER);
      complexspiral_counter = 0;
    }
    else if (animationnumber == 152)    //ComplexSpiral
    {
      colorMode(HSB);
      frameRate(50);
      stroke(0,0,0);
      fill(0);
      strokeWeight(6);
      rectMode(CORNER);
    }
    else if (animationnumber == 153)    //BeatCircle
    {
      frameRate(50);
      noStroke();
      if (beatcircle_counter %2 == 0)
      {fill(255);}
      else
      {fill(255,0,0);}
      beatcircle_counter += 1;
      beatcircle_radius = 64;
    }
    else if (animationnumber == 154)    //BeatCircleLinesReinit
    {
      frameRate(50);
      strokeWeight(8);
      strokeCap(SQUARE);
      noStroke();
      if (beatcircle_counter %2 == 0)
      {fill(255);}
      else
      {fill(255,0,0);}
      beatcircle_counter += 1;
      beatcircle_radius = 64;
      beatcircles_linepos = 0;
    }
    else if (animationnumber == 155)    //BeatCircleLines
    {
      frameRate(50);
      strokeWeight(8);
      strokeCap(SQUARE);
      noStroke();
      if (beatcircle_counter %2 == 0)
      {fill(255);}
      else
      {fill(255,0,0);}
      beatcircle_counter += 1;
      beatcircle_radius = 64;
      beatcircles_linepos +=1;
    }
    else if (animationnumber == 156)    //BeatCircleColorLines1
    {
      frameRate(50);
      strokeWeight(8);
      strokeCap(SQUARE);
      noStroke();
      if (beatcircle_counter %2 == 0)
      {fill(255);}
      else
      {fill(255,0,0);}
      beatcircle_counter += 1;
      beatcircle_radius = 64;
      beatcircles_linepos +=1;
    }
    else if (animationnumber == 157)    //BeatCircleColorLines2
    {
      frameRate(50);
      strokeWeight(8);
      strokeCap(SQUARE);
      noStroke();
      if (beatcircle_counter %2 == 0)
      {fill(255);}
      else
      {fill(255,0,0);}
      beatcircle_counter += 1;
      beatcircle_radius = 64;
      beatcircles_linepos +=1;
    }
    else if (animationnumber == 158)    //CosmoCurveReinit
    {
      cosmoscurve_center = new PVector(width/2,height/2);
      colorMode(RGB);
      frameRate(50);
      background(0);
      smooth();
      noStroke();
      cosmoscurve_n = 0;
      cosmoscurve_d = 2;
    }
    else if (animationnumber == 159)    //RedDiagonalLines
    {
      frameRate(50);
      background(0);
      stroke(255,0,0);
      strokeWeight(8);
      redposx = 0;
      redposy = 0;
  
    }
    else if (animationnumber == 160)    //BlueDiagonalLines
    {
      frameRate(50);
      stroke(0,0,255);
      strokeWeight(8);
      blueposx = 0;
      blueposy = 0;
    }
    else if (animationnumber == 161)    //WhiteNoiseCrescendo
    {
      frameRate(50);
      noStroke();
      noFill(); 
      rectMode(CORNER);
      whitenoisecrescendo_brightness = 20;
    }
    else if (animationnumber == 162)    //TriangleStrobo
    {
      frameRate(50);
      stroke(255);
      strokeWeight(8);
    }
    else if (animationnumber == 163)    //BlueDiagonalLines2
    {
      frameRate(50);
      stroke(0,0,255);
      strokeWeight(8);
      blueposx = 0;
      blueposy = 0;
    }
    else if (animationnumber == 164)    //BlueDiagonalLines3
    {
      frameRate(50);
      stroke(0,0,255);
      strokeWeight(8);
      blueposx = 0;
      blueposy = 0;
    }
    else if (animationnumber == 165)    //RedDiagonalLines2
    {
      frameRate(50);
      stroke(255,0,0);
      strokeWeight(8);
      redposx = 0;
      redposy = 0;
    }
    else if (animationnumber == 166)    //WhiteDiagonalLines
    {
      frameRate(50);
      strokeWeight(8);
      blueposx = 0;
      blueposy = 0;
    }
    else if (animationnumber == 167)    //WhiteDiagonalLines2
    {
      frameRate(50);
      strokeWeight(8);
      redposx = 0;
      redposy = 0;
    }
    else if (animationnumber == 168)    //WhiteStraightLines
    {
      frameRate(50);
      stroke(255);
      strokeWeight(8);
      redposx = 0;
      redposy = 0;
    }
    else if (animationnumber == 169)    //InwardsSpiral
    {
      background(0);
      frameRate(50);
      noStroke(); 
      inwardsspiral_counter = 0;
    }
    else if (animationnumber == 170)    //InwardsSpiralReverse
    {
      frameRate(50);
      noStroke(); 
      inwardsspiral_counter = 0;
    }
    else if (animationnumber == 171)    //ExplodingCircle
    {
      background(0);
      frameRate(50);
      stroke(255); 
      noFill();
      strokeWeight(28);
      explodingcircle_counter = 0;
    }
    else if (animationnumber == 172)    //RotozoomWhite
    {
      frameRate(50);
      colorMode(RGB);
    }
    else if (animationnumber == 173)    //NewtonPendulum
    {
      noStroke();
      frameRate(50);
      fill(255);
      stroke(255);
      strokeWeight(4);
      newtonpendulum_lengths[0] = 0.00009;
      for(int i=1;i<30;i++){
        //arrange newtonpendulum_lengths so frequency difference between WavePendulums is constant
        newtonpendulum_lengths[i] = newtonpendulum_g*newtonpendulum_lengths[i-1]/( newtonpendulum_g + 4*PI*PI*newtonpendulum_lengths[i-1] + 4*PI*sqrt(newtonpendulum_g*newtonpendulum_lengths[i-1]) );
      }
      newtonpendulum_pends = new ArrayList();
      for(int i=0; i<30; i++){
        newtonpendulum_p = new WavePendulum(newtonpendulum_lengths[i],0.2);
        newtonpendulum_pends.add(newtonpendulum_p);
      }
    }
    else if (animationnumber == 174)    //HypnoPendulum
    {
      frameRate(50);
      colorMode(RGB);
      hypnopendulum_lengths[0] = 400;
      for(int i=1;i<pendulum_n;i++){
        //arrange lengths so frequency difference between HypnoWheelPendulums is constant
        hypnopendulum_lengths[i] = hypnopendulum_lengths[i-1] - 2;
      }
       
       
      hypnopendulum_pends = new ArrayList();
      for(int i=0; i<pendulum_n; i++){
        hypnopendulum_p = new HypnoWheelPendulum(hypnopendulum_lengths[i],color(150*(i%4),0,0));
        hypnopendulum_pends.add(hypnopendulum_p);
      }
      smooth();
    }
    else if (animationnumber == 175)    //LargeWheelPendulum
    {
      frameRate(50);
      colorMode(RGB);
      wheelpendulum_lengths[0] = 200;
      for(int i=1;i<pendulum_n;i++){
        //arrange lengths so frequency difference between LargeWheelPendulums is constant
        wheelpendulum_lengths[i] = wheelpendulum_lengths[i-1] - 1;
      }
      wheelpendulum_pends = new ArrayList();
      for(int i=0; i<pendulum_n; i++){
        if ((i%4) != 0) {
          wheelpendulum_p = new LargeWheelPendulum(wheelpendulum_lengths[i],color(205*(i%4),0,0));
        }
        else {
          wheelpendulum_p = new LargeWheelPendulum(wheelpendulum_lengths[i],color(255,255,255));
        }
        wheelpendulum_pends.add(wheelpendulum_p);
      }
      smooth();
    }
    else if (animationnumber == 176)    //Mugen
    {
      smooth();
      mugen_xamp = 0;    //5*width/12;
      mugen_yamp = 0;    //3*height/8;
      background(0);
      frameRate(50);
      strokeCap(ROUND);
      colorMode(RGB); 
      
    }  
    else if (animationnumber == 177)    //ArcWave
    {
      colorMode(RGB);
      frameRate(60);
      arcwave_maxi=(int)sqrt(width/2*height/2)*4;
      background(0);
      arcwave_arcs= new ArcWaveClass[5];
      arcwave_ray = 0;
      for(int a=0;a<5;a++){
        arcwave_arcs[a]=new ArcWaveClass(width/2,height/2,32+a*32);
      }
      arcwave_arcs=(ArcWaveClass[]) reverse(arcwave_arcs);
      noFill();
      stroke(255);
      strokeWeight(8);
      smooth();
      strokeCap(ROUND);
  
    }
    else if (animationnumber == 178)    //OutwardSpiralWhite
    {
      outwardspiral_init();
    }
    else if (animationnumber == 179)    //OutwardSpiralBlue
    {
      outwardspiral_init();
    }
    else if (animationnumber == 180)    //OutwardSpiralRed
    {
      outwardspiral_init();
    }
    else if (animationnumber == 181)    //ColumnsWhite
    {
      frameRate(50);
      colorMode(RGB);
      columns_firstheight2 = height - columns_offsety - columns_firstheight1;
      columns_secondheight2 = height - columns_offsety - columns_secondheight1;
      columns_thirdheight2 = height - columns_offsety - columns_thirdheight1;
      columns_shift = false;
    }
    else if (animationnumber == 182)    //ColumnsBlack
    {
      frameRate(50);
      colorMode(RGB);
      columns_firstheight2 = height - columns_offsety - columns_firstheight1;
      columns_secondheight2 = height - columns_offsety - columns_secondheight1;
      columns_thirdheight2 = height - columns_offsety - columns_thirdheight1;
      columns_shift = true;
    }
    else if (animationnumber == 183)    //CircleContour
    {
      frameRate(25);
      background(0);
      colorMode(HSB);
      smooth();
    }
    else if (animationnumber == 184)    //ColorExplode
    {
      
      background(0);
      strokeWeight(4); 
      colorexplode_intcounter = 0;
      //colorMode(HSB,1);
      colorMode(HSB);
  
      for(int i = 0; i < colorexplode_Z.length; i++) {
        colorexplode_Z[i] = new colorexplode_particle(random(width), random(height), random(-.5,.5), random(-.5,.5), 1);
      }
        
      frameRate(50);
      
    }
  
    else if (animationnumber == 185)    //ColorRain
    {
      frameRate(30);
      colorMode(HSB);
      noFill();
      background(0);
      strokeWeight(1);
      noStroke();
      colorrain_cells = new colorrain_CellArray((float)width, (float)height, width/4, height/4);
    }
    else if (animationnumber == 186)    //WarpSpeed
    {
      frameRate(50); 
    }
    else if (animationnumber == 187)    //BWTriangles
    {
      frameRate(50); 
      background(0);
      strokeWeight(0.1);
      createParticleSystem();
    }
    else if (animationnumber == 188)    //GlitchDiagonalLines
    {
      frameRate(50);
      strokeWeight(3);
      for (int i = 0; i < glitchdiagonallines_num; i++) {
        //glitchdiagonallines_particleArray[i] = new glitchdiagonallines_Particle ((int)random(width),(int)random(height));
        glitchdiagonallines_particleArray[i] = new glitchdiagonallines_Particle ((int)random(width), (int)random(height)); 
        //glitchdiagonallines_particleArray[i] = new glitchdiagonallines_Particle (width/2, height/2);
      }
    }
    
    else if (animationnumber == 189)    //FlashingDotsBorder
    {
      frameRate(50);
      strokeWeight(0);
      stroke(255);
      fill(255);
      // initialize values of grid
      for (int j=0; j<flashingdotsborder_y.length; j++) {
        for (int i=0; i<flashingdotsborder_x.length; i++) {
          flashingdotsborder_x[i]=(width/(flashingdotsborder_num-1))*i;
          flashingdotsborder_y[j]=(height/(flashingdotsborder_num-1))*j;
        }
      }
    }
    else if (animationnumber == 190)    //FallingCircles
    {
      background(0);
      smooth();
      colorMode(HSB);
      strokeWeight(1);
      frameRate(50);
      fallingCircles = new FallingCircles(NUMBER_OF_PANELS*4);
      fallingcircles_fade = 40;
  
    }
    else if (animationnumber == 191)    //SetExplodingParticles
    {
      frameRate(30);
      colorMode(HSB);
      strokeWeight(4);
      for (int i=0;i<nbExplodingParticles;i++) {
        explodingparticle[i]=new ExplodingParticles();
      }
      fill(0,100);
      ExplodingParticles_explodeflag = true;
    }
    else if (animationnumber == 192)    //ReleaseExplodingParticles
    {
      frameRate(30);
      colorMode(HSB);
      strokeWeight(4);
      for (int i=0;i<nbExplodingParticles;i++) {
        explodingparticle[i]=new ExplodingParticles();
      }
      fill(0,100);
      ExplodingParticles_explodeflag = false;
    }
    else if (animationnumber == 193)    //RandomBWFlow
    {
      frameRate(50);
      for (int y = 0; y < randomBWFlow_resolutionY; y ++) {
        randomBWFlow_wind[y] = 1 * sin(4 * PI * y / randomBWFlow_resolutionY);
        for (int x = 0; x < randomBWFlow_resolutionX; x ++) {
          randomBWFlow_flow[x][y] = new PVector();
          //randomBWFlow_flow[x][y] = new PVector(0.2 - random(0.4), 0.2 - random(0.4));
        }
      }
      for (int i = 0; i < randomBWFlow_particleCount; i ++) {
        bwflowparticle[i] = new RandomBWFlowParticle(random(randomBWFlow_resolutionX),
          random(randomBWFlow_resolutionY));
      }
    }
    else if (animationnumber == 194)    //Tesselate
    {
      smooth();
      noStroke();
      strokeJoin(ROUND);
      background(0);
      frameRate(50);
      tesselate_size_point_x = width/2;
    }    
    else if (animationnumber == 195)    //DigitalHexParticles
    {
      background(0);
      noFill();
      strokeWeight(4);
      strokeCap(ROUND);
      noSmooth();
      frameRate(50);
      digitalhexparticleSystem = new DigitalHexParticleSystem(10);
    }

    else if (animationnumber == 196)    //RedArcTransition
    {
      frameRate(50);
      //background(0);
      stroke(255,0,0,70);
      strokeWeight(4);
      redarctransition_bottomtopx = width;
      redarctransition_bottomtopy = width;
      redarctransition_bottomdownx = 0;
      redarctransition_bottomdowny = width;
      redarctransition_x1 = 0;
      redarctransition_y1 = 0;
      redarctransition_x2 = 0;
      redarctransition_y2 = width;
      redarctransition_x21 = 0;
      redarctransition_y21 = 0;
      redarctransition_x22 = width;
      redarctransition_y22 = 0;
      redarctransition_topleftx = 0;
      redarctransition_toplefty = 0;
      redarctransition_toprightx = width;
      redarctransition_toprighty = 0;
    }
    else if (animationnumber == 197)    //BlueArcTransition
    {
      frameRate(50);
      //background(0);
      stroke(0,0,255,70);
      strokeWeight(4);
      redarctransition_bottomtopx = width;
      redarctransition_bottomtopy = width;
      redarctransition_bottomdownx = 0;
      redarctransition_bottomdowny = width;
      redarctransition_x1 = 0;
      redarctransition_y1 = 0;
      redarctransition_x2 = 0;
      redarctransition_y2 = width;
      redarctransition_x21 = 0;
      redarctransition_y21 = 0;
      redarctransition_x22 = width;
      redarctransition_y22 = 0;
      redarctransition_topleftx = 0;
      redarctransition_toplefty = 0;
      redarctransition_toprightx = width;
      redarctransition_toprighty = 0;
    }
    else if (animationnumber == 198)    //LightBlobs
    {
     frameRate(50);
     lightblobs_w = int(width*lightblobs_scale);
     lightblobs_h = int(height*lightblobs_scale);
       
     lightblobs_pg = createGraphics(lightblobs_w, lightblobs_h);
       
     for (int i=0; i<lightblobs_numBlobs; i++) {
     lightblobs_b[i] = new lightblobs_Blob(random(lightblobs_w),random(lightblobs_h),random(-1,1),random(-1,1), 1+random(15));
     }

    }
    else if (animationnumber == 199)    //RandomSmokeParticles
    {
      frameRate(50);
      colorMode(HSB);
      smooth();
      background(#ffffff);
      smokeparticles_seed = (int) random(2531, 15824);
      noStroke();
      filter(INVERT);      
    }
    else if (animationnumber == 200)    //RedMetaBalls
    {
      colorMode(HSB);
      redmetaballs_w = width/2;
      redmetaballs_h = height/2;
      frameRate(50);
      redmetaballs_pg = createGraphics(redmetaballs_w, redmetaballs_h);
       
      for (int i=0; i<redmetaballs_numBlobs; i++) {
        redmetaballs_b[i] = new redmetaballs_Blob(random(redmetaballs_w),random(redmetaballs_h),random(-1,1),random(-1,1));
      }
    }
    else if (animationnumber == 201)    //Butterfly
    {
      background(0);
      noFill();
      frameRate(60);
      noSmooth();
      strokeWeight(1);
      butterfly_s = random(90, 100);    
    }
    else if (animationnumber == 202)    //CirclePusherRotate
    {
      frameRate(50);
      circlepusher_setAngleRotate = true;
      if (circlepusher_alreadyGenerated == false) {
        circlepusher_initialize_circles();
      }
      circlepusher_alreadyGenerated = true;
      stroke(255);
      strokeWeight(1);
      fill(255);
      smooth();
    }
    else if (animationnumber == 203)    //CirclePusherStraight
    {
      frameRate(50);
      circlepusher_setAngleRotate = false;
      if (circlepusher_alreadyGenerated == false) {
        circlepusher_initialize_circles();
      }
      circlepusher_alreadyGenerated = true;
      stroke(255);
      fill(255);
      smooth();
    }
    else if (animationnumber == 204)    //Shutter
    {
      frameRate(50);
      strokeWeight(1);
      noStroke();
      rectMode(CENTER);
      shutter_colorMode = (shutter_colorMode + 1) % 3;
      shutter_distance = shutter_distanceInit;
    }
    else if (animationnumber == 205)    //OrbitingParticles
    {
      frameRate(60);
      background(0);
      strokeWeight(8);
      stroke(255);
      colorMode(RGB);
      strokeCap(ROUND);
      noSmooth();
      if (orbitingparticles_initialised == false) {
        orbitingparticles_particlelist = new OrbitingParticle[orbitingparticles_number];
        
        //The first particle shall be red
        orbitingparticles_particlelist[0] = new OrbitingParticle(orbitingparticles_globalx,orbitingparticles_globaly,orbitingparticles_dispersion,random(orbitingparticles_speedmin, orbitingparticles_speedmax), color(255,0,0));
        
        for (int i = 1; i< orbitingparticles_number;i++) {
          orbitingparticles_particlelist[i] = new OrbitingParticle(orbitingparticles_globalx,orbitingparticles_globaly,orbitingparticles_dispersion,random(orbitingparticles_speedmin, orbitingparticles_speedmax), color(255));
        }
      }
      orbitingparticles_initialised = true;
      orbitingparticles_changefocus();
    }
    else if (animationnumber == 206)    //Vines
    {
      frameRate(50);
      strokeWeight(1);
      noFill();
      if (flowing_lines_init == false) {
        flowing_lines_Path = new FlowingLinePath();
        //flowing_lines_lines = new FlowingLine[] { new FlowingLine(color(222,56,75), 30f, 80, 20f), 
        //                                          new FlowingLine(color(255,170,0), 15.0f, 50, 15f), 
        //                                          new FlowingLine(color(255,0,0), -15.0f, 45, 15f) };
        flowing_lines_lines = new FlowingLine[] { new FlowingLine(color(255,255,255), 30f, 80, 20f), 
                                                    new FlowingLine(color(160,160,160), 15.0f, 50, 15f), 
                                                    new FlowingLine(color(255,0,0), -15.0f, 45, 15f) };
        
      }
      flowing_lines_init = true;
    }
    else if (animationnumber == 207)    //ArrowStyle
    {
      noFill();
      frameRate(50);
      colorMode(RGB); 
      strokeWeight(16);
      strokeCap(SQUARE);
      stroke(255);
      arrowstyle_pos = - 0.9*height;
      arrowstyle_height = height/2; 
    }
    else if (animationnumber == 208)    //SingleArrow - Up-Down White
    {
      singlearrow_setup();
      singlearrow_arrowlist.add(new SingleArrow(0,height/2,color(255)));
    }
    else if (animationnumber == 209)    //SingleArrow - Left-Right White
    {
      singlearrow_setup();
      singlearrow_arrowlist.add(new SingleArrow(1,height/2,color(255)));
    }
    else if (animationnumber == 210)    //SingleArrow - Right-Left White
    {
      singlearrow_setup();
      singlearrow_arrowlist.add(new SingleArrow(2,height/2,color(255)));
    }
    else if (animationnumber == 211)    //SingleArrow - Down-Up White
    {
      singlearrow_setup();
      singlearrow_arrowlist.add(new SingleArrow(3,height/2,color(255)));
    }
    else if (animationnumber == 212)    //SingleArrow - Up-Down Red
    {
      singlearrow_setup();
      singlearrow_arrowlist.add(new SingleArrow(0,height/2,color(255,0,0)));
    }
    else if (animationnumber == 213)    //SingleArrow - Left-Right Red
    {
      singlearrow_setup();
      singlearrow_arrowlist.add(new SingleArrow(1,height/2,color(255,0,0)));
    }
    else if (animationnumber == 214)    //SingleArrow - Right-Left Red
    {
      singlearrow_setup();
      singlearrow_arrowlist.add(new SingleArrow(2,height/2,color(255,0,0)));
    }
    else if (animationnumber == 215)    //SingleArrow - Down-Up Red
    {
      singlearrow_setup();
      singlearrow_arrowlist.add(new SingleArrow(3,height/2,color(255,0,0)));
    }
    else if (animationnumber == 216)    //Rotozoom 1
    {
      frameRate(60);
      colorMode(RGB);
      String configSpecific = NUMBER_OF_PANELS + "_panels/";
      rotozoom_img=loadImage(configSpecific + "Rotozoom/rotozoom1.jpg");
      rotozoom_img.resize(256, 256);
    }
    else if (animationnumber == 217)    //Rotozoom 2
    {
      frameRate(60);
      colorMode(RGB);
      String configSpecific = NUMBER_OF_PANELS + "_panels/";
      rotozoom_img=loadImage(configSpecific + "Rotozoom/rotozoom2.jpg");
      rotozoom_img.resize(256, 256);
    }
    else if (animationnumber == 218)    //Rotozoom 3
    {
      frameRate(60);
      colorMode(RGB);
      String configSpecific = NUMBER_OF_PANELS + "_panels/";
      rotozoom_img=loadImage(configSpecific + "Rotozoom/rotozoom3.jpg");
      rotozoom_img.resize(256, 256);
    }
    else if (animationnumber == 219)    //MilkTank
    {
      colorMode(HSB);
      strokeWeight(8);
      frameRate(50);
      noStroke();
    
      milktank_w = width;
      milktank_h = height;  
      milktank_regroupX = width/2;
      milktank_regroupY = height/2;
      milktank_pixi = new int[milktank_w][milktank_h];
      milktank_blobs = new milktank_blob[milktank_numberofparticles];
      for(int i = 0; i < milktank_blobs.length; i++) {
        milktank_blobs[i] = new milktank_blob();
      }    
    }
    else if (animationnumber == 220)    //FireNoiseSquare
    {
      int sq_size = width/(8*NUMBER_OF_PANELS);
      frameRate(30);
      squares = new FireNoiseSquare[width/sq_size*height/sq_size];
     
      int idx = 0;
      for (int i=0; i < width/sq_size; i++){
          for (int j=0; j < height/sq_size; j++){
            int c = floor(random(0,18));
            squares[idx] = new FireNoiseSquare(i*sq_size, j*sq_size, sq_size, c);
            idx++;
          }
      }
    }
    else if (animationnumber == 221)    //Slasher
    {
      frameRate(50);
      colorMode(RGB);
      if (slasher_initialized == false) {
        slash=new Slash[slasher_nb];
        for(int i=0; i<slasher_nb; i++){
            slash[i]=new Slash(slasher_colors[i%3]);
        }
      }
      slasher_initialized = true;
      for(int i=0; i<slasher_nb; i++){
          slash[i].initSlash();
      }    

    }
    else if (animationnumber == 222)    //NekoJiru
    {
      colorMode(RGB);
      frameRate(50);
      
      nekojiru_mx = 5*width/6;
      nekojiru_my = 6*height/8;
      nekojiru_eyearcparam1 = height/8;
      nekojiru_eyearcparam2 = width/6;
      nekojiru_bulgesize = width/32;
      nekojiru_bulgedistance = width/6;
      nekojiru_eyesizeX = 2*height/5;
      nekojiru_eyesizeY = 2*width/9;
      nekojiru_eyedistance = 2*width/3;
      nekojiru_blinkyMax = height;
      nekojiru_blinkyNasty = height/2;
      
      nekojiru_initStateMachine();
    }
    else if (animationnumber == 223)    //LetterExplode
    {
      frameRate(50);
      background(0);
      smooth();
      noFill();
      colorMode(HSB);
    
      for (int i = 0; i < particleletters_N; i++) {
        particleletters_parts.add(new LetterParticle(random(width), random(height), 0, 0));
      }
      particleletters_font = loadFont("AldotheApache-48.vlw");
    }
    else if (animationnumber == 224)   //TriangleStroboColor
    {
      rectMode(CORNER);
      frameRate(25);
      noStroke();
      strokeWeight(8);
      background(0);
    }
    else if (animationnumber == 225)    //ExplodingCircleLeft
    {
      background(0);
      frameRate(60);
      stroke(255); 
      noFill();
      strokeWeight(28);
      explodingcircle_counter = 0;
    }
    else if (animationnumber == 226)    //ExplodingCircleRight
    {
      background(0);
      frameRate(60);
      stroke(255,0,0); 
      noFill();
      strokeWeight(28);
      explodingcircle_counter = 0;
    }
    else if (animationnumber == 227)    //ThunderLinesInit
    {
      frameRate(60);
      stroke(255); 
      noFill();
      strokeWeight(4);
      colorMode(RGB);
      strokeCap(ROUND);
      thunderline_setupcomplete = false;
      thunderline_density = 5;
      setup_thunderlines();
      thunderline_init = true;
      thunderline_setupcomplete = true;
    }
    else if (animationnumber == 228)    //ThunderLines - More lines
    {
      frameRate(60);
      stroke(255); 
      noFill();
      strokeWeight(4);
      colorMode(RGB);
      strokeCap(ROUND);
      thunderline_setupcomplete = false;
      if (thunderline_density < 30) {
        thunderline_density += 1;
      }
      setup_thunderlines();
      thunderline_init = true;
      thunderline_setupcomplete = true;
    }
    else if (animationnumber == 229)    //ThunderLines - Less lines
    {
      frameRate(60);
      stroke(255); 
      noFill();
      strokeWeight(4);
      colorMode(RGB);
      strokeCap(ROUND);
      thunderline_setupcomplete = false;
      if (thunderline_density > 4) {
        thunderline_density -= 1;
      }
      setup_thunderlines();
      thunderline_init = true;
      thunderline_setupcomplete = true;
    }
    else if (animationnumber == 230)    //Double Fusee
    {
      doublefusee_init();
    }
    else if (animationnumber == 231)    //DiscoStar
    {
      frameRate(50);
      smooth();
      colorMode(HSB);
      noStroke();
    }
    else if (animationnumber == 232)    //WormHole
    { 
      frameRate(50);
      strokeWeight(4);
      noFill();
      smooth();
      wormhole_c = wormhole_c_init; 
    }
    else if (animationnumber == 233)    //Atoms - One Electron
    { 
      atoms_setup(1);
    }
    else if (animationnumber == 234)    //Atoms - Two Electron
    { 
      atoms_setup(2);
    }
    else if (animationnumber == 235)    //Atoms - Three Electron
    { 
      atoms_setup(3);
    }
    else if (animationnumber == 236)    //PerfectCircle
    {
      frameRate(50);
      noStroke();
      if (perfect_circleinitialised == false) {
        perfect_circleperfectcirclelist = new ArrayList<PerfectCircle>(); 
        perfect_circleperfectcirclelist.add(new PerfectCircle(0, 0));
        perfect_circleperfectcirclelist.add(new PerfectCircle(2*PI/3.0, 0));
        perfect_circleperfectcirclelist.add(new PerfectCircle(4*PI/3.0, 0));
      }
      perfect_circleinitialised = true;
      perfect_circlebeatprotosize = perfect_circlebeatprotomaxsize;
      perfect_circleredprotocolor = !perfect_circleredprotocolor;
    }
    else if (animationnumber == 237)    //HyperSpeed
    {
      frameRate(60);
      stroke(255);
      strokeWeight(4);
      strokeCap(ROUND);
      
      if (hyperspeed_init == false) {
        hyperspeed_nagarelist = new ArrayList<NagareBoshi>();
        for (int i = 0;i < hyperspeed_numberofstars;i++) {
          hyperspeed_nagarelist.add(new NagareBoshi());
        }
      }

    }
    else if (animationnumber == 238)    //ColorWaves - Regular
    {
      colorMode(HSB);
      background(0);
      smooth();
      if (waves_init == false) {
        waves_list = new ArrayList<ColorWave>();
      }
      waves_init = true;
      create_randomwave();
    }
    else if (animationnumber == 239)    //ColorWaves - Strong
    {
      colorMode(HSB);
      background(0);
      smooth();
      if (waves_init == false) {
        waves_list = new ArrayList<ColorWave>();
      }
      waves_init = true;
      create_strongwave();
    }
    else if (animationnumber == 240)    //ContinuousTriangles - Resynchronize
    {
      frameRate(50);
      colorMode(RGB);
      noStroke();
      continoustriangles_drift = false;
      continoustriangles_invert = false;
      continoustriangles_resync = true;
      continoustriangles_setup();
    }
    else if (animationnumber == 241)    //ContinuousTrianglesInvert - Resynchronize
    {
      frameRate(50);
      colorMode(RGB);
      noStroke();
      continoustriangles_drift = false;
      continoustriangles_invert = true;
      continoustriangles_resync = true;
      continoustriangles_setup();
    }
    else if (animationnumber == 242)    //ContinuousTriangles - Drift
    {
      frameRate(50);
      colorMode(RGB);
      noStroke();
      continoustriangles_drift = true;
      continoustriangles_invert = false;
      continoustriangles_resync = false;
      continoustriangles_setup();
    }
    else if (animationnumber == 243)    //ContinuousTrianglesInvert - Drift
    {
      frameRate(50);
      colorMode(RGB);
      noStroke();
      continoustriangles_drift = true;
      continoustriangles_invert = true;
      continoustriangles_resync = false;
      continoustriangles_setup();
    }
    else if (animationnumber == 244)    //Mandala
    {
      colorMode(RGB);
      smooth();
      background(0);
      strokeCap(ROUND);
      strokeWeight(1);
      frameRate(60);
      mandala_ballsize = mandala_maxballsize;
    }
    else if (animationnumber == 245)    //Mandala - change shape
    {
      colorMode(RGB);
      smooth();
      background(0);
      strokeCap(ROUND);
      strokeWeight(1);
      frameRate(60);
      //mandala_ballsize = mandala_maxballsize;
      mandala_switch = !mandala_switch;
    }
    else if (animationnumber == 246)    //Kaleido
    {
      background(0);
      frameRate(60);
      colorMode(RGB);
      //kaleido_posX = 0;
      strokeWeight(1);
      fill(0);
      stroke(0);
      noSmooth();
    }
    else if (animationnumber == 247)    //KaleidoGray
    {
      background(0);
      frameRate(60);
      colorMode(RGB);
      //kaleido_posX = 0;
      strokeWeight(1);
      fill(0);
      stroke(0);
      noSmooth();
    }
    else if (animationnumber == 248)    //Flowers
    {
      smooth();
      noFill();
      frameRate(50);

      colorMode(HSB);
      initFlowers();
      //background(0);
      flowers_sequencenumber += 1;
    }
    else if (animationnumber == 249)    //ElectricSpiral
    {
      electricspiral_cx = width/2;
      electricspiral_cy = height/2;
      electricspiral_crad = (max(width,height)/2) * 0.85;
      electricspiral_framecounter = 0;
      noStroke();
      smooth();
      colorMode(HSB);
      background(0);
      frameRate(50);
      
      for (int i = 0; i < electricspiral_nbrPoints; ++i)
      {
        electricspiral_dots[i] = new ElectricSpiralDot();
        electricspiral_dots[i].tine = -1;
      }
    }
    else if (animationnumber == 250)    //SmallSquareLeft
    {
      background(0);
      noSmooth();
      frameRate(40);
      fill(255);
      noStroke();
      strokeWeight(1);
    }
    else if (animationnumber == 251)    //SmallSquareCenter
    {
      background(0);
      noSmooth();
      frameRate(40);
      fill(255);
      noStroke();
      strokeWeight(1);
    }
    else if (animationnumber == 252)    //SmallSquareRight
    {
      background(0);
      noSmooth();
      frameRate(40);
      fill(255);
      noStroke();
      strokeWeight(1);
    }
    else if (animationnumber == 253)    //SmallSquares
    {
      background(0);
      noSmooth();
      frameRate(40);
      fill(255);
      noStroke();
      strokeWeight(1);
    }
    else if (animationnumber == 254)    //FastSpiral
    {
      fastspiral_init();
    }
    else if (animationnumber == 255)    //WeirdSquares
    {
      noStroke();
      colorMode(HSB);
      noiseDetail(2);
      frameRate(50);
    
      weirdsquare_step = height/2;
      weirdsquare_bezierbase = height/3;
      weirdsquare_offset = height/15;
      weirdsquare_redbackground = 0;
    
      weirdsquare_initialize();  
    }
    else if (animationnumber == 256)    //ColumnsWhiteRed
    {
      frameRate(50);
      colorMode(RGB);
      columns_firstheight2 = height - columns_offsety - columns_firstheight1;
      columns_secondheight2 = height - columns_offsety - columns_secondheight1;
      columns_thirdheight2 = height - columns_offsety - columns_thirdheight1;
      columns_shift = false;
    }
    else if (animationnumber == 257)    //ColumnsBlackRed
    {
      frameRate(50);
      colorMode(RGB);
      columns_firstheight2 = height - columns_offsety - columns_firstheight1;
      columns_secondheight2 = height - columns_offsety - columns_secondheight1;
      columns_thirdheight2 = height - columns_offsety - columns_thirdheight1;
      columns_shift = true;
    }
    else if (animationnumber == 258)    //SpotsMultiColor
    {
      frameRate(50);
      stroke(255);
      colorMode(RGB);
      spots_tailleCone = 4;
      strokeWeight(4);
    }
    else if (animationnumber == 259)    //StroboLine
    {
      rectMode(CORNER);
      frameRate(50);
      colorMode(RGB);
      fill(255);
      stroke(255);
      strokeWeight(4);
    }
    else if (animationnumber == 260)   //Strobonormal
    {
      rectMode(CORNER);
      frameRate(25);
      noStroke();
      strokeWeight(8);
      background(0);
      colorMode(RGB);
    }
    else if (animationnumber == 261)    //Fusee up Red
    {
      fusee_init(0);
    }
    else if (animationnumber == 262)    //Fusee down Red
    {
      fusee_init(1);
    }
    else if (animationnumber == 263)    //Fusee left Red
    {
      fusee_init(2);
    }
    else if (animationnumber == 264)    //Fusee right Red
    {
      fusee_init(3);
    }
    else if (animationnumber == 265)    //Fusee center Horizontal Red
    {
      fusee_init(4);
    }
    else if (animationnumber == 266)    //Fusee center Vertical Red
    {
      fusee_init(5);
    }
    else if (animationnumber == 267)    //WideFlashRed
    {
      rectMode(CORNER);
      resetMatrix();
      frameRate(25);
      drawwide = flash_sustain;
    }
    else if (animationnumber == 268)    //DoubleFlowers
    {
      frameRate(60);
      smooth();
      noStroke();
      colorMode(HSB);
      doubleflower_initFlowers();
    }
    else if (animationnumber == 269)    //3DBigAssCube
    {
      colorMode(HSB);
      frameRate(50);
      strokeCap(ROUND);
      smooth();
      thirdDimension_colorlist3d[0] = color(0,255,255);
      thirdDimension_colorlist3d[1] = color(0,0,255);
      
      thirdDimension_viewer3d = new ProjectionViewer();  
      thirdDimension_viewer3d.create_cube(width, color(0,0,255), color(0,255,0), 6, 12, false, 0, 0, 0, 0, 0, 0.04, 0.02, 0.03, true, true, true, false, false);
      
      thirdDimension_jerkyinit = false;
      thirdDimension_noglitchcubeinit = false;
    }
    else if (animationnumber == 270)    //CornerCube
    {
      colorMode(HSB);
      frameRate(50);
      strokeCap(ROUND);
      smooth();
      thirdDimension_colorlist3d[0] = color(0,255,255);
      thirdDimension_colorlist3d[1] = color(0,0,255);
      thirdDimension_viewer3d = new ProjectionViewer();  
      thirdDimension_viewer3d.create_cube(3*width/4, color(0,0,255), color(0,255,255), 4, 8, true, 0, 0, true, true, false, false, true);
      thirdDimension_jerkyinit = false;
      thirdDimension_noglitchcubeinit = false;
    }
    else if (animationnumber == 271)    //GlitchCube
    {
      colorMode(HSB);
      frameRate(50);
      strokeCap(ROUND);
      smooth();
      thirdDimension_colorlist3d[0] = color(0,255,255);
      thirdDimension_colorlist3d[1] = color(0,0,255);
      
      if (thirdDimension_noglitchcubeinit == false) {
        thirdDimension_viewer3d = new ProjectionViewer();  
        thirdDimension_viewer3d.create_cube(width/2, color(0,0,255), color(0,255,0), 3, 6, true, width/4, height/4, true, true, true, false, false);
      }
            
      thirdDimension_jerkyinit = false;
      thirdDimension_noglitchcubeinit = true;
    }
    else if (animationnumber == 272)    //NoGlitchCube
    {
      colorMode(HSB);
      frameRate(50);
      strokeCap(ROUND);
      smooth();
      thirdDimension_colorlist3d[0] = color(0,255,255);
      thirdDimension_colorlist3d[1] = color(0,0,255);
      
      if (thirdDimension_noglitchcubeinit == false) {
        thirdDimension_viewer3d = new ProjectionViewer();
        thirdDimension_viewer3d.create_cube(width/2, color(0,0,255), color(0,255,0), 3, 6, true, width/4, height/4, true, true, true, false, false);
      }
      
      thirdDimension_jerkyinit = false;
      thirdDimension_noglitchcubeinit = true;
    }
    else if (animationnumber == 273)    //JerkyCube
    {
      colorMode(HSB);
      frameRate(50);
      strokeCap(ROUND);
      smooth();
      thirdDimension_colorlist3d[0] = color(0,255,255);
      thirdDimension_colorlist3d[1] = color(0,0,255);
      
      if (thirdDimension_jerkyinit == false) {
        thirdDimension_viewer3d = new ProjectionViewer();
        thirdDimension_viewer3d.create_cube(0.85*width/2, color(0,0,255), color(0,0,255), 3, 6, false, width/4, 0.85*height/4, 0, 0, 0, 0.02, 0.025, 0.03, true, true, true, false, false, false);
        thirdDimension_viewer3d.wireframes.get(0).rotate3DX(thirdDimension_viewer3d.wireframes.get(0).findCenter(),-0.35);
        thirdDimension_viewer3d.wireframes.get(0).rotate3DY(thirdDimension_viewer3d.wireframes.get(0).findCenter(),0.35);
        thirdDimension_viewer3d.wireframes.get(0).rotate3DZ(thirdDimension_viewer3d.wireframes.get(0).findCenter(),0.1);      
      }
      
      thirdDimension_jerkyinit = true;
      thirdDimension_noglitchcubeinit = false;
    }
    else if (animationnumber == 274)    //MovingJerkyCube
    {
      colorMode(HSB);
      frameRate(50);
      strokeCap(ROUND);
      smooth();
      thirdDimension_colorlist3d[0] = color(0,255,255);
      thirdDimension_colorlist3d[1] = color(0,0,255);
      
      if (thirdDimension_jerkyinit == false) {
        thirdDimension_viewer3d = new ProjectionViewer();
        thirdDimension_viewer3d.create_cube(0.85*width/2, color(0,0,255), color(0,0,255), 3, 6, false, width/4, 0.85*height/4, 0, 0, 0, 0.02, 0.025, 0.03, true, true, true, false, false, false);
        thirdDimension_viewer3d.wireframes.get(0).rotate3DX(thirdDimension_viewer3d.wireframes.get(0).findCenter(),-0.35);
        thirdDimension_viewer3d.wireframes.get(0).rotate3DY(thirdDimension_viewer3d.wireframes.get(0).findCenter(),0.35);
        thirdDimension_viewer3d.wireframes.get(0).rotate3DZ(thirdDimension_viewer3d.wireframes.get(0).findCenter(),0.1);      
      }
      
      thirdDimension_jerkyinit = true;
      thirdDimension_noglitchcubeinit = false;
    }
    else if (animationnumber == 275)    //DoubleCube
    {
      colorMode(HSB);
      frameRate(50);
      strokeCap(ROUND);
      smooth();
      thirdDimension_colorlist3d[0] = color(0,255,255);
      thirdDimension_colorlist3d[1] = color(0,0,255);
      
      thirdDimension_viewer3d = new ProjectionViewer();  
      thirdDimension_viewer3d.create_cube(3*width/4, color(0,0,255), color(0,255,255), 3, 6, true, width/8, 0.8*height/8, true, true, false, false, true);
      thirdDimension_viewer3d.create_cube(width/2, color(0,0,255), color(0,255,255), 3, 6, false, width/4, 0.8*height/4, true, true, false, false, false);
      
      thirdDimension_jerkyinit = false;
      thirdDimension_noglitchcubeinit = false;
    }
    else if (animationnumber == 276)    //SinglePyramid
    {
      colorMode(HSB);
      frameRate(50);
      strokeCap(ROUND);
      smooth();
      thirdDimension_colorlist3d[0] = color(0,255,255);
      thirdDimension_colorlist3d[1] = color(0,0,255);
      
      thirdDimension_viewer3d = new ProjectionViewer();  
      if (random(1) > 0.5) {
      thirdDimension_viewer3d.create_pyramid(width/2, color(0,0,255), color(0,0,255), 3, 6, false, width/2, height/2, 0, 0, 0, random(0.02, 0.05), random(0.02, 0.05), random(0.02, 0.05), true, true, true, true, false);
      }
      else {
      thirdDimension_viewer3d.create_pyramid(width/2, color(0,0,255), color(0,0,255), 3, 6, false, width/2, height/2, 0, 0, 0, -random(0.02, 0.05), -random(0.02, 0.05), -random(0.02, 0.05), true, true, true, true, false); 
      }
      thirdDimension_jerkyinit = false;
      thirdDimension_noglitchcubeinit = false;
    }
    else if (animationnumber == 277)    //MultiplePyramids
    {
      colorMode(HSB);
      frameRate(50);
      strokeCap(ROUND);
      smooth();
      thirdDimension_colorlist3d[0] = color(0,255,255);
      thirdDimension_colorlist3d[1] = color(0,0,255);
      
      thirdDimension_viewer3d = new ProjectionViewer();  
      thirdDimension_viewer3d.create_pyramid(width/2, color(0,0,255), color(0,255,255), 3, 6, false, -width/4, -height/4, random(1, 3), random(0.5, 2), random(-1, 1), random(0.04), random(0.04), random(0.04), true, true, false, true, false);
      
      thirdDimension_jerkyinit = false;
      thirdDimension_noglitchcubeinit = false;
    }
    else if (animationnumber == 278)    //BloodSki
    {
      frameRate(50);
      noStroke ();
      colorMode(RGB);
    
      bloodSki_Co = 10;
      bloodSki_Xc = bloodSki_Co/2;
      bloodSki_Yc = 3*bloodSki_Co/4;
      bloodSki_Wc = width-bloodSki_Co;
      bloodSki_Hc = height-bloodSki_Co;
      bloodSki_S  = 50;
      bloodSki_N  = 50;
      bloodSki_minRad= int(width/16);
      bloodSki_maxRad= int(width/4);
      bloodSki_particleManager = new BloodSkiParticleManager (bloodSki_N, bloodSki_minRad, bloodSki_maxRad, width/2, height/2, 0);
    }
    else if (animationnumber == 279)    //Gloubiboulga
    {
      colorMode(HSB);
      frameRate(60);
      gloubiboulga_swarm = new ArrayList();
      for (int i=0; i<20; i++) {
          PVector newpos = new PVector(width/2, height/2);
          GloubiboulgaDots myGloubiboulgaDots = new GloubiboulgaDots( newpos, 1 );
          myGloubiboulgaDots.col=color(random(255), random(180, 210), 255, 90);
          gloubiboulga_swarm.add(myGloubiboulgaDots);
          myGloubiboulgaDots.col=color(random(255), random(180, 210), 255, 90);
      }
    }
    else if (animationnumber == 280)    //RevolutionLines
    {
      frameRate(50);
      colorMode(RGB);
      fill(0);
      noStroke();
      rect(0,0,width,height);
      colorMode(HSB);
      revolutionline_lines = new RevolutionLine[0];
      //background(0);
      smooth();
      fill(0,8);
      strokeWeight(4);
      new RevolutionLine(width/2, height/2, 0);
      new RevolutionLine(width/6, -height/12, 0.1);
    }
    else if (animationnumber == 281)    //RedNoiseShape1
    {
      frameRate(50);
      colorMode(RGB);
      noStroke();
      noFill(); 
      rectMode(CORNER);
    }
    else if (animationnumber == 282)    //RedNoiseShape2
    {
      frameRate(50);
      colorMode(RGB);
      noStroke();
      noFill(); 
      rectMode(CORNER);
    }
    else if (animationnumber == 283)    //RedNoiseShape3
    {
      frameRate(50);
      colorMode(RGB);
      noStroke();
      noFill(); 
      rectMode(CORNER);
    }
    else if (animationnumber == 284)    //RedNoiseShape4
    {
      frameRate(50);
      colorMode(RGB);
      noStroke();
      noFill(); 
      rectMode(CORNER);
    }
    else if (animationnumber == 285)    //RedNoiseShape5
    {
      frameRate(50);
      colorMode(RGB);
      noStroke();
      noFill(); 
      rectMode(CORNER);
      rednoise_circlerad = 0;
    }
    else if (animationnumber == 286)    //RedNoiseShape6
    {
      frameRate(50);
      colorMode(RGB);
      noStroke();
      noFill(); 
      rectMode(CORNER);
    }
    else if (animationnumber == 287)    //TurningSingleLines
    {
      frameRate(50);
      colorMode(RGB);
      noFill();
      stroke(255);
      strokeWeight(16);
      turningsinglelines_position = turningsinglelines_init;
      turningsinglelines_init = -1.5*width;
    }
    else if (animationnumber == 288)    //RandomAppearingLines
    {
      frameRate(50);
      colorMode(RGB);
      noFill();
      stroke(255);
      strokeWeight(8);
      randomappearinglines_initx = width/4;
      randomappearinglines_inity = -height;
      randomappearinglines_framecount = 0;
      randomappearinglines_currentangle = random(0,2*PI);
      randomappearinglines_currentx = randomappearinglines_initx; 
      randomappearinglines_currenty = randomappearinglines_inity;
      randomappearinglines_previousx = randomappearinglines_initx;
      randomappearinglines_previousy = randomappearinglines_inity;
    }
    else if (animationnumber == 289)    //ImpulseRectangles
    {
      frameRate(50);
      colorMode(RGB);
      fill(255);
      noStroke();
      impulserectangles_posx = 0;
      impulserectangles_posy = 0;
    }
    else if (animationnumber == 290)    //ImpulseRectangles
    {
      frameRate(50);
      colorMode(RGB);
      fill(255);
      noStroke();
      impulserectangles_posx = 0;
      impulserectangles_posy = 0;
    }
    else if (animationnumber == 291)    //ImpulseRectangles
    {
      frameRate(50);
      colorMode(RGB);
      fill(255);
      noStroke();
      impulserectangles_posx = 0;
      impulserectangles_posy = 0;
    }
    else if (animationnumber == 292)    //ImpulseRectangles
    {
      frameRate(50);
      colorMode(RGB);
      fill(255);
      noStroke();
      impulserectangles_posx = 0;
      impulserectangles_posy = 0;
    }
    else if (animationnumber == 293)    //Crescent
    {
      frameRate(60);
      colorMode(HSB); 
      strokeWeight(12);
      crescent_distext = width/2;
      crescent_distint = width/4;
      crescent_emphasis = 0;
    }
    else if (animationnumber == 294)    //Clock
    {
      frameRate(50);
      colorMode(RGB);
      clock_rotate = true;
    }
    else if (animationnumber == 295)    //ColorBeat
    {
      colorMode(HSB);
      frameRate(50);
      colorbeat_maxval = 5*height/6;
      colorbeat_minvalue = height/6;
      colorbeat_value = colorbeat_maxval; 
    }
    else if (animationnumber == 296)    //ColorBeatStroboLine
    {
      colorMode(HSB);
      frameRate(25);
    }
    else if (animationnumber == 297)    //ColorBeatWhiteStroboTriangle
    {
      colorMode(HSB);
      frameRate(25);
    }
    else if (animationnumber == 298)    //ColorBeatTransition
    {
      colorMode(HSB);
      frameRate(50);
      frameRate(50);
      colorbeat_transitionpos = 0;
    }
    else if (animationnumber == 299)    //InvertExplode
    {
      frameRate(50);
      colorMode(HSB);
      invertexplode_maxcirclewidth = width*1.2;
      invertexplode_circlewidth = invertexplode_maxcirclewidth;
      invertexplode_pos = 0;
      invertexplode_linelength = width/6;
      invertexplode_circlehue = invertexplode_maxcirclehue;
      invertexplode_angle += invertexplode_anglespeed;
    }
    else if (animationnumber == 300)    //ParticlesFlowRed
    {
      frameRate(50);
      colorMode(HSB, 255);
     
      particlesflow_currFrame = new int[width*height];
      particlesflow_prevFrame = new int[width*height];
      particlesflow_tempFrame = new int[width*height];
      for(int i=0; i<width*height; i++) {
        particlesflow_currFrame[i] = color(0, 0, 0);
        particlesflow_prevFrame[i] = color(0, 0, 0);
        particlesflow_tempFrame[i] = color(0, 0, 0);
      }
     
      particlesflow_particles = new ParticleFlow[(width+particlesflow_particleMargin*2)/particlesflow_particlesDensity*(height+particlesflow_particleMargin*2)/particlesflow_particlesDensity];
      int i = 0;
      for(int y=-particlesflow_particleMargin; y<height+particlesflow_particleMargin; y+=particlesflow_particlesDensity) {
        for(int x=-particlesflow_particleMargin; x<width+particlesflow_particleMargin; x+=particlesflow_particlesDensity) {
           if (i == particlesflow_particles.length) {
             //println(i);
             break;
           }
           int c = color((255+20*sin(PI*x/width))%255, 240, 255*sin(PI*y/width));
           particlesflow_particles[i++] = new ParticleFlow(x, y, c);
        }
      }
    }
    else if (animationnumber == 301)    //DarkSnakes
    {
      frameRate(60);
      colorMode(RGB);
      stroke(0, 0, 0, 10);
      smooth();
      for(int i = 0; i < darksnakes_snakes.length; i++) {
        darksnakes_snakes[i].tm = 1;
      }  
    }
    else if (animationnumber == 302)    //BrightSnakes
    {
      frameRate(60);
      colorMode(RGB);
      stroke(255, 40);
      smooth();
      for(int i = 0; i < brightsnakes_snakes.length; i++) {
        brightsnakes_snakes[i].tm = 1;
      }  
    }
    else if (animationnumber == 303)    //LightPainting
    {
      frameRate(60);
      background(0);
      if (lightpainting_initok == false) {
        lightpainting_canvas = new LightPaintingCanvas3D(lightpainting_focalLength, lightpainting_interaction_distance);
     
        //Initialize the array of Particles to be used in the animation.
        for (int i = 0; i < lightpainting_particleCount; i++) {
          lightpainting_sparks[i] = new LightPaintingParticle(random(256), random(256), random(256));
        }
      }
      lightpainting_initok = true;
      lightpainting_addRandomLine();
    }
    else if (animationnumber == 304)    //ShiftPixelsUp - Slow
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_slowspeed;
    }
    else if (animationnumber == 305)    //ShiftPixelsDown - Slow
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_slowspeed;
    }
    else if (animationnumber == 306)    //ShiftPixelsLeft - Slow
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_slowspeed;
    }
    else if (animationnumber == 307)    //ShiftPixelsRight - Slow
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_slowspeed;
    }
    else if (animationnumber == 308)    //ShiftPixelsUp - Fast
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_fastspeed;
    }
    else if (animationnumber == 309)    //ShiftPixelsDown - Fast
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_fastspeed;
    }
    else if (animationnumber == 310)    //ShiftPixelsLeft - Fast
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_slowspeed;
    }
    else if (animationnumber == 311)    //ShiftPixelsRight - Fast
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_slowspeed;
    }
    else if (animationnumber == 312)    //ShredPixelsVertical - Slow
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_slowspeed;
    }
    else if (animationnumber == 313)    //ShredPixelsHorizontal - Slow
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_slowspeed;
    }
    else if (animationnumber == 314)    //ShredPixelsVertical - Fast
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_fastspeed;
    }
    else if (animationnumber == 315)    //ShredPixelsHorizontal - Fast
    {
      frameRate(60);
      shiftpixels_speed = shiftpixels_fastspeed;
    }
    else if (animationnumber == 316)    //LightFusion
    {
      noStroke();
      background(255);
      frameRate(60);
      lightfusion_xspan = lightfusion_xmax - lightfusion_xmin;
      lightfusion_yspan = lightfusion_ymax - lightfusion_ymin;
      lightfusion_X = width/6;
      lightfusion_Y = height;
      lightfusion_speedX = width/24.0;
      lightfusion_speedY = height/128.0;
      lightfusion_moveUp = true;
      lightfusion_moveRight = true;
      lightfusion_column = true;
      
      // draw first frame
      lightfusion_drawFrame(0);
    }
    else if (animationnumber == 317)    //RandomPaint
    {
      background(5);
      stroke(255, 255, 0, 1);
      strokeWeight(10);
      frameRate(24);
      smooth();
      randompaint_startX = random(width);
      randompaint_startY = random(height);
    }
    else if (animationnumber == 318)    //Redwave
    {
      noStroke();
      frameRate(60);
      redwave_xspan = redwave_xmax - redwave_xmin;
      redwave_yspan = redwave_ymax - redwave_ymin;
      // draw first frame
      redwave_drawFrame(0);
    }
    else if (animationnumber == 319)    //DiagonalColor
    {
      colorMode(HSB);
      background(0);
      frameRate(60);
      smooth();
     
      for (int i = 0; i < diagonalcolors.length;i++) {
        if (i < diagonalcolors.length - diagonalcolors.length/10) {
          diagonalcolors[i] = new DiagonalColor(0);
        }
        else {
          diagonalcolors[i] = new DiagonalColor(180);
        }
      }
    }
    else if (animationnumber == 320)    //HypnoSpiralRed
    {
      noStroke();
      background(255);
      frameRate(60);
      hypnospiralred_X = width/2;
      hypnospiralred_Y = height/2;
      hypnospiralred_xspan = hypnospiralred_xmax - hypnospiralred_xmin;
      hypnospiralred_yspan = hypnospiralred_ymax - hypnospiralred_ymin;
      hypnospiralred_drawFrame(0);
    }
    else if (animationnumber == 321)    //NightRoad
    {
      noStroke();
      background(255);
      frameRate(60);
      nightroad_xspan = nightroad_xmax - nightroad_xmin;
      nightroad_yspan = nightroad_ymax - nightroad_ymin;
      nightroad_Y = 0;
      colorMode(HSB);
      //nightroad_drawFrame(0);
    }
    else if (animationnumber == 322)    //HypnoTriangle
    {
      frameRate(50);
      if (hypnotriangle_init == true) {
        hypnotriangle_init = false;
        hypnotriangle_list = new ArrayList<HypnoTriangle>();
      }
      hypnotriangle_list.add(new HypnoTriangle(hypnotriangle_instancecounter));
      hypnotriangle_instancecounter += 1;
    }
    else if (animationnumber == 323)    //RotatingCut - B&W
    {
      frameRate(50);
      colorMode(HSB);
    }
    else if (animationnumber == 324)    //RotatingCut - Blue
    {
      frameRate(50);
      colorMode(HSB);
    }
    else if (animationnumber == 325)    //ArcRot - Green
    {
      frameRate(60);
      colorMode(HSB);
      noFill();
      smooth();
      strokeWeight(8);
      arcRot_pulseSize = arcRot_maxPulseSize;    
    }
    else if (animationnumber == 326)    //ArcRot - Red
    {
      frameRate(60);
      colorMode(HSB);
      noFill();
      smooth();
      strokeWeight(8);
      arcRot_pulseSize = arcRot_maxPulseSize;
    }
    else if (animationnumber == 327)
    {
      frameRate(40);
      colorMode(HSB);
      smooth();
      background(0);
      strokeWeight(4);
    
      if (energytriangles_init == false) {
        for (int i = energytriangles_density; i > 0; i-=1) {
          for (int j = energytriangles_density; j > 0; j-=1) {
            float xPos = i *(width/energytriangles_density) -width/energytriangles_density/2; 
            float yPos = j *(height/energytriangles_density) -width/energytriangles_density/2; 
            float no = i * j + 1;
      
            EnergyTriangles.add(new EnergyTriangle(xPos, yPos, no));
          }
        }
      }
      energytriangles_init = true;
      energytriangles_energy = 500;
    }
    else if (animationnumber == 328)
    {
      frameRate(50);
      colorMode(HSB);
      noStroke();
    }
    else if (animationnumber == 329)
    {
      frameRate(60);
      reverseTriangles_red = createGraphics(width, height);
      reverseTriangles_green = createGraphics(width/NUMBER_OF_PANELS, height);
      reverseTriangles_size = reverseTriangles_sizeInit;
    }
    else if (animationnumber == 330)
    {
      frameRate(60);
      noStroke();
      colorMode(HSB);
      if (trigoshapes_initComplete == false) {
        trigoshapes_particles = new TrigoShapeParticle[11]; // Create trigoshapes_particles
        for(int n = 0; n < trigoshapes_particles.length; n++)
          trigoshapes_particles[n] = new TrigoShapeParticle(width/2, height/2);
        trigoshapes_particles2 = new TrigoShapeParticle[6]; // Create trigoshapes_particles
        for(int n = 0; n < trigoshapes_particles2.length; n++)
          trigoshapes_particles2[n] = new TrigoShapeParticle(width/2, height/2);
        trigoshapes_arrowImage = createArrowImage();
        trigoshapes_radius = (180*width)/400;
        trigoshapes_smallradius = (90*width)/400;
      }
      else {
        trigoshapes_chosenFunction = (trigoshapes_chosenFunction+1) % 9;
        trigoshapes_particleAngle += HALF_PI;
        trigoshapes_particleFormation = 0; 
      }
      trigoshapes_initComplete = true;
    }
    else if (animationnumber == 331)          //Nonotak 1
    {
      if (nonotak_1_color == 0) {nonotak_1_color = 255;}
      else {nonotak_1_color = 0;}
      frameRate(20);
      colorMode(RGB);
      background(0);
      stroke(255);
      strokeWeight(4);
      noFill();
      nonotak_1_x += 4;
    }
    else if (animationnumber == 332)          //Nonotak 2
    {
      frameRate(50);
      colorMode(RGB);
      background(0);
      noStroke();
      nonotak_2_x = 0;
    }  
    else if (animationnumber == 333)          //Nonotak 3
    {
      frameRate(50);
      colorMode(RGB);
      background(0);
      noStroke();
      nonotak_3_x = 0;
    }  
    else if (animationnumber == 334)          //Nonotak 4
    {
      frameRate(60);
      colorMode(RGB);
      background(0);
      stroke(255);
      strokeWeight(8);
      noFill();
    }
    else if (animationnumber == 335)          //Nonotak 5
    {
      frameRate(60);
      colorMode(RGB);
      background(0);
      strokeWeight(8);
      nonotak_5_y = 0;
      nonotak_5_up = false;
    }
    else if (animationnumber == 336)    //NonotakPanelFill - Left
    {
      frameRate(30);
      noStroke();
      if (NUMBER_OF_PANELS == 3) {
        nonotakPanelFill_list.add(new NonotakPanelFill(0));
      }
      else if (NUMBER_OF_PANELS == 5) {
        nonotakPanelFill_list.add(new NonotakPanelFill(1));
      }
    }
    else if (animationnumber == 337)    //NonotakPanelFill - Center
    {
      frameRate(30);
      noStroke();
      if (NUMBER_OF_PANELS == 3) {
        nonotakPanelFill_list.add(new NonotakPanelFill(1));
      }
      else if (NUMBER_OF_PANELS == 5) {
        nonotakPanelFill_list.add(new NonotakPanelFill(2));
      }
    }
    else if (animationnumber == 338)    //NonotakPanelFill - Right
    {
      frameRate(30);
      noStroke();
      if (NUMBER_OF_PANELS == 3) {
        nonotakPanelFill_list.add(new NonotakPanelFill(2));
      }
      else if (NUMBER_OF_PANELS == 5) {
        nonotakPanelFill_list.add(new NonotakPanelFill(3));
      }
    }
    else if (animationnumber == 339)    //RandomWhiteLineFlash
    {
      frameRate(50);
      fill(0);
      noStroke();
      rect(0,0,width,height);
    }
    else if (animationnumber == 340)    //NonotakWoosh 1
    {
      frameRate(60);
      nonotakWoosh_list.add(new NonotakWoosh(0));
    }
    else if (animationnumber == 341)    //NonotakWoosh 2
    {
      frameRate(60);
      nonotakWoosh_list.add(new NonotakWoosh(1));
    }
    else if (animationnumber == 342)    //NonotakWoosh 3
    {
      frameRate(60);
      nonotakWoosh_list.add(new NonotakWoosh(2));
    }
    else if (animationnumber == 343)    //NonotakWoosh 4
    {
      frameRate(60);
      nonotakWoosh_list.add(new NonotakWoosh(3));
    }
    else if (animationnumber == 344)    //RotatingCutFast - B&W
    {
      frameRate(80);
      colorMode(HSB);
    }
    else if (animationnumber == 345)    //Patatap 0
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(0));
    }
    else if (animationnumber == 346)    //Patatap 1
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(1));
    }
    else if (animationnumber == 347)    //Patatap 2
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(2));
    }
    else if (animationnumber == 348)    //Patatap 3
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(3));
    }
    else if (animationnumber == 349)    //Patatap 4
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(4));
    }
    else if (animationnumber == 350)    //Patatap 5
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(5));
    }
    else if (animationnumber == 351)    //Patatap 6
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(6));
    }
    else if (animationnumber == 352)    //Patatap 7
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(7));
    }
    else if (animationnumber == 353)    //Patatap 8
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(8));
    }
    else if (animationnumber == 354)    //Patatap 9
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(9));
    }
    else if (animationnumber == 355)    //Patatap 10
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(10));
    }
    else if (animationnumber == 356)    //Patatap 11
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(11));
    }
    else if (animationnumber == 357)    //Patatap 12
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(12));
    }
    else if (animationnumber == 358)    //Patatap 13
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(13));
    }
    else if (animationnumber == 359)    //Patatap 14
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatapObjectList.add(new PatatapObject(14));
    }
    else if (animationnumber == 360)    //Patatap 15
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
      patatap_currentColorset = (patatap_currentColorset+1)%patatap_colorsetBackground.length;
    }
    else if (animationnumber == 361)    //ParallelWorlds - Regular
    {
      frameRate(50);
      if (parallelworlds_init == false) {
        parallelworlds_list = new ArrayList<ParallelWorldLine>();
      }
      if (crecy_init == false) {
        crecy_list = new ArrayList<Crecy>();
      }
      crecy_init = true;
      parallelworlds_init = true;
      parallelworlds_list.add(new ParallelWorldLine(true));
      parallelworlds_speed = 3;
      parallelworlds_reverse = false;
    }
    else if (animationnumber == 362)    //ParallelWorlds - Slow
    {
      frameRate(50);
      if (parallelworlds_init == false) {
        parallelworlds_list = new ArrayList<ParallelWorldLine>();
      }
      if (crecy_init == false) {
        crecy_list = new ArrayList<Crecy>();
      }
      crecy_init = true;
      parallelworlds_init = true;
      parallelworlds_list.add(new ParallelWorldLine(true));
      parallelworlds_speed = 2;
      parallelworlds_reverse = false;
      crecy_internalCounter = 4;
    }
    else if (animationnumber == 363)    //ParallelWorlds - Flash
    {
      frameRate(50);
      if (parallelworlds_init == false) {
        parallelworlds_list = new ArrayList<ParallelWorldLine>();
      }
      if (crecy_init == false) {
        crecy_list = new ArrayList<Crecy>();
      }
      crecy_init = true;
      parallelworlds_init = true;
      parallelworlds_list.add(new ParallelWorldLine(true));
      parallelworlds_flashpower = 255;
      parallelworlds_reverse = false;
      crecy_internalCounter = 4;
    }
    else if (animationnumber == 364)    //ParallelWorlds - Reverse
    {
      frameRate(50);
      if (parallelworlds_init == false) {
        parallelworlds_list = new ArrayList<ParallelWorldLine>();
      }
      parallelworlds_init = true;
      if (crecy_init == false) {
        crecy_list = new ArrayList<Crecy>();
      }
      crecy_init = true;
      parallelworlds_init = true;
      parallelworlds_list.add(new ParallelWorldLine(false));
      parallelworlds_reverse = true;
      crecy_internalCounter = 4;
    }
    else if (animationnumber == 365)    //Fireflies
    {
      background(0);
      fireflies_edge = width/6;
      if (fireflies_init == false) {
        fireflies_list = new ArrayList<Firefly>();
      }
      fireflies_init = true;
      fireflies_init();
    }
    else if (animationnumber == 366)    //MultiCrecy - Low intensity
    {
      frameRate(50);
      if (parallelworlds_init == false) {
        parallelworlds_list = new ArrayList<ParallelWorldLine>();
      }
      parallelworlds_init = true;
      if (crecy_init == false) {
        crecy_list = new ArrayList<Crecy>();
      }
      crecy_init = true;
      crecy_internalCounter = 1;
      int numberOfCrecys = 1+int(random(2));
      if (NUMBER_OF_PANELS == 5) {
        numberOfCrecys = 1+int(random(3));
      }
      for (int i=0; i<numberOfCrecys;i++) {
        crecy_list.add(new Crecy(1));
      }
    }
    else if (animationnumber == 367)    //MultiCrecy - Medium intensity
    {
      frameRate(50);
      if (parallelworlds_init == false) {
        parallelworlds_list = new ArrayList<ParallelWorldLine>();
      }
      parallelworlds_init = true;
      if (crecy_init == false) {
        crecy_list = new ArrayList<Crecy>();
      }
      crecy_init = true;
      crecy_internalCounter = 1;
      int numberOfCrecys = 1+int(random(2));
      if (NUMBER_OF_PANELS == 5) {
        numberOfCrecys = 1+int(random(3));
      }
      for (int i=0; i<numberOfCrecys;i++) {
        crecy_list.add(new Crecy(1));
      }
      int numberOfCrecys2 = 1;
      if (NUMBER_OF_PANELS == 5) {
        numberOfCrecys2 = 2;
      }
      for (int i=0; i<numberOfCrecys2;i++) {
        crecy_list.add(new Crecy(2));
      }
    }
    else if (animationnumber == 368)    //MultiCrecy - High intensity
    {
      frameRate(50);
      if (parallelworlds_init == false) {
        parallelworlds_list = new ArrayList<ParallelWorldLine>();
      }
      parallelworlds_init = true;
      if (crecy_init == false) {
        crecy_list = new ArrayList<Crecy>();
      }
      crecy_init = true;
      crecy_internalCounter = 0;
      int numberOfCrecys = 1+int(random(2));
      for (int i=0; i<numberOfCrecys;i++) {
        crecy_list.add(new Crecy(1));
      }
      int numberOfCrecys2 = 1;
      if (NUMBER_OF_PANELS == 5) {
        numberOfCrecys2 = 2;
      }
      for (int i=0; i<numberOfCrecys2;i++) {      
        crecy_list.add(new Crecy(2));
      }
      crecy_list.add(new Crecy(3));
     
    }
    else if (animationnumber == 369)    //MultiCrecy - Hardcore intensity
    {
      frameRate(50);
      if (parallelworlds_init == false) {
        parallelworlds_list = new ArrayList<ParallelWorldLine>();
      }
      parallelworlds_init = true;
      if (crecy_init == false) {
        crecy_list = new ArrayList<Crecy>();
      }
      crecy_init = true;
      crecy_internalCounter = 2;
      int numberOfCrecys = 1+int(random(2));
      if (NUMBER_OF_PANELS == 5) {
        numberOfCrecys = 1+int(random(3));
      }
      for (int i=0; i<numberOfCrecys;i++) {
        crecy_list.add(new Crecy(4));
      }
      int numberOfCrecys2 = 1;
      if (NUMBER_OF_PANELS == 5) {
        numberOfCrecys2 = 2;
      }
      for (int i=0; i<numberOfCrecys2;i++) {      
        crecy_list.add(new Crecy(2));
      }
      if (random(1) > 0.8) {
        crecy_list.add(new Crecy(3));
      }
    }
    else if (animationnumber == 370)    //Snake1
    {
      frameRate(50);
      if (snake_init == false) {
        snake_specialInit();
        snake_instance1 = new Snake(4, true);
        snake_instance2 = new Snake(4, true);
        snake_instance3 = new Snake(4, true);
        snake_instance4 = new Snake(4, true);
        snake_instance5 = new Snake(4, true);
        snake_instance6 = new Snake(4, true);        
      }
      snake_init = true;
    }
    else if (animationnumber == 371)    //Snake2
    {
      frameRate(50);
      if (snake_init == false) {
        snake_specialInit();
        snake_instance1 = new Snake(4, true);
        snake_instance2 = new Snake(4, true);
        snake_instance3 = new Snake(4, true);
        snake_instance4 = new Snake(4, true);
        snake_instance5 = new Snake(4, true);
        snake_instance6 = new Snake(4, true);        
      }
      snake_init = true;
    }
    else if (animationnumber == 372)    //Snake3
    {
      frameRate(50);
      if (snake_init == false) {
        snake_specialInit();
        snake_instance1 = new Snake(4, true);
        snake_instance2 = new Snake(4, true);
        snake_instance3 = new Snake(4, true);
        snake_instance4 = new Snake(4, true);
        snake_instance5 = new Snake(4, true);
        snake_instance6 = new Snake(4, true);
      }
      snake_init = true;
    }
    else if (animationnumber == 373)    //Snake4
    {
      frameRate(50);
      if (snake_init == false) {
        snake_specialInit();
        snake_instance1 = new Snake(4, true);
        snake_instance2 = new Snake(4, true);
        snake_instance3 = new Snake(4, true);
        snake_instance4 = new Snake(4, true);
        snake_instance5 = new Snake(4, true);
        snake_instance6 = new Snake(4, true);
      }
      snake_init = true;
    }
    else if (animationnumber == 374)    //Snake5
    {
      frameRate(50);
      if (snake_init == false) {
        snake_specialInit();
        snake_instance1 = new Snake(4, true);
        snake_instance2 = new Snake(4, true);
        snake_instance3 = new Snake(4, true);
        snake_instance4 = new Snake(4, true);
        snake_instance5 = new Snake(4, true);
        snake_instance6 = new Snake(4, true);
      }
      snake_init = true;
    }
    else if (animationnumber == 375)    //Snake6
    {
      frameRate(50);
      if (snake_init == false) {
        snake_specialInit();
        snake_instance1 = new Snake(4, true);
        snake_instance2 = new Snake(4, true);
        snake_instance3 = new Snake(4, true);
        snake_instance4 = new Snake(4, true);
        snake_instance5 = new Snake(4, true);
        snake_instance6 = new Snake(4, true);
      }
      snake_init = true;
    }
    else if (animationnumber == 376)    //PeriodicNoise
    {
      frameRate(50);
    }    
    
    else if (animationnumber == 377)    //SweepingBallsAndArrows
    {
      frameRate(50);
      if (sweeperBalls_init == false) {
        sweeperBalls_list = new ArrayList<SweeperBall>();
        sweeperBalls_listarrow = new ArrayList<DoubleArrow>();
      }
      sweeperBalls_init = true;
      for (int i = 0; i<sweeperBalls_nbOfBalls; i++) {
        sweeperBalls_list.add(new SweeperBall());
      }
      sweeperBalls_listarrow.add(new DoubleArrow());
    }
    else if (animationnumber == 378)    //RotatingHalfCircle
    {
      frameRate(50);
      fill(0);
      noStroke();
      rect(0,0,width,height);
    }
    else if (animationnumber == 379)    //FuckedUpSine3 - no reinit
    {
      frameRate(50);
      strokeWeight(4);
      noFill();
      smooth();
    }
    else if (animationnumber == 380)    //MultiCrecy - Very light intensity
    {
      frameRate(50);
      if (parallelworlds_init == false) {
        parallelworlds_list = new ArrayList<ParallelWorldLine>();
      }
      
      //Reinit the parallel worlds arraylist
      parallelworlds_list = new ArrayList<ParallelWorldLine>();
      
      parallelworlds_init = true;
      if (crecy_init == false) {
        crecy_list = new ArrayList<Crecy>();
      }
      crecy_init = true;
      crecy_internalCounter = 3;
      int numberOfCrecys = 3;
      for (int i=0; i<numberOfCrecys;i++) {
        crecy_list.add(new Crecy(5));
      }
    }
    else if (animationnumber == 381)    //MultiCrecy - Double intensity
    {
      frameRate(50);
      if (parallelworlds_init == false) {
        parallelworlds_list = new ArrayList<ParallelWorldLine>();
      }
      parallelworlds_init = true;
      if (crecy_init == false) {
        crecy_list = new ArrayList<Crecy>();
      }
      crecy_init = true;
      crecy_internalCounter = 4;
      int numberOfCrecys = 1+int(random(2));
      if (NUMBER_OF_PANELS== 5) {
        numberOfCrecys = 1+int(random(3));
      }
      for (int i=0; i<numberOfCrecys;i++) {
        crecy_list.add(new Crecy(4));
      }
      numberOfCrecys = 1;
      for (int i=0; i<numberOfCrecys;i++) {
        crecy_list.add(new Crecy(6));
      }
    }
    else if (animationnumber == 382)    //MultiCrecy - Refrain
    {
      frameRate(50);
      if (parallelworlds_init == false) {
        parallelworlds_list = new ArrayList<ParallelWorldLine>();
      }
      parallelworlds_init = true;
      if (crecy_init == false) {
        crecy_list = new ArrayList<Crecy>();
      }
      crecy_init = true;
      crecy_internalCounter = 4;
      int numberOfCrecys = 1+int(random(2));
      for (int i=0; i<numberOfCrecys;i++) {
        crecy_list.add(new Crecy(1));
      }
      crecy_list.add(new Crecy(2));
      crecy_list.add(new Crecy(3));
     
    }
    else if (animationnumber == 383)    //NonotakPanelFill - ExtremeLeft
    {
      frameRate(30);
      noStroke();
      if (NUMBER_OF_PANELS == 3) {
        nonotakPanelFill_list.add(new NonotakPanelFill(2));
      }
      else if (NUMBER_OF_PANELS == 5) {
        nonotakPanelFill_list.add(new NonotakPanelFill(0));
      }
    }    
    else if (animationnumber == 384)    //NonotakPanelFill - ExtremeRight
    {
      frameRate(30);
      noStroke();
      if (NUMBER_OF_PANELS == 3) {
        nonotakPanelFill_list.add(new NonotakPanelFill(0));
      }
      else if (NUMBER_OF_PANELS == 5) {
        nonotakPanelFill_list.add(new NonotakPanelFill(4));
      }
    }
    else if (animationnumber == 385)    //Tumbler
    {
      frameRate(50);
      noStroke();
    }
    else if (animationnumber == 386) {  //DynamicAngleLines - White
      setup_dynamicAngleLines();
    }
    else if (animationnumber == 387) {  //DynamicAngleLines - Half Red
      setup_dynamicAngleLines();
    }
    else if (animationnumber == 388) {  //DynamicAngleLines - Red
      setup_dynamicAngleLines();
    }
    else if (animationnumber == 389) {  //FauveRandomFlash
      frameRate(40);    
    }
    else if (animationnumber == 390)    //BarWavesWhite
    {
      if (!barWaves_init) {
        barWaves_columns = width/4;
        barWaves_offSets = new float[barWaves_columns];
        barWaves_offTheta = new float[barWaves_columns];  
        barWaves_stepX = width/barWaves_columns;
      }
      strokeWeight(barWaves_stepX+1);
     
      barWaves_initWaves();
      barWaves_init = true;    
    }
    else if (animationnumber == 391)    //BarWavesRed
    {
      if (!barWaves_init) {
        barWaves_columns = width/4;
        barWaves_offSets = new float[barWaves_columns];
        barWaves_offTheta = new float[barWaves_columns];  
        barWaves_stepX = width/barWaves_columns;
      }
      strokeWeight(barWaves_stepX+1);
     
      barWaves_initWaves();
      barWaves_init = true;    
    }
    else if (animationnumber == 392)    //BarWavesBlue
    {
      if (!barWaves_init) {
        barWaves_columns = width/4;
        barWaves_offSets = new float[barWaves_columns];
        barWaves_offTheta = new float[barWaves_columns];  
        barWaves_stepX = width/barWaves_columns;
      }
      strokeWeight(barWaves_stepX+1);
     
      barWaves_initWaves();
      barWaves_init = true;    
    }    
    else if (animationnumber == 393)    //RedSun
    {
      redSun_szS = width*.7;
      redSun_internalCircleRadius = 0;
    }
    else if (animationnumber == 394)    //SlicedWave - White
    {
      noFill();
      strokeCap(SQUARE); 
      randomSeed(36);
     
      if (slicedWave_init == false) {
        for (int i=0; i<slicedWave_slices; i++) {
          for (int j=0; j<slicedWave_pieces; j++) {
            slicedWave_r[slicedWave_c] = random(j*(width/slicedWave_pieces), (j+1)*(width/slicedWave_pieces));
            slicedWave_c++;
          }
        }
        slicedWave_init = true;
      }
      slicedWave_angleStock += 15;    
    }
    else if (animationnumber == 395)    //SlicedWave - Red
    {
      noFill();
      strokeCap(SQUARE); 
      randomSeed(36);
     
      if (slicedWave_init == false) {
        for (int i=0; i<slicedWave_slices; i++) {
          for (int j=0; j<slicedWave_pieces; j++) {
            slicedWave_r[slicedWave_c] = random(j*(width/slicedWave_pieces), (j+1)*(width/slicedWave_pieces));
            slicedWave_c++;
          }
        }
        slicedWave_init = true;
      }
      slicedWave_angleStock += 15;    
    }
    else if (animationnumber == 396)    // Dirty Audio processing - to be modified
    {
      background(0);
      uglyImpulseKickList = new ArrayList<UglyImpulseKick>();
      uglyImpulseSnareList = new ArrayList<UglyImpulseSnare>();
      uglyImpulseCymbalList = new ArrayList<UglyImpulseCymbal>();
      uglyImpulseBassList = new ArrayList<UglyImpulseBass>();
    }
    else if (animationnumber == 397)    //Patatap with Audio
    {
      frameRate(50);
      colorMode(RGB);
      if (patatap_init == false) {
        patatap_init = true;
        patatapObjectList = new ArrayList<PatatapObject>();
      }
    }
    else                                //Not implemented case - do nothing
    {    }
  }

//Put the flag to 1, allow the draw function
setupcomplete = true;

}
