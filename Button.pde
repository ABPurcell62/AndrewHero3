
class Button {
  
   // declare perimeter vars 
  int x; 
  int y; 
  color c; 
  String letter; 
  
  // declare hard code vars
  int top; 
  int bottom; 
  int left; 
  int right; 
  
  /////////////// constructor /////////////////
  Button (int startingX, int startingY, color startingColor,
  String startingLetter) {
    // initialize parameters vars
    x = startingX;
    y = startingY;
    c = startingColor;
    letter = startingLetter; 
    
    // initialize hard code vars 
    top = y - noteHeight/2; 
    bottom = y + noteHeight/2; 
    left = x - noteWidth/2; 
    right = x + noteWidth/2;
  }
  
  ////////////////// functions //////////////////

  void render() { 
    // box
    fill(c);
    rect(x, y, noteWidth, noteHeight);
    // text
    fill(0);
    textSize(40);
    text(letter, x-10, y+13); 
  } 
}
