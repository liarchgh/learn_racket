#lang racket
(require racket/contract)
; https://leetcode.com/problems/integer-to-roman/solutions/4474998/racket-hash-map/

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

; 针对当前级别的单位取余作为下一级计算的基础数字，除数为对应字母的数量
(define (mods num str dw)
	(let
		[
			(str_num (quotient num dw))
			(next_num (remainder num dw))
		]
		(cons (repeat-string str str_num) next_num)
	)
)

(define (itr num ps)
	(if (or (empty? ps) (zero? num))
		""
		(letrec
			[
				(p (car ps))
				(now_str_data (mods num (car p) (cdr p)))
			]
			(string-append
				(car now_str_data)
				(itr (cdr now_str_data) (cdr ps)))))
)

(define/contract (int-to-roman num)
	(-> exact-integer? string?)
	(itr num presets)
	)

(let
	[(ins 3749)]
	(displayln (int-to-roman ins))
	)
