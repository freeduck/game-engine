#lang racket

(require rackunit 
         "../main.rkt"
         "./util.rkt")

(test-case "Create/Read/Update/Destroy component"
  
           (define-component health (amount))

           (define no-health (entity))
           (define h (health 5))

           (define e (add-component no-health h))

           (check-not-false
             (get-component e health?))

           (define e-with-more-health (update-component e health? 
                                                        (curryr update:health/amount add1)))

           (check-equal?
             (read:health/amount e-with-more-health)
             6)

           (define no-health-again (remove-component e h))
           
           (check-false
             (get-component no-health-again health?)))




(test-case "Add/Remove entity from game"
   (define bullet (entity))

   (define e (entity (health 5 
                             #:update 
                             (add-component^ (spawner bullet)))))         

   (define g0 (game e))
   (define g1 (tick g0))
   (define g2 (tick g1))
   (define g3 (tick g2))

   (check-equal?
     (length (game-entities g0))
     1)

   (check-equal?
     (length (game-entities g1))
     2)
   
   (check-equal?
     (length (game-entities g2))
     3) 

   (check-equal?
     (length (game-entities g3))
     4) 
   )

