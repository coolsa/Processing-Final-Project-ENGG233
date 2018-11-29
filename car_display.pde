//this is the file that will have the car pixel art. this is faaaancy view port.
//above the actual dials and stuff, this is where you would see a car zooming about.
//perhaps the gps in the corner? that might be neat as well.
//gps would be large, 64x64, or how about segments of 32x32, 3 segments, something like that?
//96x96 is a good number...
//now to do this car view part!

class carDisplay{
  //this one is meant to do the car part. the big ol moving car. that fancy one.
  //part of it is the car, other part is the not-car.
  String carType;
  int frame = 0; //this tells us what the offset from the origin is. this is going to change every render.
  carDisplay(String car){
    carType = car;
  }
  void render(String carType){
    PImage carBody = loadImage("vehicle/vehiclePic/"+carType+"/carBody.png"),
    wheel1 = loadImage("vehicle/vehiclePic/"+carType+"/wheel"+(1+frame%2)+".png");
    frame = (++frame%16);
  }
}
