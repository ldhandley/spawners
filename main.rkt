#lang at-exp codespells

;(require-mod rocks)
;(require-mod hierarchy)
;(require-mod fire-particles)

(require spawners/mod-info)

(define (spawner-rune-img)
  (define (X)
    (circle 20 'solid 'cyan))
  (define (arrow)
    (above
     (triangle 20 'solid 'blue)
     (rectangle 5 20 'solid 'blue)))
  (define (Y)
    (square 15 'solid 'cyan))
  (rotate -135 (above (X)
         (arrow)
         (Y)
         )))

(define-classic-rune (spawner exp [time 1000])
  #:background "blue"
  #:foreground (spawner-rune-img)
  (unreal-js @~a{
 (function(){
            
  const uclass = require('uclass')().bind(this,global)
  class MySMA extends StaticMeshActor {
   ctor() {
   // this.StaticMeshComponent.SetStaticMesh(StaticMesh.Load('/Engine/BasicShapes/Cube.Cube'))
   }
  }      
  let MySMA_C = uclass(MySMA) 
  var c = new MySMA_C(GWorld,{X:0, Y:0, Z:0},
  {Roll:0, Pitch:0, Yaw:0})

  c.StaticMeshComponent.SetMobile()

  var i = setInterval(function(){
   
   if(c.IsValid()){
    @(at [
          @~a{c.GetActorLocation().X} ;Ugh, using ~a is gross...
          @~a{c.GetActorLocation().Z} ;Flipping Z and Y
          @~a{c.GetActorLocation().Y}
      ]
      (unreal-js-fragment-content (if (procedure? exp)
                                     (exp)
                                      exp
                                    )))
   } else {
    clearInterval(i)
   }
   }, @time)

    return c
  })()
 }))


(define-classic-rune-lang my-mod-lang #:eval-from main.rkt
  (spawner))

(module+ main

  (codespells-workspace ;TODO: Change this to your local workspace if different
   (build-path (current-directory) ".." ".."))

  #;(thread (thunk*
           (local-require (only-in fire-particles explosion flames)
                          (only-in rocks metallic-rock gnarly-rock))
           (sleep 10)
           (unreal-eval-js
            (at [0 200 50] (parentify metallic-rock
                                      flames
                                      (spawner
                                      explosion))))))
  
  (once-upon-a-time
   #:world (demo-world)
   #:aether (demo-aether
             #:lang (append-rune-langs #:name main.rkt
		      (my-mod-lang #:with-paren-runes? #t)
		      ;(hierarchy:my-mod-lang)
                      ;(rocks:my-mod-lang)
                      ;(fire-particles:my-mod-lang)
             ))))


