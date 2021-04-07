#lang racket

(define (reverse_and_base x)
	(if (< x 10)
		(list x 10)
		(let*
			([base_ls (reverse_and_base (quotient x 10))]
			[res (first base_ls)]
			[base (first (rest base_ls))])
			(list
				(+ (* (remainder x 10) base) res)
				(* base 10)))))

(define (reverse x)
	(if (= x 0)
		0
		(let*
			([res_m (reverse_and_base (abs x))]
			[res (* (first res_m) (/ x (abs x)))])
			(cond
				[(< res (- (expt 2 31))) 0]
				[(> res (- (expt 2 31) 1)) 0]
				[else res]))))

; (reverse 123)
