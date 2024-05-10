#lang racket

(define (find-median-sorted-arrays nums1 nums2)
	(-> (listof exact-integer?) (listof exact-integer?) flonum?)
		(define (find_mid ns1 ns2 last_num idx length)
			(let
				([end (>= idx (quotient length 2))]
					[need_average (= (remainder length 2) 0)])
				(cond
					[(empty? ns1)
						(cond
							[(and end need_average) (list last_num (first ns2))]
							[end (list (first ns2))]
							[else (find_mid ns1 (rest ns2) (first ns2) (+ idx 1) length)])]
					[(empty? ns2)
						(cond
							[(and end need_average) (list last_num (first ns1))]
							[end (list (first ns1))]
							[else (find_mid (rest ns1) ns2 (first ns1) (+ idx 1) length)])]
					[else
						(let
							([n1 (first ns1)]
								[n2 (first ns2)])
							(cond
								[(and end need_average (< n1 n2)) (list last_num n1)]
								[(and end need_average) (list last_num n2)]
								[(and end (< n1 n2)) (list n1)]
								[end (list n2)]
								[(< n1 n2) (find_mid (rest ns1) ns2 n1 (+ idx 1) length)]
								[else (find_mid ns1 (rest ns2) n2 (+ idx 1) length)]))])))
		(let
			([ress (find_mid nums1 nums2 0 0 (+ (length nums1) (length nums2)))])
			(/ (apply + ress) (length ress))))

; (find-median-sorted-arrays (list 1 2) (list 3 4))
