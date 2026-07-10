class Ball{
    //system stuff
    
    float G = 6.7/10; 
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
    float elasticity = 1.01 ; //decay factor for collision; set 1 for no effect
    float friction = .999; // decay factor but to balance things out
    float bindingConstant =1; //constant to tune the KE needed to shatter apart planets

    boolean dead = false; //if true, then the loop will delete it 

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
    boolean collideCheck(Ball other){
        float r1 = this.radius;
        float r2 = other.radius;
        float rTotal = r1 + r2;
        float xDist = abs(this.location.x - other.location.x);
        float yDist = abs(this.location.y - other.location.y);
        float dist = pow((xDist * xDist) + (yDist * yDist), 1.0/2);
        if(dist <= rTotal){ return true;}
        else{return false;}
    }
    void collision(Ball other){
        float massRatio = max(this.mass, other.mass) / min(this.mass, other.mass);
        PVector normal = PVector.sub(this.location, other.location);
        normal.normalize();

        float v1n = this.velocity.dot(normal);
        float v2n = other.velocity.dot(normal);
        float relativeNormSpeed = abs(v2n - v1n);

        float KE = (0.5 * this.mass * v1n * v1n) + (0.5 * other.mass * v2n * v2n);
        
        float bindingEnergy = (this.mass + other.mass) * bindingConstant;
        //three cases
        // similar size, and the KE is high then, they shatter each other
                //similar size, KE is low then they merge
            if(massRatio < 2){
                if(KE > bindingEnergy){
                    this.shatter();
                    other.shatter();
                } else{this.merge(other);}
            }
            else{
                if (this.mass > other.mass){ this.merge(other);}
                else{other.merge(this);}
        //big size diff, they merge            
        
    }
}


    void shatter(){
        int fragments = int(random(2,5));
        float fragMass = this.mass / fragments;

        // if the shattered mass is much less than the min mass, then we assume it to vaporize :)
        if (fragMass > massLower * .5) {
            for (int i =0; i < fragments; i++){
                Ball frag = new Ball(
                    this.location.x + random(-radius, radius),
                    this.location.y + random(-radius, radius),
                    this.velocity.x + random(-5,5),
                    this.velocity.y + random (-5,5)
                );
                frag.mass = fragMass;
                frag.radius = pow(fragMass, 1.0/2.0) / 3.14;

                ballList.add(frag);
            }
        }

    }
    void merge(Ball other){
        //conserve momentum using p = mv

        PVector newVel = PVector.add(PVector.mult(this.velocity, this.mass), PVector.mult(other.velocity, other.mass));
        float newMass = this.mass + other.mass;
        newVel.div(newMass);

        //bigger absorve small

        this.mass = newMass;
        this.radius = pow(newMass, 1.0/2.0) / 3.14;
        this.velocity = newVel;

        other.dead = true;
    }
    void display() {
        stroke(1);
        strokeWeight(2);
        fill(c);

        ellipse(location.x, location.y, radius * 2, radius * 2);

    }

}