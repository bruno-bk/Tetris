int blockSize = 30;
int cols = 10;
int rows = 18;

Grid mainGrid = new Grid(blockSize, cols, rows, 0, 0);
Grid nextPieceGrid = new Grid(blockSize, 4, 3, 12*blockSize, 6*blockSize);

void setup() {
  size(540, 540);
}

void draw() {
  background(0);
  mainGrid.draw();
  nextPieceGrid.draw();
}
