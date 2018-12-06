//this is the big ol file. with the data_provide file, this one calculates car stuff.
//direction, speed, fuel, fuel usage, other stuff. all here.
//it reads from the data provided, and then works on that.
//this file has kind of ended up as the main, overarching file, with most of the things that are mildly important. THIS IS THe CAR
//for now, i have to reorganize this to get rid of the hud stuff.
class carStatus {
  //this is where the cars are setup.
  //so minicar = BMW_323i
  //and truck = Truck_F150
  //otherwise default to minicar i guess.
  float radius, tankCapacity; //radius of wheel, tank size in litres.
  float speed; //speed in km/h
  vehicleData vehicle;
  carHud hud;
  float dirAngle = 0;
  String direction = "";
  carStatus(String carType) {
    if (carType.equals("truck")) {
      vehicle = new vehicleData("Truck_F150");
      radius = 25.4;
      tankCapacity = 80;
    } else {//else if(carType.equals("minicar")){ //commented this out, now defaults to minicar.
      vehicle = new vehicleData("BMW_323i");
      radius = 23;
      tankCapacity = 60;
    }

    secondTick();
  }
  void updateSpeed(int rpm, float gearRatio) {
    speed = (rpm/60)*(1/gearRatio)*(2*PI*(radius/10)); //radius to meterse.
    //so that would become speed in meters per second..
    //so m/s to km/h = (m*1000) over (seconds to hour = seconds to minutes to hours... seconds / 60 / 60
    speed = speed*1000.0/(60*60); //so this is speed in km/h.
  }
  void updateDirection(float prevLat, float prevLong, float nextLat, float nextLong){
    float[] diffPos = {nextLat-prevLat,nextLong-prevLong};
    direction = "";
    if(diffPos[0]>0)
      direction += "N";
    else if(diffPos[0]<0)
      direction += "S";
    
    if(diffPos[1]>0)
      direction += "E";
    else if(diffPos[1]<0)
      direction += "W";
    //i could rework this so that i have two values, one is the angle and the other is the distance.
    //remember, soh cah toa...
    //i have oposite and adj. so i just need tan of those values. the matter of what i want for the direction.
    //this might work:
    dirAngle = tan(diffPos[0]/diffPos[1]); //just need to so some things with taht.
  }
  void secondTick() {
    //println("asdfasdf");
    vehicle.timeStep();
    updateSpeed(vehicle.rpm[vehicle.time], vehicle.gearRatio[vehicle.time]);
    if(vehicle.time>0)
    updateDirection(vehicle.latitude[vehicle.time-1],vehicle.longitude[vehicle.time-1],vehicle.latitude[vehicle.time],vehicle.longitude[vehicle.time]);
    //hudUpdate(vehicle.fuelLevel[vehicle.time], vehicle.rpm[vehicle.time], speed,vehicle.longitude[vehicle.time],vehicle.latitude[vehicle.time]);
  }
}
