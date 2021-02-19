#lang codespells

(provide mod-name #;pak-folder main.rkt)

(require racket/runtime-path)

(define
  mod-name
  "Spawners")
#;
(define-runtime-path
  pak-folder
  "BuildUnreal/WindowsNoEditor/Spawners/Content/Paks/")

(define-runtime-path
  main.rkt
  "main.rkt")

