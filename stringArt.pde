PImage img;  // Declare PImage object

int xOffset;
int yOffset;


void setup() {
  size(500, 500);
  img = loadImage("Eye.jpg");  // Load your image
  img.loadPixels();  // Make sure to load the pixels of the image
  //int resizeWidth=(int)imageHeight(width/2,img.height);
  //println(resizeWidth);
  println(img.height);
  img.resize(400,0);
  println(img.height);
  frameRate(240);
  xOffset=(width-img.width)/2;
  yOffset=(height-img.height)/2;
}

void draw() {
  background(255);
  
  // Get the 2D matrix of RGB pixel values
  double[][] pixelValues = new double[img.width][img.height];
  double[][] stringMatrix = new double[img.width][img.height];
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int loc = x + y * img.width;
      stringMatrix[x][y]=0;
      pixelValues[x][y] = 1-((red(img.pixels[loc])+blue(img.pixels[loc])+green(img.pixels[loc]))/765);
    }
  }
  //println("mouseY-yOffset",mouseY-yOffset);
  //println(pixelValues[max(min(mouseX-xOffset,img.width - 1),0)][max(min(mouseY-yOffset,img.height -1 ),0)]);
  strokeWeight(1);
  stroke(0);
  noFill();
  circle(width/2,height/2, width);
  
  //image(img, xOffset, yOffset);  // Display the image
  println("Dist:");
  println(PtLDist(3,10,mouseX,height-mouseY));
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
