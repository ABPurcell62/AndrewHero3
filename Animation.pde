
class Animation {
  // declare perimeter vars 
  PImage[] images;
  float speed;
  float scaleX;
  float scaleY;

// declare hard code vars 
  float index;
  boolean isAnimating;

  /////////////// constructor /////////////
  Animation(PImage[] tempImages, float tempSpeed, 
  float tempScaleX, float tempScaleY) {
    // inmitialize parameter vars 
    images = tempImages;
    speed = tempSpeed;
    scaleX = tempScaleX;
    scaleY = tempScaleY;

    // initialize hard code vars 
    index = 0;
    isAnimating = false;
  }
  
  ////////////////// functions //////////////////

  // updates the index which image to display for
  // the animation
  void next() {
    index += speed;
    // resets the index if it is too big
    if (index >= images.length) {
      index=0;
      isAnimating=false;
    }
  }

  // display an image of the animation
  void display(int x, int y) {
    imageMode(CENTER);
    if (isAnimating) {
      int imageIndex = int(index);
      PImage img = images[imageIndex];
      image(img, x, y, img.width*scaleX, img.height*scaleY);
      next();
      }
      else {
      PImage img = images[0];
      image(img, x, y, img.width*scaleX, img.height*scaleY);
    }
  }
  
  // keeps the last frame frozen 
  void nextOneShot() {
    // resets the index if it is too big
    if (index >= images.length-1) {
      isAnimating=false;
      index = images.length-1;
    } 
      else {
      index += speed;
    }
  }

  // displays the frames and then freezes
  void displayOneShot(int x, int y) {
    imageMode(CENTER);
    int imageIndex = int(index);
    PImage img = images[imageIndex];
    image(img, x, y, img.width*scaleX, img.height*scaleY);
    nextOneShot();
  }
}
