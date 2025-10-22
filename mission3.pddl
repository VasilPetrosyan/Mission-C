(define (problem lunar-mission-3)
    (:domain lunar-extended)

     (:objects
        
        wp1 - waypoint
        wp2 - waypoint
        wp3 - waypoint
        wp4 - waypoint
        wp5 - waypoint
        wp6 - waypoint

        r1 - robot
        r2 - robot
        l1 - lander
        l2 - lander

        Alice - astronaut
        Bob - astronaut
    )

    (:init
        ;defining the map 
        (connectedpos wp1 wp2)
        (connectedpos wp2 wp1)
        (connectedpos wp2 wp4)
        (connectedpos wp4 wp2)
        (connectedpos wp2 wp3)
        (connectedpos wp3 wp5)
        (connectedpos wp5 wp3)
        (connectedpos wp5 wp6)
        (connectedpos wp6 wp4)
        ;the physical storage of robots is empty at the start 
        (physicalStorage r1)
        (physicalStorage r2)
        ;the hard drive storage of robots is empty at the start 
        (storageEpmty r1)
        (storageEpmty r2)
        ;association between lander and robot
        (landerAssociatedRobot  r1 l1)
        (landerAssociatedRobot  r2 l2)

        ;the robot 2 and its lander 2 are undeployed at the start     
        (undeployedLanader l2)
        
        
      
        ;the robot 1 and its lander are deployed at WP2
        (deployedrob r1)
        (atLandingsite r1)
        (posrobot wp2 r1)
        (posland wp2 l1)
        
        ;the following predicates are used to describe the location of the astronouts 
        (atDockingbay Alice r1)
        (atControlroom Bob r2)
      

       

        
        
    )

    (:goal
        (and
           
            ; we must deploy r2 during the mission 
            (deployedrob r2)
            
           
            ;mission aims 
            (pictureCaptured  wp3)
            (scaned wp4)
            
            (pictureCaptured wp2)

            (scaned wp6)
         
            (collectSample wp5)
           
            (collectSample wp1)

            ; at the end of the mission the robots must have empty storge and be at the landning site 

            (physicalStorage r1)
            (physicalStorage r2)

            (atLandingsite r1)
            (atLandingsite r2)

            (storageEpmty r1)
            (storageEpmty r2)

           
        )
    )
)