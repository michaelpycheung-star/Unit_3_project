// --- Global Variables ---
color currentColor;
float thickness = 5;
color canvasColor;
PImage savedImage; // For the Load feature

// Tool states
int stampMode = 0; // 0: Squiggly, 1: Circle, 2: Square
float sliderX = 350;

// Colors
color red, orange, yellow, green, blue, purple, black;

void setup() {
  size(800, 600);
  
  red    = color(255, 0, 0);
  orange = color(255, 165, 0);
  yellow = color(255, 255, 0);
  green  = color(0, 200, 0);
  blue   = color(0, 0, 255);
  purple = color(150, 0, 255);
  black  = color(0);
  
  currentColor = black;
  canvasColor = color(255);
  background(canvasColor);
}

void draw() {
  // 1. Toolbar UI
  noStroke();
  fill(230);
  rect(0, 0, width, 100);
  stroke(0);
  line(0, 100, width, 100);

  // 2. Color Buttons (Now including Black)
  circleButton(red, 30, 30, 25);
  circleButton(orange, 65, 30, 25);
  circleButton(yellow, 100, 30, 25);
  circleButton(green, 30, 70, 25);
  circleButton(blue, 65, 70, 25);
  circleButton(purple, 100, 70, 25);
  circleButton(black, 135, 50, 30); // Black button

  // 3. Thickness Slider
  drawSlider(200, 50, 150);

  // 4. Indicator
  drawIndicator(400, 50);

  // 5. Stamp Tools
  rectButton(color(200), 480, 25, 50, 50, (stampMode == 1), "CIRC");
  rectButton(color(200), 540, 25, 50, 50, (stampMode == 2), "RECT");

  // 6. Action Buttons
  actionButton("NEW", 650, 20, 80, 20);
  actionButton("SAVE", 650, 45, 80, 20);
  actionButton("LOAD", 650, 70, 80, 20);

  // 7. Continuous Drawing (Squiggly)
  if (mousePressed && mouseY > 100 && stampMode == 0) {
    stroke(currentColor);
    strokeWeight(thickness);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}

// --- Required Button Functions ---

void circleButton(color c, float x, float y, float d) {
  if (dist(mouseX, mouseY, x, y) < d/2) {
    strokeWeight(3);
    stroke(100);
  } else {
    strokeWeight(1);
    stroke(0);
  }
  fill(c);
  circle(x, y, d);
}

void rectButton(color c, float x, float y, float w, float h, boolean active, String label) {
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
    strokeWeight(4);
  } else {
    strokeWeight(active ? 3 : 1);
  }
  stroke(active ? color(0, 120, 255) : 0);
  fill(c);
  rect(x, y, w, h);
  fill(0);
  textAlign(CENTER, CENTER);
  text(label, x + w/2, y + h/2);
}

// --- Action & UI Handlers ---

void mousePressed() {
  // Color selection
  if (dist(mouseX, mouseY, 30, 30) < 12) { currentColor = red; stampMode = 0; }
  if (dist(mouseX, mouseY, 65, 30) < 12) { currentColor = orange; stampMode = 0; }
  if (dist(mouseX, mouseY, 100, 30) < 12) { currentColor = yellow; stampMode = 0; }
  if (dist(mouseX, mouseY, 30, 70) < 12) { currentColor = green; stampMode = 0; }
  if (dist(mouseX, mouseY, 65, 70) < 12) { currentColor = blue; stampMode = 0; }
  if (dist(mouseX, mouseY, 100, 70) < 12) { currentColor = purple; stampMode = 0; }
  if (dist(mouseX, mouseY, 135, 50) < 15) { currentColor = black; stampMode = 0; }

  // Stamp Toggles
  if (mouseX > 480 && mouseX < 530 && mouseY > 25 && mouseY < 75) stampMode = (stampMode == 1) ? 0 : 1;
  if (mouseX > 540 && mouseX < 590 && mouseY > 25 && mouseY < 75) stampMode = (stampMode == 2) ? 0 : 2;

  // Action Button Logic
  if (mouseX > 650 && mouseX < 730) {
    // NEW
    if (mouseY > 20 && mouseY < 40) {
      fill(255);
      noStroke();
      rect(0, 101, width, height);
    }
    // SAVE
    if (mouseY > 45 && mouseY < 65) {
      PImage canvasPart = get(0, 101, width, height-101);
      canvasPart.save("myPainting.png");
      println("Saved!");
    }
    // LOAD
    if (mouseY > 70 && mouseY < 90) {
      savedImage = loadImage("myPainting.png");
      if (savedImage != null) {
        image(savedImage, 0, 101);
      }
    }
  }

  // Stamp Placement
  if (mouseY > 100) {
    fill(currentColor);
    noStroke();
    if (stampMode == 1) circle(mouseX, mouseY, thickness * 5);
    if (stampMode == 2) rect(mouseX - (thickness*2.5), mouseY - (thickness*2.5), thickness*5, thickness*5);
  }
}

void mouseDragged() {
  if (mouseX >= 200 && mouseX <= 350 && mouseY > 40 && mouseY < 60) {
    sliderX = mouseX;
    thickness = map(sliderX, 200, 350, 1, 25);
  }
}

void drawSlider(float x, float y, float len) {
  stroke(150);
  strokeWeight(4);
  line(x, y, x + len, y);
  if (dist(mouseX, mouseY, sliderX, y) < 10) fill(100);
  else fill(255);
  strokeWeight(1);
  stroke(0);
  circle(sliderX, y, 15);
}

void drawIndicator(float x, float y) {
  fill(255);
  stroke(0);
  strokeWeight(1);
  rect(x - 25, y - 25, 50, 50);
  fill(currentColor);
  noStroke();
  circle(x, y, thickness * 1.5);
}

void actionButton(String label, float x, float y, float w, float h) {
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) fill(200);
  else fill(255);
  stroke(0);
  strokeWeight(1);
  rect(x, y, w, h);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(10);
  text(label, x + w/2, y + h/2);
  textSize(12); // Reset
}
