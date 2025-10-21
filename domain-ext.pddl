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
        (pos ?x - waypoint ?r - robot);currect pos of rover
        (posland ?x - waypoint ?la - lander)

        (undeployed ?l - lander)

        ;(robotlander ?r - robot ?la - lander)
        (connectedpos ?x - waypoint ?y - waypoint) ;conectivity
        (dataTransmited  ?r - robot) ;transmitted 
        (dataCapture  ?l-waypoint);captured data 
        (scan ?l-waypoint)  
        (collectSample ?x - waypoint)
        (landerRobot  ?r - robot ?l - lander)

        (deployed ?r - robot)
        (collection ?r - robot)
        (storageEpmty ?r - robot)
        (physicalStorage ?r - robot)

        (atLandingsite ?r - robot)

        (movedawy ?r - robot)

        (atDockingbay ?p - people ?r - robot)
        (atControlroom ?p - people ?r - robot)
        (collected ?r - robot)
        ;(robotAtpos ?x)
        ;)
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

    (:action move
        :parameters (?x - waypoint  ?y - waypoint ?r - robot )
        :precondition (and
            (pos ?x ?r)
            (connectedpos ?x ?y)
            (deployed ?r)
            (atLandingsite ?r)
            ;(posland ?x ?la)
           ; (not (atLandingsite ?r))
           ; (robotAtpos ?x)
        )
        :effect (and
            (not (pos ?x ?r))
            (pos ?y ?r)
            (not (atLandingsite ?r))
            (movedawy ?r)
           ; (not(robotAtpos ?x))
           ; (robotAtpos ?y)
        )
    )
    
    (:action movegen
        :parameters (?x - waypoint  ?y - waypoint ?r - robot)
        :precondition (and
            (pos ?x ?r)
            (connectedpos ?x ?y)
            (deployed ?r)
            (movedawy ?r)
            ;(atLandingsite ?r)
           ; (not (atLandingsite ?r))
           ; (robotAtpos ?x)
        )
        :effect (and
            (not (pos ?x ?r))
            (pos ?y ?r)
            ;(not (atLandingsite ?r))
           ; (not(robotAtpos ?x))
           ; (robotAtpos ?y)
        )
    )
   
    (:action moveerop
        :parameters (?x - waypoint  ?y - waypoint ?r - robot ?la - lander)
        :precondition (and
            (pos ?x ?r)
            (connectedpos ?x ?y)
            (deployed ?r)
            (landerRobot  ?r ?la)
            (posland ?y ?la)
            
        )
        :effect (and
            (not (pos ?x ?r))
            (pos ?y ?r)
            ;(not (atLandingsite ?r))
            (atLandingsite ?r)
           
        )
    )

     (:action moveperson
        :parameters (?p - people  ?r - robot )
        :precondition (and
            (atDockingbay ?p ?r)
            
        )
        :effect (and
            (atControlroom ?p ?r)
            (not (atDockingbay ?p ?r))
           
        )
    )
    (:action movepersonel
        :parameters (?p - people  ?r - robot )
        :precondition (and
            (atControlroom ?p ?r)
            
        )
        :effect (and
            (atDockingbay ?p ?r)
            (not (atControlroom ?p ?r))
           
        )
    )

    (:action deploy
        :parameters (?x - waypoint  ?r - robot ?l - lander ?p - people)
        :precondition (and
            ;(not(deployed ?r))
            ;(landerRobot ?l ?r)
            ;(not )
            (undeployed ?l)
            (atDockingbay ?p ?r)
            ;(atControlroom ?p  ?r )
            ;(landerRobot ?l ?r)
            
        )
        :effect (and
            (deployed ?r)
            (pos ?x ?r)
            (landerRobot ?l ?r)
            (posland ?x ?l)
            (not (undeployed ?l))
            (atLandingsite ?r)
            ;(not(robotAtpos ?x))
            ;(robotAtpos ?x)
            ;(robotlander ?r ?l)
        )
    )
    
     (:action capture
        :parameters (?x - waypoint  ?r - robot )
        :precondition (and
            (pos ?x ?r)
            (storageEpmty ?r)
            (deployed ?r)
            ;(robotAtpos ?x)
            ;(not(dataCapture ?x))
        )
        :effect (and
            
            (dataCapture ?x)
            (not(storageEpmty ?r))
        )
    )
    (:action scaner
        :parameters (?x - waypoint  ?r - robot )
        :precondition (and
           
            (pos ?x ?r)
            (storageEpmty ?r)
            (deployed ?r)
            ;(not (scan  ?x))
        )
        :effect (and
            
            (scan  ?x)
            (not(storageEpmty ?r))
        )
    )

    (:action transmit
        :parameters (?r - robot ?p - people)
        :precondition (and
           ;( not(storageEpmty ?r) )
           (deployed ?r)
           (atControlroom ?p ?r)
        )
        :effect (and
            
            (dataTransmited ?r)
            (storageEpmty ?r)
        )
    )

    (:action sampleCollecton
        :parameters (?x - waypoint  ?r - robot )
        :precondition (and
            
           (pos ?x ?r)
           (physicalStorage ?r)
           (deployed ?r) 
           ;(not (collectSample ?x))
        )
        :effect (and
            
            (collectSample ?x)
            (collection ?r)
            (not (physicalStorage ?r))
        )
    )

      (:action dropoffsample
        :parameters (?x - waypoint  ?r - robot ?la - lander ?p - people)
        :precondition (and
            ;(not (physicalStorage ?r))
            (deployed ?r)
            ;(pos ?x ?r)
            ;(posland ?x ?la)
            ;(landerRobot ?la ?r)
            (atLandingsite ?r)
            (atDockingbay ?p ?r)
        )
        :effect (and
            (physicalStorage ?r)
            ;(landingSite ?r ?la)
            ;(atLandingsite ?r)
        )
    )

)