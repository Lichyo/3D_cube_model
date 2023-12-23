class Cubit
{
  float x = 0;
  float y = 0;
  float z = 0;
  PMatrix3D matrix;
  color colors;
  Face [] faces = new Face[6];


  Cubit(PMatrix3D matrix, float x, float y, float z)
  {
    faces [0] = new Face(new PVector(0, 0, 1), color(0, 255, 0));    // green front
    faces [1] = new Face(new PVector(0, 0, -1), color(0, 0, 255));    // blue back
    faces [2] = new Face(new PVector(0, 1, 0), color(255, 255, 0));  // white up
    faces [3] = new Face(new PVector(0, -1, 0), color(255, 255, 255));  // yellow down
    faces [4] = new Face(new PVector(1, 0, 0), color(255, 0, 0));    // orange
    faces [5] = new Face(new PVector(-1, 0, 0), color(255, 150, 0));    // red
    this.matrix = matrix;
    this.x = x;
    this.y = y;
    this.z = z;
  }

  // update the data after rotate
  void update(float x, float y, float z) {
    matrix.reset();
    matrix.translate(x, y, z);
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void show()  // print on screen
  {
    //noFill();
    stroke(1);
    strokeWeight(0.1);
    pushMatrix();
    applyMatrix(matrix);  // hold all matrix data in here
    for (int i = 0; i < 6; i++) {
      faces[i].show();
    }
    popMatrix();
  }
  
   void turnFacesZ(int dir) {
    for (Face f : faces) {
      f.rotateFaceZ(dir*HALF_PI); 
    }
  }

  void turnFacesY(int dir) {
    for (Face f : faces) {
      f.rotateFaceY(dir*HALF_PI); 
    }
  }

    void turnFacesX(int dir) {
    for (Face f : faces) {
      f.rotateFaceX(dir*HALF_PI); 
    }
  }
}
