#lang racket

;;; Student Name: Aidan McLaughlin
;;;
;;; Check one:
;;; [X] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___

;;;;;;;;;;;
;; 1. assq

;; `assq` is a function that takes a key and an association list.
;;
;; It returns the corresponding key/value pair from the list
;; (*i.e.*, the pair whose key is *eq?* to the one it is given).
;;
;; If the key is not found in the list, `assq` returns `#f`.

(define operator-list
  (list (list '+ +)
        (list '- -)
        (list '* *)
        (list '/ /)
        (list '> >)
        (list '< <)
        (list '>= >=)
        (list '<= <=)
        (list '= =)
        (list 'x 10)
        (list 'x2 100)
        (list 'NEQ (lambda (x y) (not (= x y))))
        (list 'ANND (lambda (x y) (and x y)))
        (list 'ORR (lambda (x y) (or x y)))
        (list 'NOTT not)))

(define (my-assq key lst)
  (cond [(null? lst) #f]
        [(eq? key (first (first lst))) (first lst)] 
        [else (my-assq key (rest lst))]))

(display (rest (my-assq '* operator-list))) (newline) ;; --> <procedure:*>


;;;;;;;;;;;
;; 2. lookup-list

;; Add the ability to look up symbols to your evaluator.
;;
;; Add the `lookup-list` argument to your hw2 evaluator (or ours, from the solution set).
;; `(evaluate 'foo lookup-list)` should return whatever `'foo` is associated with in `lookup-list`.

(define (evaluate expr)
  (cond [(number? expr) expr]
        [(and (not (list? expr)) (my-assq expr operator-list)) (second (my-assq expr operator-list))]
        [(my-assq (first expr) operator-list) ((second (my-assq (first expr) operator-list)) (evaluate (second expr)) (evaluate (third expr)))]
        [(eq? (first expr) 'IPH) (if (evaluate (second expr))
                                     (evaluate (third expr))
                                     (evaluate (fourth expr)))]
        [(eq? (first expr) 'UM) (- (evaluate (second expr)))]
        [else #f]))

(display (evaluate '(IPH (<= (* (- x 2) (/ 9 3)) 0) (UM x2) (- (+ 7 8) 9)))) (newline) ;; --> 6