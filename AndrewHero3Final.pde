// import libraries 
import processing.sound.*;



////////////////////////declare vars ///////////////////
// declare selection windows 
SelectionWindow instructionsWindow;
SelectionWindow myNameIsJonasWindow; 
SelectionWindow goBackAWindow;
SelectionWindow mainMenu;
SelectionWindow playAgain;

// declare buttons 
Button b1;
Button b2;
Button b3;

//  My Name Is Jonas 
SoundFile mNIJ;
// Welcome Screen
SoundFile wS; 
// miss note sound 
SoundFile missSound;
// cheering 
SoundFile cheeringSound;
// Even Flow 
SoundFile evenFlowSound;

// declare global vars 
int score;
int state;
int index;
int multiplierScore;

// x's and y's  
int buttonY;
int note1X; 
int note2X;
int note3X; 

// note and button size 
int noteHeight; 
int noteWidth; 

// multiplier display x & y 
int multiplierX;
int multiplierY; 

// bpm of song
// 196 is real bpm but I had to brute force it
int bpm = 225;
float bps = bpm/60;

// seconds between beats
float spb = 1/bps;
// convert from seconds to ms
float mspb = spb*1000;

// declare first timer 
int startTime;
int currentTime;

// arrayList stuff
ArrayList < Note > note1List;
ArrayList < Note > note2List;
ArrayList < Note > note3List;

// animation stuff
Animation welcomeScreenAnimation;
PImage[] welcomeScreenImages  = new PImage[17];

Animation instructionsAnimation;
PImage[] instructionsImages = new PImage [2];

Animation crowdAnimation;
PImage[] crowdImages = new PImage [2];

// images
PImage selectionScreenImage;
PImage finalScoreImage; 
PImage fireBallImage;

// text type face 
PFont oldEnglish;


///////////////////////////// green note ///////////////////////////////////
boolean [] note1Bool = {
 
// intro noise 
false, false, false, false, false, 
  
// green page 1 
false, false, false , true, false, 
false, true, false, false, true,
false, false, false, false, false,
true, false, false, true, false, 
false, true,

// green page 2
false, false, false, false, false, 
false, false, false, false, false,
false, true, false, true, false,
false, false, true, false, false,
true, false, false, true, false, 
false, false, false, false, false, 
false, false, false, false,
false, true,false, true,

// new  green page 3 
false, false, false, false, false, 
false, false, false, false, true, 
false, true, false, false, false, 
false, false, false, false, false, 
false, true, false, true, false, 
false, false, false, false, false, 

// new green page 4 
false, false, false, true, false, 
true, false, false, false, false, 
false, false, false, false, false, 
true, false, true, false, false, 
false, false, false, false, 

// new green page 5 
false, false, false, false, false, 
false, true, true, true, true, 
false, true, false, false, false, 
false, false, false, true, true, 
true, true, false, true, false, 
false, false, true, false, false, 
true, false, 

// new green page 6
false, true, false, false, false, 
false, false, true, false, false, 
true, false, false, true, false, 
false, false, false, false, false, 
false, false, false, false, false, 
true, false, true, false, false, 
false, true, false, 

// new green page 7 
false, true, false, false, true, 
false, false, false, false, false, 
false, false, false, false, false, 
false, true, false, true, false, 
false, false, false, false, false, 
false, false, false, true, false, 
true, false, false, 

// new green page 8 
false, false, false, false, false, 
false, false, true, false, true, 
false, false, false, false, false, 
false, false, false, false, true, 
false, true, false, false, false, 
false, false, false, false, false, 
false, true, false, 
true, false, false, false, 

// new green page 9 
true, true, false, true, false, 
false, false, false, false, false, 
true, true, true, true, false, 
true, false, false, false, false, 
false, false, true, true, true, 
true, false, true, true, false, 
true, false, false, 

// new green page 10 
false, false, false, false, false, 
false, false, false, false, false, 
true, false, true, true, false, 
true, true, false, true, true, 

// new green page 11 
true, false, false, false, false, 
false, false, false, false, false, 
true, true, true, true, true, 
true, true, true, true, true, 
true, true, true, true, true, 
true, true, true, true, true, 

// green page 12 
true, false, true, false, false, 
false, true, false, false, true, 
false, false, true, false, true, 
false, false, false, true, false, 
false, true, false, false, true, 
false, true, false, false, false, 
true, false, false, 

// green page 13 
true, false, false, true, false, 
true, false, false, false, true, 
false, false, true, false, false, 
true, false, true, false, false, 
false, true, false, false, true, 
false, false, true, false, true, 
false, false, false, 

// SECOND green page 14 
true, false, false, true, false, 
true, false, false, false, true, 
false, false, true, false, false, 
true, false, true, false, false, 
false, true, false,  
false, false, true, false, true, 
false, false, false, 

// green page 15 
true, false, false, true, false, 
false, true, true, true, false, 
false, false, false, false, false, 
false, false, false, true, true, 
true, false, false, false,
false, false, false, false, false, 
false, false, false, false, false, 
false, false, 
false, false, false, true, false, 
false, false, true, 

// green page 16 
false, false, true, false, false, 
true, false, false, false, false, 
false, true, false, false, true,
false, false, true, false, false, 
false, 

// hold 
true, true, true, true, true,
true, true, true, true, true, 
true, true, true, true, true,

// end of song 
false, false, false, false, false, 
false, false, false, false, false, 
};

