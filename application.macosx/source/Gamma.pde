
///////////////////////////////////////////////////////////////
/// Create pre-calculated gamma tables for color correction ///
///////////////////////////////////////////////////////////////

String NONE = "";
String GAMMA_20 = "gamma_20";
String GAMMA_22 = "gamma_22";
String GAMMA_25 = "gamma_25";
String SPECIAL1 = "special1";

//use it for lpd6803 based led devices
int[] gamma20 = generateGammaTab(2.0f);

int[] gamma22 = generateGammaTab(2.2f);

//use it for ws2801 based led devices
int[] gamma25 = generateGammaTab(2.5f);

//gamma correction found in ledstyles.de forum 
private final int[] apecialGammaTab1 = {
    0,   0,   1,   1,   1,   1,   1,   2,
    2,   2,   2,   3,   3,   3,   4,   4,
    4,   5,   5,   5,   6,   6,   7,   7,
    8,   8,   9,   9,  10,  10,  11,  11,
   12,  12,  13,  13,  14,  14,  15,  15,
   16,  16,  17,  17,  18,  18,  19,  19,
   20,  20,  21,  21,  22,  22,  23,  23,
   24,  24,  25,  25,  26,  27,  28,  29,
   30,  30,  31,  32,  33,  34,  35,  36,
   36,  37,  38,  39,  40,  41,  42,  43,
   43,  44,  45,  46,  47,  48,  49,  50,
   51,  52,  52,  53,  54,  55,  56,  57,
   58,  59,  60,  61,  62,  63,  64,  65,
   66,  67,  68,  69,  70,  71,  72,  73,
   74,  75,  76,  77,  78,  79,  80,  81,
   82,  83,  84,  85,  86,  88,  89,  90,
   91,  92,  93,  94,  95,  96,  97,  98,
   99, 100, 102, 103, 104, 105, 106, 107,
  108, 109, 110, 112, 113, 114, 115, 116,
  117, 119, 120, 121, 122, 123, 124, 126,
  127, 128, 129, 130, 132, 133, 134, 135,
  136, 138, 139, 140, 141, 142, 144, 145,
  146, 147, 149, 150, 151, 152, 154, 155,
  156, 158, 159, 160, 161, 162, 164, 165,
  167, 168, 169, 171, 172, 173, 174, 176,
  177, 178, 180, 181, 182, 184, 185, 187,
  188, 189, 191, 192, 193, 195, 196, 197,
  199, 200, 202, 203, 204, 206, 207, 208,
  210, 211, 213, 214, 216, 217, 218, 220,
  221, 223, 224, 226, 227, 228, 230, 231,
  233, 234, 236, 237, 239, 240, 242, 243,
  245, 246, 248, 249, 251, 252, 254, 255
};


// Create a pre-calculated gamma table
// Best for WS2801 LED : Gamma_25
private int[] generateGammaTab(float gamma) {
        int[] ret = new int[256];

        for (int i=0; i<256; i++) {
                ret[i] = (int)(Math.pow ((float)(i)/255.0f, gamma)*255.0f+0.5f);
        }

        return ret;
}

    
// apply brightness level and gamma correction
 public int[] applyBrightnessAndGammaTab(int[] buffer, String type, float brightness) {
    int ret[] = new int[buffer.length];
    int ofs=0;
    int r,g,b;

    for (int n=0; n<buffer.length; n++) {
      int tmp = buffer[ofs];        
      r = (int) ((tmp>>16) & 255);
      g = (int) ((tmp>>8)  & 255);
      b = (int) ( tmp      & 255);                       
      
      //apply brightness
      r = (int)(r*brightness);
      g = (int)(g*brightness);
      b = (int)(b*brightness);
      //apply gamma
      if (type == GAMMA_20) {
        r = gamma20[r];
        g = gamma20[g];
        b = gamma20[b];
        ret[ofs] = (r<<16)|(g<<8)|b;
        ofs++;          
      }
      else if (type == GAMMA_22) {
        r = gamma22[r];
        g = gamma22[g];
        b = gamma22[b];
        ret[ofs] = (r<<16)|(g<<8)|b;
        ofs++;
      }
      else if (type == GAMMA_25) {
        r = gamma25[r];
        g = gamma25[g];
        b = gamma25[b];
        ret[ofs] = (r<<16)|(g<<8)|b;
        ofs++;
      }            
      else if (type == SPECIAL1) {
        r = apecialGammaTab1[r];
        g = apecialGammaTab1[g];
        b = apecialGammaTab1[b];
        ret[ofs] = (r<<16)|(g<<8)|b;
        ofs++;
      }
    }
    return ret;
}




public class RGBAdjust {

    private int r,g,b;
    
    public RGBAdjust(int r, int g, int b) {
            this.r = r;
            this.g = g;
            this.b = b;
    }
  
    public int getR() {
            return r;
    }
  
    public int getG() {
            return g;
    }
  
    public int getB() {
            return b;
    }
  
    @Override
    public String toString() {
            return "[r=" + r + ", g=" + g + ", b=" + b + "]";
    }
}
