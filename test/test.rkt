#! racket
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
; (louder "zxcv")
; (define louder
;   (lambda (s)
;     (string-append s "!")))
; louder


; (define (sigma f a b)
;   (if (= a b)
;       0
;       (+ (f a) (sigma f (+ a 1) b))))
; (writeln (time (round (sigma (lambda (x) (/ 1.0 x)) 1 20000))))
; (writeln (time (round (sigma (lambda (x) (/ 1 x)) 1 20000))))


; (apply
;   (lambda x (string-append (car x) "sdf") )
;   '("xx" "xcvx"))
; ((lambda (z . x) (string-append (car x) "sdf") )
;   "zz" "xx" "cc")
; ((lambda ([z "zx"] . x) (string-append z "sdf") )
;   )

; (define (tf q)
;   (lambda (a #:base [z (if (> (string-length q) 2) q "no" )] s . x) (string-append a "-" z "-" s "-" (car x)) ))
; ((tf "fff") "aa" "ss" "dd" #:base "zz")
; ((tf "fff") "aa" "ss" "dd")

; ((case-lambda
;   [(n1) (string-append "s:" n1)]
;   [(n1 n2) (string-append "s:" n1 "-" n2)])
;   "sdf" "xx")

; (define (m s1) (lambda (x) (string-append s1 x)))
; ((m "ss") "xx")
; (define ((m2 s1) s2) (string-append s1 s2))
; ((m2 "zz") "xx")

; (define (sp s)
; 	(apply values (string-split s " ")))
; (sp "aa bb cc")
; (define-values 
; s2


; 4.7

; (member "ax" '("vv" "ax" "ss" "ax" "xx"))
; (member "aaa" '("vv" "ax" "ss" "ax" "xx"))


; 4.8

; (let ([x #t])
; 	(if x
; 		(display "if true")
; 		(display "if false")
; 	)
; 	(when x
; 		(display "if true1")
; 		(display "if true2")
; 	)
; )

; 4.12

; (define (tv v)
; 	(printf "v:~a\n" v)
; 	(case v
; 		[(1) "111"]
; 		[(2 0) "222"]
; 		[else "ccc"]
; 	)
; )
; (tv 1)
; (tv 0)
; (tv 2)
; (tv 4)

; (remove-duplicates '('(1 2) '(2 1)) #:key (lambda (n) (printf "~a\n" n) (list->mutable-set n)))
; (remove-duplicates (list (list 1 2) (list 2 1)))

; 8.1

; (define in (open-input-file "in.txt"))
; (define out (open-output-file "out.txt" #:exists 'truncate))
; (displayln (read-line in) out)
; (close-input-port in)
; (close-output-port out)

; (define in (open-input-file "in.txt"))
; (call-with-input-file "in.txt"
; 	(lambda (in)
; 		(call-with-output-file "out.txt"
; 			#:exists 'truncate
; 			(lambda (out)
; 				(displayln (read-line in) out)))
; 		(close-input-port in)))

; (define ti (open-output-string))
; (display "t1" ti)
; (display "t2" ti)
; (display (get-output-string ti))

; (define server (tcp-listen 42111))
; (define-values (cin cout) (tcp-connect "localhost" 42111))
; (define-values (sin sout) (tcp-accept server))
; (display "hello1" cout)
; (display "hello2" sout)
; (close-output-port cout)
; (close-output-port sout)
; (read-line sin)
; (read-line cin)

; ; system cmd, shell call
; (define (capture-output cmd)
; 	(with-output-to-string
; 		(λ () (system cmd))))
; (define pwd-output (capture-output "pwd"))
; (printf "Current directory is: ~a\n" pwd-output)

; system cmd, shell call and capture stdout and stderror
(define (shell-call command)
	(define stdout (open-output-bytes)) ; 创建一个字符串输出端口用于捕获
	(define stderr (open-output-string))
	(define result
		(parameterize
			([current-error-port (dup-output-port stderr #t)]
				[current-output-port (dup-output-port stdout #t)])
			(system command))) ; 执行命令
	(define error-output (get-output-string stderr)) ; 获取输出
	(define common-output (get-output-string stdout))
	(close-output-port stdout) ; 关闭字符串输出端口
	(close-output-port stderr)
	(values common-output error-output)) ; 返回捕获的输出
; ; 使用示例
; (define-values (stdout-output1 stderr-output1) (shell-call "ls"))
; (printf "Command stdout output: ~a\n" stdout-output1)
; (printf "Command stderr output: ~a\n" stderr-output1)
; (define-values (stdout-output stderr-output) (shell-call "ls not_existing_file"))
; (printf "Command stdout output: ~a\n" stdout-output)
; (printf "Command stderr output: ~a\n" stderr-output)

; Process Pipes
(define-values (wc-path-raw wc-path-error) (shell-call "which wc"))
(define wc-path (string-replace (string-replace wc-path-raw "\n" "") "\r" ""))
(print wc-path)
(define-values (p so si se)
	; must be absolute path
	(subprocess #f #f #f wc-path "-w"))
(display "a b c\n" si)
(close-output-port si)
(read-line so)
(read-line se)
(close-input-port so)
(close-input-port se)