//this one is a fancy boi. this is where the display is basically made. this should be able to read the images that i make.
//the pixel art of the cars, the fuel, etc. this is where it all haaaaapens.
//incredibly important! this is what the user sees! not the terminal, but the display!
/*
should it have sounds? i did make the test that i can easily work in...

if i have time & will i might.
*/

class carHud{ //this is split into other parts, one for fuel, one for speed, one for 
  fuelLevel fuelStats;
  
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