////////////////////////////// red note //////////////////////////////////////
boolean [] note2Bool = {
  // intro noise 
  false, false, false, false, false, 
  
  // red page 1 
true, false, true, false, false,
false, false, false, true, false,
false, false, true, false, true, 
false, false, false, false, false,
true, false,

// red page 2  
false, false, false, false, false,
true, false, true, false, false, 
false, false, false, false, true,
false, true, false, false, false, false, 
false, true, false, false, false, 
false, false, false, true, false,
true, false, false, false, false, 
false, false,

// new red page 3 
false, false, false, true, false, 
true, false, false, false, false, 
false, false, false, false, false, 
true, false, true, false, false, 
false, false, false, false, false, 
false, false, true, false, true,

// new red page 4 
false, false, false, false, false, 
false, false, false, false, true, 
false, true, false, false, false, 
false, false, false, false, false, 
false, true, false, true, 

// new red page 5 
false, false, false, true, false, 
true, false, false, false, false, 
false, false, false, false, false, 
true, false, true, false, false, 
false, false, false, false, true, 
false, true, false, false, false, 
false, false, 

// new red page 6 
true, false, false, false, true, 
false, true, false, false, false, 
false, false, true, false, false, 
false, false, false, false, true, 
false, true, false, false, false, 
false, false, false, true, false, 
true, false, false, 

// new red page 7
false, false, false, true, false, 
false, false, false, false, false, 
true, false, true, false, false, 
false, false, false, false, false, 
false, false, true, false, true, 
false, false, false, false, false, 
false, false, false, 

// new red page 8
false, true, false, true, false, 
false, false, false, false, false, 
false, false, false, true, false, 
true, false, false, false, false, 
false, false, false, false, false, 
true, false, true, false, false, 
false, false, false,
false, false, false, false, 

// new red page 9 
false, false, false, false, false, 
false, false, true, false, true, 
false, false, false, false, false, 
false, false, false, false, true, 
false, true, false, false, false, 
false, false, false, false, false, 
false, true, false, 

// new red page 10 
true, true, false, true, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, true, false, true, true, 

// new red page 11 
false, true, false, true, false, 
false, false, true, false, true, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 

// red page 12 
false, false, false, true, false, 
true, false, false, false, false, 
false, false, false, false, false, 
true, false, true, false, false, 
false, false, false, false, false, 
false, false, true, false, true, 
false, false, false, 

// red page 13
false, false, false, false, false, 
false, true, false, true, false, 
false, false, false, false, false, 
false, false, false, true, false, 
true, false, false, false, false, 
false, false, false, false, false, 
true, false, true, 

// SECOND red page 14 
false, false, false, false, false, 
false, true, false, true, false, 
false, false, false, false, false, 
false, false, false, true, false, 
true, false, false,
false, false, false, false, false, 
true, false, true, 


// red page 15 
false, false, true, false, false,
false, false, false, false, true, 
true, true, false, false, false, 
false, false, false, false, false, 
false, true, true, true, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, 
false, true, false, false, true, 
false, true, false, 

// red page 16 
false, false, false, false, true, 
false, false, false, true, false, 
true, false, false, false, false, 
false, true, false, false, false, 
false,

// hold 
true, true, true, true, true,
true, true, true, true, true, 
true, true, true, true, true,

// end of song 
false, false, false, false, false, 
false, false, false, false, false, 
};


