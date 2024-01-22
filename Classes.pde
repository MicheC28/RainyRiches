//Classes Tab

class Player { //Class for the Player object, cardboard box on wheels. Used for player and logo.
  PVector position; //Position of player.
  PVector velocity; // Velocity.
  PVector acceleration; // Acceleration.
  float player_size; // Size of box.
  float wheel_size; // Size of wheels.

  Player(PVector position, float size) {// Takes in a PVector for the initial position of the player and a size.
    this.position = position; //Assigned provided value to global counterpart (global in class, not entire program).
    this.player_size = size;
    velocity = new PVector(0, 0); //Initializes velocity.
    acceleration = new PVector(0, 0); //Initializes acceleration.
    wheel_size = player_size*0.3; // Gives wheel_size 30% the value of player_size.
  }

  void display() {// To draw/display the box. No return value, no parameters.

    setText(player_size*0.6);// Sets the text size as 3/5 size of Player object and the font and alignment.
    rectMode(CENTER);

    fill(#cd9777); // Mid-tone brown for the fill of the box.
    stroke(#8a5a44); // Darker brown for the outline.
    strokeWeight(3); 
    rect(position.x, position.y, player_size, player_size); // Draws the main body of the box at PVector position with player_size as the width and height.
    strokeCap(PROJECT); // To make the flaps of the lid.
    strokeWeight(6); // Thicker for the lid flaps.
    line(position.x-player_size/2, position.y-player_size/2, position.x-player_size/1.5, position.y-player_size/1.5);// Draws left box flap.
    line(position.x+player_size/2, position.y-player_size/2, position.x+player_size/1.5, position.y-player_size/1.5); // Draws right box flap.
    fill(10, 160, 31); //Green colour for the $ on the box. 
    text("$", position.x, position.y); // Draws the $ in the middle of the box.
    noStroke();
    if (powerUp_jump == false) { // Draws the wheels, only drawn when the player does not have the rockets enabled.
      fill(50); // Darker gray.
      ellipse(position.x-player_size/2, position.y+player_size/2+wheel_size/2, wheel_size, wheel_size); // Draws the left wheel.
      ellipse(position.x+player_size/2, position.y+player_size/2+wheel_size/2, wheel_size, wheel_size); // Draws the right wheel.
      fill(120); // Lighter gray.
      ellipse(position.x-player_size/2, position.y+player_size/2+wheel_size/2, wheel_size/2, wheel_size/2); // Draws the left wheel centre.
      ellipse(position.x+player_size/2, position.y+player_size/2+wheel_size/2, wheel_size/2, wheel_size/2); // Draws the right wheel centre.
    } else {//When the rockets are enabled, draw them.
      //For the fire.
      fill(#ffa200); // Orange for outer part.
      noStroke(); 
      triangle(position.x-player_size, position.y+player_size/2, position.x-player_size/2, position.y+player_size/2, position.x-player_size*0.75, position.y+player_size*1.5); // Draws left orangle flame.
      triangle(position.x+player_size, position.y+player_size/2, position.x+player_size/2, position.y+player_size/2, position.x+player_size*0.75, position.y+player_size*1.5); // Draws right orangle flame.
      fill(#ffdd00); // Yellow, for inner part.
      triangle(position.x-player_size, position.y+player_size/2, position.x-player_size/2, position.y+player_size/2, position.x-player_size*0.75, position.y+player_size); // Draws the left yellow flame.
      triangle(position.x+player_size, position.y+player_size/2, position.x+player_size/2, position.y+player_size/2, position.x+player_size*0.75, position.y+player_size); // Draws the right yellow flame.

      //For the metal body of the rockets.
      fill(#8d99ae); // Gray with a little blue.
      strokeWeight(2);
      stroke(80); // Darker gray for outline.
      rectMode(CENTER);
      rect(position.x-player_size*0.75, position.y, player_size/2, player_size, 20); // Draws the left rocket booster body.
      rect(position.x+player_size*0.75, position.y, player_size/2, player_size, 20); // Draws the right rocket booster body.
      // Draws the points on the left rocket booster body.
      point(position.x+player_size*0.6, position.y);
      point(position.x+player_size*0.75, position.y);
      point(position.x+player_size*0.9, position.y);
      point(position.x+player_size*0.75, position.y-player_size/3);
      point(position.x+player_size*0.75, position.y+player_size/3);
      // Draws the points on the right rocket booster body.
      point(position.x-player_size*0.6, position.y);
      point(position.x-player_size*0.75, position.y);
      point(position.x-player_size*0.9, position.y);
      point(position.x-player_size*0.75, position.y-player_size/3);
      point(position.x-player_size*0.75, position.y+player_size/3);
    }
  }

  void update() {// To update position of the player. No return, no parameters.
    if (gamePlay == true) { // When game is played (not paused)...
      position.add(velocity); // Add velocity to position.
      velocity.add(acceleration); // Add acceleration to velocity.
      velocity.limit(10); // Limits velocity so player doesn't move super fast. 
      acceleration.limit(3); // Limits the acceleration to 3, so player does not move too fast.
      acceleration.mult(0); //Resets the acceleration, ready for next update.
    }
  }

  void gravity() {// For applying a gravitational force. No return, no parameters.
    acceleration.add(grav); // Adds PVector grav (for player) to acceleration.
  }

  void fly() {// For flying up or boosting up with rockets. No return, no parameters.
    acceleration.add(fly); // Adds PVector fly to acceleration.
  }

  void drop() {// For dropping down whering rockets. No return, no parameters.
    acceleration.add(drop); // Adds PVector drop to acceleration.
  }

  void right() {// For changing the direction of the rolling box to rolling to the right and the speed. No return, no parameters.
    if (move_right == false) {// If box was previously moving to the left...
      move_right = true; // Changes boolean to true.
      velocity.mult(0); // Sets velocity to 0, so the speed starts at a slower pace as box is moving in new direction.
    }
    acceleration.add(right); // Adds PVector right to acceleration. Acceleration now moves the box to the right. Increases speed each time right is added.
  }

  void left() {// For changing the direction fo the rolling box to rolling to the left and the speed. No return, no parameters.
    if (move_right == true) {// If box was previously moving to the right...
      move_right = false; // Change boolean to false.
      velocity.mult(0); // Set velocity to 0, so the speed starts at a slower pace as box is moving in new direction.
    }
    acceleration.add(left); // Adds PVector left to acceleration. Acceleration now moves the box to the left. Increases speed each time left is added.
  }

  void ed() {// To detect if the box has reached the edges of the display window. No return, no parameters.
    if (position.y>=height-player_size/2-wheel_size) { // Once the player hits the bottom edge...
      position.y = height-player_size/2-wheel_size; // Draws the player on the ground.
      onGround = true; // Set onGround to true. This boolean prevents the player from dropping through the ground.
    } else {
      onGround = false; // Otherwise, set it to false. Meaning the player can drop.
    }
    if (position.y<=player_size*0.75) {// If the box has reached the top edge of the display window.
      canFly = false; // Set canFly to false, this prevents the player from flying/jumping out of the display window.
      position.y = player_size*0.75; // Display the player at the top of the screen.
    } else {
      canFly = true;// Otherwise, set it to true.
    }
    if (position.x <=player_size/1.5) {// If the player reaches the left edge of the screen...
      position.x = player_size/1.5; // Draw the player at the left edge. Prevents them from rolling out of the display window.
    }
    if (position.x >= width-player_size/1.5) { // If the player reaches the right edge of the screen...
      position.x=width-player_size/1.5; // Draw the player at the right edge. Prevents them from rolling out of the display window.
    }
  }
}


class Money { // Class for the Money object, draws banknotes. Used for drawing banknotes and debt forms.
  PVector pos; // PVector for the position of each Money object.
  PVector velo; // PVector for the velocity.
  PVector acc; // PVector for the acceleration.
  int type; // For differentiating between each type of bill.
  color fill; // For background colour of the bill.
  color outlineText; // For outline and text colour.
  String bill_value; // What each bill says.
  int textSize; // Size of text on bill.
  boolean collision = false; // For detecting if there has been a collision between the Money object and the player.

  Money(int type) {// Takes an integer. Either 1, 5, 10, 20, 0(mystery bill), or debt (a variable containing -50).
    this.type = type; // Assign the type integer given to it's global counterpart (global for the class).
    pos = new PVector(random(money_size, width-money_size), random(-height*2, -50)); // Initializes position of each Money object. Position is randomly generated. Y Coordinates range from -1200 to -50 to keep a consistant number of bills on screen at once.
    velo = new PVector(0, 0); // Initializes velocity.
    acc = new PVector(0, 0); // Initializes acceleration.

    if (type == 1) { // If type is 1 (for $1 bills).
      fill = #ccd5ae; // Pale green background.
      outlineText = #606c38; // Darker green for outline and text colour.
      bill_value = "$1"; // Bill says $1.
    } else if ( type == 5) { // If it is a $5 bill.
      fill = #48cae4; // Blue colour for the bill background.
      outlineText = #023e8a; // Dark blue for the outline and text colour.
      bill_value = "$5"; // Bill says $5.
    } else if (type == 10) { // If it is a $10 bill.
      fill = #e0aaff; // Light purple colour background.
      outlineText = #5a189a; // Dark purple colour for outline and text colour.
      bill_value = "$10"; // Bill says $10.
    } else if ( type == 20) { // If it is a $20 bill.
      fill = #70e000; // Vibrant green background.
      outlineText = #004b23; // Dark vibrant green outline and text colour.
      bill_value = "$20"; // Bill says $20.
    } else if (type == debt) { // If it is a debt form.
      fill = #fae0e4; // Light pink background.
      outlineText = #dd1c1a; // Red outline and text colour.
      bill_value = "DEBT"; // Says DEBT on the form.
    } else if (type == 0) { // If it is a mystery / power up bill.
      fill = #ffd000; // Light orange background.
      outlineText = #ff7b00; // Darker orange for the outline and text colour.
      bill_value = "???"; // Bill says ???.
    }
  }

  void display() { // To display each Money object. No return, no parameters.
    rectMode(CENTER);
    strokeWeight(2);

    if (!collision) { // When the bill is in mid air/ has not collided with the player or the ground.
      fill(fill); // Use the colour in variable fill for the fill of the rect.
      stroke(outlineText); // Use the outlineText colour for outline.
      rect(pos.x, pos.y, money_size, money_size/2); // Draws the bill.
      fill(outlineText); // Use the outlineText colour for text fill.
      if (type == debt) { // If it's the debt form, make text size smaller.
        textSize = 12; // Set text size to 12.
      } else { // If, not..
        textSize = bill_text_size; // Set text size to bill_text_size.
      }
      setText(textSize); // Sets the font, alignment, and size of the text on the bill.
      text(bill_value, pos.x, pos.y); // Writes the value of the bill on the bill.
    }
  }

  void fall() { // For the calculations to make the Money object to fall. No return, no parameters.
    if (type == 0) { // If the bill is a mystery/power up bill
      acc.add(grav_powerUp); // It will fall faster. Adds grav_powerUp to acceleration.
    }
    acc.add(grav_money); // Normal bills fall slower than the mystery bill. Adds PVector grav_money to the acceleration.
  }

  void update() { // For updating the position of the Money object. No return, no parameters.
    if (gamePlay==true || sceneCounter == 0) { // When gamePlay is true, meaning the game is not paused.
      pos.add(velo); // Add velocity to position.
      velo.add(acc); // Add acceleration to velocity.
      acc.limit(3); // Litmit the acceleration to 3 so the bills don't move too fast.
      acc.mult(0); // Resets acceleration, ready for next update.
    }
  }

  void respawn() { // To redraw the Money object back at the top of the screen once it collides with the player for the ground. No return, no parameters.
    if (collision == true || pos.y > width+money_size) { // If the object collides with the player or the ground...
      pos = new PVector(random(width), random(-height, -30)); // Set its position as a random position above the top edge of the display window.
      velo.mult(0); // Reset the velocity, so the bill doesn't fall with previous velocity.
      collision = false; // Set collision to false. Displays the bill now.
    }
  }

  void collision() { // To check if the Money object has collided with the player. No return, no parameters.
    if (pos.x < player_pos.x+player_size/2 && pos.x > player_pos.x-player_size/2) { // If the Money object collides with the player. (This checks the x coordinates).
      if (pos.y > player_pos.y-player_size/2 && pos.y < player_pos.y+player_size/2 && collision == false) { // This checks the Y coordinate and if collision as not yet been detected.
        collision = true; // Set collision boolean to true.
        if (sceneCounter == 1) { // If it is in game screen, add to the scores. This is to prevent the score changing on the title screen.
          if (type == 0) { // If it was a mystery / power up bill, the power up counter increases by 1.
            powerUp_counter +=1;
          } else {
            score += type; // The value of the bill, which is the same as it type, is added to the total score.
          }
        }
      }
    }
  }
}

class Button { // Class for the Buttons.
  PVector pos; // PVector of the button position.
  color background; // The background colour of the button.
  color outline; // The outline colour of the button.
  color designFill; // The colour of the icon on the button.
  float size; // The size of the button.
  int type; // The type of the button. 0 is pause button, 1 is play button, 2 is home button.

  Button(PVector pos, float size, int type) { // Takes in a PVector for the position, a size, and a type.
    this.pos = new PVector(pos.x, pos.y); // Assigns the given values to their global counterparts (global in the class).
    this.size = size;
    this.type = type;
    background = #ffdda1; // Button background is a light orange colour.
    designFill = #ff9c00; // Design is a mid-tone orange colour.
    outline = #e77728; // Outline is a darker orange colour.
  }

  void display() { // To display the buttons. No return, no parameters.
    rectMode(CENTER);
    fill(background); // Sets background as the light orange colour.
    strokeWeight(4);
    stroke(outline); // Sets stroke colour to the dark orange colour.
    rect(pos.x, pos.y, size, size); // Draws the square base of the button at the given position.
    fill(designFill); // Uses the mid-tone orangle colour for the colour of the icon on the button.
    if (type == 0) {// For the pause button icon.
      rect(pos.x-size/5, pos.y, size/5, size*0.6); // Two vertical rectangles. Left bar.
      rect(pos.x+size/5, pos.y, size/5, size*0.6); // Right bar.
    } else if (type == 1) {// For the play button icon.
      triangle(pos.x-size/5, pos.y-size*0.3, pos.x-size/5, pos.y+size*0.3, pos.x+size*0.3, pos.y);// Draws the triangle for the play button.
    } else if (type == 2) {// For the home button icon.
      rect(pos.x, pos.y+size/5, size*0.6, size*0.4); // Draw the base of the house icon.
      triangle(pos.x-size*0.3, pos.y, pos.x+size*0.3, pos.y, pos.x, pos.y-size*0.4); // Draws the roof of the house icon.
    }
  }

  void hover() {// For when the mouse hovers over the button or clicks it. No return, no parameters.
    if (mouseX < pos.x+size/2 && mouseX > pos.x-size/2 && mouseY < pos.y+size/2 && mouseY > pos.y-size/2) { // If the mouse is above the button...
      noStroke();
      fill(255, 120); 
      rect(pos.x, pos.y, size, size); // Draws a translucent white square on top of the button to make it appear glowing.
      if (mousePressed == true) { // If the mouse is pressed...
        if (type == 0) {// If it is a pause button,
          gamePlay = false; // Pauses the game.
        } else if (type == 1) { //If it is a play button,
          if (sceneCounter == 0) {// If is on the title screen,
            start_new_game = false; // Starts a new game. 
            sceneCounter = 1; // Sets the scene to the in game scene.
          }
          gamePlay = true; // Sets gamePlay to true, unpauses gamePlay.
        } else if (type == 2) {// If it is a home button.
          start_new_game = true; // Sets start_new_game to true.
          sceneCounter = 0; // Sets the scene to the title screen.
        }
      }
    }
  }
}

class PowerUpIcon { // Class for the power up icons at the top left of the screen when the game is running.
  float x; // The x coordinate of the icon. Used seperate float instead of PVectors as there will be no movement.
  float y; // The y coordinate of the icon.

  PowerUpIcon(float x) { // Takes in an x coordinate.
    this.x = x; // Sets the given x value as the global x (for the class).
    y = 100; // Gives y a value of 100.
  }

  void displayEmpty() { // For displaying the icon as empty.
    fill(100); // Gray.
    noStroke();
    rectMode(CENTER);
    rect(x, y, money_size, money_size/2); // Draw a gray rectangle the same size as a bill at position (x,y).
  }
  void displayFull() { // For displaying the icon as collect or full.
    rectMode(CENTER);
    // Draws the mystery bill at position (x,y).
    fill(#ffd000); // Light orange. 
    stroke(#ff7b00); // Darker orange.
    strokeWeight(2);
    rect(x, y, money_size, money_size/2); // Draws the bill.
    fill(#ff7b00); // Darker orange.
    setText(bill_text_size);
    text("???", x, y); // Draws the ??? text on the bill.
  }
}
