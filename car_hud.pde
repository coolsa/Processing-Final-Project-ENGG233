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
  carDisplay car;
  carHud(float maxFuel){
    
    fuel = new fuelLevel(maxFuel);
    speed = new carSpeed();
    rpm = new carRPM();
    gps = new carGPS();
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
  void render(float x, float y){//51.206, -114.350  50.905,-113.950
    float[] maxPos = {51.193, -114.350};
    float[] minPos = {50.926,-113.823};
    float[] posDifference = {maxPos[0]-minPos[0],maxPos[1]-minPos[1]};
    float diffX = x-minPos[0], diffY = y-minPos[1];
    image(calgaryMap,(256*(diffY/posDifference[1]))-128,256*((diffX/posDifference[0])-.5));
    image(gpsX,0,0);
  }
}

class carSpeed{
  void render(float speed){
    PImage speedometer = loadImage("vehicle/dashboard/speedometerBack.png");
    image(speedometer,0,0);
    text(nfc(speed,3)+" KM/H",13,28,44,35);
  }
}
class carRPM{
  void render(float rpm){ //currently just a modification of the speedometer, but will be updated in soon.
    PImage speedometer = loadImage("vehicle/dashboard/speedometerBack.png");
    image(speedometer,0,0);
    text(nfc(rpm,3)+" RPM",13,28,44,35);
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
