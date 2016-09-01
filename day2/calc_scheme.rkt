#lang racket

;;; Course: ENGR3520
;;; Author: Oliver Steele
;;; Date: 2016-10-01

(define (apply-op op arg1 arg2)
  (cond [(eq? op '+) (+ arg1 arg2)]
        [(eq? op '-) (- arg1 arg2)]
        [(eq? op '*) (* arg1 arg2)]
        [(eq? op '/) (/ arg1 arg2)]))

(define (calc-as-you-go-helper arg1 input)
  (cond [(null? input) arg1]
        [else
         (calc-as-you-go-helper (apply-op (first input) arg1 (second input)) (list-tail input 2))]))

(define (calc-as-you-go input)
  (calc-as-you-go-helper (first input) (rest input)))

(write (calc-as-you-go '(1 + 2))) (newline)
(write (calc-as-you-go '(1 + 2 * 3))) (newline)

(define (calc-rpn-helper input stack)
  (cond [(null? input)
         (first stack)]
        [(number? (first input))
         (calc-rpn-helper (rest input) (cons (first input) stack))]
        [else
         (calc-rpn-helper (rest input) (cons (apply-op (first input) (second stack) (first stack)) (list-tail stack 2)))]))

(define (calc-rpn input)
  (calc-rpn-helper input '()))

(write (calc-rpn '(1 2 +))) (newline)
(write (calc-rpn '(1 2 + 3 *))) (newline)
(write (calc-rpn '(1 2 3 + *))) (newline)