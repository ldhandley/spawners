#lang at-exp codespells

(require spawners/mod-info)

(require-mod rocks)
(require-mod hierarchy)
(require-mod fire-particles)


(define-classic-rune (spawner exp [time 1000])
  #:background "blue"
  #:foreground (circle 40 'solid 'blue)
  (unreal-js @~a{
 (function(){
            
  const uclass = require('uclass')().bind(this,global)
  class MySMA extends StaticMeshActor {
   ctor() {
    //this.StaticMeshComponent.SetStaticMesh(StaticMesh.Load('/Engine/BasicShapes/Cube.Cube'))
   }
  }      
  let MySMA_C = uclass(MySMA) 
  var c = new MySMA_C(GWorld,{X:@(current-x), Y:@(current-z), Z:@(current-y)},
  {Roll:@(current-roll), Pitch:@(current-pitch), Yaw:@(current-yaw)})

  var i = setInterval(function(){
   if(c.IsValid()){
    @(unreal-js-fragment-content (if (procedure? exp)
                                     (exp)
                                      exp
                                    ))
   } else {
    clearInterval(i)
   }
   }, @time)
  })()
 }))

(define-classic-rune (destroy-actors [radius 50])
  #:background "blue"
  #:foreground (circle 40 'solid 'red)
  (unreal-js @~a{
 (function(){
   var actors = KismetSystemLibrary.SphereOverlapActors(GWorld, {X:@(current-x), Y:@(current-z), Z:@(current-y)}, @radius).OutActors
   actors.map(function(a){
     a.DestroyActor()
   })          
  })()
 }))

(define-classic-rune-lang my-mod-lang #:eval-from main.rkt
  (spawner destroy-actors))

(module+ main
  (codespells-workspace ;TODO: Change this to your local workspace if different
   (build-path (current-directory) ".." ".."))
  
  (once-upon-a-time
   #:world (demo-world)
   #:aether (demo-aether
             #:lang (append-rune-langs #:name main.rkt
		      (my-mod-lang #:with-paren-runes? #t)
		      (hierarchy:my-mod-lang)
                      (rocks:my-mod-lang)
                      (fire-particles:my-mod-lang)))))


