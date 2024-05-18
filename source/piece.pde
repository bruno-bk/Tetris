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

  void moveDown() {
    move(0, 1);
  }

  void move(int dx, int dy) {
    if (!checkCollision(x + dx, y + dy, shape)) {
      x += dx;
      y += dy;
    }
  }

  boolean checkCollision(int newX, int newY, int[][] newShape) {
    for (int i = 0; i < newShape.length; i++) {
      for (int j = 0; j < newShape[i].length; j++) {
        if (newShape[i][j] != 0) {
          int posX = newX + j;
          int posY = newY + i;
          if (posX < 0 || posX >= grid.cols || posY >= grid.rows) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
