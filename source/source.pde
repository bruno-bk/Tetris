int blockSize = 30;
int cols = 10;
int rows = 18;

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

void drawGameScreen() {
  mainGrid.draw();
  nextPieceGrid.draw();

  currentPiece.draw();
  nextPiece.draw();
}

void setup() {
  size(540, 540);
}

void draw() {
  background(0);
  drawGameScreen();
}
