//oh boy this is the whole thing.
/*
so the goal: to make something fancy that is a hud. perhaps have a little car zoooooming around a map. that would be neat.

ill have it so that the spedometer and stuff have a startup sequence. "system START" and maby some welcome messages?

otherwise, everything seems quite straight forward, just repetitive? the hardest thing would be reading the files and stuff.
unless i make the map, that might be harder...


IM DOING THE MAP. I HAVE THE FILES FOR IT SO WE DOING IT BOIS.

k so with that data, i think they predefined the wheels size? i could use that to do things. theres also the lat/long that i might be able to get another speed calculation out of.
the accuracy isnt that important though, i dont think
if it was i dont think the example would be going like, 130 km/h. because lol thats crazy.

the cars are the bmw 323i
and truck is the ford f150

both the 1985 cars fit the AESTHETIC im aiming for. so lets use those. pixelate the cars and sideview and you got yourself a nice looking view.
because everyone knows that the 1980's are back in style...

SO STRAIGHT OFF: The vehicles depicted are property of their respective companies, and no profit is derived from this project, etc etc. Please don't sue me if you find this.

plan out the work.

file for the display, that seems obvious. objects for the bits and bobs? like a new object handling the spedometer, one for the fuel, etc? that could work
then another file for the reading of the files, thats important. getting the information from the files. yea.

a big ol file handling the display, where the objects handling the spedometer and such come in.

I could use pointers inside the object to update the data inside of them. 

now for the view. i want to make it so that the display is pretty, right?
so i have to load in images. thats a big part of this all. or have it read images like a bmp or something. 

*/

//fuelLevel fuel;
//carSpeed speedometer;
//carStatus car;
carDisplay car;
carGPS gps;
void setup(){
  size(1044,704);
  noStroke();
  smooth(0); //gotta get them pixely feeeeeel.
  textFont(createFont("font/PressStart2P-Regular.ttf",4)); //font from google fonts. very nice pixel art.
  textAlign(CENTER);
  //if you couldnt tell from what i have so far, im heavily inspired by them 8/16/pixely games.
  //pushMatrix();
  //car = new carStatus("minicar");
  //car = new carDisplay(car.vehicle.carType,0xffffff);
  //car.secondTick();//first render, make it so its not empty for the first frame.
  //popMatrix();
  gps = new carGPS();
  
}
int second = millis();
String carSelect = "";
boolean setup = false;
void draw(){
  //scale(2,2);
  //int test = millis();
  //if(test%50==0){
  //int second = millis()/1000;
  //if(second%3==2)
  //  gps.render(51.051, -114.092);
  //if(second%3==1)
  //  gps.render(51.081, -114.032);
  //if(second%3==0){
  //  println("LOOPS BROTHER");
  //  gps.render(51.074, -114.135);}
  //51.051, -114.092 //start
  //51.096,-114.046 //middle
  
  //51.074, -114.135 //end
  //if i hardcode the starting and ending coords to these, it should be good.

  if(carSelect.equals("truck") && !setup){
    setup = true;
    car = new carDisplay("truck",0xffffff);
  }
  else if(carSelect.equals("minicar") && !setup){
    car = new carDisplay("minicar",0xffffff);
    setup = true;
  }
  if(carSelect.equals("") && !setup){
    scale(3,3);
    background(0);
    text("1. truck\n2.minicar\n3. exit",width/6,height/6);
  }
  else if(carSelect.equals("exit"))
    exit();
  else{
    car.hudUpdate(car.status.vehicle.time,car.status.vehicle.fuelLevel[car.status.vehicle.time], car.status.vehicle.rpm[car.status.vehicle.time], car.status.speed,car.status.vehicle.longitude[car.status.vehicle.time],car.status.vehicle.latitude[car.status.vehicle.time],car.status.dirAngle,car.status.direction,car.status.fuelEconomyAvrg,car.status.fuelConsumption,car.status.fuelEconomy, car.status.distance, car.status.range);
    //i hate myself. the above. i truely hate myself. though it is easy to understand i still hate it so much. it needs to run on framerate though so i cant put it inside. ehh...
    //there are some oddities with the whole thing. like the jumps in the bar graphs.
    //but im going to chock it up to issues in the actual data feed. the gps jumps around inconsistently, so I can only assume how reliable the other values are. (which is not that good)
    if(second/200 != millis()/200){
      //keeps the view port at 60 fps, but renders the project a bit more frequently. 
      car.status.secondTick();
            //println("asdfasdf");
      second = millis();
    }
    //carDisplay.render(0xffffff);
  }
}

void keyPressed(){
  if(keyCode==49)
    carSelect = "truck";
  if(keyCode==50)
    carSelect = "minicar";
  if(keyCode==51)
    carSelect = "exit";
}
