(set-logic QF_NRA)
(declare-fun x1 () Real)
(declare-fun x2 () Real)
(declare-fun x3 () Real)
(declare-fun x4 () Real)
(declare-fun x5 () Real)
(declare-fun x6 () Real)
(assert (<= 4.0 x1))
(assert (<= x1 6.3504))
(assert (<= 4.0 x2))
(assert (<= x2 6.3504))
(assert (<= 4.0 x3))
(assert (<= x3 6.3504))
(assert (<= 6.3504 x4))
(assert (<= x4 8.0))
(assert (<= 4.0 x5))
(assert (<= x5 6.3504))
(assert (<= 6.3504 x6))
(assert (<= x6 8.0))
(assert (not (< (+ (* (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- x2) x3) (* x1 x4)) (+ (* x2 x5) (+ (- (* x3 x6) (* x5 x6)) (* x1 (+ (- x1) (+ x2 (+ (- x3 x4) (+ x5 x6))))))))) (^ (* 4.0 (* x1 (+ (* x1 (* x4 (+ (- x1) (+ x2 (+ (- x3 x4) (+ x5 x6)))))) (+ (* x2 (* x5 (+ (- x1 x2) (+ x3 (+ (- x4 x5) x6))))) (- (- (- (- (* x3 (* x6 (+ x1 (+ (- x2 x3) (+ x4 (- x5 x6)))))) (* x2 (* x3 x4))) (* x1 (* x3 x5))) (* x1 (* x2 x6))) (* x4 (* x5 x6))))))) 0.5))) (- 1.0)) (+ (* 1.0 1.448) (+ (* (^ x1 0.5) 0.266) (+ (* 1.0 (* 0.266 (- 2.0))) (+ (* (^ x2 0.5) (- 0.295)) (+ (* 1.0 (* 0.295 2.0)) (+ (* (^ x3 0.5) (- 0.57)) (+ (* 1.0 (* 0.57 2.0)) (+ (* (^ x4 0.5) 0.745) (+ (* 1.0 (* 0.745 (- 2.52))) (+ (* (^ x5 0.5) (- 0.268)) (+ (* 1.0 (* 0.268 2.0)) (+ (* (^ x6 0.5) (- 0.385)) (* 1.0 (* 0.385 2.52))))))))))))))) 0.0)))
(check-sat)
(exit)
