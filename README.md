# gravity-balls
A gravity (maybe some bouncing) phyiscs simulation done in java processing. 
I hope to create a full physics engine in the future, but we all start somewhere.

# requirements
You will need to use Java processing to run this simulation (its free :)
[java Processing] (https://processing.org/download)

# how this works: physics (nerd babble)
    After an apple fell onto Sir Issac Newton's Head, he formulated the equation F = Gmm/r^2 and F = ma. (nerd)
    We use the "mass" values of the balls and the distnaces between any two balls to determine the 
    gravitiational force between the two. And we use F= ma to determine how fast the balls should accelerate. 

    Usually, this just leads to two balls accelerating directly towards each other in a straight 
    line and then colliding. If we give the balls some initial velocity, we can observe cooler ellipical patterns. 
    If the parameters are just right and it fulfills the equation for circular centripital motion, F = mv^2 / r 
    then you end up with an perfectly circular orbit. 


    The PVector library is used to represent and compute Vectors.

    The momentum equation nets us the velocity of a ball after an collsion. If two balls are to merge after a collision, 
    then that will be represented by an inelastic euqation. 
    However, if it is to shatter, then the left over KE from the collision that is needed to overcome 
    the binding energy can be used. That should be equal to the sum of the KE of the new fragments.  
# How to use 
    Click run for simulation to run. (in the IDE)
    Left click anywhere to spawn balls in. And watch!
    
    Right click to use your cursor as a gravity well, shift + right click to make it negative mass for dispersion. 


