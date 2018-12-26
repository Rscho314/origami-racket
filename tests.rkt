#lang racket

(require "axioms.rkt")

(define crease1 (axiom1 (vertex 'x1 'y1) (vertex 'x2 'y2)))
(define crease1-r (axiom1 (vertex 0 0) (vertex 3 3)))

(define rotated-crease (ccrotate90-crease crease1))
(define rotated-crease-r (ccrotate90-crease crease1-r))

(define crease2 (axiom2 (vertex 'x1 'y1) (vertex 'x2 'y2)))
(define crease2-r (axiom2 (vertex 0 0) (vertex 3 3)))
