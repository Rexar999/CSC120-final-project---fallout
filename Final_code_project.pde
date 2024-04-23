
import processing.sound.*;

//declaring my vars
SoundFile jumpSound;
SoundFile background;
SoundFile gunShot;

// declaring my vars
Player p1;

int state = 0;

int score = 0;

int lives = 3;

PImage beginImg;
PImage lifeCounter;
PImage badEnd;
PImage goodEnd;
PImage greatEnd;
PImage desertImg;

PImage[] playerLeftImg = new PImage[2];
PImage[] playerRightImg = new PImage[2];
PImage[] roachLeftImg = new PImage[1];
PImage[] roachRightImg = new PImage[1];

Animation playerLeftAnime;
Animation playerRightAnime;
Animation roachLeftAnime;
Animation roachRightAnime;

Enemy e1;
Enemy e2;

ArrayList<Bullet> bulletList;
ArrayList<Enemy> enemyList;

Platform plat1;
Platform plat2;
Platform plat3;
Platform plat4;
Platform plat5;
Platform plat6;
Platform plat7;
Platform plat8;

ArrayList<Platform> platformList;

void setup(){
  size(1200, 800);
  
  //initialize my vars
  p1 = new Player(width/2, height/2, 50, 50);
  
  for(int i=1; i<=playerLeftImg.length; i ++){
    playerLeftImg[i-1] = loadImage ("shootLeft" + i + ".png");
    playerLeftImg[i-1].resize(50, 50);
  }
  for(int i=1; i<=playerRightImg.length; i ++){
    playerRightImg[i-1] = loadImage ("shootRight" + i + ".png");
    playerRightImg[i-1].resize(50, 50);
  }
  for(int i=1; i<=roachLeftImg.length; i ++){
    roachLeftImg[i-1] = loadImage ("roachLeft.png");
    roachLeftImg[i-1].resize(50, 50);
  }
  for(int i=1; i<=roachRightImg.length; i ++){
    roachRightImg[i-1] = loadImage ("roachRight.png");
    roachRightImg[i-1].resize(50, 50);
  }
  
  playerLeftAnime = new Animation(playerLeftImg, 0.1, 1);
  playerRightAnime = new Animation(playerRightImg, 0.1, 1);
  roachLeftAnime = new Animation(roachLeftImg, 0.1, 2);
  roachRightAnime = new Animation(roachRightImg, 0.1, 2);
  
  beginImg = loadImage("beginImg.jpg");
  lifeCounter = loadImage("lifeCounter.jpg");
  desertImg = loadImage("desert.jpg");
  badEnd = loadImage("badEnd.jpg");
  goodEnd = loadImage("goodEnd.jpg");
  greatEnd = loadImage("greatEnd.jpg");
  imageMode(CENTER);
  beginImg.resize(width,height);
  lifeCounter.resize(50,50);
  desertImg.resize(width,height);
  badEnd.resize(width,height);
  goodEnd.resize(width,height);
  greatEnd.resize(width,height);
  
  e1 = new Enemy(300, 200, 50, 50);
  e2 = new Enemy(600, 300, 50, 50);
  
  bulletList = new ArrayList<Bullet>();
  enemyList = new ArrayList<Enemy>();
  
  enemyList.add(e1);
  enemyList.add(e2);
  
  plat1 = new Platform(width/2, height*5/6, width);
  plat2 = new Platform(width-width/8, height*4/6, width/4);
  plat3 = new Platform(width/8, height*4/6, width/4);
  plat4 = new Platform(width*3/8, height*3/6, width/6);
  plat5 = new Platform(width-width*3/8, height*3/6, width/6);
  plat6 = new Platform(width/2, height*2/6, width/4);
  plat7 = new Platform(width-width/8, height/6, width/4);
  plat8 = new Platform(width/8, height/6, width/4);
  
  platformList = new ArrayList<Platform>();
  
  platformList.add(plat1);
  platformList.add(plat2);
  platformList.add(plat3);
  platformList.add(plat4);
  platformList.add(plat5);
  platformList.add(plat6);
  platformList.add(plat7);
  platformList.add(plat8);
  
  //initialize sound vars
  jumpSound = new SoundFile(this, "jump grunt.wav");
  background = new SoundFile(this, "music.wav");
  gunShot = new SoundFile(this, "gunShot.wav");
}

