//this one is a fancy boi. this is where the display is basically made. this should be able to read the images that i make.
//the pixel art of the cars, the fuel, etc. this is where it all haaaaapens.
//incredibly important! this is what the user sees! not the terminal, but the display!
/*
should it have sounds? i did make the test that i can easily work in...

if i have time & will i might.
*/

class carHud{ //this is split into other parts, one for fuel, one for speed, one for 
  fuelLevel fuel;
  carSpeed speed;
  carRPM rpm;
  carGPS gps;
  carDirection direction;
  carFuelEconGraph fuelGraph;
  carFuelConsumpGraph fuelConsume;
  carHud(float maxFuel){
    fuel = new fuelLevel(maxFuel);
    speed = new carSpeed();
    rpm = new carRPM();
    gps = new carGPS();
    fuelGraph = new carFuelEconGraph();
    fuelConsume = new carFuelConsumpGraph();
    direction = new carDirection();
  }
}

class carGPS{
  //so using hardcoded values for the top right and bottom left should be ok.
  //top right 51.215882,-114.348209
  //bottom left 50.816416,-113.716145
  //float[] maxPos = {51.158,-114.355};
  //float[] minPos = {50.906,-113.835};
  //float[] posDifference = {maxPos[0]-minPos[0],maxPos[1]-minPos[1]};
  PImage gpsX = loadImage("calgary/gpsX.png"),
  calgaryMap = loadImage("calgary/calgaryMap.png"); //a 96x96 image.
  //so in relation to the position, then scale it down? something like that.
  //i bet it must do something with the difference between the corners, the difference from the max pos and given pos, and the size of the image.
  void render(float x, float y,String direction){//51.206, -114.350  50.905,-113.950
    float[] maxPos = {51.193, -114.350};
    float[] minPos = {50.926,-113.823};
    float[] posDifference = {maxPos[0]-minPos[0],maxPos[1]-minPos[1]};
    float diffX = x-minPos[0], diffY = y-minPos[1];
    image(calgaryMap,(256*(diffY/posDifference[1]))-128,256*((diffX/posDifference[0])-.5));
    image(gpsX,0,0);
    //stroke(0xffffff);
    //fill(0xFfffff);
    //text(direction,120,120); //debug, render text direction.
    //textSize(4);
    noStroke();
  }
}

