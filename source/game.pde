int blockSize = 30;
int cols = 10;
int rows = 18;

int speed = 30;
int counter = speed;

int pieces_counter = 0;

boolean gamoOver = false;

Grid mainGrid = new Grid(blockSize, cols, rows, 0, 0);
Grid nextPieceGrid = new Grid(blockSize, 4, 3, 12*blockSize, 6*blockSize);

Piece currentPiece = new Piece(randomPiece(), color(255, 0, 0), mainGrid);
Piece nextPiece = new Piece(randomPiece(), color(255, 0, 0), nextPieceGrid);

int[][] randomPiece() {
  int[][][] pieces = {
    { { 1, 1, 1, 1 } },
    { { 1, 1, 1 }, { 0, 1, 0 } },
    { { 1, 1, 1 }, { 0, 1, 0 }, { 0, 1, 0 } },
    { { 1, 1, 1 }, { 1, 0, 0 } },
    { { 1, 1 }, { 1, 1 } },
    { { 1, 1, 1 }, { 1, 1, 1 } },
    { { 1, 1, 0 }, { 0, 1, 1 } }
  };
  return pieces[int(random(pieces.length))];
}

void game_texts() {
  fill(color(255));
  textAlign(LEFT);
  textSize(25);
  String pont = "Pontuação: " + pieces_counter;
  text(pont, 350, 120);
  
  text("Proxima peça ", 350, 170);
}

void drawGameScreen() {
  background(0);
  game_texts();
  mainGrid.draw();
  mainGrid.drawSavedPieces();
  nextPieceGrid.draw();

  currentPiece.draw();
  nextPiece.draw();
}

void drawGameOverScreen(){
  background(100);
  fill(color(255));
  rect(70, 70, 400, 270);
  textAlign(CENTER);
  fill(color(0));
  textSize(35);
  text("GAME OVER!", 270, 140);
  textSize(25);
  String pont = "Pontuação: " + pieces_counter;
  text(pont, 250, 180);
  
  fill(color(200));
  rect(120, 240, 300, 50);
  fill(color(0));
  textSize(35);
  text("voltar", 270, 275);
}

void gameLoop() {
  if(++counter >= speed) {
    drawGameScreen();
    counter = 0;
    
    if(currentPiece.checkCollisionBelow()) {
      pieces_counter++;
      mainGrid.savePieceInGrid(currentPiece);
      currentPiece = nextPiece;
      currentPiece.changeGrid(mainGrid);
      nextPiece = new Piece(randomPiece(), color(255, 0, 0), nextPieceGrid);
      mainGrid.update();
      
      if(currentPiece.checkCollisionBelow()){
        gamoOver = true;
      }
      
      if(pieces_counter % 5 == 0 && speed > 5){
        speed--;
      }
    } else {
      currentPiece.moveDown();
    }
  }
}

void resetGame(){
  pieces_counter = 0;
  gamoOver = false;
  mainGrid.reset();
  speed = 30;
  counter = speed;
}

boolean isGameOver(){
  return gamoOver;
}
