enum screns {
  MENU,
  RULES,
  GAME,
  GAMEOVER,
  CREDITS
}

screns scren = screns.GAME;

void setup() {
  size(540, 540);
}

void draw() {
  if(scren == screns.MENU){
    background(255);
    
  } else if(scren == screns.RULES){
    background(255);

  } else if (scren == screns.GAME){ 
    gameLoop();
    if(isGameOver()){
      scren = screns.GAMEOVER;
      drawGameOverScreen();
    }
    
  } else if(scren == screns.CREDITS){
    background(255);
  }
}

void mousePressed() {
  if (scren == screns.MENU) {
    resetGame();
    scren = screns.GAME;
  
  } else if (scren == screns.RULES) {
    scren = screns.MENU;

  } else if (scren == screns.GAMEOVER && mouseX > 120 && mouseX < 420 && mouseY > 240 && mouseY < 290){
    scren = screns.MENU;
  
  } else if (scren == screns.CREDITS) {
    scren = screns.MENU;
  }
}

void keyPressed() {
  if(scren == screns.GAME){
    if (keyCode == LEFT) {
      currentPiece.moveLeft();
    } else if (keyCode == RIGHT) {
      currentPiece.moveHight();
    } else if (keyCode == ' ') {
      currentPiece.rotate();
    }

    drawGameScreen();
  }
}
