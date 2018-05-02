/**
 * Don't let it fall - a simple game builded with Processing
 * 
 * @author Thiago Reis @date May, 2018
 */

// Text font
PFont f;

// Constants
final int START = 0;
final int GAME = 1;
final int DIED = 2;
final float VELOC = -10; // always negative
final int MENU_HEIGHT = 70;

// Flags
int playing;
boolean newBest;

// Ohter global variables
int ballX, ballY;
int ballSize;
float xVel, yVel;
int points;
int best;

void setup() {
  size(300, 500);
  //surface.setResizable(true);
  f = createFont("Arial", 16, true);
  playing = START;
  points = best = 0; ballSize = 150;
  newBest = false;
}

void draw() {
  background(255);
  minimumWindow(400, 600);
  
  // Menu
  fill(0);
  rect(0, 0, width, MENU_HEIGHT);
  
  // Text
  textFont(f, 16);
  fill(255);
  textAlign(LEFT, CENTER);
  if(playing == START) text("Click on the ball to play!\nPress 'r' to restart", width/8, 35);
  else text("Points: " + points + "\nPress 'r' to restart", width/8, 35);
  
  // Ball
  stroke(0); fill(255,0,0); 
  if(playing == START) {ellipse(width/2, height/2, ballSize, ballSize); ballX = width/2; ballY = height/2;}
  else {
    ellipse(ballX, ballY, ballSize, ballSize);
    if(playing == GAME) {
      ballX += xVel;
      ballY += yVel;
      yVel += VELOC / (-20); // "gravity"
    }
  }
  
  // Collisions
  endGame();
  collisions();
}

// Handle with mouse click when it
void mousePressed() {
  float distance = distance(mouseX, mouseY, ballX, ballY);
  if(distance <= ballSize/2) {
    if(playing == START) { playing = GAME; yVel = VELOC; if(distance != 0) xVel = VELOC * (mouseX - ballX) / distance; }
    else if (playing == GAME && !collisions()) {  // If it's stuck on a wall, it won't allow any click from the player
      points++;
      if(distance == 0) yVel = xVel = 0; // to avoid division by 0
      else {
        yVel = VELOC * (mouseY - ballY) / distance;
        xVel = VELOC * (mouseX - ballX) / distance;
      }
    }
  }
}

// Handle with key events
void keyPressed() {
  //if(key == 'q' || key == 'Q') exit();
  if(key == 'r' || key == 'R') { playing = 0; points = 0; newBest = false; }
}

// Deal with the end of the game -> touch the ground
void endGame() {
  if((ballY + ballSize / 2) >= height) {
    ballY = height - ballSize / 2;
    // Stops the ball to moving
    xVel = yVel = 0;
    // Set status game
    playing = DIED;
    if(points > best) {
      best = points;
      newBest = true;
    }
    // Loss dialog
    fill(0);
    rect(0, height/2, width, 70);
    // Loss text
    textFont(f, 16);
    fill(255);
    textAlign(CENTER, TOP);
    if(newBest) text("You lost!\nPoints: " + points + "  New best!", width/2, height/2 + 10);
    else text("You lost!\nPoints: " + points + "  Best: " + best, width/2, height/2 + 10);
  }
}

// Sees if it occurred a collision -> touch side walls and ceil
boolean collisions() {
  // If it touch any side wall
  if((ballX - ballSize / 2) <= 0 || (ballX + ballSize / 2) >= width) {
    // If the ball stuck into the walls, it will pull out of it
    if((ballX - ballSize / 2) < 0) ballX = ballSize / 2 + 1;
    if((ballX + ballSize / 2) > width) ballX = width - ballSize / 2 - 1;
    xVel *= -1;
    return true;
  }
  // If it touch the ceil, bellow the menu
  if((ballY - ballSize / 2) <= MENU_HEIGHT) {
    // Same case from above, but for the top part
    if((ballY - ballSize / 2) < MENU_HEIGHT) ballY = ballSize / 2 + MENU_HEIGHT + 1;
    yVel *= -1;
    return true;
  }
  return false;
}

// Calculate the euclidian's distance between two points
float distance(float x1, float y1, float x2, float y2) {
  return sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
}

// Deal with window size
void minimumWindow(int mWidth, int mHeight) {
  if (width < mWidth) {
    surface.setSize(mWidth, height);
  }
  if (height < mHeight) {
    surface.setSize(width, mHeight);
  }
}
