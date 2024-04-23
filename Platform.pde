class Platform {
  
  //variables
  int x;
  int y;
  int w;
  int h;
  
  int left;
  int right;
  int top;
  int bottom;
  
  //constructor
  Platform(int startingX, int startingY, int startingW){
    rectMode(CENTER);
    
    x = startingX;
    y = startingY;
    w = startingW;
    h = 10;
    
    left = x - w/2; 
    right = x + w/2; 
    top = y - h/2; 
    bottom = y + h/2; 
  }
  
  void render(){
    rect(x,y,w,h);
  }
  
  void collide(Player aPlayer){
    // if player collides with a platform
    if (left < aPlayer.right && 
        right > aPlayer.left && 
        top < aPlayer.bottom && 
        bottom > aPlayer.top){
          if(aPlayer.isFalling == true &&  aPlayer.isJumping == false){
            aPlayer.isFalling = false; //stop falling
            aPlayer.y = y - h/2 - aPlayer.h/2;
          }
          if(aPlayer.isJumping == true &&  aPlayer.isFalling == false){
            aPlayer.isJumping = false; //stop falling
            aPlayer.isFalling = true;
            aPlayer.y = y + h/2 + aPlayer.h/2;
          }
    }
  }
  
    void enemyCollide(Enemy anEnemy){
    // if player collides with a platform
    if (left < anEnemy.right && 
        right > anEnemy.left && 
        top < anEnemy.bottom && 
        bottom > anEnemy.top){
          if(anEnemy.isFalling == true &&  anEnemy.isJumping == false){
            anEnemy.isFalling = false; //stop falling
            anEnemy.y = y - h/2 - anEnemy.h/2;
          }
          if(anEnemy.isJumping == true &&  anEnemy.isFalling == false){
            anEnemy.isJumping = false; //stop falling
            anEnemy.isFalling = true;
            anEnemy.y = y + h/2 + anEnemy.h/2;
          }
    }
  }
  
}
