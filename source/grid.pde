class Grid {
  int blockSize = 0;
  int cols = 0;
  int rows = 0;
  int originX = 0;
  int originY = 0;
  int[][] grid;

  Grid(int blockSize, int cols, int rows, int originX, int originY) {
    this.blockSize = blockSize;
    this.cols = cols;
    this.rows = rows;
    this.originX = originX;
    this.originY = originY;
    grid = new int[rows][cols];
  }

  void draw() {
    for (int x = 0 + originX; x < (blockSize*cols)+originX; x += blockSize) {
      for (int y = 0 + originY; y < (blockSize*rows)+originY; y += blockSize) {
        stroke(100);
        noFill();
        rect(x, y, blockSize, blockSize);
      }
    }
  }
}
