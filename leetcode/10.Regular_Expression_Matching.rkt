#lang racket

; https://leetcode.com/problems/regular-expression-matching/description/

(define (is-match s p)
	(-> string? string? boolean?)
		(regexp-match? (string-append "^" p "$") s)
	)

; (is-match "aa" "a")
; (is-match "mississippi" "mis*is*p*.")
; (is-match "mississippi" "mis*iis*p*.")