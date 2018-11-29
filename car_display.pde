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
  int framePos; //this tells us what the offset from the origin is. this is going to change every render.
  carDisplay(String car){
    framePos=0;
    carType = car;
    render();
  }
  void render(){
    scale(2,2);
    println(framePos);
    PImage carBody = loadImage("vehicle/vehiclePic/"+carType+"/carBody.png"),
    wheels = loadImage("vehicle/vehiclePic/"+carType+"/wheel"+(1+(framePos/8)%2)+".png"),
    sideMask = loadImage("vehicle/vehiclePic/"+carType+"/sideMask.png"),
    sideShine = loadImage("vehicle/vehiclePic/"+carType+"/sideShine.png")
    ;
    this.framePos = ((framePos+1)%64);
    println(framePos);
    //if(random(10)>1)
    //  image(wheels,0,0);
    //else
    //  image(wheels,0,-1);
    //image(carBody,0,0);
    sideShine.blend(sideShine,0,0,64,32,0-framePos,0,64,32,BLEND);
    sideMask.filter(INVERT);
    sideShine.mask(sideMask);
    image(sideShine,0,0);
  }
}
