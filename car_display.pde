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
    clear();
    background(0xff00ff);
    PImage carBody = loadImage("vehicle/vehiclePic/"+carType+"/carBody.png"),
    wheels = loadImage("vehicle/vehiclePic/"+carType+"/wheel"+(1+(framePos/8)%2)+".png"),
    sideMask = loadImage("vehicle/vehiclePic/"+carType+"/sideMask.png"),
    sideShine = loadImage("vehicle/vehiclePic/"+carType+"/sideShine.png"),
    topMask = loadImage("vehicle/vehiclePic/"+carType+"/topMask.png"),
    topMask2 = loadImage("vehicle/vehiclePic/"+carType+"/topMask.png"),
    topShine = loadImage("vehicle/vehiclePic/"+carType+"/topShine.png"),
    frontMask = loadImage("vehicle/vehiclePic/"+carType+"/frontMask.png"),
    frontShine = loadImage("vehicle/vehiclePic/"+carType+"/frontShine.png"),
    pureShine = loadImage("vehicle/vehiclePic/"+carType+"/pureShine.png")
    ;
    this.framePos = ((framePos+1)%64);
    //if(random(10)>1)
    //  image(wheels,0,0);
    //else
    //  image(wheels,0,-1);
    //topShine.blend(topShine,0,0,64,32,0-2*framePos,0,64,32,BLEND);
    //topMask.filter(THRESHOLD,0.5);
    //topShine.mask(topMask);
    //topMask.mask(topMask);
    topMask.filter(INVERT);
    topMask.blend(topShine,0,0,64,32,0-framePos,0,64,32,ADD);
    //topMask.mask(topMask2);
    //topMask.filter(INVERT);
    //topShine.mask(topShine);
    //topShine.mask(topMask2);
    pureShine.mask(topMask);
    pureShine.blend(topMask2,0,0,64,32,0,0,64,32,MULTIPLY);
    //topMask2.filter(THRESHOLD);
    pureShine.mask(topMask2);
    image(topMask,0,0);
    image(topMask2,64,0);
    image(pureShine,128,0);
    //carBody.blend(topShine,0,0,64,32,0,0,64,32,LIGHTEST);
    
    
    frontShine.blend(frontShine,0,0,64,32,0-framePos,0,64,32,BLEND);
    frontShine.mask(frontMask);
    carBody.blend(frontShine,0,0,64,32,0,0,64,32,LIGHTEST);
    sideShine.blend(sideShine,0,0,64,32,0-framePos,0,64,32,BLEND);
    sideShine.mask(sideMask);
    carBody.blend(sideShine,0,0,64,32,0,0,64,32,LIGHTEST);
    image(carBody,0,32);
  }
}
