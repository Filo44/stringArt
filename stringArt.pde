PImage img;  // Declare PImage object

int xOffset;
int yOffset;

int amountScrews;
int r;
int[][] screwLocations;
ArrayList<Integer> screwPath;

double[][] pixelValues;
double[][] stringPixelMatrix;

void setup() {
  size(500, 500);
  frameRate(240);

  img = loadImage("Eye.jpg");  // Load your image
  img.loadPixels();  // Make sure to load the pixels of the image
  img.resize(400,0);

  xOffset=(width-img.width)/2;
  yOffset=(height-img.height)/2;

  r=width/2;
  amountScrews=10;
  screwPath= new ArrayList<Integer>();
  screwPath.add(1);
  screwPath.add(5);

  screwLocations= new int[amountScrews][2];
  int k=0;
  for (int a = 0; a < 360; a += 360/amountScrews) {
    int x = (int)(sin(radians(a)) * r)+width/2;
    int y = (int)(cos(radians(a)) * r)+height/2;

    screwLocations[k][0]=x;
    screwLocations[k][1]=y;
    k++;
  }

  pixelValues = new double[img.width][img.height];
  stringPixelMatrix = new double[img.width][img.height];
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int loc = x + y * img.width;
      stringPixelMatrix[x][y]=0;
      pixelValues[x][y] = 1-((red(img.pixels[loc])+blue(img.pixels[loc])+green(img.pixels[loc]))/765);
    }
  }

}

void draw() {
  background(255);

  //render screws
  stroke(255,0,0);
  strokeWeight(10);
  for(int[] screw : screwLocations){
    point(screw[0],screw[1]);
  }
  println(screwPath);

  stroke(0);
  strokeWeight(2);
  int parity=screwPath.size()%2;
  for(int i=0;i<screwPath.size()-parity;i+=2){
    int screw=screwPath.get(i);
    int x1=screwLocations[screw][0];
    int y1=screwLocations[screw][1];

    int screw2=screwPath.get(i+1);
    int x2=screwLocations[screw2][0];
    int y2=screwLocations[screw2][1];

    println("x1:",x1);
    println("y1:",y1);
    println("x2:",x2);
    println("y2:",y2);
    line(x1,y1,x2,y2);

  }



  strokeWeight(1);
  stroke(0);
  noFill();
  circle(width/2,height/2, width);
  
  // image(img, xOffset, yOffset);  // Display the image
  // println("Dist:");
  // println(PtLDist(3,10,mouseX,height-mouseY));
  //noLoop();
}


double PtLDist(double lM,double lC,double pX,double pY){
  double perpM=-(1/lM);
  double perpC=pY-(pX*perpM);
  
  double icX = (perpC - lC) / (lM - perpM);
  double icY = lM * icX + lC;
  
  //Draw OG line
  stroke(0);
  //line(0,0,500,500);
  line(0,(float)(height-lC),(float)width,(float)(height-((width*lM)+lC)));
  
  //OG point
  strokeWeight(10);
  point((float)pX, (float)(height-pY));
  
  //Perp line
    strokeWeight(1);
  stroke(255,0,0);
  line(0,(float)(height-perpC),(float)width,(float)(height-((width*perpM)+perpC)));
  
  //Intercept point
  strokeWeight(10);
  point((float)icX, (float)(height-icY));
  return (double)dist((float)pX,(float)pY,(float)icX,(float)icY);
}


float calcErr(double[][] imageData,double[][] pixelsm){
  float errorA=0;
  if(imageData.length==pixelsm.length && imageData[0].length==pixelsm[0].length){
    for(int i=0; i<imageData.length;i++){
      for(int j=0; j<imageData[0].length;j++){
        errorA+=abs((float)(imageData[i][j]-pixelsm[i][j]));
      }
    }
    return errorA;
  }else{
    return -1;
  }
}



//double imageHeight(int radius, int imageHeight){
//  println("2*radius:", 2*radius);
//  println("(radius*radius)",(radius*radius));
//  println("-(imageHeight*imageHeight)/4",-(imageHeight*imageHeight)/4);
//    println("(radius*radius)",(radius*radius));
//  println("(radius*radius)-(imageHeight*imageHeight)/4:",(radius*radius)-(imageHeight*imageHeight)/4);
//  println("sqrt((radius*radius)-(imageHeight*imageHeight)/4):", sqrt((radius*radius)-(imageHeight*imageHeight)/4));
//  println("-2*sqrt((radius*radius)-(imageHeight*imageHeight)/4):", -2*sqrt((radius*radius)-(imageHeight*imageHeight)/4));

//  return (2*radius)-2*sqrt((radius*radius)-((imageHeight*imageHeight)/4));
//}
