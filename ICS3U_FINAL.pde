// Final Project : Rainy Riches by Michelle Chen
// Game Objective : Collect as many falling bills as you can within the give time limit of 60 seconds.
// NOTE: In the comments the follwing mean the same:
// mystery bills and power up bills
// Home screen and title screen
// Final screen and win screen



//Declaring
//Text
PFont mainFont; // Main font used throughout the game.

//PVectors
PVector player_pos; //Position of the player (cardboard box).
PVector logo_pos; // Position of the cardboard box logo on the title screen.
PVector grav; // Acceleration for the force of gravity applied to the player.
PVector grav_money; // Acceleration for the force of gravity applied to most bills and debt.
PVector grav_powerUp; // Acceleration for the force of gravity applied to the mystery bills (power up bills).
PVector fly; // Acceleration for the player to fly.
PVector left; // Acceleration for the player to move left.
PVector right; // Acceleration for the player to move right.
PVector drop; // Acceleration for the player to drop down when in the air.
PVector scoreBoard; // Position of the score board while game is running.
PVector button_pos_play; // Position of the play/resume button when game is paused.
PVector button_pos_home; // Position of the home button when the game is paused.
PVector button_pos_pause; // Position of the pause button when the game is running.
PVector button_pos_start; // Position of the start button on the title screen.
PVector button_pos_home_final; // Position of the home button on the winning/score screen.

//Size variables
int buttonSizeBig = 100; // Size for larger buttons.
int buttonSizeSmall = 50; // Size for smaller buttons.
float player_size = 50; // Size of the player.
float logo_size = 200; // Size of the logo.
float money_size = 40; // Size of each banknote, the length. Width is half the length.

//Booleans
boolean onGround = false; // To check if player is on ground, if so will prevent player from dropping anymore when rockets are enabled.
boolean canFly = true; // To check if player is beneath the top edge of window, prevents player from flying out of the display window when the rockets are enabled.
boolean powerUp_jump = false; // To check if the player has the rockects enabled.
boolean gamePlay = true; // To check if the game is being played, is set to false when game is paused.
boolean start_new_game = true; // Used to reset the game when a new game is started. Is false when the game is running, is set to true when returned to the home screen, then aspects are reinitialized. 
boolean start_timer = false; // Used to determine when the timer runs.
boolean move_right = false; // Used for determining speeds when the box moves left or right.

//Timer Variables
int frameCounter = 3600; //Keeps track of how many frames are remaining. At 60fps, there are 3600 total frames run during 60 seconds.
int second_remain = 0; // Keeps track of how mnay seconds remain for each game.

//high score
int highscore = 0; // For the highest score. Resets each time the program is closed.

// Bill Variables
// How many of each type of bill there are in the game.
int money_count_1 = 15;
int money_count_5 = 10;
int money_count_10 = 10;
int money_count_20 = 10;
int money_count_debt = 5;
int bill_text_size = 20; // Size of text on bill.

int debt = -50;// How much the debt form is worth.
int score = 0; // The score, value of the sum of all collected bills.
int powerUp_counter = 0; // Keeps track of how many mystery/power up bills the player has collected.
int sceneCounter = 0; // Used to switch between scenes. 0 is title screen (home), 1 is the game, and 2 is the final/scoring screen.

//Classes
Player p; // The player.
Player logo; // The logo.

PowerUpIcon powerUp_1; // Each power up icon slot at top left. Left one.
PowerUpIcon powerUp_2;// Middle one.
PowerUpIcon powerUp_3;// Right one.

//Object Arrays
//Banknotes on the title screen.
Money [] title_1 = new Money[money_count_1];// For the $1 bills.
Money [] title_5 = new Money[money_count_5];// For the $5 bills.
Money [] title_10 = new Money[money_count_10];// For the $10 bills.
Money [] title_20 = new Money[money_count_20];// For the $20 bills.
Money [] title_debt = new Money[money_count_debt];// For the debts.

//Banknotes (bills) in game.
Money [] bill_1 = new Money[money_count_1];// For the $1 bills.
Money [] bill_5 = new Money[money_count_5];// For the $5 bills.
Money [] bill_10 = new Money[money_count_10];// For the $10 bills.
Money [] bill_20 = new Money[money_count_20];// For the $20 bills.
Money [] bill_debt = new Money[money_count_debt];// For the debts.

Money powerUp; //For the mystery/power up bill. (There is only one as it will reappear or respawn once it either is collected by the player or hits the ground.)

//Button Objects
Button play; // Resume button when the game is paused.
Button home; // Home button when the game is paused.
Button pause; // Pause button when the game is running.
Button start; // The start button on title screen.
Button home_final; // The home button on final/scoring screen.

void setup() {
  size(1200, 800); // Sets size of game window, 1200px wide, 800px tall.

  //Initializing
  //Positions
  logo_pos = new PVector(width/2, height-150);// Position of logo on title screen.
  button_pos_start = new PVector (width/2, height/2); // Position of start button on title screen.
  button_pos_home_final = new PVector (width/2, height*0.75); // Position of home button on final/scoring screen.
  scoreBoard = new PVector(105, 35); // Position of the scoreboard in game.
  
  //Accelerations
  grav = new PVector(0, 0.2); // Gravitational force applied to player. 
  grav_money = new PVector (0, 0.005); // Gravitational force applied to banknotes.
  grav_powerUp = new PVector (0, 0.015); // Gravitational force applied to mystery/power up bills.
  fly = new PVector (0, -10); // For "flying" or boosting up into the air.
  left = new PVector (-5, 0); // For moving left.
  right = new PVector (5, 0); // For moving right.
  drop = new PVector (0, 10); // For dropping down.

  //Player Objects
  logo = new Player(logo_pos, logo_size);// Logo on title screen.

  //Button Objects
  start = new Button(button_pos_start, buttonSizeBig, 1);// Start button on title screen.
  home_final = new Button(button_pos_home_final, buttonSizeBig, 2);// Home button on the final/scoring screen.
  
  //Font
  mainFont = loadFont("Georgia-Bold-48.vlw");//Font used in the game.

  //Arrays of Objects
  //Banknotes on the title screen. Uses for loops to iterate through each index of the arrays.
  for (int i = 0; i<title_1.length; i++) {// $1 bills.
    title_1[i] = new Money(1);
  }
  for (int i =0; i<title_5.length; i++) {// $5 bills.
    title_5[i] = new Money(5);
  }
  for (int i =0; i<title_10.length; i++) {// $10 bills.
    title_10[i] = new Money(10);
  }
  for (int i =0; i<title_20.length; i++) {// $20 bills.
    title_20[i] = new Money(20);
  }
  for (int i=0; i<title_debt.length; i++) {// Debt bills.
    title_debt[i] = new Money(debt);
  }
}

void draw() {
  drawBackground_sky();// Draws the background (sky, mountains, buildings, etc).
  timer(); // Runs the timer function.
  startNewGame();// Runs the function that checks for when a new game is started and reinitializes certain objects and position.
  setScene_Home(); // Draws the title (home) screen.
  setScene_inGame(); // Draws the game screen.
  timerOut(); // Responsible for what happens after the timer runs out (change to final screen, reset timer, etc).
  setScene_final(); // Draws the final screen.
}

void keyPressed() {
  movement_keys(); // For the key movements. 
}
