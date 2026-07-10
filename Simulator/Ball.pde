class Ball{
    //system stuff
    
    float G = 6.0/7; 
    //gravitional constant, feel free to adjust. 
    //I will try to set the default value to a optimal one and make the simulation look right
    
    float speedLimit = 100; 
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
    float elasticity = 1 ; //decay factor for collision; set 1 for no effect
    float friction = .99; // decay factor but to balance things out

    Ball(float x, float y, float xVel, float yVel){
        location = new PVector(x,y);
        velocity = new PVector(xVel, yVel);
        acceleration = new PVector(0,0);

        c = color(random(255),random(255),random(255));

        mass = random(massLower, massUpper);
        //scale area to the mass.
        
        radius = pow(mass, 1.0/2.0) / 3.14;

    }    

    void move(){
        velocity.add(acceleration);
        location.add(velocity);
        velocity.limit(speedLimit);
        velocity.mult(friction);
        acceleration.mult(0);

    }

    void bounce(){
        if(location.x > width){
            velocity.x *= -1 * elasticity;

        }
        if(location.x < 0){
            velocity.x *= -1 * elasticity;
        }

        if (location.y > height){
            velocity.y *= -1 * elasticity;
        }
        if (location.y < 0){
            velocity.y *= -1 * elasticity;
        }    
    }

    void applyForce(PVector force){
        PVector f = PVector.div(force, mass); // a = F/m
        acceleration.add(f);
    }
    void attract(Ball other){
        PVector force = PVector.sub(this.location, other.location);
        float d = force.mag();

        //constrain distance so that force doesn't approach infinity when distance approachs 0
        d = constrain(d,this.radius + other.radius,100.0);

        force.normalize();

        float strength = (G * this.mass * other.mass) / (d * d);

        force.mult(strength);
        other.applyForce(force);
    }

    void display() {
        stroke(1);
        strokeWeight(2);
        fill(c);

        ellipse(location.x, location.y, radius * 2, radius * 2);

    }

}