#lang racket

; symbolic and concrete calculation for origami axioms

(require "base-types.rkt")

(provide (all-defined-out)
         (all-from-out "base-types.rkt"))

; vertex -> vertex -> crease
(define (axiom1 v1 v2)
  (crease (λ (s) (vadd v1 (vsmul s (vsub v2 v1))))))

; vertex -> vertex -> crease
; uvperp == unique vector instead of vperp == vector bc ccrotate90-crease returns a crease
(define (axiom2 v1 v2)
  (let* ([construction-crease (axiom1 v1 v2)]
         [pmid ((crease-equation construction-crease) 1/2)]
         [uvperp ((crease-equation (ccrotate90-crease construction-crease)) 1)])
    (crease (λ (s) (vadd pmid (vsmul s uvperp))))))