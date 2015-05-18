  //Created by Brian O'Meara for Evolution 2013 Lightning Talks
//   This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.

PFont f16;
PFont f32;
PFont f64;
PFont f128;
PFont f200;
PFont f96;
Table table;
String section = "A";
int offset = 0;

void setup() {
  frameRate(20);
  //size(1200, 900);
  size(displayWidth, displayHeight);
  f128 = createFont("Arial", 128, true); 
  f96 = createFont("Arial", 96, true); 
  f200 = createFont("Arial", 200, true);
  f64 = createFont("Arial", 64, true); 
  f32 = createFont("Arial", 32, true); 
  f16 = createFont("Arial", 16, true); 
  table = loadTable("ssblightning.tsv", "header, tsv");
//  table = loadTable("http://www.weebly.com/uploads/3/1/9/3/31930665/ssblightning.tsv", "header, tsv");
 // table = loadTable("LightningTalksSchedule2014.csv", "header, csv");
}



void draw() {

  if (keyPressed) {
    if (key == 'a' || key=='A') {
      section = "A";
    }
    if (key == 'b' || key=='B') {
      section = "B";
    }
    if (key == 'c' || key=='C') {
      section = "C";
    }
  }
  fill(0, 0, 0);
  textAlign(CENTER);

  if (minute()%5<3) {
    background(91, 250, 81);
  } 
  else if (minute()%5==3) {
    background(252, 252, 0);
  }
  else {
    background(203, 4, 4);
    textFont(f64);       
    text("Set up for next talk", width/2, 2*height/5);
  }
  offset=0;
  textFont(f200);       
  int secondsLeft = 4*60 - ( 60* (minute()%5) + second());
  String[] timeString = new String[2];
  //timeString[0] = nf(minute()%5, 1);
  int minutesLeft = floor(secondsLeft/60.0);

  timeString[0] = nf(minutesLeft, 1);
  //timeString[1] = nf(second(), 2);
  timeString[1] = nf(abs(minutesLeft * 60 - secondsLeft), 2);
  if ( minutesLeft < 0) {
    timeString[0] = "0";
    timeString[1] = nf(60-abs(secondsLeft), 2);
  }
  text(join(timeString, ':'), width/2, height/5);
  textFont(f16);       
  int currentTimeInt = (60 * hour()) + minute();
  text("Running script for section " + section + ", type A, B, or C to switch to appropriate section", width/2, height-50);

  for (TableRow row : table.matchRows(section, "Section")) {
    int rowCurrentTimeInt = (60*int(row.getString("Hour"))) + int(row.getString("Minute"));
    if ( (currentTimeInt - rowCurrentTimeInt < 4) && (currentTimeInt - rowCurrentTimeInt >= 0)) {
      textFont(f64);       
      text("Now: " + row.getString("Presenter") +  " " + row.getString("Time") , width/2, 2*height/5);
    }
    if ( (rowCurrentTimeInt - currentTimeInt <= 5) && (rowCurrentTimeInt - currentTimeInt > 0)) {
      textFont(f64);       
      text("Next: " + row.getString("Presenter") +  " " + row.getString("Time") , width/2, 3*height/5);
    }
    if ((rowCurrentTimeInt - currentTimeInt > 0) & (offset < 4) && (rowCurrentTimeInt - currentTimeInt > 5)) {
      textFont(f32);       
      text("Then: " + row.getString("Presenter") +  " " + row.getString("Time") , width/2, 4*height/5 + 40*offset);
      offset=offset+1;
    }
  }
}
