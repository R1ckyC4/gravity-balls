# gravity-balls
A gravity (maybe some bouncing) phyiscs simulation done in java processing. 
I hope to create a full physics engine in the future, but we all start somewhere.

#how this works: physics (nerd babble)
    After an apple fell onto Sir Issac Newton's Head, he formulated the equation F = Gmm/r^2 and F = ma. (nerd)
    We use the "mass" values of the balls and the distnaces between any two balls to determine the gravitiational force between the two. And we use F= ma to determine how fast the balls should accelerate. 

    Usually, this just leads to two balls accelerating directly towards each other in a straight line and then colliding. If we give the balls some initial velocity, we can observe cooler ellipical patterns. 
    If the parameters are just right and it fulfills the equation for circular centripital motion, F = mv^2 / r then you end up with an perfectly circular orbit. 


    The PVector library is used to represent and compute Vectors.
#How to use 
    Click run for simulation to run.
    Left click anywhere to spawn balls in. And watch!