#lang racket

(require "../../core/main.rkt")


;A component that wraps a single sprite id
;  there's no animation at this component's level.
;  It can be used to create animation systems with more complex
;  components.
(define-component sprite (id))  ;Can add things like tint, offset, extra scale, extra rotation, etc. laster

;Whenever you construct a new sprite, it ends up in the
; insertion queue, along with its id.  This is the last step
; before we throw the image away (to the gcard) and refer to it only by id.
(define insertion-queue '())  ;Holds images, Gets emptied
(define seen-sprite-ids '())  ;Doesn't hold images, Doesn't get emptied

(define (seen? i)
  (member i seen-sprite-ids))

(define/contract (make-sprite i)
  (-> image? sprite?)

  (define id (image->id i))  ;This is one operation that may be slow at runtime, and it'll happen for any sprite constructed at runtime.  We should probably throw some kind of warning if we detect a sprite getting created at runtime.

  (set! insertion-queue (cons (list id i)
                              insertion-queue))

  (when (not (seen? i))
    (set! seen-sprite-ids (cons i seen-sprite-ids)))

  (sprite id))

(define (get-queued-sprites) insertion-queue)

;Is this where we tie in the mode-lambda stuff??
;When do things get added to the sprite database?
;What queries will need to be made to it?

(define sprite-db (list))

;Can happen at runtime...
(define (insert-sprite s)
  42 ;Return id??
  )

(define (get-id s)
  
  42)





;Under this rendering semantics:
;  Every entity that you want rendered should have
;   1) one or more animated-sprite components, each of which will respond to a (render ...) call with a sprite id.  
;   2) a position component 
;   2) a size component
;   3) [later?] a scale component
;   4) [later?] a rotation component
;   5) [later?] a layer component

;On every tick, the rendering system will look at the collection of entities with animated sprites.  Let's call that es:

; entities will be rendered as if sorted by layer, and then by order of animated sprites on the entity.  their position will be translated to screen coordinates according to some parameterizable scalar factor. 
; the width and height of the draw area will be determined by the size of the game's bounding box on the first tick.  It should not change after that. 

;As for sprites, I'd like to try to minimize memory usage.  One option is to make the user register all the sprite up front, then reference them by ids from then on.  We can throw them away after they go to the graphics card.

;Buuut.  That feels onerous compared to letting the user lexically see what sprite will be attached to what entity..

#;
(begin
  (define wizard  (entity (sprite [WIZARD-IMAGE])))
  (define wizard2 (entity (sprite [WIZARD-IMAGE])))
 )

;Here, both wizards have the same sprite.  We want the appearance of a 2 to 1 relationship there.
;But at render time, each entity should render separately.  They should just look the same.
;On the bottom end, at the mode-lambda level (and presumably the gcard level), we need to refer to sprites by ids.  So each wizard sprite will have the same id. 








;META: Thinking about what user will write, how to teach them how to write it, how to make the writing meaningful -- all at one time is the task of a programminer.  We call it tests, docs, code.






