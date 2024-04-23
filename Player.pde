class Player {
  
  //variables
  int x;
  int y;
  
  int w;
  int h;
  
  boolean isMovingRight;
  boolean isMovingLeft;
  
  boolean isJumping;
  boolean isFalling;
  boolean isFacing;
  
  int speed;
  
  int jumpHeight; // distance that you can jump upwards
  int highestY; // y value of the top of your jump
  
  int left;
  int right;
  int top;
  int bottom;
  
  //constructor
  Player(int startingX, int startingY, int startingW, int startingH){
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    
    isMovingLeft = false;
    isMovingRight = false;
    
    isJumping = false;
    isFalling = false;
    isFacing = true;
    
    speed = 10;
    
    jumpHeight = height/4;
    highestY = y - jumpHeight; 
  }
  
  //functions
  void render(){
    rectMode(CENTER);
    if(isFacing == true){
    playerLeftAnime.display(x,y);
    }else if(isFacing == false){
    playerRightAnime.display(x,y);
    }
  }
  
  void move(){
    if (isMovingLeft == true && left >= 0){
      x -= speed; // x = x - speed
   }
   
   if (isMovingRight == true && right <= width){
      x += speed; // x = x + speed
   }
   
   //update the boundas of the player
    left = x - w/2; 
    right = x + w/2; 
    top = y - h/2; 
    bottom = y + h/2;
  }
  
  void jumping(){
    if (isJumping==true){
      y-=speed;
    }
  }
  
  void falling(){
    if(isFalling == true){
      y +=speed;
    }
  }
  
  void topOfJump(){
    if (y <=highestY){
      isJumping = false; // stop jumping upward
      isFalling = true;  // start falling downward
    }
  }
  
  void land(){
    if(y >= height - h/2){
     isFalling = false; //stop falling 
     y = height - h/2; // snap player to pos where they are standing on bottom of window
    }
  }
  
  // check to see if the player is colliding with any platform
  // if the player is not colliding with any platforms, then
  // make the player start falling
  void fallOfPlatform(ArrayList<Platform> aPlatformList){
    
    // check that the player is not in the middle of a jump
    // and check that the player is not on the ground
    if(isJumping == false && y < height - h/2){
      
      boolean onPlatform = false;
      
      for (Platform aPlatform : aPlatformList){
         // if the player is colliding with a platform
        if (top <= aPlatform.bottom &&
            bottom >= aPlatform.top &&
            left <= aPlatform.right &&
            right >= aPlatform.left){
              onPlatform = true; // make onPlatform true
        }
      }
      //if you are not on a platform,
      if (onPlatform == false){
        isFalling = true;
      }
    }
  }
}
