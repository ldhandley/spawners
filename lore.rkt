#lang at-exp racket

(require codespells/lore)

(require-mod fire-particles)
(require-mod rocks)
(require-mod hierarchy)
(require-mod spawners)

(define-rune-collection-lore 
  #:name "The Automata that Conjures"
  #:description 
  @md{
    The cautionary tale behind this Rune is well known among wizards across the @b{Multiverse}.
    
    The perimeter of the @b{Growing Desert} still increases by miniscule amounts every year.
    The spawner at the center of it creates a grain of sand every few minutes.  
    
    Buried deep beneath the sand mountain at the center of the desert is the village once called @b{Forest's Edge},
    whose resident wizard was skilled enough to create the sand spawner, but not skilled enough to destroy it. 
  }
  #:rune-lores
  (list
    (rune-lore
      #:name "Spawner"
      #:rune (spawner-rune)
      #:description @md{
      An expression beginning with this rune creates a spawner described by the next 2 arguments: (1) an expression describing a thing to spawn and (2) a length of time in ms. If a 2nd argument is not given, a 1000 ms default will be used.    

      @(rune-code-example
         (append-rune-langs #:name #f
                            (hierarchy:my-mod-lang)
                            (rocks:my-mod-lang)
                            (fire-particles:my-mod-lang)
                            (spawners:my-mod-lang #:with-paren-runes? #t))
	 (parentify 
           flames
           (spawner
             gnarly-rock))
	 spawner-demo.mp4)
      }
      )

    )
  #:preview-image preview.png)



