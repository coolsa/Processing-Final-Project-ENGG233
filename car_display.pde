//this is the file that will have the car pixel art. this is faaaancy view port.
//above the actual dials and stuff, this is where you would see a car zooming about.
//perhaps the gps in the corner? that might be neat as well.
//gps would be large, 64x64, or how about segments of 32x32, 3 segments, something like that?
//96x96 is a good number...
//now to do this car view part!
//this is the file that does the rendering of the whole project.

class carDisplay{
  //this one is meant to do the car part. the big ol moving car. that fancy one.
  //part of it is the car, other part is the not-car.
  String carType;
  int framePos; //this tells us what the offset from the origin is. this is going to change every render.
  carHud hud;
  carStatus status;
  carDisplay(String car, int bgCol){
    status = new carStatus(car);
    hud = new carHud(status.tankCapacity);
    framePos=0;
    carType = status.vehicle.carType;
    render(bgCol);
  }
  void render(int bgCol){
    //scale(2,2);
    renderCity((width/64),2,bgCol);
    renderCar(2);
    framePos++;
  }
  void renderCity(int tiles, int mintiles, int backgroundColour){
    PImage sidings = loadImage("calgary/street/sidings.png"),
    road = loadImage("calgary/street/road.png"),
    city = loadImage("calgary/street/city.png"),
    clouds = loadImage("calgary/street/clouds.png"),
    mountains = loadImage("calgary/street/mountains.png"),
    skyline = loadImage("calgary/street/skyline.png");
    PImage[] world = {skyline, mountains, clouds, city, road, sidings};
    int[] worldXSpeed = {0,(framePos/64)%64,(framePos/16)%64,(framePos/2)%64,(framePos*4)%64,(framePos)%64};
    int[] worldYSpeed = {0,0,14-(framePos/24)%64,0,0,0};
    //fill(backgroundColour);
    for(int x = 0; x<6; x++){
      for(int i = -mintiles; i <= tiles; i++){
        image(world[x],64*i-worldXSpeed[x],worldYSpeed[x]);
        //rect(64,64,64*i,0);
      }
    }
  }
  void renderFuelEconomyAvrgGraph(float[] fuelEconomyAvrg,int time){
    //size is going to be large-ish.
    int iterations = 0;
    float scale = 0.5;
    if(time>30)
      iterations = time-30;
    pushMatrix();
    for(int i = time; i >= iterations;i--){
      fill(255);
      rect(0,0,15,-fuelEconomyAvrg[i]*scale);
      translate(-16,0);
    }
    popMatrix();
  }
  void renderCar(int tile){
    //scale(2,2);
    //clear();
    //background(0xff00ff);
    PImage carBody = loadImage("vehicle/vehiclePic/"+carType+"/carBody.png"),
    wheels = loadImage("vehicle/vehiclePic/"+carType+"/wheel"+(1+(framePos/8)%2)+".png"),
    sideMask = loadImage("vehicle/vehiclePic/"+carType+"/sideMask.png"),
    sideShine = loadImage("vehicle/vehiclePic/"+carType+"/sideShine.png"),
    topMask = loadImage("vehicle/vehiclePic/"+carType+"/topMask.png"),
    topShine = loadImage("vehicle/vehiclePic/"+carType+"/topShine.png"),
    frontMask = loadImage("vehicle/vehiclePic/"+carType+"/frontMask.png"),
    frontShine = loadImage("vehicle/vehiclePic/"+carType+"/frontShine.png"),
    pureDark = loadImage("vehicle/vehiclePic/"+carType+"/pureShine.png")
    ;
    pureDark.filter(INVERT);
    pureDark.filter(THRESHOLD);
    topMask.filter(INVERT);
    pureDark.blend(topShine,0,0,64,32,0-(framePos+10)%64,0,64,32,ADD);
    
    topMask.filter(INVERT);
    pureDark.mask(topMask);
    carBody.blend(pureDark,0,0,64,32,0,0,64,32,LIGHTEST);
    
    
    frontShine.blend(frontShine,0,0,64,32,0-framePos%64,0,64,32,BLEND);
    frontShine.mask(frontMask);
    carBody.blend(frontShine,0,0,64,32,0,0,64,32,LIGHTEST);
    sideShine.blend(sideShine,0,0,64,32,0-framePos%64,0,64,32,BLEND);
    sideShine.mask(sideMask);
    carBody.blend(sideShine,0,0,64,32,0,0,64,32,LIGHTEST);
    if(random(10)>1)
      image(wheels,64*tile,20);
    else
      image(wheels,64*tile,20-1);
    image(carBody,64*tile,20);
  }
  void hudUpdate(int time, float fuel, int rpm, float speed, float x, float y, float direction,String dir, float[] fuelEconAvrg, float[] fuelConsumed, float[] fuelEcon) {
    int width = 1280;//i made it with this size in mind initially, but oh boy did i need to change it.
    clear();
    background(12);
    pushMatrix();
    translate(width/2-696, height/2-164);
    scale(2, 2);
    hud.gps.render(y,x,status.direction);
    popMatrix();
    
    pushMatrix();
    scale(2,2);
    this.render(0xffffff);
    popMatrix();
    //println(status.direction);
    pushMatrix();
    scale(2,2);
    image(loadImage("vehicle/dashboard/dashboard.png"),0,0);
    popMatrix();
    pushMatrix();
    translate(width/2 - -128, height/2-64);
    scale(2, 2);
    hud.fuel.render(fuel);
    popMatrix();

    pushMatrix();
    translate(width/2-253, height/2-64);
    scale(2, 2);
    hud.rpm.render(rpm);
    popMatrix();

    pushMatrix();
    translate(width/2-64, height/2-64);
    scale(2, 2);
    hud.speed.render(speed);
    popMatrix();
    pushMatrix();
    translate(width/2-505,height/2-204);
    scale(2,2);
    hud.direction.render(direction,dir);
    popMatrix();
    
    pushMatrix();
    translate(width/2-256,height/2-128);
    scale(2,2);
    hud.fuelGraph.render(fuelEconAvrg,time,fuelEcon);
    //renderFuelEconomyAvrgGraph(fuelEconAvrg,time);
    popMatrix();
    pushMatrix();
    translate(width/2-256,height/2+256);
    scale(2,2);
    hud.fuelConsume.render(fuelConsumed,time);
    //renderFuelEconomyAvrgGraph(fuelEconAvrg,time);
    popMatrix();
  }
}
