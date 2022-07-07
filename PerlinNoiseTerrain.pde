int cols , rows;
//scale
int scl = 20;
int w = 2000;
int h = 1600;
  
float flying = 0;
 
float[][] terrain;

void setup() {
  
  size(600,600,P3D);
  
  //assim a quantidade de quadrados cabem exatamente dentro da nossa tela
  cols = w/scl;
  rows = h/scl;
  
  terrain = new float[cols][rows];
  
  
}

void draw() { 
  
  flying -= 0.1;
  
  float yoff = flying;
  for(int y = 0; y < rows; y++){
     float xoff = 0;
    for(int x = 0; x < cols; x++){
      terrain[x][y] = map(noise(xoff,yoff),0,1,-100,100);
      xoff +=0.2;
    }
    yoff +=0.2;
  }
  
  background(0);
  stroke(255);
  noFill();
  
  //rotacionando para uma perspectiva de terreno na horizontal e vem de vertical...
  //+50 é pra jogar um pouco pra baixo
  translate(width/2 , height/2 +50);
  rotateX(PI/3);
  //nosso offset esta no meio da tela , porém os quadrados começam na posição 0 que é o...
  //meio da tela , entao jogamos tudo metade da tela pro lado pra encaixar os quadrados e eles nao ficarem no meio.
  translate(-w/2 , -h/2);
  
    for(int y = 0; y < rows -1; y++){
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++){        
      
        vertex(x*scl , y*scl , terrain[x][y]);
        //assim , vai criar uma vertex na posição y de baixo que seria no caso 0*20 = 0 ...
        //y+1 = 0+1*20 = 20;... depois ,  1+1*20 = 40 enquanto vertex y de cima é 20;
        vertex(x*scl , (y+1)*scl, terrain[x][y+1]);
        
      //Coordenada de 20 em 20 , e como o tamanho do quadrado é 20 , entao cada quadrado
      //é distanciado em 20 
        //*rect(x*scl , y*scl , scl , scl);
    }
    endShape();
  }


}