#lang racket

;;; Student Name: Aidan McLaughlin
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [X] I completed this assignment with assistance from ____
;;;     and/or using these external resources: __GOOGLE__ (list-ref - happy to make my own if preferred)

;;; 1.  Create a calculator that takes one argument: a list that represents an expression.

(define (calculate x)
  (cond [(eq? (first x) 'ADD) (+ (list-ref x 1) (list-ref x 2))]
        [(eq? (first x) 'SUB) (- (list-ref x 1) (list-ref x 2))]
        [(eq? (first x) 'MUL) (* (list-ref x 1) (list-ref x 2))]
        [(eq? (first x) 'DIV) (/ (list-ref x 1) (list-ref x 2))]
        )
  )

(display (calculate '(ADD 3 4))) (newline);; --> 7

;;; 2. Expand the calculator's operation to allow for arguments that are themselves well-formed arithmetic expressions.

(define (calculate-recursive instruction)
  (cond [(number? instruction) instruction]
        [(eq? (first instruction) 'ADD) (+ (calculate-recursive (list-ref instruction 1)) (calculate-recursive (list-ref instruction 2)))]
        [(eq? (first instruction) 'SUB) (- (calculate-recursive (list-ref instruction 1)) (calculate-recursive (list-ref instruction 2)))]
        [(eq? (first instruction) 'MUL) (* (calculate-recursive (list-ref instruction 1)) (calculate-recursive (list-ref instruction 2)))]
        [(eq? (first instruction) 'DIV) (/ (calculate-recursive (list-ref instruction 1)) (calculate-recursive (list-ref instruction 2)))]
        )
  )

(display (calculate-recursive '(ADD 3 (MUL 4 5)))) (newline) ;; --> 23   ;; what is the equivalent construction using list?
(display (calculate-recursive '(SUB (ADD 3 4) (MUL 5 6)))) (newline) ;; --> -23

;;; 3. Add comparators returning booleans (*e.g.*, greater than, less than, ...).
;; Note that each of these takes numeric arguments (or expressions that evaluate to produce numeric values),
;; but returns a boolean.  We suggest operators `GT`, `LT`, `GE`, `LE`, `EQ`, `NEQ`.

(define (calculate-recursive-2 instruction)
  (cond [(number? instruction) instruction]
        [(eq? (first instruction) 'GT) (> (calculate-recursive-2 (list-ref instruction 1)) (calculate-recursive-2 (list-ref instruction 2)))]
        [(eq? (first instruction) 'LT) (< (calculate-recursive-2 (list-ref instruction 1)) (calculate-recursive-2 (list-ref instruction 2)))]
        [(eq? (first instruction) 'GE) (>= (calculate-recursive-2 (list-ref instruction 1)) (calculate-recursive-2 (list-ref instruction 2)))]
        [(eq? (first instruction) 'LE) (<= (calculate-recursive-2 (list-ref instruction 1)) (calculate-recursive-2 (list-ref instruction 2)))]
        [(eq? (first instruction) 'EQ) (eq? (calculate-recursive-2 (list-ref instruction 1)) (calculate-recursive-2 (list-ref instruction 2)))]
        [(eq? (first instruction) 'NEQ) (not (eq? (calculate-recursive-2 (list-ref instruction 1)) (calculate-recursive-2 (list-ref instruction 2))))]

        [(eq? (first instruction) 'ADD) (+ (calculate-recursive-2 (list-ref instruction 1)) (calculate-recursive-2 (list-ref instruction 2)))]
        [(eq? (first instruction) 'SUB) (- (calculate-recursive-2 (list-ref instruction 1)) (calculate-recursive-2 (list-ref instruction 2)))]
        [(eq? (first instruction) 'MUL) (* (calculate-recursive-2 (list-ref instruction 1)) (calculate-recursive-2 (list-ref instruction 2)))]
        [(eq? (first instruction) 'DIV) (/ (calculate-recursive-2 (list-ref instruction 1)) (calculate-recursive-2 (list-ref instruction 2)))]
        )
  )

(display (calculate-recursive-2 '(GT (ADD 3 4) (MUL 5 6)))) (newline) ;; --> #f
(display (calculate-recursive-2 '(LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) (newline) ;; --> #t

;;; 4. Add boolean operations ANND, ORR, NOTT

(define (calculate-recursive-3 instruction)
  (cond [(number? instruction) instruction]

        [(eq? (first instruction) 'ANDD) (and (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2)))]
        [(eq? (first instruction) 'ORR) (or (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2)))]
        [(eq? (first instruction) 'NOTT) (not (calculate-recursive-3 (list-ref instruction 1)))]
        
        [(eq? (first instruction) 'GT) (> (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2)))]
        [(eq? (first instruction) 'LT) (< (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2)))]
        [(eq? (first instruction) 'GE) (>= (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2)))]
        [(eq? (first instruction) 'LE) (<= (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2)))]
        [(eq? (first instruction) 'EQ) (eq? (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2)))]
        [(eq? (first instruction) 'NEQ) (not (eq? (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2))))]

        [(eq? (first instruction) 'ADD) (+ (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2)))]
        [(eq? (first instruction) 'SUB) (- (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2)))]
        [(eq? (first instruction) 'MUL) (* (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2)))]
        [(eq? (first instruction) 'DIV) (/ (calculate-recursive-3 (list-ref instruction 1)) (calculate-recursive-3 (list-ref instruction 2)))]
        )
  )

(display (calculate-recursive-3 '(ANDD (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))))) (newline) ;; --> #f

;;; 5. Add IPH

(define (calculate-iph instruction)
  (cond [(number? instruction) instruction]

        [(eq? (first instruction) 'IPH) (if (calculate-iph (list-ref instruction 1))
                                      (calculate-iph (list-ref instruction 2))
                                      (calculate-iph (list-ref instruction 3))
                                      )
                                    ]

        [(eq? (first instruction) 'ANDD) (and (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2)))]
        [(eq? (first instruction) 'ORR) (or (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2)))]
        [(eq? (first instruction) 'NOTT) (not (calculate-iph (list-ref instruction 1)))]
        
        [(eq? (first instruction) 'GT) (> (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2)))]
        [(eq? (first instruction) 'LT) (< (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2)))]
        [(eq? (first instruction) 'GE) (>= (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2)))]
        [(eq? (first instruction) 'LE) (<= (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2)))]
        [(eq? (first instruction) 'EQ) (eq? (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2)))]
        [(eq? (first instruction) 'NEQ) (not (eq? (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2))))]

        [(eq? (first instruction) 'ADD) (+ (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2)))]
        [(eq? (first instruction) 'SUB) (- (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2)))]
        [(eq? (first instruction) 'MUL) (* (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2)))]
        [(eq? (first instruction) 'DIV) (/ (calculate-iph (list-ref instruction 1)) (calculate-iph (list-ref instruction 2)))]
        )
  )

(display (calculate-iph '(IPH (GT (ADD 3 4) 7) (ADD 1 2) (ADD 1 3)))) (newline) ;; -> 4

;;; 6. Obscure challenges :)
;; Unary minus
;; New operands
;; Spellings that look like scheme's

(define (calculate-obscure instruction)
  (cond [(number? instruction) instruction]

        [(eq? (first instruction) 'IPH) (if (calculate-obscure (list-ref instruction 1))
                                      (calculate-obscure (list-ref instruction 2))
                                      (calculate-obscure (list-ref instruction 3))
                                      )
                                    ]

        [(eq? (first instruction) 'UM) (- 0 (calculate-obscure (list-ref instruction 1)))]

        [(eq? (first instruction) 'and) (and (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]
        [(eq? (first instruction) 'or) (or (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]
        [(eq? (first instruction) 'not) (not (calculate-recursive-3 (list-ref instruction 1)))]

        ;; [else (apply (eval (first instruction)) (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]  ;; How I'd like to do the apply if eval worked the way I hoped
        ;; Otherwise, without googling more than I feel was intended I can rewrite all the previous cases using symbol versions of the operators.
        [(eq? (first instruction) '>) (> (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]
        [(eq? (first instruction) '<) (< (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]
        [(eq? (first instruction) '>=) (>= (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]
        [(eq? (first instruction) '<=) (<= (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]
        [(eq? (first instruction) 'eq?) (eq? (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]
        [(eq? (first instruction) 'neq?) (not (eq? (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2))))]

        [(eq? (first instruction) '+) (+ (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]
        [(eq? (first instruction) '-) (- (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]
        [(eq? (first instruction) '*) (* (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]
        [(eq? (first instruction) '/) (/ (calculate-obscure (list-ref instruction 1)) (calculate-obscure (list-ref instruction 2)))]
        )
  )

(display (calculate-obscure '(and (> 2 1) (< 1 0)) )) (newline) ;; -> #f
(display (calculate-obscure '(and (< (- 2 6) 1) (< 0 1)) )) (newline) ;; -> #t
(display (calculate-obscure '(UM -1))) (newline) ;; -> 1