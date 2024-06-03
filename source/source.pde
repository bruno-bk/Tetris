import processing.sound.*;
enum screns {
  MENU,
  RULES,
  THEME,
  GAME,
  GAMEOVER,
  CREDITS
}

screns scren = screns.MENU;
PImage imgMenu,imgConfig,imgCredito,imgTema;
PImage[] sprites = new PImage[6];
int backgroundColor = 0;

SoundFile pointSound;
SoundFile gameOverSound;
SoundFile backgroundMusic;
  
void setup() {
  size(540, 540);
  frameRate(30);
  imgMenu = loadImage("..\\img\\tela_menu.png");
  imgConfig = loadImage("..\\img\\tela_config.png");
  imgCredito = loadImage("..\\img\\tela_credito.png");
  imgTema = loadImage("..\\img\\tela_tema.png");  
  
  pointSound = new SoundFile(this, "..\\sound\\plus_points.wav");
  gameOverSound = new SoundFile(this, "..\\sound\\game_over.wav");
  backgroundMusic = new SoundFile(this, "..\\sound\\ost.wav");
  for (int i = 0; i < sprites.length; i++) {
    sprites[i] = loadImage("..\\img\\sprite" + str(i+1) + ".jpg");
  }
}

void draw() {
  if(scren == screns.MENU){
    background(255);
    image(imgMenu, 0, 0);
    
    if(mouseX > 187 && mouseX < 187 + 163  && mouseY > 198 && mouseY < 198 + 40){
      cursor(HAND);
    } else if (mouseX > 187 && mouseX < 187 + 163  && mouseY > 270 && mouseY < 270 + 40){
      cursor(HAND);
    } else if (mouseX > 187 && mouseX < 187 + 163  && mouseY > 340 && mouseY < 340 + 40){
      cursor(HAND);
    } else {
      cursor(ARROW);
    }

  } else if(scren == screns.RULES){
    background(255);
    image(imgConfig, 0, 0);
    mostrarRegras();
    
    if (mouseX > 155 && mouseX < 155 + 35 && mouseY > 432 && mouseY < 432 + 30){
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
    
  } else if(scren == screns.THEME){
    image(imgTema, 0, 0);
    if(mouseX > 40 && mouseX < 40 + 157  && mouseY > 140 && mouseY < 140 + 245){
      cursor(HAND);
    } else if (mouseX > 333 && mouseX < 333 + 157  && mouseY > 140 && mouseY < 140 + 245){
      cursor(HAND);
    } else {
      cursor(ARROW);
    }

  } else if (scren == screns.GAME){ 
      gameLoop();
      if(isGameOver()){
        scren = screns.GAMEOVER;
        drawGameOverScreen();
      }

   } else if (scren == screns.GAMEOVER){ 
     if (mouseX > 120 && mouseX < 420 && mouseY > 240 && mouseY < 290){
       cursor(HAND);
     } else {
       cursor(ARROW);
     }

   } else if(scren == screns.CREDITS){
    background(255);
    image(imgCredito, 0, 0);
    mostrarCreditos();
     
    if (mouseX > 155 && mouseX < 155 + 35 && mouseY > 432 && mouseY < 432 + 30){
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
  }
}

void mousePressed() {
  if (scren == screns.MENU) {
    if(mouseX > 187 && mouseX < 187 + 163  && mouseY > 198 && mouseY < 198 + 40){//JOGAR
      resetGame();
      scren = screns.THEME;
      backgroundMusic.loop(); 
      backgroundMusic.amp(0.25);
    } else if (mouseX > 187 && mouseX < 187 + 163  && mouseY > 270 && mouseY < 270 + 40){//REGRAS
      scren = screns.RULES;
    } else if (mouseX > 187 && mouseX < 187 + 163  && mouseY > 160 && mouseY < 340 + 40){//CREDITO
      scren = screns.CREDITS;
    }    
  
  } else if (scren == screns.RULES) {
    int buttonX = 155;
    int buttonY = 432;
    int buttonWidth = 35;
    int buttonHeight = 30;
    if(mouseX > buttonX && mouseX < buttonX + buttonWidth  && mouseY > buttonY && mouseY < buttonY + buttonHeight) {
      scren = screns.MENU;
    }
  
  } else if (scren == screns.THEME) {
    if(mouseX > 40 && mouseX < 40 + 157  && mouseY > 140 && mouseY < 140 + 245) {
      backgroundColor = 0;
      scren = screns.GAME;
    } else if (mouseX > 333 && mouseX < 333 + 157  && mouseY > 140 && mouseY < 140 + 245) {
      backgroundColor = 255;
      scren = screns.GAME;
    }

  } else if (scren == screns.GAMEOVER && mouseX > 120 && mouseX < 420 && mouseY > 240 && mouseY < 290){
    scren = screns.MENU;
  
  } else if (scren == screns.CREDITS) {
    int buttonX = 155;
    int buttonY = 432;
    int buttonWidth = 35;
    int buttonHeight = 30;
    if(mouseX > buttonX && mouseX < buttonX + buttonWidth  && mouseY > buttonY && mouseY < buttonY + buttonHeight) {
      scren = screns.MENU;
    }
}
}
void keyPressed() {
  if(scren == screns.GAME) {
    if (keyCode == LEFT) {
      currentPiece.moveLeft();
    } else if (keyCode == RIGHT) {
      currentPiece.moveHight();
    } else if (keyCode == DOWN) {
      currentPiece.moveAllDown();
      counter = speed;
    } else if (keyCode == ' ') {
      currentPiece.rotate();
    }
  }
}
void mostrarRegras() {
  image(imgConfig, 0, 0); // Desenhe a imagem de configuração como fundo
  fill(255); // Defina a cor do texto como branco
  textAlign(CENTER);
  textSize(20);
  text("HISTÓRIA", width/2 + 10, 100); // Título da história
  textSize(14);
  // Texto da história
  text("Bob, um Construtor de Matriz, é convoca-\ndo para salvar Tetraland do caos.", width/2 + 10, 120);
  text("Ele deve reconstruir o Coração da Matriz, \numa estrutura mágica que mantém o \nequilíbrio do mundo digital,", width/2 + 10, 160);
  text("usando Tetrominos, enquanto enfrenta a \nameaça da Desorganização liderada \npor erro.", width/2 + 10, 220);
  text("Ao restaurar a harmonia, ele é celebrado \ncomo o herói de Tetraland.", width/2 + 10, 280);
  
  // Título dos controles
  textSize(20);
  text("CONTROLES", width/2 + 10, 330); // Título dos controles
  // Texto dos controles
  textSize(14);
  text("Setas direcionais: Movem o Tetromino \npara a esquerda ou direita.", width/2 + 10, 350);
  text("Barra de espaço: Realiza a rotação do\n Tetromino.", width/2 + 10, 380);
  text("Tecla de queda rápida (seta para baixo): \n Faz o Tetromino cair instantaneamente  \naté a base.", width/2 + 10, 410);
}

void mostrarCreditos() {
  image(imgCredito, 0, 0); // Desenhe a imagem de configuração como fundo
  fill(255); // Defina a cor do texto como branco
  textSize(20);
  textAlign(CENTER);
  text("", width/2 + 10, 50); // Ajuste de posição com deslocamento para a direita
  textSize(14);
  text("Desenvolvido por: \nBruno Bilhar Karaziack, \nDaniel de Oliveira Domingos, \nMurilo Luciano dos Santos, \nTomaz de Aquino Ribeiro Junior.", width/2 + 10, 100);
  text("Ano de Criação: 2024.\nInspiração: Tetris, \n(criado por Alexey Pajitnov)", width/2 + 10, 410);
  // Adicione mais créditos aqui, se necessário
}
