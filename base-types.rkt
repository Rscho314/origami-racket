#lang racket

; base types and operations on them

(provide (all-defined-out))

; number -> number -> vertex
(struct vertex (x y))

; expr -> fold
(struct fold (equation))

;helpers
; λ -> vertex -> vertex -> vertex
(define (vop op v1 v2)
  (vertex (op (vertex-x v1) (vertex-x v2))
          (op (vertex-y v1) (vertex-y v2))))

(define (vop-symbol op v1 v2)
  (vertex `(,op ,(vertex-x v1) ,(vertex-x v2))
          `(,op ,(vertex-y v1) ,(vertex-y v2))))

; vertex -> vertex -> vertex
(define (vadd v1 v2)
  (vop + v1 v2))

(define (vadd-symbol v1 v2)
  (vop-symbol + v1 v2))

; vertex -> vertex -> vertex
(define (vsub v1 v2)
  (vop - v1 v2))

(define (vsub-symbol v1 v2)
  (vop-symbol - v1 v2))

; number -> vertex -> vertex
(define (vsmul s v)
  (vertex (* s (vertex-x v)) (* s (vertex-y v))))

(define (vsmul-symbol s v)
  (vertex `(* ,s ,(vertex-x v)) `(* ,s ,(vertex-y v))))