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
  
  void drawSavedPieces() {
    fill(color(255, 0, 0));
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (grid[i][j] != 0) {
          rect(j * blockSize, i * blockSize, blockSize, blockSize);
        }
      }
    }
  }
  
  void savePieceInGrid(Piece piece){
    for (int i = 0; i < piece.shape.length; i++) {
      for (int j = 0; j < piece.shape[i].length; j++) {
        if (piece.shape[i][j] != 0) {
          grid[piece.y + i][piece.x + j] = 1;
        }
      }
    }
  }
  
  void update() {
    for (int i = 0; i < rows; i++) {
      boolean removeLine = true;
      for (int j = 0; j < cols; j++) {
        if(grid[i][j] == 0){
          removeLine = false;
        }
      }

      if(removeLine){
        i--;
        for (int k = i; k >= 0; k--) {
          for (int l = 0; l < cols; l++) {
            grid[k+1][l] = grid[k][l];
          }
        }
      }
    }
  }
}
