class Piece {
  int[][] shape;
  int colorP;
  int x;
  int y;
  Grid grid;

  Piece(int[][] shape, int colorP, Grid grid) {
    this.shape = shape;
    this.colorP = colorP;
    this.x = grid.cols / 2 - shape[0].length / 2;
    this.y = 0;
    this.grid = grid;
  }

  void changeGrid(Grid newGrid) {
    this.grid = newGrid;
    this.x = grid.cols / 2 - shape[0].length / 2;
  }

  void draw() {
    fill(colorP);
    for (int i = 0; i < shape.length; i++) {
      for (int j = 0; j < shape[i].length; j++) {
        if (shape[i][j] != 0) {
          rect((x + j) * blockSize + grid.originX, (y + i) * blockSize + grid.originY, blockSize, blockSize);
        }
      }
    }
  }
}