///////////////////////////////// yellow note /////////////////////////////////
boolean [] note3Bool = {
    // intro noise 
  false, false, false, false, false, 
 
 // yellow page 1 
false, false, false, false, false,
true, false, false, false, false,
false, true, false, false, false, 
false, false, true, false, false, 
false,false,

// yellow page 2  
false, true, true, true, true, 
false, false, false, true, true, 
true, false, false, false, false,
false, false, false, false, true, false,
false, false, false, false, true,
true, true, true, false, false,
false, true, true, true, false, 
false, false,

// new yellow page 3 
true, true, true, false, false, 
false, true, true, true, false, 
false, false, true, true, true,
false, false, false, true, true, 
true, false, false, false, true, 
true, true, false, false, false, 

// new yellow page 4 
true, true, true, false, false, 
false, true, true, true, false, 
false, false, true, true, true, 
false, false, false, true, true, 
true, false, false, false, 
 
// new yellow page 5
true, true, true, false, false, 
false, false, false, false, false, 
false, false, true, true, true, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, true, 
false, false, 

// new yellow page 6
false, false, false, true, false, 
false, false, false, false, true, 
false, false, false, false, false, 
true, true, true, true, false, 
false, false, true, true, true, 
false, false, false, false, false, 
false, false, false, 

// new yellow page 7 
true, false, false, false, false, 
false, true, true, true, true, 
false, false, false, true, true, 
true, false, false, false, true, 
true, true, false, false, false, 
true, true, true, false, false, 
false, true, true,

// new yellow page 8
true, false, false, false, true, 
true, true, false, false, false, 
true, true, true, false, false, 
false, true, true, true, false, 
false, false, true, true, true, 
false, false, false, true, true, 
true, false, false, 
false, true, true, true, 

// new yellow page 9 
false, false, false, false, true, 
true, true, false, false, false, 
false, false, false, false, false, 
false, true, true, true, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, 

// new yellow page 10 
false, false, false, false, true, 
false, true, true, false, true, 
false, false, false, false, false, 
false, false, false, false, false, 

// new yellow page 11 
false, false, false, false, true, 
false, true, true, false, true, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 

// yellow page 12
false, false, false, false, false, 
false, false, true, false, false, 
true, false, false, false, false, 
false, false, false, false, true, 
false, false, true, false, false, 
false, false, false, false, false, 
false, false, true, 

// yellow page 13 
false, false, true, false, false, 
false, false, false, false, false, 
false, true, false, false, true, 
false, false, false, false, false, 
false, false, false, true, false, 
false, true, false, false, false, 
false, false, false, 

// SECOND yellow page 14 
false, false, true, false, false, 
false, false, false, false, false, 
false, true, false, false, true, 
false, false, false, false, false, 
false, false, false, 
false, true, false, false, false, 
false, false, false, 

// yellow page 15
false, false, false, false, false, 
true, false, false, false, false, 
false, false, true, true, true, 
true, true, true, false, false, 
false, false, false, false, 
true, true, true, true, true, true, 
true, true, true, true, true, true, 
true, true, 
false, false, false, false, false, 
false, false, false, 

// yellow page 16
false, true, false, false, false, 
false, false, true, false, false, 
false, false, false, true, false, 
false, false, false, false, true, 
false, 
  
// hold 
false, false, false, false, false, 
false, false, false, false, false, 
false, false, false, false, false, 

// end of song 
false, false, false, false, false, 
false, false, false, false, false, 
};

