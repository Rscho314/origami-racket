#lang racket

; A folding pattern consists in a hash table with 2 fields:
; vertices and folds. Both are sets. They represent a lists
; of goals that have to be constructed from known data (pa-
; per corners and edges) and origami axioms.

; TODO: ensure set construction works with vertex and fold structs!

(define vertices (λ v (list->set v)))

(define creases (λ f (list->set f)))

(define (folding-pattern vertices creases)
  (hash 'vertices vertices 'creases creases))