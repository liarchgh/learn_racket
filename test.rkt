#lang racket

; (define (got-milk? lst)
; 	(and (not (null? lst))
; 		(or (eq? 'milk (car lst))
; 			(got-milk? (cdr lst))))) ; recurs only if needed
; (got-milk? '(rb milk))


; (define (reply-non-string s)
; 	(if (and (string? s) (string-prefix? s "hello "))
; 		"hi"
; 		"no"))
; (reply-non-string "hello racket")


; (define (reply-more s)
; 	(if (string-prefix? s "hello ")
; 		"hi!"
; 		(if (string-prefix? s "goodbye ")
; 			"bye!"
; 			(if (string-suffix? s "?")
; 				"I don't know"
; 				"huh?"))))
; (reply-more "ss?")


; (define (reply-more s)
; 	(cond
; 		[(string-prefix? s "hello ") "hi!"]
; 		[(string-prefix? s "goodbye ") "bye!"]
; 		[(string-suffix? s "?") "I don't know"]
; 		[else "huh?"]))
; (reply-more "ss?")


; (define (doublev v)
;   ((if (string? v)
;       (lambda (b) (string-append b b))
;       ((curry *) v))
;     v))
; (doublev 3)


; (define (louder s)
;   (string-append s "!"))
; (define louder
;   (lambda (s)
;     (string-append s "!")))
; louder


(define (sigma f a b)
  (if (= a b)
      0
      (+ (f a) (sigma f (+ a 1) b))))
(time (round (sigma (lambda (x) (/ 1.0 x)) 1 200000)))
(time (round (sigma (lambda (x) (/ 1 x)) 1 200000)))
