ArrayList<Ball> ballList;

float maxSpeed = 8; //spawn max speed, not system max

float wellMass = 5000; // for later goofy if you want to use your mouse as a gravity well. 

boolean trails = false;

int W = 1280;
int H = 720;

float largestMass = 0;
void settings(){
    size(W,H);
}
void setup(){
    ballList = new ArrayList<Ball>();
    
}
void draw(){

    if (trails){
        fill(173, 216,230, 67);
        noStroke();
        rect(0,0,width,height);
    }
    else{background(173, 216, 230);}
    Ball mouseWell = null;

    //Right click for grav
    if (mousePressed && (mouseButton == RIGHT) && !keyPressed){
        mouseWell = new Ball(mouseX, mouseY, 0,0);
        mouseWell.mass = wellMass;
    }
    //right shift click for anti grav, which is disperse

    if (mousePressed && (mouseButton == RIGHT && keyCode == SHIFT)){
        mouseWell = new Ball(mouseX, mouseY, 0,0);
        mouseWell.mass = wellMass * -1; //equations should hold up i hope
    }
    //for mouse grav
    for (int i = 0; i < ballList.size(); i++){
        Ball b = ballList.get(i);
        if(b.dead) {continue;}

        //update largestMass tracker

        if (b.mass > largestMass) {largestMass = b.mass;}

        if (mouseWell != null){
            mouseWell.attract(b);
        }
        //ball to ball grav
        for(int j = 0; j < ballList.size(); j++){
            if (i != j){
                Ball other = ballList.get(j);
                if (other.dead) {continue;}
                b.attract(other);
                if (b.collideCheck(other)){
                    b.collision(other);
                }
            }
        }
    b.move();
    b.bounce();
    b.display();
    }
    for (int i = ballList.size() - 1; i >= 0; i--){
        if (ballList.get(i).dead){
            ballList.remove(i);
        }
    }
    //clean 
    //UI
    fill(173, 216, 230);
    noStroke();
    rect(0, 0, width, 40);
    fill(0);
    textSize(16);

    String gravityStatus;
    if(mouseWell != null){
        gravityStatus = "Active";
} else{gravityStatus = "Off";}
    text("Left Click to Spawn Ball | Right Click (Gravity) add shift for anti grav [" + gravityStatus + "] | r : Reset | e for trails | t for particle collider :)"  , 20, 30);
    text("Balls: " + ballList.size() + " | Largest Ball: " + int(largestMass), 20, 50);
}
void mousePressed(){
    if (mouseButton == LEFT){
        ballList.add(new Ball(mouseX, mouseY, random(-1 * maxSpeed, maxSpeed), random(-1 * maxSpeed, maxSpeed)));
    }
}
void keyPressed(){
    if (key == 'r' || key == 'R'){
        ballList.clear();
        largestMass = 0;
        background(173, 216, 230);
    }
    if ( key == 't' || key == 'T'){
        tester();
    }
    if (key == 'e' || key == 'E'){
        trails = !trails;
        if (!trails) {background(173,216,230);} 
    }
}

void tester(){ // this method will be used to spawn 2 balls to collide to try and fix the shatter() method
        Ball t1 = new Ball( W/4, H/2, 10, 0);
        t1.mass = 300;
        Ball t2 = new Ball(3 * (W/4), H/2, -10, 0);
        t2.mass = 300;

        ballList.add(t1);
        ballList.add(t2);
        
    }

