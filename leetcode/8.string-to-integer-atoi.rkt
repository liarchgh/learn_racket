#lang racket
; https://leetcode.com/problems/string-to-integer-atoi/submissions/1416138397/

; 先预处理，用正则把前导空格、非数字部分的结尾去掉
(define (prehandle s)
  (let
    [(res (regexp-match #px"^\\s*([+-]?\\d+)" s))]
    (match res
      [#f ""]
      [_ (car (cdr res))])))

(define (my-atoi s)
  (let
    [
      ; 预处理后转number，其实有问题，racket中的科学计数法会被正确转出来，但其实不符合规则
      (num (string->number (prehandle s) 10))
      (int_max (- (expt 2 31) 1))
      (int_min (- (expt 2 31))) ]
    (match num
      ; 不是数字，说明没成功，主要是#f
      [(? (lambda (n) (not (real? n)))) 0]
      ; 超出范围后clamp
      [(? (lambda (n) (>= n int_max))) int_max]
      [(? (lambda (n) (<= n int_min))) int_min]
      [_ num])))

(let
	([str "words and 987"])
  (displayln (prehandle str))
	(displayln (my-atoi str))
	)
