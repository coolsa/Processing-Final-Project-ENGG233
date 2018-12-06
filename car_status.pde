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
  float speed, distance=0; //speed in km/h and distance in km.
  float fuelConsumed;
  float[] fuelEconomy, fuelEconomyAvrg;
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
    fuelEconomy = new float[vehicle.vehicle.getRowCount()];
    fuelEconomyAvrg = new float[vehicle.vehicle.getRowCount()];
    secondTick();
  }
  void updateDistance(){ //speed is in this, so no need to feed it in.
    //because each update should be exactly 1 second. "each second, data is read from a file" or something.
    distance += speed/60;
  }
  void updateSpeed(int rpm, float gearRatio) {
    speed = (rpm/60)*(1/gearRatio)*(2*PI*(radius/10)); //radius to meterse.
    //so that would become speed in meters per second..
    //so m/s to km/h = (m*1000) over (seconds to hour = seconds to minutes to hours... seconds / 60 / 60
    speed = speed*1000.0/(60*60); //so this is speed in km/h. easy converting back too. just speed*(60*60)/1000. v nice
  }
  void updateDirection(float prevLat, float prevLong, float nextLat, float nextLong){

    //float[] diffPos = {1.0,1.0};
    float[] diffPos = {nextLat-prevLat,nextLong-prevLong}; //sometimes it buggs out during a map jump
    //because the car teleports. thats normal.
    direction = "";
    dirAngle = atan(diffPos[1]/diffPos[0])+PI/2; //just need to so some things with tht.
    //i could rework this so that i have two values, one is the angle and the other is the distance.
    //remember, soh cah toa... / is distance between the two points, but i have _ and | so:
    //i have oposite and adj. so i just need arc tan of those values. the matter of what i want for the direction.
    //this might work, but i think ill need to alter the positions a bit. in the rendering.
    if(Float.isNaN(dirAngle)){
      println("asuid\nasdfasdfasdf\n\nasdasdfasdfasdfn\n\nasdfasdfasdfhfuiashdf");
      dirAngle = 0;
    }
    if(diffPos[0]>0){
      dirAngle-=PI;
      direction += "N";
    }
    else if(diffPos[0]<0){
      direction += "S";
    }
    if(diffPos[1]>0){
      //dirAngle += PI;
      direction += "E";
    }
    else if(diffPos[1]<0){
      direction += "W";
    }
    println(dirAngle);
    println(direction); //more debug.
  }
  void updateFuelConsumed(float startFuel, float fuelLevel){
    //fuel at start of trip - fuel at present time in trip.
    fuelConsumed = startFuel-fuelLevel;
  }
  void updateFuelEconomy(){//because this is based off of the fuel consumed, distance, no need to feed values in
    fuelEconomy[vehicle.time] = distance/fuelConsumed; //this allows history! woooooo.
    if(vehicle.time>0){//the below basically calculates the average over time, very fancy.
      //more complex, we know the prev (fuelAvrg[n-1] is (fuel[0]+fuel[1]+...+fuel[n-1])/(n-1), so n would be ((n-1)*fuelAvrg[n-1] + fuel[n])/n. v fancy.
      fuelEconomyAvrg[vehicle.time] = (fuelEconomyAvrg[vehicle.time-1]*(vehicle.time-1) + fuelEconomy[vehicle.time])/vehicle.time;
      if(Float.isNaN(fuelEconomy[vehicle.time]) || Float.isNaN(fuelEconomyAvrg[vehicle.time-1]))
        fuelEconomyAvrg[vehicle.time] = 0;
    }
    else
      fuelEconomyAvrg[vehicle.time] = fuelEconomy[vehicle.time];
  }
  void updateRange(){
  }
  void secondTick() {
    //println("asdfasdf");
    vehicle.timeStep();
    updateSpeed(vehicle.rpm[vehicle.time], vehicle.gearRatio[vehicle.time]);
    updateDistance();
    updateFuelConsumed(vehicle.fuelLevel[0],vehicle.fuelLevel[vehicle.time]);
    updateFuelEconomy();
    println(fuelEconomy[vehicle.time]);
    println(fuelEconomyAvrg[vehicle.time]);
    //println(fuelConsumed);
    if(vehicle.time>0)
    updateDirection(vehicle.latitude[vehicle.time-1],vehicle.longitude[vehicle.time-1],vehicle.latitude[vehicle.time],vehicle.longitude[vehicle.time]);
    //hudUpdate(vehicle.fuelLevel[vehicle.time], vehicle.rpm[vehicle.time], speed,vehicle.longitude[vehicle.time],vehicle.latitude[vehicle.time]);
  }
}
