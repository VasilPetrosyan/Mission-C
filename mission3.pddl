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
        Alice - people
        Bob - people
    )

    (:init
        (connectedpos wp1 wp2)
        (connectedpos wp2 wp1)
        (connectedpos wp2 wp4)
        (connectedpos wp4 wp2)
        (connectedpos wp2 wp3)
        (connectedpos wp3 wp5)
        (connectedpos wp5 wp3)
        (connectedpos wp5 wp6)
        (connectedpos wp6 wp4)
        
        (physicalStorage r1)
        (physicalStorage r2)

        (storageEpmty r1)
        (storageEpmty r2)
        
        (landerRobot  r1 l1)
        (landerRobot  r2 l2)

        (pos wp2 r1)
        (posland wp2 l1)

        (not (deployed r2))
        
        (undeployed l2)
        
        (atDockingbay Alice r1)

        

        (atControlroom Bob r2)
        ;(atDockingbay Bob r2)

        
        ;lan

        ;(not (deployed r2))

        (deployed r1)
        (not(undeployed l1))

        (atLandingsite r1)
        
    )

    (:goal
        (and
            (deployed r2)
            (dataCapture  wp3)
            (scan wp4)
            
            (dataCapture wp2)

            (scan wp6)

            (collectSample wp5)
            
            (collectSample wp1)

            (physicalStorage r1)
            (physicalStorage r2)

            (posland wp2 l1)

            (atLandingsite r1)

            (atLandingsite r2)

            (storageEpmty r1)
            (storageEpmty r2)

           
        )
    )
)