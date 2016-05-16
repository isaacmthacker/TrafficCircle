class Car {
  float xPos;
  float yPos;
  float vel;
  float start_vel;
  float center_x;
  float center_y;
  float x_rad;
  float y_rad;
  float theta;
  color col;
  color start_col;



  Car(float x, float y, float v, float cx, float cy, float xr, float yr, float t, color c) {
    xPos = x;
    yPos = y ;
    vel = v;
    start_vel = v;
    center_x = cx;
    center_y = cy;
    x_rad = xr;
    y_rad = yr;
    theta = t;
    col = c;
    start_col = c;
  }

  void move() {
    theta += vel;
    if (theta > 2*PI) theta -= 2*PI;
    xPos = x_rad*cos(theta) + center_x;
    yPos = y_rad*sin(theta) + center_y;
  }

  void display() {
    fill(col);
    ellipse(xPos, yPos, 10, 10);
    //textSize(30);
    //text(theta, xPos, yPos);
  }
}