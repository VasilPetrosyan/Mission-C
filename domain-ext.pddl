(define (domain lunar-extended)
   (:requirements :strips :typing)
    
    ; -------------------------------
    ; Types
    ; -------------------------------

    ; EXAMPLE

    ; (:types
    ;     parent_type
    ;     child_type - parent_type

    ; )
    (:types
        robot
        lander
        waypoint
        people
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------

    ; EXAMPLE

    ; (:predicates
    ;     (no_arity_predicate)
    ;     (one_arity_predicate ?p - parameter_type)
    ; )

    (:predicates
        (posrobot ?x - waypoint ?r - robot) ;predicte for position of the robot
        (posland ?x - waypoint ?la - lander) ;predicte for position of the lander

        (undeployedLnader ?l - lander); predicte to see if the lander is undeployed 

        
        (connectedpos ?x - waypoint ?y - waypoint); predicte to see if the positions x -> y

        (dataTransmited  ?r - robot) ; a predicte to see if the data has been transmitted by robot
        (pictureCaptured  ?l-waypoint) ;predicte to  for  pictures captured at waypoint l
        (scaned ?l-waypoint)  ; predicte for data scned at a waypoint 
        (collectSample ?x - waypoint) ;predicte for checking if sample collected at waypiont 
        (landerAssociatedRobot  ?r - robot ?l - lander) ; predicte for association between lander robot

        (deployedrob ?r - robot); predicte to see if the robot is depolyed 

        (storageEpmty ?r - robot);predicte to check storage empty for robot
        (physicalStorage ?r - robot);predicte to check physical storage is empty for robot
        

        (atLandingsite ?r) ;predicte to check if the robot is at the landing site 

        (movedawyfromlander ?r) ;a predicate used for moving away from the lander 
        
        ;two predicted for determining which robot took part at scaning or capturing at a given waypoint
        (scanedbyRobot ?l-waypoint ?r - robot)  
        (capturedbyRobot  ?l-waypoint ?r - robot)

        (atDockingbay ?p - people ?r - robot)
        (atControlroom ?p - people ?r - robot)
       
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    ; EXAMPLE

    ; (:action action-template
    ;     :parameters (?p - parameter_type)
    ;     :precondition (and
    ;         (one_arity_predicate ?p)
    ;     )
    ;     :effect 
    ;     (and 
    ;         (no_arity_predicate)
    ;         (not (one_arity_predicate ?p))
    ;     )
    ; )

   (:action moveFromLandingSite
        :parameters (?x - waypoint  ?y - waypoint ?r - robot )
        :precondition (and
            (posrobot ?x ?r)
            (connectedpos ?x ?y)
            (deployedrob ?r) ;robot must be deployed 
            (atLandingsite ?r) ;be at landng site 
            
        )
        :effect (and
            (not (posrobot ?x ?r)) ; the position of the robot is no longer the previous position 
            (posrobot ?y ?r)
            (not (atLandingsite ?r)) ;robot no longer at the landing site 
            (movedawyfromlander ?r); we have moved away from landing site 
           
        )
    )
    
    ;an action used to move robot from one waypont to another given robot has moved away from landing site 
    ;?x represents where the robot is currently at ?y is where the robot wants to go
    (:action movegeneral
        :parameters (?x - waypoint  ?y - waypoint ?r - robot)
        :precondition (and
            (posrobot ?x ?r)
            (connectedpos ?x ?y)
            (deployedrob ?r) ;robot must be deployed
            (movedawyfromlander ?r) ;robot moved away from landing site 
          
        )
        :effect (and
            (not (posrobot ?x ?r))
            (posrobot ?y ?r) 
           
        )
    )
    ;an action used to move the robot from waypoint x to the waypoint y where y is the position where the lander of the robot is 
    ;?x represents where the robot is currently at ?y is where the robot wants to go
    (:action moveToLanding
        :parameters (?x - waypoint  ?y - waypoint ?r - robot ?la - lander)
        :precondition (and
            (posrobot ?x ?r) 
            (connectedpos ?x ?y)
            (deployedrob ?r)
            (landerAssociatedRobot  ?r ?la) ;the lander and the robot at the position are associated  
            (posland ?y ?la)
            
        )
        :effect (and
            (not (posrobot ?x ?r))
            (posrobot ?y ?r)
            (atLandingsite ?r); the robot is in the landing site 
            (not (movedawyfromlander ?r))
        )
    )

     (:action movepersontoControl
        :parameters (?p - people  ?r - robot )
        :precondition (and
            (atDockingbay ?p ?r)
            
        )
        :effect (and
            (atControlroom ?p ?r)
            (not (atDockingbay ?p ?r))
           
        )
    )
    (:action movepersontoDocking
        :parameters (?p - people  ?r - robot )
        :precondition (and
            (atControlroom ?p ?r)
            
        )
        :effect (and
            (atDockingbay ?p ?r)
            (not (atControlroom ?p ?r))
           
        )
    )

   ;action used to deploy the robot and lander at a waypoint x from a lander 
    (:action deploy
        :parameters (?x - waypoint  ?r - robot ?l - lander ?p - people)
        :precondition (and
          
            (undeployedLnader ?l) ;the lander of the robot is undeployed thus we need to depoly it 
            (atDockingbay ?p ?r)
            
        )
        :effect (and
            (deployedrob ?r);robot is deployed 
            (posrobot ?x ?r)
            (landerAssociatedRobot ?l ?r);association is defined between robot and lander
            (posland ?x ?l) ;postion of the lander is defined 
            (not (undeployedLnader ?l)) ; the lander is no longer undeployed 
            (atLandingsite ?r) ; the robot is at the landing site 
            
        )
    )
    
    ;action used to capure an image at waypoint x by robot r
     (:action capture
        :parameters (?x - waypoint  ?r - robot )
        :precondition (and
            (posrobot ?x ?r) 
            (storageEpmty ?r) ;must have an empty storage
            (deployedrob ?r)
            
        )
        :effect (and
            (not (dataTransmited  ?r)); data has not been transmitted when we capture the image 
            (pictureCaptured ?x)
            (not(storageEpmty ?r)) ;the storgae is no loger empty 
            (capturedbyRobot  ?x ?r) 
        )
    )
    ;action used to scan an image at waypoint x by robot r and works very similar to capture 
    (:action scaner
        :parameters (?x - waypoint  ?r - robot )
        :precondition (and
           
            (posrobot ?x ?r)
            (storageEpmty ?r)
            (deployedrob ?r)
           
        )
        :effect (and
            
            (scaned  ?x)
            (not(storageEpmty ?r))
            (not (dataTransmited  ?r))
            (scanedbyRobot  ?x ?r)
        )
    )

   ;action used to transmit  images by the robot at waypoint w
    (:action transmitImage
        :parameters (?r - robot  ?w - waypoint ?p - people)
        :precondition (and
           ; the robot is deployed and at position of the image capured 
           (posrobot ?w ?r) 
           (capturedbyRobot  ?w ?r)
           (deployedrob ?r)
           (atControlroom ?p ?r)
        )
        :effect (and
            ;data is transmited and storgage is empty
            (dataTransmited ?r)
            (storageEpmty ?r)
         
        )
    )
    ;action used to transmit scans  by the robot at waypoint w
     (:action transmitScan
        :parameters (?r - robot  ?w - waypoint ?p - people)
        :precondition (and
        ;the robot is deployed and at position of the scan 
           (posrobot ?w ?r)
           (deployedrob ?r)
           (scanedbyRobot  ?w ?r)
           (atControlroom ?p ?r)
        )
        :effect (and
           ;data is transmited and storgage is empty
            (dataTransmited ?r)
            (storageEpmty ?r)
           
        )
    )

    (:action sampleCollecton
        :parameters (?x - waypoint  ?r - robot )
        :precondition (and
            
           (posrobot ?x ?r)
           (physicalStorage ?r); physical storage must be empty 
           (deployedrob ?r) 
           
        )
        :effect (and
            
            (collectSample ?x) ; sample has been collected at waypoint x
            (not (physicalStorage ?r)) ;pysical storage is no longer empty 
           
        )
    )

    ; an action used to drop off sample at waypoint x by robot r that is associated to lander la
      (:action dropoffsample
        :parameters (?x - waypoint  ?r - robot ?la - lander ?p - people)
        :precondition (and

           ;must be depoloyed and at the landing site 
            (deployedrob ?r) 
            (atLandingsite ?r)
            (posrobot ?x ?r)
            (atDockingbay ?p ?r)
            
        )
        :effect (and
            (physicalStorage ?r);pysical storage is now empty 
           
            
            
        )
    )

)