import peasy.*;
PeasyCam cam;

String [] move = {"u", "d", "r", "l", "b", "f"};
String scramble = "";
int counter = 0;
boolean startScramble = false;
boolean backScramble = false;

int dim = 3;
Cubit [] cube = new Cubit[dim*dim*dim];
void setup() {
  getScramble();
  size(600, 600, P3D);
  int index = 0;
  cam = new PeasyCam(this, 400 );
  for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
      for (int z = -1; z <= 1; z++) {
        PMatrix3D matrix = new PMatrix3D();
        matrix.translate(x, y, z);
        cube[index] = new Cubit(matrix, x, y, z);
        index++;
      }
    }
  }
}

void rotate_Z(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Cubit cb = cube[i];
    if (cb.z == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(HALF_PI*dir);
      matrix.translate(cb.x, cb.y);
      cb.update(round(matrix.m02), round(matrix.m12), cb.z);
      cb.turnFacesZ(dir);
    }
  }
}

void rotate_X(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Cubit cb = cube[i];
    if (cb.x == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(HALF_PI*dir);
      matrix.translate(cb.y, cb.z);
      cb.update(cb.x, round(matrix.m02), round(matrix.m12));
      cb.turnFacesX(dir);
    }
  }
}

void rotate_Y(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Cubit cb = cube[i];
    if (cb.y == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(HALF_PI*dir);
      matrix.translate(cb.x, cb.z);
      cb.update(round(matrix.m02), cb.y, round(matrix.m12));
      cb.turnFacesY(dir);
    }
  }
}
void getScramble()
{
  int ran = 0;
  for (int i = 0; i < 20; i++)
  {
    int index = int(random(move.length));
    ran++;
    if (ran < 2)
    {
      scramble = scramble + move[index];
    } else
    {
      scramble = scramble + move[index].toUpperCase();
      ran = 0;
    }
  }
  println(scramble);
}

void keyPressed()
{
  applyMove(key);
}

void applyMove(char sc)
{
  switch(sc)
  {

  case ' ':
    if(counter == 0)
      startScramble = true;
    else if (counter == 20)
    {
      backScramble = true;
    }
    break;
    
  case 'L':
    rotate_X(-1, 1);
    break;
  case 'l':
    rotate_X(-1, -1);
    break;
  case 'r':
    rotate_X(1, 1);
    break;
  case 'R':
    rotate_X(1, -1);
    break;
  case 'u':
    rotate_Y(-1, 1);
    break;
  case 'U':
    rotate_Y(-1, -1);
    break;
  case 'D':
    rotate_Y(1, 1);
    break;
  case 'd':
    rotate_Y(1, -1);
    break;
  case 'f':
    rotate_Z(1, 1);
    break;
  case 'F':
    rotate_Z(1, -1);
    break;
  case 'B':
    rotate_Z(-1, 1);
    break;
  case 'b':
    rotate_Z(-1, -1);
    break;
  }
}

void draw() {

  if (startScramble == true)
  {
    if (frameCount%2 == 1)
    {
      if ((counter < scramble.length() ) && backScramble == false)
      {
        applyMove(scramble.charAt(counter));
        counter++;
        println("Counter = " + counter);
      } else if (backScramble == true)
      {
        if (counter != 0)
        {
          String temp = "" + scramble.charAt(counter-1);
          if (temp.equals(temp.toUpperCase()))
          {
            temp = temp.toLowerCase();
          } else
          {
            temp = temp.toUpperCase();
          }
          applyMove(temp.charAt(0));
          counter--;
        } else if (counter == 0)
        {
          startScramble = false;
          backScramble = false;
        }
      }
    }
  }
  scale(50);
  background(51);
  for (int i = 0; i < cube.length; i++) {
    cube[i].show();
  }
}
