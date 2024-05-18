int blockSize = 30;
int cols = 10;
int rows = 18;
int[][] grid = new int[rows][cols];


void setup() {
  size(540, 540);
}

void draw() {
  background(0);
  drawGrid();
}

void drawGrid() {
  for (int x = 0; x < blockSize*cols; x += blockSize) {
    for (int y = 0; y < blockSize*rows; y += blockSize) {
      stroke(100);
      noFill();
      rect(x, y, blockSize, blockSize);
    }
  }
}