void setup() {
  size(1300, 900);
  rectMode(CENTER);
  imageMode(CENTER);
  textMode (CENTER);
  
  /////////////////////////////// initialize my vars ///////////////////

  // animation for loops
  for(int i = 0; i < welcomeScreenImages.length; i++){
    welcomeScreenImages[i] = loadImage("sprite_NewWelcomeScreen" + i + ".png");
  }
  welcomeScreenAnimation = new Animation (welcomeScreenImages, 1, 1, 1.23);
 
 for(int i = 0; i < instructionsImages.length; i++){
    instructionsImages[i] = loadImage("instruction" + i + ".jpg");
  }
  instructionsAnimation = new Animation (instructionsImages, .5, .435, .527);
  
   for(int i = 0; i < crowdImages.length; i++){
    crowdImages[i] = loadImage("crowd" + i + ".jpg");
  }
  crowdAnimation = new Animation (crowdImages, .4, .9, 1);
 
  // loading images
  selectionScreenImage = loadImage("selectionScreenReal.jpg");
  finalScoreImage = loadImage("finalScoreScreen.jpg");
  fireBallImage = loadImage("fireBall0.png");
  
  // add type face 
  oldEnglish = loadFont("OldEnglishTextMT-48.vlw");
  textFont(oldEnglish);

  // note sizes 
 noteHeight = 50;
 noteWidth = 75;
  
   // button height 
 buttonY = (7*height)/8;
 note1X = (width/3) + (noteWidth/2);
 note2X = width/2; 
 note3X = (2 * width/3) - (noteWidth/2); 
 
 // multiplier x & y
 multiplierX = (width/6) + 35; 
 multiplierY = height/2;
 
  // button 
  b1 = new Button(note1X, buttonY, color (0,255,0), "a");
  b2 = new Button(note2X, buttonY, color (255,0,0), "s");
  b3 = new Button(note3X, buttonY, color (#F9FA3F), "d");

  // note lists 
  note1List = new ArrayList<Note>();
  note2List = new ArrayList<Note>();
  note3List = new ArrayList<Note>();
  
  // windows                               noteX  noteY  scaleW  scaleH
  instructionsWindow = new SelectionWindow (885, 220, 390, 100, 
  //  box c                     textX  textY  textC
  color(#43B3DE), "Instructions", 692, 250, color(255));
  myNameIsJonasWindow = new SelectionWindow (885, 420, 350, 100, 
  color(255), "Play", 800, 443, color(#43B3DE));
  goBackAWindow = new SelectionWindow (170, 70, 300, 100, 
  color (#43B3DE), "Go Back", 33, 97, color (255));
  mainMenu = new SelectionWindow ((2 * width/3) + 130, height/3 +275, 300, 100, 
  color (#43B3DE), "Menu", 905, 603, color(255));
  playAgain = new SelectionWindow ((2 * width/3) + 130, height/3 + 430, 300, 100,
  color (255), "Replay", 885, 760, (#43B3DE));
  
  // timer 
   startTime = millis();

 // songs 
  mNIJ = new SoundFile(this, "myNameIsJonas.mp3");
  mNIJ.rate(1.0);
  wS = new SoundFile(this, "welcomeScreen.mp3");
  missSound = new SoundFile(this, "miss.mp3");
  cheeringSound = new SoundFile(this, "cheering.mp3");
  evenFlowSound = new SoundFile(this, "evenFlow.mp3");
  
  // initialize globals 
  score = 0;
  state = 0; 
  index = 0;
  multiplierScore = 0;
}

void draw() {
  background(42);
  
  // start the finite state machine 
  switch(state) {
    
  /////////////////// case for welcome screen ////////////////////
  case 0:
  welcomeScreen();
  break;
  
 ///////////////////////// case for selection screen ////////////////////////////
   case 1: 
   selectionScreen();
   // play background music
   if (evenFlowSound.isPlaying() == false) {
    evenFlowSound.play();
    }
   
   // window to instructions 
   instructionsWindow.render();
   if(instructionsWindow.isMouseButton() == true){
     state += 1; 
   }
   
// window for my name is jonas 
   myNameIsJonasWindow.render(); 
   if(myNameIsJonasWindow.isMouseButton() == true){
     state += 2 ; 
     evenFlowSound.stop();
   }
   break; 
   
   /////////////////////////case for instructions  ////////////////////////////
   case 2:
  instructionsScreen();
  goBackAWindow.render();
  if(goBackAWindow.isMouseButton() == true){
     state -- ; 
   }
   break;
 
   
////////////////////////// case for my name is jonas  ////////////////////////////
   case 3:
   ///////////////////////////////////// draw background ////////////////////
   // display crowd animation
   crowdAnimation.isAnimating = true;
   crowdAnimation.display(width/2, height/2);
   
   // guitar fret
   guitarFret();
  
   // display box 
   displayScoreBox();
   
   // draw all the buttons 
  b1.render(); 
  b2.render();
  b3.render();
  
  // draw the note bar 
  fill(174, 183, 183, 100);
  rect(width/2, buttonY, (width/2)-140, noteHeight);
  
  ///////////////////////////// timer stuff within the draw////////////////////////
  // start the timer loop
  currentTime = millis();
  if (currentTime - startTime >= mspb) {
    
    // use the timer loop to add notes to array list 
    // adds note 1
    if (note1Bool[index] == true) {
      note1List.add(new Note(note1X, height/4, color(0, 255, 0)));
    }
    
    // adds note 2
    if (note2Bool[index] == true) {
      note2List.add(new Note(note2X, height/4, color(255, 0, 0)));
    }
    
    // adds note 3
    if (note3Bool[index] == true) {
      note3List.add(new Note(note3X, height/4, color (#F9FA3F)));
    }
    
    // more timer stuff 
    startTime = millis();
    index++;
   
   // plays my name is jonas 
if (mNIJ.isPlaying() == false) {
    mNIJ.play();
    }
    
    // stops the song and changes the case 
    if (index >= note1Bool.length){
      mNIJ.stop();
      state = 4; 
    }
  }
    ////////////////////////////// note functions ////////////////////////////////
  
 //for loop to render and move notes 
 // note 1
  for (Note eachNote: note1List){
    eachNote.render();
    eachNote.move();
    eachNote.outOfBounds();
    eachNote.noteExplosion(note1X, buttonY);
  }
  
  // note 2
  for (Note eachNote: note2List){
    eachNote.render();
    eachNote.move();
    eachNote.outOfBounds();
    eachNote.noteExplosion(note2X, buttonY);
  }
  
  // note 3
  for (Note eachNote: note3List){
    eachNote.render();
    eachNote.move();
    eachNote.outOfBounds();
    eachNote.noteExplosion(note3X, buttonY);
  }

/////////////////////// for loop to remove notes /////////////////////////////
   // for note1list 
    for (int noteIndex = note1List.size() - 1; noteIndex >= 0; noteIndex --) {
      if (note1List.get(noteIndex).isHit == true){
        note1List.remove(note1List.get(noteIndex));
      }
  }
  
  // for note2list 
    for (int noteIndex = note2List.size() - 1; noteIndex >= 0; noteIndex --) {
      if (note2List.get(noteIndex).isHit == true){
        note2List.remove(note2List.get(noteIndex));
      }
  }
  
   // for note3list 
    for (int noteIndex = note3List.size() - 1; noteIndex >= 0; noteIndex --) {
      if (note3List.get(noteIndex).isHit == true){
        note3List.remove(note3List.get(noteIndex));
      }
  }
 break;
 
 /////////////////////////////// case for the end of game ///////////////////////////
 case 4: 
 highScoreFinal();
 // play cheering 
 if (cheeringSound.isPlaying() == false) {
    cheeringSound.play();
    }
    // main menu
 mainMenu.render();
  if(mainMenu.isMouseButton() == true){
     state -= 3 ; 
     index = 0;
     score = 0; 
     multiplierScore = 0; 
     cheeringSound.stop();
   }
   
   // play again
 playAgain.render (); 
 if(playAgain.isMouseButton() == true){
     state -= 1 ; 
     index = 0; 
     score = 0; 
     multiplierScore = 0; 
     cheeringSound.stop();
   }
 break; 
// end of cases
}
// end of draw 
}


void keyPressed () {
  
  // if statement to change the startscreen into main screen
 if (key == 'r') {
// change to the second state 
 state = 1;
 wS.stop();
 }
 
 // key pressed only to play song
 if (state == 3) {
   // 'a' key
  if (key == 'a') {
    for (Note everyNote : note1List) {
      everyNote.checkDistance();
      break;
    }
   }
 
  // 's' key
  if (key == 's') {
    for (Note everyNote : note2List) {
      everyNote.checkDistance();
      break;
    }
  }
  
   // 'd' key
  if (key == 'd') {
    for (Note everyNote : note3List) {
      everyNote.checkDistance();
      break;
    }
  }
  
 }
// end of key pressed 
}

// funcion for start of screen 
void welcomeScreen () {
 // play the background song for the start screen 
 if (wS.isPlaying() == false) {
   wS.play();
 }
 // opening animation
 welcomeScreenAnimation.isAnimating = true;
 welcomeScreenAnimation.displayOneShot(width/2, height/2);
 // blackout box
 fill(0);
 rect(920, 540, 100, 50);
 fill(255);
 // text
 textSize(75);
 text("'r'", 885, 555);
}

// function for screen selection
void selectionScreen () {
  // display background image 
  image(selectionScreenImage, width/2, height/2, 
  selectionScreenImage.width*.488, selectionScreenImage.height*.478 );
  // text 
  fill(255);
  text("Click Either Button", 580, 95 ); 
}

// function the instructions 
void instructionsScreen () {
  // display background image
  instructionsAnimation.isAnimating = true;
 instructionsAnimation.display(width/2, height/2);
}

// function for the final score
void highScoreFinal () { 
  // display background image 
 image(finalScoreImage, width/2, height/2, 
 finalScoreImage.width*.497, finalScoreImage.height*.65);
 // text
 fill (0);
 textSize(75);
 text (score, width/2 + 430, height/2 - 35);
}

// function that displays scoreBoard 
void displayScoreBox () {
  // background square 
 stroke(255);
 fill(0);
 square(multiplierX-50, multiplierY, 150);
 
 // display the score 
 fill(255);
 textSize(35);
 text(score, multiplierX -90 , multiplierY - 45);
 textSize(75);
 
 //line to seperate the box 
 line(multiplierX - 125, multiplierY - 40, multiplierX + 25, multiplierY - 40);
 stroke(0);
 
 //displays the multiplier score 
   if (multiplierScore >= 10 && multiplierScore < 20) {
            text("x2",  multiplierX - 87, multiplierY + 42);
          }
    else if (multiplierScore >= 20 && multiplierScore < 30) {
            text("x3", multiplierX - 87, multiplierY + 42);
          }
     else if (multiplierScore >= 30) {          
            text("x4", multiplierX - 87, multiplierY + 42);
          }     
}

// draws the guitar fret 
void guitarFret () {
  // the wood of the fret 
  fill(#430B0B);
  rect((2*(note1X - noteWidth))-(2*noteWidth) + 10, 0, 
  ((note3X + noteWidth)-(note1X - noteWidth) ), 2*height);
  
  stroke(0);
  strokeWeight(5);
  // vertical lines
  // left
  line(note1X - (noteWidth), height, note1X - (noteWidth), 0);
  // right
  line(note3X + (noteWidth), height, note3X + (noteWidth), 0);
  // notes 
  line(note1X, height, note1X, 0);
  line(note2X, height, note2X, 0);
  line(note3X, height, note3X, 0);
  
  // horizontal lines
  line(note1X - (noteWidth), height/8, note3X + (noteWidth), height/8);
  line(note1X - (noteWidth), height/4, note3X + (noteWidth), height/4);
  line(note1X - (noteWidth), 3*height/8, note3X + (noteWidth), 3*height/8);
  line(note1X - (noteWidth), height/2, note3X + (noteWidth), height/2);
  line(note1X - (noteWidth), 5*height/8, note3X + (noteWidth), 5*height/8);
  line(note1X - (noteWidth), 3*height/4, note3X + (noteWidth), 3*height/4);
 
  // song title 
  fill(255);
  textSize(50);
  text("My Name Is Jonas", 436, 70);
  textSize(20);
  text("BY", 440, 95);
  textSize(30);
  text("Weezer,1994", 437, 125);
} 
