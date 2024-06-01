class Piece {
  int[][] shape;
  int colorP;
  int x;
  int y;
  int spriteIndex;
  Grid grid;

  Piece(int[][] shape, int colorP, Grid grid) {
    this.shape = shape;
    this.colorP = colorP;
    this.x = grid.cols / 2 - shape[0].length / 2;
    this.y = 0;
    this.spriteIndex = int(random(1, sprites.length+1));
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
          image(sprites[this.spriteIndex-1], (x + j) * blockSize + grid.originX, (y + i) * blockSize + grid.originY);
        }
      }
    }
  }

  void moveDown() {
    move(0, 1);
  }
  
  void moveLeft() {
    move(-1, 0);
  }
  
  void moveHight() {
    move(1, 0);
  }

  void move(int dx, int dy) {
    if (!checkCollision(x + dx, y + dy, shape)) {
      x += dx;
      y += dy;
    }
  }
  
  void rotate() {
    int[][] newShape = new int[shape[0].length][shape.length];
    for (int i = 0; i < shape.length; i++) {
      for (int j = 0; j < shape[i].length; j++) {
        newShape[j][shape.length - 1 - i] = shape[i][j];
      }
    }
    if (!checkCollision(x, y, newShape)) {
      shape = newShape;
    }
  }

  boolean checkCollision(int newX, int newY, int[][] newShape) {
    for (int i = 0; i < newShape.length; i++) {
      for (int j = 0; j < newShape[i].length; j++) {
        if (newShape[i][j] != 0) {
          int posX = newX + j;
          int posY = newY + i;
          if (posX < 0 || posX >= grid.cols || posY >= grid.rows || (posY >= 0 && grid.grid[posY][posX] != 0)) {
            return true;
          }
        }
      }
    }
    return false;
  }
  
  boolean checkCollisionBelow(){
   for (int i = 0; i < shape.length; i++) {
      for (int j = 0; j < shape[i].length; j++) {
        if (shape[i][j] != 0) {
          int posX = x + j;
          int posY = y + i + 1;

          if (posY >= grid.rows || (posY >= 0 && grid.grid[posY][posX] != 0)) {
            return true;
          }
        }
      }
    }
    return false; 
  }
}