class carSpeed{
  void render(float speed){
    PImage speedometer = loadImage("vehicle/dashboard/speedometer.png"),
    pointer = loadImage("vehicle/dashboard/speedometerPointer.png"),
    numbers = loadImage("vehicle/dashboard/speedometerNumbers.png");
    image(speedometer,0,0);
    image(numbers,0,0);
    pushMatrix();
    translate(32,32);
    println(speed); 
    rotate(PI+(speed/200)*PI);//v fancy dial.
    image(pointer,-32,-32);
    popMatrix();
    text(nfc(speed,3)+" \tKM/H",0,64,64,10);
  }
}
class carRPM{
  void render(float rpm){ //currently just a modification of the speedometer, but will be updated in soon.
    PImage tachometer = loadImage("vehicle/dashboard/speedometer.png"),
    pointer = loadImage("vehicle/dashboard/speedometerPointer.png"),
    numbers = loadImage("vehicle/dashboard/tachometerNumbers.png");
    image(tachometer,0,0);
    image(numbers,0,0);
    pushMatrix();
    translate(32,32);
    println(rpm); 
    rotate(PI+(rpm/2000)*PI); //fancy rotating dial
    image(pointer,-32,-32);
    popMatrix();
    text(nfc(rpm,3)+" RPM",0,64,64,10);
  }
}
class fuelLevel{
  float maxFuel,fuelLevel;
  fuelLevel(float maxFuel){
    this.maxFuel = maxFuel;
  }
  void render(float fuelLevel){
    PImage fuelBack = loadImage("vehicle/dashboard/fuelBack.png"),
    fuelMask = loadImage("vehicle/dashboard/fuelMask.png"),
    fuelColours = loadImage("vehicle/dashboard/fuelColours.png"),
    fuelLight = loadImage("vehicle/dashboard/fuelLight.png"),
    fuelLightMask= loadImage("vehicle/dashboard/fuelLightMask.png");
    
    fuelMask.filter(THRESHOLD,(fuelLevel/maxFuel)%(256.0/255)); //to make things a bit more regular.
    fuelMask.filter(INVERT);
    fuelColours.mask(fuelMask);
    
    //fuelLightMask.filter(INVERT);
    fuelLightMask.filter(THRESHOLD,((fuelLevel+0.5)/maxFuel)%1); //feels a bit hacky, but hey, the display works. ish.
    //fuelLightMask.filter(INVERT);
    fuelLight.mask(fuelLightMask);
    fuelBack.blend(fuelLight,0,0,64,64,0,0,64,64,BLEND);
    fuelBack.blend(fuelColours,0,0,64,64,0,0,64,64,BLEND);
    image(fuelBack,0,0);
    text(nfc(fuelLevel,1)+"L\n/\n"+nfc(maxFuel,1)+"L",8,16,23,30);
    //text("test",15,15);
  }
}
class carFuelConsumpGraph{
  int x = 8,y=32,barCount=32;
  float largestValue=0.001;
  void render(float[] fuelConsumption, int time){
    //size is going to be large-ish.
    if(fuelConsumption[time] > largestValue && time > 2)
      largestValue = fuelConsumption[time];
    int iterations = 0;
    float scale = y/largestValue;
    if(time>barCount-1)
      iterations = time-barCount+1;
    pushMatrix();
    translate((time-iterations)*8,0);
    for(int i = time; i >= iterations;i--){
      fill(200);
      rect(0,0,7,-fuelConsumption[i]*scale);
      fill(255);
      textSize(2);
      text(nfc(i,0),0,0,8,8);
      textSize(4);
      translate(-8,0);
    }
    popMatrix();
    //fill(255);
    text(nfc(largestValue,2),-40,-y,48,16);
    text(nfc(largestValue*3/4,2),-40,-y*3/4,48,16);
    text(nfc(largestValue*2/4,2),-40,-y*2/4,48,16);
    text(nfc(largestValue*1/4,2),-40,-y*1/4,48,16);
    text(nfc(0,2),-40,0,48,16);
    text("Fuel Consumption (Litres) over time (seconds)",0,8,8*barCount,16);
  }
}
class carFuelEconGraph{
  int x = 8,y=32,barCount=32;
  float largestValue=0.01;
  void render(float[] fuelEconomyAvrg, int time, float[] fuelEconomy){
    //size is going to be large-ish.
    if(fuelEconomyAvrg[time] > largestValue && time > 2)
      largestValue = fuelEconomyAvrg[time];
    int iterations = 0;
    float scale = y/largestValue;
    if(time>barCount-1)
      iterations = time-barCount+1;
    pushMatrix();
    translate((time-iterations)*8,0);
    for(int i = time; i >= iterations;i--){
      fill(200);
      rect(0,0,7,-fuelEconomyAvrg[i]*scale);
      fill(255);
      textSize(2);
      text(nfc(i,0),0,0,8,8);
      textSize(4);
      translate(-8,0);
    }
    popMatrix();
    //fill(255);
    text(nfc(largestValue,2),-40,-y,48,16);
    text(nfc(largestValue*3/4,2),-40,-y*3/4,48,16);
    text(nfc(largestValue*2/4,2),-40,-y*2/4,48,16);
    text(nfc(largestValue*1/4,2),-40,-y*1/4,48,16);
    text(nfc(0,2),-40,0,48,16);
    text("Average Fuel Economy (km/l) over time (seconds)",0,8,8*barCount,16);
  }
}
class carDirection{
  void render(float direction,String dir){
    PImage compassBack = loadImage("vehicle/dashboard/compassBack.png"),
    compassLetters = loadImage("vehicle/dashboard/compassLetters.png"),
    compassNeedle = loadImage("vehicle/dashboard/compassNeedle.png")
    ;
    pushMatrix();
    //translate(-width/2,-height/2);
    pushMatrix();
    //translate(width/2,height/2);
    image(compassBack,0,0);
    popMatrix();
    pushMatrix();
    //rotate(-direction);
    translate(32,32);
    rotate(PI-direction+PI/2);//oh boy i did need to alter those positions.
    image(compassLetters,-32,-32);
    popMatrix();
    
    //translate(width/2,height/2);
    image(compassNeedle,0,0);
    popMatrix();
    text(dir,0,64,64,10);
  }
}
