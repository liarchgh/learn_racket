#lang racket

; https://leetcode.com/problems/palindrome-number/
(define (is-palindrome x)
	(-> exact-integer? boolean?)
	(let
		([num_str (~v x)])
		(equal? (list->string (reverse (string->list num_str))) num_str)))

; (is-palindrome 121)