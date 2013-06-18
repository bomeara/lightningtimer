PFont f16;
PFont f32;
PFont f64;
PFont f128;

void setup() {
  frameRate(4);
  size(400, 400);
  f128 = createFont("Arial", 128, true); 
  f64 = createFont("Arial", 64, true); 
  f32 = createFont("Arial", 32, true); 
  f16 = createFont("Arial", 16, true); 
  // Table table = loadTable("data.csv","header");
}



void draw() {
  if (minute()%5<3) {
    background(91, 250, 81);
  } 
  else if (minute()%5==3) {
    background(252, 252, 0);
  }
  else {
    background(203, 4, 4);
  }

  textFont(f128);       
  fill(0, 0, 0);
  //stroke(175);
  textAlign(CENTER);
  int secondsLeft = 4*60 - ( 60* (minute()%5) + second());
  String[] timeString = new String[2];
  //timeString[0] = nf(minute()%5, 1);
  int minutesLeft = floor(secondsLeft/60.0);

  timeString[0] = nf(minutesLeft, 1);
  //timeString[1] = nf(second(), 2);
  timeString[1] = nf(abs(minutesLeft * 60 - secondsLeft), 2);
  if ( minutesLeft < 0) {
    timeString[0] = "0";
    timeString[1] = nf(abs(secondsLeft), 2);
  }
  text(join(timeString, ':'), width/2, 100);
}

