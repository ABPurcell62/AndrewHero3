
class Note{
  // declare perimeter vars
  int x;
  int y;
  color c;
  
  // declare hard code vars
  boolean isHit; 
  boolean isOutOfBounds;
  
  int speed;
  int perfect;
  int great;
  int good;
  int okay;
  int bad;
  int miss;
 
  int top;
  int bottom;
  int left;
  int right;
  
  /////////////// constructor /////////////////
  Note(int x_, int y_, color c_){
    
   // initialize parameters vars
    x = x_;
    y = y_;
    c = c_;
    
    // initialize hard code vars
    isHit = false;
    isOutOfBounds = false;
    
  speed = 18;
  perfect = 50;
  great = 30;
  good = 20;
  okay = 10;
  bad = 5;
  miss =-10;
 
  top = y - noteHeight/2;
  bottom = y + noteHeight/2;
  left = x - noteWidth/2;
  right = x + noteWidth/2;
  }
  
   ////////////////// functions //////////////////
   
  void render(){
    rectMode(CENTER);
    fill(c); 
    rect(x, y, noteWidth, noteHeight);
  }
  
  // make a function to remove the blocks 
  void removeNote () {
    fill(42); 
    rect(x, y, noteWidth, noteHeight);
  }
  
  void move(){
   y+=speed; 
   
    // make the hit box update 
    top = y - noteHeight/2;
    bottom = y + noteHeight/2;
    left = x - noteWidth/2;
    right = x + noteWidth/2;
  }
 
 // function that adds multiplier to score
  void checkMultiplier (int scoreValue) {
    if (multiplierScore >= 10 && multiplierScore < 20) {
            score += 2 * scoreValue; 
          }
    else if (multiplierScore >= 20 && multiplierScore < 30) {
            score += 3 * scoreValue; 
          }
     else if (multiplierScore >= 30) {          
            score += 4 * scoreValue; 
          }     
  }
 
  // function to check the distance and to give a score 
      void checkDistance () {
        // perfect
        if (abs(this.bottom - buttonY) < 10) {
          score += perfect;
          isHit = true;
          println("perfect!");
          multiplierScore ++; 
          checkMultiplier(perfect);
          println (score);
          }
        
          // great
          else if (abs(this.bottom - buttonY) < 20) {
          score += great;
          isHit = true;
           println("great!");
           multiplierScore ++; 
           checkMultiplier(great);
           println (score);
        }
        
        // good
        else if (abs(this.bottom - buttonY) < 30) {
          score += good;
          isHit = true;
          println("good");
          multiplierScore ++; 
          checkMultiplier(good);
          println (score);
         
        }
        
        // okay
        else if (abs(this.bottom - buttonY) < 40) {
          score += okay;
          isHit = true;
          println("okay");
          multiplierScore ++; 
          checkMultiplier(okay);
          println(score);
        }
        
        // bad
        else if (abs(this.bottom - buttonY) < 50) {
          score += bad;
          isHit = true;
          println("bad");
          multiplierScore ++; 
          checkMultiplier(bad);
          println (score);
        }
        
        // miss
        else {
          score += miss;
          isHit = false;
          println("too early");
          multiplierScore = 0; 
          checkMultiplier(miss);
          // play miss sound
          if (missSound.isPlaying() == false) {
            missSound.play();
            }
          println (score);
        }
      }
      
      // checks to see if note gets out of bounds 
      // regardless of whether button is pressed
 void outOfBounds () {
   if (this.bottom > buttonY + 50) {
          isHit = true; 
          isOutOfBounds = true;
          score += miss;
          println("didn't hit");
          multiplierScore = 0; 
          checkMultiplier(miss);
          // play miss sound
          if (missSound.isPlaying() == false) {
            missSound.play();
            }
          println (score);
        }
 }
  
  // play animation for when a note is hit 
  void noteExplosion(int buttonX, int buttonY) {
  if(isHit == true && isOutOfBounds == false)  {
    image(fireBallImage, buttonX, buttonY);
  }
  }
}
