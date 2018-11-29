//this is the big ol file. with the data_provide file, this one calculates car stuff.
//direction, speed, fuel, fuel usage, other stuff. all here.
//it reads from the data provided, and then works on that.
class carStatus{
  //this is where the cars are setup.
  //so minicar = BMW_323i
  //and truck = Truck_F150
  //otherwise default to minicar i guess.
  float radius, tankCapacity; //radius of wheel, tank size in litres.
  vehicleData vehicle;
  
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
  }
}
