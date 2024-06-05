int blockSize = 30;
int cols = 10;
int rows = 18;

int speed = 30;
int counter = 0;

int pieces_counter = 0;

boolean gamoOver = false;
boolean animation = false;
int removingLine = 0;
int removingCol = 0;

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

void checkCompletedLines() {
  removingLine = mainGrid.completedLine();
  if(removingLine != 0) {
    animation = true;
    pointSound.play();
    pointSound.amp(0.5);
  }
}

void removeLineAnimation() {
  mainGrid.resetBlock(removingLine, removingCol);

  if(++removingCol == cols) {
    mainGrid.updateRemovedLine(removingLine);
    animation = false;
    removingCol = 0;
    checkCompletedLines();
  }
}

void game_texts() {
  fill(color(255-backgroundColor));
  textAlign(LEFT);
  textSize(25);
  String pont = "Pontuação: " + pieces_counter;
  text(pont, 350, 120);
  
  text("Proxima peça ", 350, 170);
}

void drawGameScreen() {
  background(backgroundColor);
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
  drawGameScreen();

  if(animation) {
    removeLineAnimation();

  } else if(++counter >= speed) {
    counter = 0;
    if(currentPiece.checkCollisionBelow()) {
      pieces_counter++;
      mainGrid.savePieceInGrid(currentPiece);
      currentPiece = nextPiece;
      currentPiece.changeGrid(mainGrid);
      nextPiece = new Piece(randomPiece(), color(255, 0, 0), nextPieceGrid);
      
      if(currentPiece.checkCollisionBelow()) {
        backgroundMusic.stop();
        gameOverSound.play(); 
        gameOverSound.amp(0.50);
        gamoOver = true;
      }
      
      if(pieces_counter % 5 == 0 && speed > 5){
        speed--;
      }

      checkCompletedLines();

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
  counter = 0;
}

boolean isGameOver(){
  return gamoOver;
}
