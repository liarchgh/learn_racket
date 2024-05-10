#lang racket

(define (cal_prefix str_lss res_ls)
	(if (ormap (lambda (str_ls) (empty? str_ls)) str_lss)
		res_ls
		(let
			([first_char (first (first str_lss))])
			(if (andmap (lambda (str_ls) (char=? first_char (first str_ls))) str_lss)
				(cal_prefix (map
					(lambda (str_ls) (rest str_ls)) str_lss)
					(append res_ls (list first_char)))
				res_ls))))

(define (longest-common-prefix strs)
	(-> (listof string?) string?)
		(if (empty? strs)
			""
			(list->string
				(cal_prefix
					(map (lambda (str) (string->list str)) strs)
					empty))))

; (let
; 	([str_lss (list "flower" "flower" "flower" "flower")])
; 	(longest-common-prefix str_lss)
; 	)
