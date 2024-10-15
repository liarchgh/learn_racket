#lang racket
(require racket/contract)
; https://leetcode.com/problems/roman-to-integer/submissions/1423424261/

(define presets
	'(
		("M"	.	1000)
		("CM"	.	900)
		("D"	.	500)
		("CD"	.	400)
		("C"	.	100)
		("XC"	.	90)
		("L"	.	50)
		("XL"	.	40)
		("X"	.	10)
		("IX"	.	9)
		("V"	.	5)
		("IV"	.	4)
		("I"	.	1)))

(define (repeat-string str n)
	(if (zero? n)
		""
		(string-append str (repeat-string str (sub1 n)))))

; 直接根据前缀来处理就行，贪心匹配就行
(define (mods rns str dw)
	(if (string-prefix? rns str)
		(let [(next_rns_data (mods (substring rns (string-length str)) str dw))]
			(cons (+ dw (car next_rns_data)) (cdr next_rns_data)))
		(cons 0 rns)))

(define (itr rns ps)
	(if (or (empty? ps) (empty? rns))
		0
		(letrec
			[
				(p (car ps))
				(now_rns_data (mods rns (car p) (cdr p)))
			]
			(+
				(car now_rns_data)
				(itr (cdr now_rns_data) (cdr ps)))))
)

(define/contract (roman-to-int s)
	(-> string? exact-integer?)
		(itr s presets)
	)

(let
	[(ins "MCMXCIV")]
	(displayln (roman-to-int ins))
	)
