void setText(float size) { // Sets the Text. No return, takes in a parameter for the size of the text.
  textFont(mainFont); // Sets the font to mainFont.
  textAlign(CENTER, CENTER); // Sets alignment to CENTER, CENTER.
  textSize(size); // A takes the size parameter provided a sets that as the text size.
}

void drawBackground_sky() { // Draws the background of the game. Includes sky, mountains, and buildings.
  noStroke();
  background(#90E0EF); // Light blue for sky.
  fill(#48CAE4, 100); // A translucent mid-tone blue for the mountains.
  //Below are the multiple triangles drawn for the mountinous background.
  //Position of triangle is as such, (x position (left, mid, right), layer (back, mid, fore)).
  triangle(0, height/4, 0, height, width*0.75, height); //Left back tri.
  triangle(width, height/2, width, height, width/2, height); // Right back tri.
  fill(#00B4D8, 100); // Slightly darker than previous colour.
  triangle(width/3, height, width*0.75, height/3, width*0.9, height); // Middle mid tri.
  triangle(0, height, 0.1*width, 0.7*height, width/2, height); // Left mid tri.
  triangle(width, 0.6*height, width, height, 0.8*width, height);// Right mid tri.
  fill(#0096C7, 120); // Slightly darker than previous colour.
  triangle(width, 0.8*height, 0.2*width, height, width, height); // Right fore tri
  triangle(0, 0.9*height, 0, height, width, height); // left fore tri

  fill(#0077B6, 200); // A darker blue (than the sky). For the buildings.
  beginShape(); // Uses beginShape(), vertex(), and endShape() to create skyline.
  stroke(0); // Black outline.
  strokeWeight(2);
  vertex(0, 0.6*height);
  vertex(0.1*width, 0.6*height);
  vertex(0.1*width, height/2);
  vertex(0.15*width, height/2);
  vertex(0.15*width, height*0.7);
  vertex(0.35*width, height*0.7);
  vertex(0.35*width, height*0.4);
  vertex(0.4*width, height*0.4);
  vertex(0.4*width, height*0.5);
  vertex(0.5*width, height*0.5);
  vertex(0.5*width, height*0.65);
  vertex(0.55*width, height*0.65);
  vertex(0.55*width, height*0.7);
  vertex(0.70*width, height*0.7);
  vertex(0.70*width, height*0.45);
  vertex(0.75*width, height*0.45);
  vertex(0.75*width, height*0.5);
  vertex(0.85*width, height*0.5);
  vertex(0.9*width, height*0.5);
  vertex(0.9*width, height*0.6);
  vertex(width, height*0.6);
  vertex(width, height);
  vertex(0, height);
  endShape();// End of shape. 
  fill(#023E8A, 222); // Very dark blue.
  rectMode(CENTER); // Darkest buildings in foreground. From left to right.
  rect(0.23*width, 0.8*height, width*0.1, 0.4*height); // On the left.
  rect(0.3*width, 0.875*height, width*0.07, 0.25*height);
  rect(0.4*width, 0.85*height, width*0.07, 0.3*height);
  rect(0.625*width, 0.8*height, width*0.1, 0.4*height);
  rect(0.75*width, 0.85*height, width*0.07, 0.3*height);
  rect(0.97*width, 0.85*height, width*0.07, 0.3*height);// On the right.
}

void displayScore(PVector score_pos) {// For displaying the score, takes in a PVector for the position of the scoreborad. No return.
  fill(0, 100); // Translucent black.
  rectMode(CENTER);
  rect(score_pos.x, score_pos.y, 200, 60); // Draws a rectangle at score_pos.
  setText(30);
  fill(230); // Very light gray, almost white.
  text("Score : $" + score, score_pos.x, score_pos.y); // Writes the score on the scoreboard.
}

void startNewGame() { // For starting a new game. Reintitializes some aspects to restart the game. No return, no parameters.
  if (start_new_game == true) { // If start_new_game is true, meaning the player just returned to home screen...
  
    player_pos = new PVector(width/2, height/2); // Reset the player position as in the centre of the sreen.
    p = new Player (player_pos, player_size); // Resets the players Player object.
    
    button_pos_home = new PVector(725, 400); // Sets the position of the home button.
    button_pos_play = new PVector(475, 400); // Sets the position of the play button.
    button_pos_pause = new PVector(1160, 35); // Sets the position of the pause button.
    play = new Button (button_pos_play, buttonSizeBig, 1); // Initializes the play button.
    home = new Button(button_pos_home, buttonSizeBig, 2); // Initializes the home button.
    pause = new Button(button_pos_pause, buttonSizeSmall, 0); // Initializes the pause button.
    
    powerUp = new Money(0);// Initializes the mystery / power up bill.
    powerUp_1 = new PowerUpIcon(money_size); // Initializes the left power up icon.
    powerUp_2 = new PowerUpIcon(2.5*money_size); // Initializes the middle power up icon.
    powerUp_3 = new PowerUpIcon(4*money_size); // Initializes the right power up icon.
    powerUp_counter =0; // Sets the power up counter to 0.
    powerUp_jump = false; // Initially disables the ability for the player to fly. Disables rockets.
    
    score = 0; // Sets the score to 0.
    
    frameCounter = 3600; // Sets the frameCounter to 3600, basically resets the timer to 60 seconds.
    
    for (int i = 0; i<bill_1.length; i++) { // For loops to initialize array of Money objects.
      bill_1[i] = new Money(1); // $1 bills.
    }

    for (int i =0; i<bill_5.length; i++) {
      bill_5[i] = new Money(5); // $5 bills.
    }

    for (int i =0; i<bill_10.length; i++) {
      bill_10[i] = new Money(10); // $10 bills.
    }

    for (int i =0; i<bill_20.length; i++) {
      bill_20[i] = new Money(20); // $20 bills.
    }

    for (int i =0; i<bill_debt.length; i++) {
      bill_debt[i] = new Money(debt); // Debt forms.
    }
  }
}

void setScene_Home() { // Sets the title screen. All code below would be put in draw function. Is all put in this function to reduce clutter in draw function. No returns, no parameters.
  if (sceneCounter == 0) { // For when the title / home screen is suppose to appear.
    for (int i=0; i<title_1.length; i++) { // For loops to iterate and call the methods of each Money object.
      title_1[i].update(); // Methods for the $1 bills.
      title_1[i].display();
      title_1[i].fall();
      title_1[i].collision();
      title_1[i].respawn();
    }
    for (int i=0; i<title_5.length; i++) { // Methods for the $5 bills.
      title_5[i].display();
      title_5[i].update();
      title_5[i].fall();
      title_5[i].collision();
      title_5[i].respawn();
    }
    for (int i=0; i<title_10.length; i++) { // Methods for the $10 bills.
      title_10[i].display();
      title_10[i].update();
      title_10[i].fall();
      title_10[i].collision();
      title_10[i].respawn();
    }
    for (int i=0; i<title_20.length; i++) { // Methods for the $20 bills.
      title_20[i].display();
      title_20[i].update();
      title_20[i].fall();
      title_20[i].collision();
      title_20[i].respawn();
    }
    for (int i=0; i<title_debt.length; i++) { // Methods for the debt forms.
      title_debt[i].display();
      title_debt[i].update();
      title_debt[i].fall();
      title_debt[i].collision();
      title_debt[i].respawn();
    }   
    logo.display(); // Display the logo.
    fill(0, 120); // Translucent black.
    noStroke();
    rect(width/5, 400, 450, 175); // Black box for message about how to play.
    rect(width/5, 575, 450, 150); // Black box for message about mystery bills.
    rect(width*0.8, 400, 450, 175); // Black box for message about bill and debt values.
    rect(width*0.8, 575, 450, 150); // Black box for message about highscore.
    setText(100);
    fill(#f18701); // Darker orange colour for title.
    text("Rainy Riches", width/2, 100); // The title.
    textSize(50); // Smaller text size for subtitle.
    text("Get as much as you can in 60 seconds!", width/2, 200); // Subtitle.
    fill(#ffc300); // Lighter orange for other text.
    textSize(30); // Smaller size.
    text("Use left and right \narrow keys to change \nbox direction, up to fly\n with rocket, down to drop.", width/5, 400); // Text about how to play. 
    text("Collect 3 mystery bills \n to unlock the rocket.", width/5, 575); // Text about mystery bills.
    text("Collect bills to increase\nscore! Avoid the debt that \ndecreases score!", width*0.8, 400); // Text about bill and debt value.
    text("Highscore: "+ highscore, width*0.8, 575); // Text showing highscore.
    start.display(); // Displays start button.
    start.hover(); // Calls the start button's hover method.
  }
}

void setScene_inGame() {// Sets the in game screen. All code below would be put in draw function. Is all put in this function to reduce clutter in draw function. No returns, no parameters. 
  if (sceneCounter == 1) { // For when the game is running.
    setText(200);
    fill(255, 150); // Translucent white for the timer in the background.
    text(second_remain, width/2, height/2); // Text for the timer.

    for (int i=0; i<bill_1.length; i++) {// For loops to iterate through each object of the array and call its methods.
      bill_1[i].update(); // Methods for the $1 bills.
      bill_1[i].display();
      bill_1[i].fall();
      bill_1[i].collision();
      bill_1[i].respawn();
    }
    for (int i=0; i<bill_5.length; i++) {
      bill_5[i].update();// Methods for the $5 bills.
      bill_5[i].display();
      bill_5[i].fall();
      bill_5[i].collision();
      bill_5[i].respawn();
    }
    for (int i=0; i<bill_10.length; i++) {
      bill_10[i].update();// Methods for the $10 bills.
      bill_10[i].display();
      bill_10[i].fall();
      bill_10[i].collision();
      bill_10[i].respawn();
    }
    for (int i=0; i<bill_20.length; i++) {
      bill_20[i].update();// Methods for the $20 bills.
      bill_20[i].display();
      bill_20[i].fall();
      bill_20[i].collision();
      bill_20[i].respawn();
    }
    for (int i=0; i<bill_debt.length; i++) {
      bill_debt[i].update();// Methods for the debt forms.
      bill_debt[i].display();
      bill_debt[i].fall();
      bill_debt[i].collision();
      bill_debt[i].respawn();
    }

    if (powerUp_jump == false) { // If the power up has not been enabled...
      powerUp.update(); // Call the methods. The power up / mystery bills no longer fall after the player has collected 3.
      powerUp.display();
      powerUp.fall();
      powerUp.collision();
      powerUp.respawn();
    }

    p.ed(); // To check if the player is at the edge of the display window.
    p.display(); // To display the player.
    p.update(); // To update the player's position.
    
    if (onGround == false) { //If the player is in the air...
      p.gravity(); // Apply the force of graviy to it.
    }
    
    if (powerUp_counter >= 3) { // When the player collected 3 mystery bills...
      powerUp_jump = true; // Sets this boolean to true, giving the playwre the rocket boosters.
    }
    
    displayScore(scoreBoard); // Displays the scoreboard at the top left hand part of the screen.
    pause.display(); // Displays the pause button at the top right of the screen. 
    pause.hover(); // Calls the hover and click methods for the pause button.
    powerUp_1.displayEmpty(); // Displays the empty power up icon at the left.
    powerUp_2.displayEmpty(); // Displays the empty power up icon in the middle.
    powerUp_3.displayEmpty(); // Displays the empty power up icon at the right.

    if (powerUp_counter >= 1) { // Checks how many bills has been collected and displays each one.
      if (powerUp_counter >=2) {
        if (powerUp_counter >= 3) {
          powerUp_3.displayFull(); // Right icon.
        }
        powerUp_2.displayFull(); // Middle icon.
      }
      powerUp_1.displayFull(); // Left icon.
    }

    start_timer = true; // Starts the timer.

    if (gamePlay == false) { // If the game is paused...
      rectMode(CENTER);
      fill(0, 150); // Translucent black.
      noStroke();
      rect(width/2, height/2, width, height); // Draws a translucent black rectangle over the whole screen.
      setText(80); // Sets the text font, size, and alignment.
      fill(255); // White text fill.
      text("GAME PAUSED", width/2, height/3); // Writes GAME PAUSED in the middle of the screen.
      play.display(); // Displays the resume button.
      play.hover(); // Calls the hover and click methods for the resume button.
      home.display(); // Displays the home button.
      home.hover(); // Calls the hover and click methods for the home button.
    }
  }
}
void timerOut() { // Is responsible for what happens after the timer has run out. No return, no parameters.
  if (second_remain <= 0) { // When the timer runs out...
    sceneCounter = 2; // Sets it to the final/win screen.
    if (score > highscore) { // If if the final score is higher than the previously recorded highscore...
      highscore = score; // Sets it as the new highscore.
    }
  }
}

void setScene_final() { // Sets the final screen with final score and highscore. All code below would be put in draw function but is all put in this function to reduce clutter in draw function. No returns, no parameters. 
  if (sceneCounter == 2) { // On the final / win screen.
    rectMode(CENTER);
    fill(0, 160); // Translucent black.
    rect(width/2, height/2, width, height); // Draw a translucent black rectangle over the entire screen.
    setText(80);
    fill(255); // White text fill.
    text("YOU'VE COLLECTED:", width/2, height/4); // Writes how much the player has collected.
    text("$"+score, width/2, height*0.38); 
    textSize(40);
    text("HIGHSCORE: $"+highscore, width/2, height/2); // Writes the highscore after the game.
    home_final.display(); // Display button to go back to home screen.
    home_final.hover(); // Calls the hover and click method for the home button.
  }
}


void timer() { // For running the timer.
  second_remain = frameCounter/60; // As fps is 60, this gives second_remain the number of seconds remaining for the game.
  if (start_timer == true && gamePlay == true && sceneCounter == 1) { // If the boolean start timer is true, the game is not paused, and the game play screen is displayed...
    frameCounter--; // Subtracts 1 for each frame that passes.
  }
}

void movement_keys() { // For containing all the code for the keypressed function. Reduce clutter. No return, no parameters.
  if (keyCode == UP && canFly == true && powerUp_jump == true) { //Up arrow key boost the player up (allows them to fly) when tapped. Only works when within screen limits and has rockets enabled.
    p.fly();
  } else if (keyCode == DOWN && onGround == false) {// Down arrow key drops the player down when in the air and when within screen limits.
    p.drop();
  } else if (keyCode == RIGHT) {// Right arrow changes the direction of the moving box. Does not change speed.
    p.right();
  } else if (keyCode == LEFT) {// Left arrow changes the direction of the moving box. Does not change speed.
    p.left();
  }
}
