#lang racket

; symbolic and concrete calculation for origami axioms

(require "base-types.rkt")

; vertex -> vertex -> maybe fold
(define (axiom1 v1 v2)
  (λ (s)
    (vadd v1 (vsmul s (vsub v2 v1)))))

(define (axiom1-symbol v1 v2)
  (λ (s)
    (vadd-symbol v1 (vsmul-symbol s (vsub-symbol v2 v1)))))