#lang racket

;;; Student Name: Aidan McLaughlin
;;;
;;; Check one:
;;; [X] I completed this assignment without assistance or external resources.
;;; Note: I didn't finish the lambdas :(
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___

;; REPL Calculator

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
        (list 'UM -)
        (list 'x 10)
        (list 'x2 100)
        (list 'NEQ (lambda (x y) (not (= x y))))
        (list 'ANND (lambda (x y) (and x y)))
        (list 'ORR (lambda (x y) (or x y)))
        (list 'NOTT not)))

(define (my-assq key lst)
  (cond [(null? lst) #f]
        [(eq? key (first (first lst))) (second (first lst))] 
        [else (my-assq key (rest lst))]))

(define (DEFINE? expr)
  (if (and (list? expr) (= 3 (length expr)) (eq? (first expr) 'DEFINE) (not (list? (second expr))))
      #t
      #f))

(define (LAMBDA? expr)
  (if (and (list? expr) (= 3 (length expr)) (eq? (first expr) 'LAMBDA))
      #t
      #f))

(define (IPH-expr? sexpr)
  (and (pair? sexpr) (eq? (first sexpr) 'IPH)))

(define (IPH-ELSE iph-expr)
  (if (= (length iph-expr) 4)
      (fourth iph-expr)
      false))

(define (calculate-IPH sexpr)
  (if (evaluate (second sexpr))
      (evaluate (third sexpr))
      (evaluate (IPH-ELSE sexpr))))

(define (add-to-ol value-pair original-list)
  (set! operator-list (append operator-list (list value-pair))))

(define (evaluate expr)
  (cond [(number? expr) expr]   ;; these first three cases are sometimes called
        [(boolean? expr) expr]  ;; self-evaluating (because they are their own
        [(null? expr) expr]     ;; values and don't need explicit evaluating)
        [(not (pair? expr)) (my-assq expr operator-list)]
        [(LAMBDA? expr) (lambda (second expr) (third expr))]
        [(DEFINE? expr) (add-to-ol (list (second expr) (evaluate (third expr))) operator-list)]
        [(IPH-expr? expr) (calculate-IPH expr)]
        [(and (list? expr) (> (length expr) 1)) (apply (evaluate (first expr)) (map evaluate (rest expr)))]
        [(and (list? expr) (= (length expr) 1)) (evaluate (first expr))]
        [else (error `(evaluate:  not sure what to do with expr ,expr))]))

(define (run-repl)
  (display "welcome to my repl.  type some scheme-ish")
  (repl))

(define (repl)
  (display "> ")
  (display (evaluate (read)))
  (newline)
  (repl))

