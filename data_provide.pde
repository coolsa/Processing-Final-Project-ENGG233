//so this is the file that would read from the csv files, for both types of car.
//should not be hardcoded in, only thing hardcoded in is the pixelart of the car, but they should default to something else
//this should only be the raw data, nothing else.

class vehicleData {
  //this class contains all the information for the vehicle.
  //all of the vehicles have standard things: 
  Table vehicle;
  int[] rpm;
  float[] gearRatio,fuelLevel,longitude,latitude;
  int time;
  float wheelSize;
  //so this accepts two major ones, the BMW_323i and the Truck_F150
  //columns are Time, Gear Ratio, Fuel Level (liter), RPM, X, Y
  //allocated to time, gearRatio, fuelLevel, rpm, longitude, latitiude
  //Time column = time+1
  //dont load the whole thing at once. think about the LIMITED MEMORY on an actual car computer. gotta cheap out yo.
  vehicleData(String carType){
    vehicle = loadTable("vehicle/car_status_"+carType+".csv","header");
    rpm = new int[vehicle.getRowCount()];
    gearRatio = new float[vehicle.getRowCount()];
    fuelLevel = new float[vehicle.getRowCount()];
    longitude = new float[vehicle.getRowCount()];
    latitude = new float[vehicle.getRowCount()];
    time = -1;
  }
  void timeStep(){
    if(time < vehicle.getRowCount()-1){ //this is to stop errors.
      time++;
      rpm[time] = vehicle.getInt(time,"RPM");
      gearRatio[time] = vehicle.getFloat(time, "Gear Ratio");
      fuelLevel[time] = vehicle.getFloat(time, "Fuel Level (liter)");
      longitude[time] = vehicle.getFloat(time, "X");
      latitude[time] = vehicle.getFloat(time, "Y");//now we have finished the time step, so move on by increasing by 1.
    }
  }
}
