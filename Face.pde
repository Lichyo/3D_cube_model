class Face {
  PVector normal;
  color colors;

  Face (PVector normal, color colors) {
    this.normal = normal;
    this.colors = colors;
  }

  void rotateFaceZ(float angle) {
    PVector v2 = new PVector();
    v2.x = round(normal.x * cos(angle) - normal.y * sin(angle));
    v2.y = round(normal.x * sin(angle) + normal.y * cos(angle));
    v2.z = round(normal.z);
    normal = v2;
  }

  void rotateFaceY(float angle) {
    PVector v2 = new PVector();
    v2.x = round(normal.x * cos(angle) - normal.z * sin(angle));
    v2.z = round(normal.x * sin(angle) + normal.z * cos(angle));
    v2.y = round(normal.y);
    normal = v2;
  }

  void rotateFaceX(float angle) {
    PVector v2 = new PVector();
    v2.y = round(normal.y * cos(angle) - normal.z * sin(angle));
    v2.z = round(normal.y * sin(angle) + normal.z * cos(angle));
    v2.x = round(normal.x);
    normal = v2;
  }
  
  void show() {
    pushMatrix();
    fill(colors);
    stroke(1);
    strokeWeight(0.1);
    rectMode(CENTER);

    // from Z to color X , Y
    translate(0.5 * normal.x, 0.5 * normal.y, 0.5 * normal.z);
    if (abs(normal.x) > 0)
    {
      rotateY(HALF_PI);
    } else if (abs(normal.y) > 0)
    {
      rotateX(HALF_PI);
    }
    square(0, 0, 1);
    popMatrix();
  }
}
