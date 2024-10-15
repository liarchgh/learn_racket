#lang racket
(require racket/contract)
; https://leetcode.com/problems/container-with-most-water/submissions/1422825738/

(define (find-max-ronji hs l r)
	(if (>= l r)
		0
		(let
			[
				(lv (vector-ref hs l))
				(rv (vector-ref hs r))
				]
			; 当前区间的容积
			(max (* (min lv rv) (- r l))
				; 较高一边的最大容积，较小一边容积不会大于当前区间容积
				(if (< lv rv)
					(find-max-ronji hs (+ l 1) r)
					(find-max-ronji hs l (- r 1)))))))

(define/contract (max-area height_l)
	(-> (listof exact-integer?) exact-integer?)
	(letrec
		[
			(height_v (list->vector height_l))
			(height_count (- (vector-length height_v) 1))
		]
		(find-max-ronji height_v 0 height_count)))

(let
	[(ins '(1 8 6 2 5 4 8 3 7))]
	(displayln (max-area ins))
	)

