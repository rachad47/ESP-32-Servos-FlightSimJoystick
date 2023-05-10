import processing.serial.*;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import cc.arduino.*;

int xpos=90; // set x servo's value to mid point (0-180);
int ypos=90; // and the same here
Serial port; // The serial port we will be using

ControlDevice cont;
ControlIO control;
//Arduino arduino;

float thumbX;
float thumbY;
float thumbf;

void setup()
{
  size(360, 360);
  frameRate(100);
   cont = ControlIO.getInstance(this).getMatchedDevice("test");
  
  if (cont == null) {
    println("miaw miaw"); // write better exit statements than me
    System.exit(-1);
  }

  println(Serial.list()); // List COM-ports
  port = new Serial(this, Serial.list()[0], 19200);
}

public void getUserInput() {
  thumbX = map(cont.getSlider("xAxis").getValue(), -1, 1, 0, 180);
  thumbY = map(cont.getSlider("yAxis").getValue(), -1, 1, 0, 180);
  thumbf = map(cont.getButton("fire").getValue(), -1, 1, 0, 180);
}

void draw()
{
  getUserInput();
  
  //just desing 
  fill(175);
  rect(0,0,360,360);
  fill(255,0,0); //rgb value so RED
  rect(180, 175, thumbX-180, 10); //xpos, ypos, width, height
  fill(0,255,0); // and GREEN
  rect(175, 180, 10, thumbY-180);
  
  //get (x,y coordinates)
  update((int)thumbX, (int)thumbY,(int)thumbf);
}

void update(int x, int y , int f )
{
  
  //Output the servo position ( from 0 to 180)
  port.write(x+"x");
  port.write(y+"y");
  port.write(f+"f");
  
  
}
