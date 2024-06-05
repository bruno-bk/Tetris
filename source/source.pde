import processing.sound.*;

enum screns {
  MENU,
  RULES,
  GAME,
  GAMEOVER,
  CREDITS
}

screns scren = screns.MENU;
PImage imgMenu,imgConfig,imgCredito;
PImage[] sprites = new PImage[6];

SoundFile pointSound;
SoundFile gameOverSound;
SoundFile backgroundMusic;
  
void setup() {
  size(540, 540);
  frameRate(30);
  imgMenu = loadImage("..\\img\\tela_menu.png");
  imgConfig = loadImage("..\\img\\tela_config.png");
  imgCredito = loadImage("..\\img\\tela_credito.png");
  
  
  pointSound = new SoundFile(this, "..\\sound\\plus_points.wav");
  gameOverSound = new SoundFile(this, "..\\sound\\game_over.wav");
  backgroundMusic = new SoundFile(this, "..\\sound\\ost.wav");
  for (int i = 0; i < sprites.length; i++) {
    sprites[i] = loadImage("..\\img\\sprite" + str(i+1) + ".jpg");
  }
}

void draw() {
  
  if(scren == screns.MENU){
    background(255);
    image(imgMenu, 0, 0);
    
  } else if(scren == screns.RULES){
    background(255);
    image(imgConfig, 0, 0);

  } else if (scren == screns.GAME){ 
      gameLoop();
      if(isGameOver()){
        scren = screns.GAMEOVER;
        drawGameOverScreen();
      }
   } else if(scren == screns.CREDITS){
    background(255);
    image(imgCredito, 0, 0);
  }
}

void mousePressed() {
  if (scren == screns.MENU) {
    if(mouseX > 187 && mouseX < 187 + 163  && mouseY > 198 && mouseY < 198 + 40){//JOGAR
    println("Botão Jogar pressionado");
      resetGame();
      scren = screns.GAME;
      backgroundMusic.loop(); 
      backgroundMusic.amp(0.25);
    } else if (mouseX > 187 && mouseX < 187 + 163  && mouseY > 270 && mouseY < 270+40){//REGRAS
      scren = screns.RULES;
    } else if (mouseX > 187 && mouseX < 187 + 163  && mouseY > 160 && mouseY < 340+40){//CREDITO
      scren = screns.CREDITS;
    }    
    
  
  } else if (scren == screns.RULES) {
    scren = screns.MENU;

  } else if (scren == screns.GAMEOVER && mouseX > 120 && mouseX < 420 && mouseY > 240 && mouseY < 290){
    scren = screns.MENU;
  
  } else if (scren == screns.CREDITS) {
    scren = screns.MENU;
  }
}

void keyPressed() {
  if(scren == screns.GAME) {
    if (keyCode == LEFT) {
      currentPiece.moveLeft();
    } else if (keyCode == RIGHT) {
      currentPiece.moveHight();
    } else if (keyCode == DOWN) {
      currentPiece.moveAllDown();
      counter = speed;
    } else if (keyCode == ' ') {
      currentPiece.rotate();
    }
  }
}
