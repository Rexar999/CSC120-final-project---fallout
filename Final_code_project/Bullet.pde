class Bullet {
  
  //variables
  int x;
  int y;
  int d;
  
  boolean shouldRemove;
  
  int left;
  int right;
  int top;
  int bottom;
  
  PVector speed;
  
  //constructor
  Bullet(int startingX, int startingY){
   x = startingX;
   y = startingY;
   
   d = 5;
   
   speed = new PVector(x-mouseX, y-mouseY);
   speed.setMag(15);
   
   shouldRemove = false;
  }
  
  void render(){
    circle(x,y,d);
  }
  
  void move(){
    x -= speed.x;
    y -= speed.y;
    
    left = x- d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }
  
  void checkRemove(){
    if(y < 0 || x < 0 || x > width || y > height){
      shouldRemove = true;
    }
  }
  
  void shootEnemy(Enemy anEnemy){
    // if the bullet collides with the enemy
    // then flag the enemy to be removed
    if (top <= anEnemy.bottom &&
        bottom >= anEnemy.top &&
        left <= anEnemy.right &&
        right >= anEnemy.left){
          anEnemy.shouldRemove = true;
          shouldRemove = true;
          score = score + 1;
    }
  }
  
  void hitPlatform(Platform aPlatform){
    // if the bullet collides with the enemy
    // then flag the enemy to be removed
    if (top <= aPlatform.bottom &&
        bottom >= aPlatform.top &&
        left <= aPlatform.right &&
        right >= aPlatform.left){
          shouldRemove = true;
    }
  }
  
  
  
  
  
  
  
}
