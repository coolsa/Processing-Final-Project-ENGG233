//this file takes all the parts, the car_status and the car_hud, and puts them together into a lovely display. this is basically the user end. 
//im worried that the simplistic file formatting may dock points, so please do let me know if that is the case.
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
fuelLevel fuel;
carSpeed speedometer;
void setup(){
  size(500,500);
  noStroke();
  smooth(0); //gotta get them pixely feeeeeel.
  textFont(createFont("font/PressStart2P-Regular.ttf",4));
  //textSize(4);
  //scale(4,4);
  //text("ttest",77,77);
  pushMatrix();
  translate(50,50);
  scale(2,2);
  fuel = new fuelLevel(80);
  speedometer = new carSpeed();
  //fuel.render(20);
  popMatrix();
  
}
int asdf = 80;
void draw(){
  clear();
  background(0);
  
  
  //fuel.render(80);
  pushMatrix();
  translate(319,300);
  scale(2,2);
  fuel.render(asdf--);
  popMatrix();
  pushMatrix();
  translate(39,298);
  scale(2,2);
  speedometer.render(50);
  popMatrix();
  
  //fuel.render(asdf--);
  if(asdf<=0) asdf = 80;
}
