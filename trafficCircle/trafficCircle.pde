ArrayList<Car> cars;
float circum;
int numCars;
float maxvel = (2*PI)/350;
float minvel = 0.01;
float mindist;
boolean pressed = false;
float centerx;
float centery;




void setup() {
  size(950, 600);
  cars = new ArrayList<Car>();

  numCars = 50;
  float step = (2*PI)/numCars;
  float xrad = width/3.0;
  float yrad = height/3.0;
  circum = 2*PI*sqrt(((xrad*xrad) + (yrad+yrad))/2);
  mindist = 20.0;
  centerx = width/2.0;
  centery = height/2.0;
  for (float t = 0.0; t < 2*PI; t += step) {
    float vel = (2*PI)/random(360);
    if (vel > maxvel) vel = maxvel;
    cars.add(new Car(xrad*cos(t)+centerx, yrad*sin(t)+centery, vel, centerx, centery, xrad, yrad, t, color(255, 255, 255)));
  }
  cars.get(cars.size()-1).col = color(255, 200, 100);

  println(maxvel, minvel);
}

float angleBetweenTwoCars(Car cur, Car next) {
  float curdiff = centery-cur.yPos;
  float nextdiff = centery-next.yPos;
  if (curdiff == 0 || nextdiff == 0) println("ZERO");
  float angleBtwn = next.theta - cur.theta;
  if (curdiff > 0 && nextdiff < 0) {
    angleBtwn = next.theta + (2*PI - cur.theta);
  }
  return angleBtwn;
}

void draw() {
  background(0);
  fill(255);
  ellipse(width/2.0, height/2.0, 15, 15);
  stroke(255);
  line(0, height/2.0, width, height/2.0);
  line(width/2.0, 0, width/2.0, height);


  for (int i = 0; i < cars.size(); ++i) {
    Car cur = cars.get(i);
    Car next = cars.get((i+1)%cars.size());
    float angleBtwn = angleBetweenTwoCars(cur, next);
    float arcDistBtwn = circum/((2*PI)/angleBtwn);
    if (arcDistBtwn <= mindist) cars.get(i).vel = next.vel;
    else if (arcDistBtwn >= mindist*1.5) {
      cars.get(i).vel += 0.01;
      if (cur.vel >= cur.start_vel) cars.get(i).vel = cur.start_vel;
    }
    if (i == cars.size()-1) {
      if (pressed) {
        cars.get(i).vel -= 0.01;
        if (cars.get(i).vel < minvel) cars.get(i).vel = minvel;
      } else {
        cars.get(i).vel += 0.01;
        if (cars.get(i).vel > maxvel) cars.get(i).vel = maxvel;
        if (arcDistBtwn <= mindist) cars.get(i).vel = next.vel;
      }
    }
    //println(cars.get(i).vel, minvel);
    if (cars.get(i).vel <= minvel) {
      cars.get(i).col = color(255, 0, 0);
    } else cars.get(i).col = cur.start_col;
    cars.get(i).move();
    cars.get(i).display();
  }
}



void keyPressed() {
  if (keyCode == 32) pressed = true;
}

void keyReleased() {
  if (keyCode == 32) pressed = false;
}