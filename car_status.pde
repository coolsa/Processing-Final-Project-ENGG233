//this is the big ol file. with the data_provide file, this one calculates car stuff.
//direction, speed, fuel, fuel usage, other stuff. all here.
//it reads from the data provided, and then works on that.
class carStatus{
  //this is where the cars are setup.
  //so minicar = BMW_323i
  //and truck = Truck_F150
  //otherwise default to minicar i guess.
  float radius, tankCapacity; //radius of wheel, tank size in litres.
  float speed; //speed in km/h
  vehicleData vehicle;
  carHud hud;
  carStatus(String carType){
    if(carType.equals("truck")){
      vehicle = new vehicleData("Truck_F150");
      radius = 25.4;
      tankCapacity = 80;
    }
    else {//else if(carType.equals("minicar")){ //commented this out, now defaults to minicar.
      vehicle = new vehicleData("BMW_323i");
      radius = 23;
      tankCapacity = 60;
    }
    hud = new carHud(tankCapacity);
    
    secondTick();
  }
  void updateSpeed(int rpm, float gearRatio){
    speed = (rpm/60)*(1/gearRatio)*(2*PI*(radius/10)); //radius to meterse.
    //so that would become speed in meters per second..
    //so m/s to km/h = (m*1000) over (seconds to hour = seconds to minutes to hours... seconds / 60 / 60
    speed = speed*1000.0/(60*60); //so this is speed in km/h.
  }
  void hudUpdate(float fuel,int rpm,float speed){
    clear();
    background(12);
    pushMatrix();
    translate(width - (width/6 + 64),height-height/3);
    scale(2,2);
    hud.fuel.render(fuel);
    popMatrix();
    
    pushMatrix();
    translate(width/6-64,height-height/3);
    scale(2,2);
    hud.rpm.render(rpm);
    popMatrix();
    
    pushMatrix();
    translate(width/2-64,height-height/3);
    scale(2,2);
    hud.speed.render(speed);
    popMatrix();
  }
  void secondTick(){
    vehicle.timeStep();
    updateSpeed(vehicle.rpm[vehicle.time],vehicle.gearRatio[vehicle.time]);
    hudUpdate(vehicle.fuelLevel[vehicle.time],vehicle.rpm[vehicle.time],speed);
  }
}
