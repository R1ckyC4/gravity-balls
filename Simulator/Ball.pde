class Ball{
    //system stuff
    
    float G = 1; 
    //gravitional constant, feel free to adjust. 
    //I will try to set the default value to a optimal one and make the simulation look right
    
    float speedLimit = 5; 
    //by spawning balls with mass and velocity out of thin air, 
    //system might not conserve energy and balls might go berserk
    
    
    float massLower = 150;
    float massUpper = 1000;

    //ball stuff
    PVector location;
    PVector velocity;
    PVector acceleration;
    color c;

    float mass;
    float radius;
    float elasticity; //decay factor for collision; set 1 for no effect
    float friction; // decay factor but to balance things out

    Ball(float x, float y, float xVel, float yVel){
        location = new PVector(x,y)
        velocity = new PVector(xVel, yVel)
        acceleration = new PVector(0,0)

        c = color(random(255),random(255),random(255))

        mass = random 
    }    



}