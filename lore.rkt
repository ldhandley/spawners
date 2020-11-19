#lang at-exp racket

(require spawners
	 codespells/lore)

(require-mod fire-particles)
(require-mod rocks)

(define-rune-collection-lore 
  #:name "Spawning"
  #:description 
  @md{
  
  }
  #:rune-lores
  (list
    (rune-lore
      #:name "Spawner"
      #:rune (spawner-rune)
      #:description @md{
      This rune creates a spawner with two given parameters: (1) a rune to spawn and (2) a length of time in ms. If a 2nd parameter is not given, the default 1000 ms will be used.    

      @(rune-code-example
         (append-rune-langs #:name #f
                            (hierarchy:my-mod-lang)
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