void draw(){
  switch(state){ 
    //state 0
    case 0:
    begin();
    break;
    case 1:
    level1();
    break;
    case 2:
    badEnd();
    break;
    case 3:
    goodEnd();
    break;
    case 4:
    greatEnd();
    break;
  }
}


void keyPressed(){
  if(key == 'a'){
    p1.isMovingLeft = true;
    p1.isFacing = true;
  }
  
  if(key == 'd'){
    p1.isMovingRight = true;
    p1.isFacing = false;
  }
  
  if(key == 'w' && p1.isJumping == false && p1.isFalling == false){
    p1.isJumping = true; // start a new jump
    jumpSound.play();
    p1.highestY = p1.y - p1.jumpHeight;
  }
  if(key == ' '){
    state = 1;
    score = 0;
    lives = 3;
  }
}

void keyReleased(){
  if(key == 'a'){
    p1.isMovingLeft = false;
  }
  
  if(key == 'd'){
    p1.isMovingRight = false;
  }
}

void mousePressed(){
  if(p1.isFacing == true){
    playerLeftAnime.isAnimating = true;
  }
  bulletList.add( new Bullet(p1.x, p1.y) );
  gunShot.play();
}

void begin(){
  background(beginImg);
  textSize(50);
  text("Press Space to Start",100,200);
}

void level1(){
  background(desertImg);
  if(random(0, 100) > 98-score*.1){
   enemyList.add( new Enemy(int(random(25, width-25)), int(random(25, height*5/6-25)), 50, 50) );
   }
  background(desertImg);
  for(int i = lives-1; i >= 0; i=i-1){
    image(lifeCounter, width*5/6+i*60, height/20, 50, 50);
  }
  fill(0,255,0);
  p1.render();
  p1.move();
  p1.jumping();
  p1.falling();
  p1.topOfJump();
  p1.land();
  p1.fallOfPlatform(platformList);
  fill(255);
  
  for (Enemy anEnemy : enemyList){
    fill(255,0,0);
    anEnemy.render();
    anEnemy.move(p1);
    anEnemy.jumping();
    anEnemy.falling();
    anEnemy.topOfJump();
    anEnemy.land();
    anEnemy.fallOfPlatform(platformList);
    anEnemy.playerHit(p1);
    fill(255);
  }
  //for loop to go through all bullets
  for (Bullet aBullet : bulletList){
    aBullet.render();
    aBullet.move();
    aBullet.checkRemove();
    
   for (Enemy anEnemy : enemyList){   
        aBullet.shootEnemy(anEnemy);
    }
    
    for (Platform aPlatform : platformList){   
        aBullet.hitPlatform(aPlatform);
    }
  }
  
  for (int i = bulletList.size()-1; i >= 0; i=i-1){
    Bullet aBullet = bulletList.get(i);
    
      if (aBullet.shouldRemove == true){
        bulletList.remove(aBullet);
    }
  }
  
  for (int i = enemyList.size()-1; i >= 0; i=i-1){
    Enemy anEnemy = enemyList.get(i);
    
      if (anEnemy.shouldRemove == true){
        enemyList.remove(anEnemy);
    }
  }
  
  //for loop to go through all platforms
  for (Platform aPlatform : platformList){
  aPlatform.render();
  aPlatform.collide(p1);
  for(Enemy anEnemy : enemyList){
      aPlatform.enemyCollide(anEnemy);
  }
  }
  if(background.isPlaying() == false){
    background.play();
  }
  textSize(50);
  text(score,50,50);
  
  if(lives == 0 && score <= 30){
    state = 2;
  }
  if(lives == 0 && score >= 50){
    state = 4;
  }
  else if(lives == 0 && score < 50 && score > 30){
    state = 3;
  }
}

void badEnd(){
  background(badEnd);
  textSize(50);
  text("Press Space to Restart",100,200);
}

void goodEnd(){
  background(goodEnd);
  textSize(50);
  text("Press Space to Restart",100,200);
}

void greatEnd(){
  background(greatEnd);
  textSize(50);
  text("Press Space to Restart",600,400);
}
