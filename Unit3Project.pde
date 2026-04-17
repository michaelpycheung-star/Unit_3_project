//Unit 3 project
//Drawing app

// 1. Variables
color selectedColor;
float thickness;
float sliderX;
boolean stampOn;

// Color Palette 
color red    = #E63946;
color blue   = #457B9D;
color green  = #2ADD8F;
color yellow = #E9C46A;
color purple = #8338EC;
color orange = #F4A261;
color white  = #FFFFFF;
color black  = #2B2D42;

void setup() {
  size(800, 600);
  background(255);

  // Defaults
  selectedColor = black;
  thickness = 5;
  sliderX = 400; // Slider starts in the middle
  stampOn = false;
}

void draw() {
  // toolbar
  noStroke();
  fill(220);
  rect(0, 0, width, 100);

  // 2. Colour bottons
  circleButton(red, 40, 30, 40);
  circleButton(blue, 90, 30, 40);
  circleButton(green, 140, 30, 40);
  circleButton(yellow, 40, 70, 40);
  circleButton(purple, 90, 70, 40);
  circleButton(orange, 140, 70, 40);

  // 3. Slider 
  stroke(0);
  strokeWeight(2);
  line(300, 50, 500, 50);

  // Knob
  if (dist(mouseX, mouseY, sliderX, 50) < 15) {
    fill(150);
  } else {
    fill(255);
  }
  circle(sliderX, 50, 25);

  // slider position to thickness
  thickness = map(sliderX, 300, 500, 1, 30);

  // 4. Indicator 
  fill(selectedColor);
  noStroke();
  if (stampOn) {
    rect(550, 35, thickness, thickness);
  } else {
    circle(565, 50, thickness);
  }

  // 5. STAMP & NEW BUTTONS
  rectButton("STAMP", 620, 20, 70, 30, stampOn);
  rectButton("NEW", 710, 20, 70, 30, false);

  //Drawing logic
  if (mousePressed && mouseY > 100) {
    stroke(selectedColor);
    strokeWeight(thickness);
    if (stampOn) {
      fill(selectedColor);
      noStroke();
      
      rect(mouseX - thickness/2, mouseY - thickness/2, thickness, thickness);
    } else {
      
      line(pmouseX, pmouseY, mouseX, mouseY);
    }
  }
} 

//functions

void circleButton(color c, float x, float y, float d) {
  // Tactile
  if (dist(mouseX, mouseY, x, y) < d/2) {
    strokeWeight(4);
    stroke(255);
  } else {
    strokeWeight(1);
    stroke(0);
  }
  fill(c);
  circle(x, y, d);
}

void rectButton(String label, float x, float y, float w, float h, boolean active) {
  // Tactile
  if ((mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) || active) {
    fill(100);
  } else {
    fill(200);
  }
  stroke(0);
  strokeWeight(1);
  rect(x, y, w, h);
  fill(0);
  textAlign(CENTER, CENTER);
  text(label, x + w/2, y + h/2);
}

// input functions

void mousePressed() {
  
  if (dist(mouseX, mouseY, 40, 30) < 20) { selectedColor = red; stampOn = false; }
  if (dist(mouseX, mouseY, 90, 30) < 20) { selectedColor = blue; stampOn = false; }
  if (dist(mouseX, mouseY, 140, 30) < 20) { selectedColor = green; stampOn = false; }
  if (dist(mouseX, mouseY, 40, 70) < 20) { selectedColor = yellow; stampOn = false; }
  if (dist(mouseX, mouseY, 90, 70) < 20) { selectedColor = purple; stampOn = false; }
  if (dist(mouseX, mouseY, 140, 70) < 20) { selectedColor = orange; stampOn = false; }

  // Toggle Stamp Button
  if (mouseX > 620 && mouseX < 690 && mouseY > 20 && mouseY < 50) {
    stampOn = !stampOn;
  }

  // Clear Canvas 
  if (mouseX > 710 && mouseX < 780 && mouseY > 20 && mouseY < 50) {
    background(255);
  }
}

void mouseDragged() {

  if (mouseX >= 300 && mouseX <= 500 && mouseY > 30 && mouseY < 70) {
    sliderX = mouseX;
  }
}
