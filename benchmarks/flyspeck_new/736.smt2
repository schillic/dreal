(set-logic QF_NRA)
(declare-fun x1 () Real)
(declare-fun x2 () Real)
(declare-fun x3 () Real)
(declare-fun x4 () Real)
(declare-fun x5 () Real)
(declare-fun x6 () Real)
(assert (<= 6.3504 x1))
(assert (<= x1 6.68429316))
(assert (<= 4.0 x2))
(assert (<= x2 6.06887582536))
(assert (<= 4.0 x3))
(assert (<= x3 6.06887582536))
(assert (<= 6.06887582536 x4))
(assert (<= x4 6.3504))
(assert (<= 4.0 x5))
(assert (<= x5 6.06887582536))
(assert (<= 4.0 x6))
(assert (<= x6 6.06887582536))
(assert (not (< (+ (* (/ (^ (+ (* x1 (* x4 (+ (- x1) (+ x2 (+ (- x3 x4) (+ x5 x6)))))) (+ (* x2 (* x5 (+ (- x1 x2) (+ x3 (+ (- x4 x5) x6))))) (- (- (- (- (* x3 (* x6 (+ x1 (+ (- x2 x3) (+ x4 (- x5 x6)))))) (* x2 (* x3 x4))) (* x1 (* x3 x5))) (* x1 (* x2 x6))) (* x4 (* x5 x6))))) 0.5) 12.0) (- (/ 1.0 2.0))) (+ (* 1.0 (* 8.0 (* 3.14159265 (* (/ (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (- (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) 3.14159265))) 3.14159265) (* (^ 8.0 0.5) (* (/ 1.0 (+ (* 4.0 3.14159265) (* 20.0 (* 3.14159265 (- (/ (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (- (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) 3.14159265))) 3.14159265)))))) (- (/ 1.0 2.0)))))))) (+ (* (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- x2) x3) (* x1 x4)) (+ (* x2 x5) (+ (- (* x3 x6) (* x5 x6)) (* x1 (+ (- x1) (+ x2 (+ (- x3 x4) (+ x5 x6))))))))) (^ (* 4.0 (* x1 (+ (* x1 (* x4 (+ (- x1) (+ x2 (+ (- x3 x4) (+ x5 x6)))))) (+ (* x2 (* x5 (+ (- x1 x2) (+ x3 (+ (- x4 x5) x6))))) (- (- (- (- (* x3 (* x6 (+ x1 (+ (- x2 x3) (+ x4 (- x5 x6)))))) (* x2 (* x3 x4))) (* x1 (* x3 x5))) (* x1 (* x2 x6))) (* x4 (* x5 x6))))))) 0.5))) (* 4.0 (* 3.14159265 (* (/ (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (- (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) 3.14159265))) 3.14159265) (* (^ 8.0 0.5) (* (/ 1.0 (+ (* 4.0 3.14159265) (* 20.0 (* 3.14159265 (- (/ (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (- (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) 3.14159265))) 3.14159265)))))) (* (/ 1.0 3.14159265) (/ 1.0 2.0)))))))) (+ (* (* (+ (- (* 4.0 (/ (* (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265) (/ (^ 8.0 0.5) (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265))))) 3.14159265)) (/ (* 504.0 (/ (* (- (* 6.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)) 3.14159265) (/ (^ 2.0 0.5) (* 6.0 (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)))))) 3.14159265)) 13.0)) (/ (* 200.0 (* (^ x2 0.5) (/ (* (- (* 6.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)) 3.14159265) (/ (^ 2.0 0.5) (* 6.0 (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)))))) 3.14159265))) 13.0)) (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- x1) x3) (* x2 x5)) (+ (* x1 x4) (+ (- (* x3 x6) (* x4 x6)) (* x2 (+ (- x2) (+ x1 (+ (- x3 x5) (+ x4 x6))))))))) (^ (* 4.0 (* x2 (+ (* x2 (* x5 (+ (- x2) (+ x1 (+ (- x3 x5) (+ x4 x6)))))) (+ (* x1 (* x4 (+ (- x2 x1) (+ x3 (+ (- x5 x4) x6))))) (- (- (- (- (* x3 (* x6 (+ x2 (+ (- x1 x3) (+ x5 (- x4 x6)))))) (* x1 (* x3 x5))) (* x2 (* x3 x4))) (* x2 (* x1 x6))) (* x5 (* x4 x6))))))) 0.5)))) (/ 1.0 2.0)) (+ (* (* (+ (- (* 4.0 (/ (* (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265) (/ (^ 8.0 0.5) (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265))))) 3.14159265)) (/ (* 504.0 (/ (* (- (* 6.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)) 3.14159265) (/ (^ 2.0 0.5) (* 6.0 (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)))))) 3.14159265)) 13.0)) (/ (* 200.0 (* (^ x3 0.5) (/ (* (- (* 6.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)) 3.14159265) (/ (^ 2.0 0.5) (* 6.0 (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)))))) 3.14159265))) 13.0)) (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- x1) x2) (* x3 x6)) (+ (* x1 x4) (+ (- (* x2 x5) (* x4 x5)) (* x3 (+ (- x3) (+ x1 (+ (- x2 x6) (+ x4 x5))))))))) (^ (* 4.0 (* x3 (+ (* x3 (* x6 (+ (- x3) (+ x1 (+ (- x2 x6) (+ x4 x5)))))) (+ (* x1 (* x4 (+ (- x3 x1) (+ x2 (+ (- x6 x4) x5))))) (- (- (- (- (* x2 (* x5 (+ x3 (+ (- x1 x2) (+ x6 (- x4 x5)))))) (* x1 (* x2 x6))) (* x3 (* x2 x4))) (* x3 (* x1 x5))) (* x6 (* x4 x5))))))) 0.5)))) (/ 1.0 2.0)) (+ (* (* (+ (- (* 4.0 (/ (* (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265) (/ (^ 8.0 0.5) (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265))))) 3.14159265)) (/ (* 504.0 (/ (* (- (* 6.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)) 3.14159265) (/ (^ 2.0 0.5) (* 6.0 (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)))))) 3.14159265)) 13.0)) (/ (* 200.0 (* (^ x4 0.5) (/ (* (- (* 6.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)) 3.14159265) (/ (^ 2.0 0.5) (* 6.0 (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)))))) 3.14159265))) 13.0)) (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ (^ x2 0.5) 2.0)) (^ (^ x6 0.5) 2.0)) (* (^ (^ x4 0.5) 2.0) (^ (^ x1 0.5) 2.0))) (+ (* (^ (^ x2 0.5) 2.0) (^ (^ x5 0.5) 2.0)) (+ (- (* (^ (^ x6 0.5) 2.0) (^ (^ x3 0.5) 2.0)) (* (^ (^ x5 0.5) 2.0) (^ (^ x3 0.5) 2.0))) (* (^ (^ x4 0.5) 2.0) (+ (- (^ (^ x4 0.5) 2.0)) (+ (^ (^ x2 0.5) 2.0) (+ (- (^ (^ x6 0.5) 2.0) (^ (^ x1 0.5) 2.0)) (+ (^ (^ x5 0.5) 2.0) (^ (^ x3 0.5) 2.0)))))))))) (^ (* 4.0 (* (^ (^ x4 0.5) 2.0) (+ (* (^ (^ x4 0.5) 2.0) (* (^ (^ x1 0.5) 2.0) (+ (- (^ (^ x4 0.5) 2.0)) (+ (^ (^ x2 0.5) 2.0) (+ (- (^ (^ x6 0.5) 2.0) (^ (^ x1 0.5) 2.0)) (+ (^ (^ x5 0.5) 2.0) (^ (^ x3 0.5) 2.0))))))) (+ (* (^ (^ x2 0.5) 2.0) (* (^ (^ x5 0.5) 2.0) (+ (- (^ (^ x4 0.5) 2.0) (^ (^ x2 0.5) 2.0)) (+ (^ (^ x6 0.5) 2.0) (+ (- (^ (^ x1 0.5) 2.0) (^ (^ x5 0.5) 2.0)) (^ (^ x3 0.5) 2.0)))))) (- (- (- (- (* (^ (^ x6 0.5) 2.0) (* (^ (^ x3 0.5) 2.0) (+ (^ (^ x4 0.5) 2.0) (+ (- (^ (^ x2 0.5) 2.0) (^ (^ x6 0.5) 2.0)) (+ (^ (^ x1 0.5) 2.0) (- (^ (^ x5 0.5) 2.0) (^ (^ x3 0.5) 2.0))))))) (* (^ (^ x2 0.5) 2.0) (* (^ (^ x6 0.5) 2.0) (^ (^ x1 0.5) 2.0)))) (* (^ (^ x4 0.5) 2.0) (* (^ (^ x6 0.5) 2.0) (^ (^ x5 0.5) 2.0)))) (* (^ (^ x4 0.5) 2.0) (* (^ (^ x2 0.5) 2.0) (^ (^ x3 0.5) 2.0)))) (* (^ (^ x1 0.5) 2.0) (* (^ (^ x5 0.5) 2.0) (^ (^ x3 0.5) 2.0)))))))) 0.5)))) (/ 1.0 2.0)) (+ (* (* (+ (- (* 4.0 (/ (* (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265) (/ (^ 8.0 0.5) (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265))))) 3.14159265)) (/ (* 504.0 (/ (* (- (* 6.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)) 3.14159265) (/ (^ 2.0 0.5) (* 6.0 (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)))))) 3.14159265)) 13.0)) (/ (* 200.0 (* (^ x5 0.5) (/ (* (- (* 6.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)) 3.14159265) (/ (^ 2.0 0.5) (* 6.0 (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)))))) 3.14159265))) 13.0)) (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ (^ x1 0.5) 2.0)) (^ (^ x6 0.5) 2.0)) (* (^ (^ x5 0.5) 2.0) (^ (^ x2 0.5) 2.0))) (+ (* (^ (^ x1 0.5) 2.0) (^ (^ x4 0.5) 2.0)) (+ (- (* (^ (^ x6 0.5) 2.0) (^ (^ x3 0.5) 2.0)) (* (^ (^ x4 0.5) 2.0) (^ (^ x3 0.5) 2.0))) (* (^ (^ x5 0.5) 2.0) (+ (- (^ (^ x5 0.5) 2.0)) (+ (^ (^ x1 0.5) 2.0) (+ (- (^ (^ x6 0.5) 2.0) (^ (^ x2 0.5) 2.0)) (+ (^ (^ x4 0.5) 2.0) (^ (^ x3 0.5) 2.0)))))))))) (^ (* 4.0 (* (^ (^ x5 0.5) 2.0) (+ (* (^ (^ x5 0.5) 2.0) (* (^ (^ x2 0.5) 2.0) (+ (- (^ (^ x5 0.5) 2.0)) (+ (^ (^ x1 0.5) 2.0) (+ (- (^ (^ x6 0.5) 2.0) (^ (^ x2 0.5) 2.0)) (+ (^ (^ x4 0.5) 2.0) (^ (^ x3 0.5) 2.0))))))) (+ (* (^ (^ x1 0.5) 2.0) (* (^ (^ x4 0.5) 2.0) (+ (- (^ (^ x5 0.5) 2.0) (^ (^ x1 0.5) 2.0)) (+ (^ (^ x6 0.5) 2.0) (+ (- (^ (^ x2 0.5) 2.0) (^ (^ x4 0.5) 2.0)) (^ (^ x3 0.5) 2.0)))))) (- (- (- (- (* (^ (^ x6 0.5) 2.0) (* (^ (^ x3 0.5) 2.0) (+ (^ (^ x5 0.5) 2.0) (+ (- (^ (^ x1 0.5) 2.0) (^ (^ x6 0.5) 2.0)) (+ (^ (^ x2 0.5) 2.0) (- (^ (^ x4 0.5) 2.0) (^ (^ x3 0.5) 2.0))))))) (* (^ (^ x1 0.5) 2.0) (* (^ (^ x6 0.5) 2.0) (^ (^ x2 0.5) 2.0)))) (* (^ (^ x5 0.5) 2.0) (* (^ (^ x6 0.5) 2.0) (^ (^ x4 0.5) 2.0)))) (* (^ (^ x5 0.5) 2.0) (* (^ (^ x1 0.5) 2.0) (^ (^ x3 0.5) 2.0)))) (* (^ (^ x2 0.5) 2.0) (* (^ (^ x4 0.5) 2.0) (^ (^ x3 0.5) 2.0)))))))) 0.5)))) (/ 1.0 2.0)) (+ (* (* (+ (- (* 4.0 (/ (* (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265) (/ (^ 8.0 0.5) (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265))))) 3.14159265)) (/ (* 504.0 (/ (* (- (* 6.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)) 3.14159265) (/ (^ 2.0 0.5) (* 6.0 (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)))))) 3.14159265)) 13.0)) (/ (* 200.0 (* (^ x6 0.5) (/ (* (- (* 6.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)) 3.14159265) (/ (^ 2.0 0.5) (* 6.0 (- (* 4.0 3.14159265) (* 20.0 (- (* 3.0 (arccos (/ 1.0 3.0))) 3.14159265)))))) 3.14159265))) 13.0)) (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ (^ x1 0.5) 2.0)) (^ (^ x5 0.5) 2.0)) (* (^ (^ x6 0.5) 2.0) (^ (^ x3 0.5) 2.0))) (+ (* (^ (^ x1 0.5) 2.0) (^ (^ x4 0.5) 2.0)) (+ (- (* (^ (^ x5 0.5) 2.0) (^ (^ x2 0.5) 2.0)) (* (^ (^ x4 0.5) 2.0) (^ (^ x2 0.5) 2.0))) (* (^ (^ x6 0.5) 2.0) (+ (- (^ (^ x6 0.5) 2.0)) (+ (^ (^ x1 0.5) 2.0) (+ (- (^ (^ x5 0.5) 2.0) (^ (^ x3 0.5) 2.0)) (+ (^ (^ x4 0.5) 2.0) (^ (^ x2 0.5) 2.0)))))))))) (^ (* 4.0 (* (^ (^ x6 0.5) 2.0) (+ (* (^ (^ x6 0.5) 2.0) (* (^ (^ x3 0.5) 2.0) (+ (- (^ (^ x6 0.5) 2.0)) (+ (^ (^ x1 0.5) 2.0) (+ (- (^ (^ x5 0.5) 2.0) (^ (^ x3 0.5) 2.0)) (+ (^ (^ x4 0.5) 2.0) (^ (^ x2 0.5) 2.0))))))) (+ (* (^ (^ x1 0.5) 2.0) (* (^ (^ x4 0.5) 2.0) (+ (- (^ (^ x6 0.5) 2.0) (^ (^ x1 0.5) 2.0)) (+ (^ (^ x5 0.5) 2.0) (+ (- (^ (^ x3 0.5) 2.0) (^ (^ x4 0.5) 2.0)) (^ (^ x2 0.5) 2.0)))))) (- (- (- (- (* (^ (^ x5 0.5) 2.0) (* (^ (^ x2 0.5) 2.0) (+ (^ (^ x6 0.5) 2.0) (+ (- (^ (^ x1 0.5) 2.0) (^ (^ x5 0.5) 2.0)) (+ (^ (^ x3 0.5) 2.0) (- (^ (^ x4 0.5) 2.0) (^ (^ x2 0.5) 2.0))))))) (* (^ (^ x1 0.5) 2.0) (* (^ (^ x5 0.5) 2.0) (^ (^ x3 0.5) 2.0)))) (* (^ (^ x6 0.5) 2.0) (* (^ (^ x5 0.5) 2.0) (^ (^ x4 0.5) 2.0)))) (* (^ (^ x6 0.5) 2.0) (* (^ (^ x1 0.5) 2.0) (^ (^ x2 0.5) 2.0)))) (* (^ (^ x3 0.5) 2.0) (* (^ (^ x4 0.5) 2.0) (^ (^ x2 0.5) 2.0)))))))) 0.5)))) (/ 1.0 2.0)) (+ (* (* 0.005 (- 1.0 (/ (^ (- (/ (^ x1 0.5) 2.0) 1.26) 2.0) (^ (- 1.3254 1.26) 2.0)))) (- 1.0)) (+ (* 0.005 (- 1.0 (/ (^ (- (/ (^ x4 0.5) 2.0) 1.26) 2.0) (^ (- 1.3254 1.26) 2.0)))) (+ (* (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- x2) x3) (* x1 x4)) (+ (* x2 x5) (+ (- (* x3 x6) (* x5 x6)) (* x1 (+ (- x1) (+ x2 (+ (- x3 x4) (+ x5 x6))))))))) (^ (* 4.0 (* x1 (+ (* x1 (* x4 (+ (- x1) (+ x2 (+ (- x3 x4) (+ x5 x6)))))) (+ (* x2 (* x5 (+ (- x1 x2) (+ x3 (+ (- x4 x5) x6))))) (- (- (- (- (* x3 (* x6 (+ x1 (+ (- x2 x3) (+ x4 (- x5 x6)))))) (* x2 (* x3 x4))) (* x1 (* x3 x5))) (* x1 (* x2 x6))) (* x4 (* x5 x6))))))) 0.5))) 0.121189) (+ (* (^ x1 0.5) (- 0.06473)) (+ (* (^ x2 0.5) 0.084657) (+ (* (^ x3 0.5) 0.084657) (+ (* (^ x5 0.5) 0.084657) (+ (* (^ x6 0.5) 0.084657) (* 1.0 (- 0.741383)))))))))))))))))) 0.0)))
(check-sat)
(exit)
