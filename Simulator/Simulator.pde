ArrayList<Ball> ballList;

float maxSpeed = 20; //spawn max speed, not system max

float wellMass = 5000; // for later goofy if you want to use your mouse as a gravity well. 

void setup(){
    size(1280, 720);
    ballList = new ArrayList<Ball>();
    
}
void draw(){
    background(173, 216, 230);
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
    fill(0);
    textSize(16);

    String gravityStatus;
    if(mouseWell != null){
        gravityStatus = "Active";
} else{gravityStatus = "Off";}
    text("Left Click to Spawn Ball | Right Click (Gravity) add shift for anti grav [" + gravityStatus + "] | r : Reset"  , 20, 30);

}
void mousePressed(){
    if (mouseButton == LEFT){
        ballList.add(new Ball(mouseX, mouseY, random(-1 * maxSpeed, maxSpeed), random(-1 * maxSpeed, maxSpeed)));
    }
}
void keyPressed(){
    if (key == 'r' || key == 'R'){
        ballList.clear();
    }
}

