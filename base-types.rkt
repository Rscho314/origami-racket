#lang racket

; base types and operations on them

(provide (all-defined-out))

; Difference between a vertex and a crease:
; vertex struct members == multi-parameter expr (not lambda)
; crease struct members == lambda s

; number -> number -> vertex
(struct vertex (x y))

; lambda _ -> crease
(struct crease (equation))

; Crease operations
; crease -> crease
(define (ccrotate90-crease c)
  (let* ([x (vertex-x ((crease-equation c) '_))]
         [y (vertex-y ((crease-equation c) '_))]
         [flat-x (flatten x)]
         [flat-y (flatten y)]
         [x1 (second flat-x)]
         [y1 (second flat-y)]
         [x2 (sixth flat-x)]
         [y2 (sixth flat-y)])
    (crease (λ (s) (vertex `(- (* ,s (- ,y1 ,y2)) ,y1) `(+ ,x1 (* ,s (- ,x2 ,x1))))))))

; crease -> (values x y)
(define (get-components c)
  (let ([x (vertex-x ((crease-equation c) 's))]
        [y (vertex-y ((crease-equation c) 's))])
    (with-handlers ([exn:fail? (lambda (exn)
                                 (raise-argument-error
                                  'get-coordinates
                                  "argument is not a crease"
                                  "crease-equation" c))])
      (values x y))))

; Vertex operations
; λ -> vertex -> vertex -> vertex
(define (vop op v1 v2)
  (vertex `(,op ,(vertex-x v1) ,(vertex-x v2))
          `(,op ,(vertex-y v1) ,(vertex-y v2))))

; vertex -> vertex -> vertex
(define (vadd v1 v2)
  (vop + v1 v2))

; vertex -> vertex -> vertex
(define (vsub v1 v2)
  (vop - v1 v2))

; number -> vertex -> vertex
(define (vsmul s v)
  (vertex `(* ,s ,(vertex-x v)) `(* ,s ,(vertex-y v))))

; vertex -> (values x y)
(define (get-coordinates v)
  (let ([x (vertex-x v)]
        [y (vertex-y v)])
    (with-handlers ([exn:fail? (lambda (exn)
                                 (values x y))]
                    [exn:fail? (lambda (exn)
                                 (raise-arguments-error 'get-coordinates
                                                       "arguments are not coordinates"
                                                       "x" x
                                                       "y" y))])
      (values (eval x) (eval y)))))