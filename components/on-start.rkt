#lang racket

(require "../game-entities.rkt")
;(require "../components/after-time.rkt")
(require posn)

;(displayln "LOADING ON START")

(provide (except-out (struct-out on-start) on-start)
         (rename-out (make-on-start on-start)))

(component on-start (rule func))

(define (make-on-start #:rule [rule (λ (g e) #t)] func)
  (new-on-start rule func))

(define (update-on-start g e c)
  ;(displayln (list "UPDATING ON START" e))
  (define updated-ent (if ((on-start-rule c) g e)
                          ((on-start-func c) g e)
                          e))
  (remove-component
   updated-ent (is-component? c)))

(new-component on-start?
               update-on-start)