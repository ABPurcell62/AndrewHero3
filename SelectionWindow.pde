
class SelectionWindow {
   // declare perimeter vars 
   int x; 
   int y; 
   int w; 
   int h; 
   color rectC; 
   String text;
   int textX;
   int textY;
   color textC;
 
   //////////////////// constructor /////////////////////
SelectionWindow (int startingX, int startingY, int startingW,
int startingH, color startingRectC, String startingText, 
int startingTextX, int startingTextY, color startingTextC) {
  
  // initialize parameters vars 
     x = startingX; 
     y = startingY;
     w = startingW; // w for width
     h = startingH; // h for height
     rectC = startingRectC;
     text = startingText;
     textX = startingTextX;
     textY = startingTextY;
     textC = startingTextC;
   }
   
   ////////////////////////// functions //////////////////////
   
   // function to draw the button 
   void render () {
     // box
     stroke(0);
     fill(rectC);
     rect(x, y, w, h, 15); 
     // text
     fill(textC);
     text(text, textX, textY);
   }
  
   // function for the overlapping 
boolean isBetween(int num, int min, int max){
  if(num < max && num > min) {
    return true;
  }
  else {
    return false;
  }
}

// function for hitbox 
boolean isMouseButton(){
  rectMode(CENTER);
  int top = y - (h/2);
  int bottom = y + (h/2);
  int left = x - (w/2);
  int right = x + (w/2);
  
  if (isBetween(mouseX, left, right) && 
  isBetween(mouseY, top, bottom) && 
  mousePressed == true){
  return true;
  }
  
  else {
    return false;
  }
}  
}
