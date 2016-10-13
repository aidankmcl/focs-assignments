#lang racket

;;;;;;;;;;
;;; Day 3 in class work

;;;;;;;;;;
;; 0.  Implement factorial both recursively and tail recursively.
;;     Hint:  The tail recursive version will use a helper function.

(define (fact-rec num)
  (if (zero? (- num 1))
      1
      (* num (fact-rec (- num 1)))))

(display (fact-rec 4)) (newline) ;; --> 24

(define (fact-tail num)
  (tail-helper num 1))

(define (tail-helper num total)
  (if (zero? (- num 1))
      total
      (* num (tail-helper (- num 1) total))))

(display (fact-tail 4)) (newline) ;; --> 24

;;;;;;;;;;;
;; 1.  Filter is built in to scheme.

;; (filter even? '(1 2 3 4 5 6))  --> '(2 4 6)  ;; using the built-in even?
;; (filter teen? '(21 17 2 13 4 42 2 16 3)) --> '(17 13 16)
                        ;; assuming (define (teen x) (and (<= 13 x) (<= x 19)))))
;; (filter list? '(3 (3 2 1) symbol (4 2) (1 (2) 3)) --> '((3 2 1) (4 2) (1 (2) 3))

;; Implement it anyway.  You might want to call it my-filter?  What arguments does it take?

(define (filter-check proc arg-list filtered-list)
  (cond [(null? arg-list) (reverse filtered-list)]
        [(proc (first arg-list)) (filter-check proc (rest arg-list) (cons (first arg-list) filtered-list))]
        [else (filter-check proc (rest arg-list) filtered-list)]))

(define (my-filter proc arg-list)
  (filter-check proc arg-list '()))

(display (my-filter odd? `(1 2 3 4 5 6))) (newline) ;; --> (1 3)

;;;;;;;;;;;
;; 2.  Map is also built in to scheme.

;; (map double '(1 2 3))  --> '(4 5 6)  ;; assuming (define (double x) (* 2 x))
;; (map incr '(1 2 3)) --> '(2 3 4)     ;; assuming (define (incr x) (+ x 1))
;; (map last '((3 2 1) (4 2) (1 2 3)) --> '(1 2 3)
                                        ;; assuming (define (last lst)
                                        ;;            (if (null? (rest lst))
                                        ;;                (first lst)
                                        ;;                (last (rest lst))))

;; Implement it as well.  You might want to call it my-map.  What arguments does it take?

(define (my-map-helper proc arg-list results)
  (if (null? arg-list)
      (reverse results)
      (my-map-helper proc (rest arg-list) (cons (proc (first arg-list)) results))))

(define (my-map proc arg-list)
  (my-map-helper proc arg-list '()))

(define (double x) (* 2 x))
(display (my-map double '(1 2 3))) (newline) ;; --> (2 4 6)


;;;;;;;;;;;
;; 3.  While we're reimplementing built-ins, implement my-append (just like built in append)
;;     It takes two lists and returns a list containing all of the elements of the originals, in order.
;;     Note that it is purely functional, i.e., it doesn't MODIFY either of the lists that it is passed.

;; (append '(1 2 3) '(4 5 6)) --> '(1 2 3 4 5 6)

;; You might want to draw out the box and pointer structures for the original two lists
;; as well as for the new list.  Confirm with a member of the instructional staff....

(define (my-append-homie content so-far)
	(if (null? content)
		so-far
		(my-append-homie (rest content) (cons (first content) so-far))))

(define (my-append first-lst second-lst)
	(reverse (my-append-homie second-lst (my-append-homie first-lst '()))))

(display (my-append '(1 2 3) '(4 5 6))) (newline) ;; (1 2 3 4 5 6)



;;;;;;;;;;;
;; 4.  zip takes two lists, and returns a list of elements of size two, until one of the lists runs out.
;; Implement `zip`.

(define (my-zip-homie first-lst second-lst so-far)
	(if (or (null? first-lst) (null? second-lst))
		so-far
		(my-zip-homie (rest first-lst) (rest second-lst) (cons (list (first first-lst) (first second-lst)) so-far))))

(define (my-zip first-lst second-lst)
	(reverse (my-zip-homie first-lst second-lst '())))

(display (my-zip '(1 2 3) '(4 5 6))) (newline) ;; --> '((1 4) (2 5) (3 6))
(display (my-zip '(1 2 3) '(a b c d e f g))) (newline) ;; --> '((1 a) (2 b) (3 c))


;;;;;;;;;;;;
;; 5.  Last built-in (for now):  (my-)reverse.
;;     Takes a list, returns a new list with the elements reversed.

(define (my-reverse-homie lst so-far)
	(if (null? lst)
		so-far
		(my-reverse-homie (rest lst) (cons (first lst) so-far))))

(define (my-reverse lst)
	(my-reverse-homie lst '()))

(display (my-reverse '(1 2 3))) (newline) ;; --> '(3 2 1)

;;;;;;;;;;;;
;; More puzzles:
;;  - (count elt lst) returns the number of times that elt appears in lst
(define (count-helper elt lst num)
	(cond [(null? lst) num]
		  [(eq? elt (first lst)) (count-helper elt (rest lst) (+ num 1))]
		  [else (count-helper elt (rest lst) num)]))

(define (count elt lst)
	(count-helper elt lst 0))

(display (count 'MEOW (list 'MEOW 'CAT 'MEOW) )) (newline) ;; --> 2

;;  - (remove-dups lst) returns a new list that contains the elements of lst but without repeats

(define (remove-dups-helper lst total)
	(cond [(null? lst) (reverse total)]
		  [(> (count (first lst) total) 0) (remove-dups-helper (rest lst) total)]
		  [else (remove-dups-helper (rest lst) (cons (first lst) total))]))

(define (remove-dups lst)
	(remove-dups-helper lst '()))

(display (remove-dups (list 1 2 3 1 4 5 2 4 6))) (newline) ;; --> '(1 2 3 4 5 6)

;;  - reverse reverses a list, but doesn't reverse sublists in a tree.  (Try it and see.)
(display (my-reverse '(1 2 (2 1 4) 3))) (newline) ;; --> (3 (2 1 4) 2 1)

;;    Write deep-reverse, which reverses all sublists as well.
; display (my-deep-reverse '(1 2 (2 1 4) 3))) (newline)
;;  - Which of these can you implement using tail recursion?
