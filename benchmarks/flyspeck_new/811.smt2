(set-logic QF_NRA)
(declare-fun x1 () Real)
(declare-fun x2 () Real)
(declare-fun x3 () Real)
(declare-fun x4 () Real)
(declare-fun x5 () Real)
(declare-fun x6 () Real)
(assert (<= 4.0 x1))
(assert (<= x1 4.7524))
(assert (<= 4.0 x2))
(assert (<= x2 4.7524))
(assert (<= 4.0 x3))
(assert (<= x3 4.7524))
(assert (<= 4.0 x4))
(assert (<= x4 5.0625))
(assert (<= 4.0 x5))
(assert (<= x5 5.0625))
(assert (<= 4.0 x6))
(assert (<= x6 5.0625))
(assert (not (< (+ (* (* (+ 1.0 (- (/ (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (- (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) 3.14159265))) 3.14159265) (* (/ (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (- (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) 3.14159265))) 3.14159265) (+ 1.0 (* (- (^ x1 0.5) 2.0) (/ (- 0.0 1.0) (- 2.52 2.0))))))) (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ (^ x2 0.5) 2.0)) (^ (^ x3 0.5) 2.0)) (* (^ (^ x1 0.5) 2.0) (^ (^ x4 0.5) 2.0))) (+ (* (^ (^ x2 0.5) 2.0) (^ (^ x5 0.5) 2.0)) (+ (- (* (^ (^ x3 0.5) 2.0) (^ (^ x6 0.5) 2.0)) (* (^ (^ x5 0.5) 2.0) (^ (^ x6 0.5) 2.0))) (* (^ (^ x1 0.5) 2.0) (+ (- (^ (^ x1 0.5) 2.0)) (+ (^ (^ x2 0.5) 2.0) (+ (- (^ (^ x3 0.5) 2.0) (^ (^ x4 0.5) 2.0)) (+ (^ (^ x5 0.5) 2.0) (^ (^ x6 0.5) 2.0)))))))))) (^ (* 4.0 (* (^ (^ x1 0.5) 2.0) (+ (* (^ (^ x1 0.5) 2.0) (* (^ (^ x4 0.5) 2.0) (+ (- (^ (^ x1 0.5) 2.0)) (+ (^ (^ x2 0.5) 2.0) (+ (- (^ (^ x3 0.5) 2.0) (^ (^ x4 0.5) 2.0)) (+ (^ (^ x5 0.5) 2.0) (^ (^ x6 0.5) 2.0))))))) (+ (* (^ (^ x2 0.5) 2.0) (* (^ (^ x5 0.5) 2.0) (+ (- (^ (^ x1 0.5) 2.0) (^ (^ x2 0.5) 2.0)) (+ (^ (^ x3 0.5) 2.0) (+ (- (^ (^ x4 0.5) 2.0) (^ (^ x5 0.5) 2.0)) (^ (^ x6 0.5) 2.0)))))) (- (- (- (- (* (^ (^ x3 0.5) 2.0) (* (^ (^ x6 0.5) 2.0) (+ (^ (^ x1 0.5) 2.0) (+ (- (^ (^ x2 0.5) 2.0) (^ (^ x3 0.5) 2.0)) (+ (^ (^ x4 0.5) 2.0) (- (^ (^ x5 0.5) 2.0) (^ (^ x6 0.5) 2.0))))))) (* (^ (^ x2 0.5) 2.0) (* (^ (^ x3 0.5) 2.0) (^ (^ x4 0.5) 2.0)))) (* (^ (^ x1 0.5) 2.0) (* (^ (^ x3 0.5) 2.0) (^ (^ x5 0.5) 2.0)))) (* (^ (^ x1 0.5) 2.0) (* (^ (^ x2 0.5) 2.0) (^ (^ x6 0.5) 2.0)))) (* (^ (^ x4 0.5) 2.0) (* (^ (^ x5 0.5) 2.0) (^ (^ x6 0.5) 2.0)))))))) 0.5)))) (- 1.0)) (+ (* (* (+ 1.0 (- (/ (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (- (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) 3.14159265))) 3.14159265) (* (/ (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (- (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) 3.14159265))) 3.14159265) (+ 1.0 (* (- (^ x2 0.5) 2.0) (/ (- 0.0 1.0) (- 2.52 2.0))))))) (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ (^ x3 0.5) 2.0)) (^ (^ x1 0.5) 2.0)) (* (^ (^ x2 0.5) 2.0) (^ (^ x5 0.5) 2.0))) (+ (* (^ (^ x3 0.5) 2.0) (^ (^ x6 0.5) 2.0)) (+ (- (* (^ (^ x1 0.5) 2.0) (^ (^ x4 0.5) 2.0)) (* (^ (^ x6 0.5) 2.0) (^ (^ x4 0.5) 2.0))) (* (^ (^ x2 0.5) 2.0) (+ (- (^ (^ x2 0.5) 2.0)) (+ (^ (^ x3 0.5) 2.0) (+ (- (^ (^ x1 0.5) 2.0) (^ (^ x5 0.5) 2.0)) (+ (^ (^ x6 0.5) 2.0) (^ (^ x4 0.5) 2.0)))))))))) (^ (* 4.0 (* (^ (^ x2 0.5) 2.0) (+ (* (^ (^ x2 0.5) 2.0) (* (^ (^ x5 0.5) 2.0) (+ (- (^ (^ x2 0.5) 2.0)) (+ (^ (^ x3 0.5) 2.0) (+ (- (^ (^ x1 0.5) 2.0) (^ (^ x5 0.5) 2.0)) (+ (^ (^ x6 0.5) 2.0) (^ (^ x4 0.5) 2.0))))))) (+ (* (^ (^ x3 0.5) 2.0) (* (^ (^ x6 0.5) 2.0) (+ (- (^ (^ x2 0.5) 2.0) (^ (^ x3 0.5) 2.0)) (+ (^ (^ x1 0.5) 2.0) (+ (- (^ (^ x5 0.5) 2.0) (^ (^ x6 0.5) 2.0)) (^ (^ x4 0.5) 2.0)))))) (- (- (- (- (* (^ (^ x1 0.5) 2.0) (* (^ (^ x4 0.5) 2.0) (+ (^ (^ x2 0.5) 2.0) (+ (- (^ (^ x3 0.5) 2.0) (^ (^ x1 0.5) 2.0)) (+ (^ (^ x5 0.5) 2.0) (- (^ (^ x6 0.5) 2.0) (^ (^ x4 0.5) 2.0))))))) (* (^ (^ x3 0.5) 2.0) (* (^ (^ x1 0.5) 2.0) (^ (^ x5 0.5) 2.0)))) (* (^ (^ x2 0.5) 2.0) (* (^ (^ x1 0.5) 2.0) (^ (^ x6 0.5) 2.0)))) (* (^ (^ x2 0.5) 2.0) (* (^ (^ x3 0.5) 2.0) (^ (^ x4 0.5) 2.0)))) (* (^ (^ x5 0.5) 2.0) (* (^ (^ x6 0.5) 2.0) (^ (^ x4 0.5) 2.0)))))))) 0.5)))) (- 1.0)) (+ (* (* (+ 1.0 (- (/ (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (- (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) 3.14159265))) 3.14159265) (* (/ (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (- (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) 3.14159265))) 3.14159265) (+ 1.0 (* (- (^ x3 0.5) 2.0) (/ (- 0.0 1.0) (- 2.52 2.0))))))) (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ (^ x1 0.5) 2.0)) (^ (^ x2 0.5) 2.0)) (* (^ (^ x3 0.5) 2.0) (^ (^ x6 0.5) 2.0))) (+ (* (^ (^ x1 0.5) 2.0) (^ (^ x4 0.5) 2.0)) (+ (- (* (^ (^ x2 0.5) 2.0) (^ (^ x5 0.5) 2.0)) (* (^ (^ x4 0.5) 2.0) (^ (^ x5 0.5) 2.0))) (* (^ (^ x3 0.5) 2.0) (+ (- (^ (^ x3 0.5) 2.0)) (+ (^ (^ x1 0.5) 2.0) (+ (- (^ (^ x2 0.5) 2.0) (^ (^ x6 0.5) 2.0)) (+ (^ (^ x4 0.5) 2.0) (^ (^ x5 0.5) 2.0)))))))))) (^ (* 4.0 (* (^ (^ x3 0.5) 2.0) (+ (* (^ (^ x3 0.5) 2.0) (* (^ (^ x6 0.5) 2.0) (+ (- (^ (^ x3 0.5) 2.0)) (+ (^ (^ x1 0.5) 2.0) (+ (- (^ (^ x2 0.5) 2.0) (^ (^ x6 0.5) 2.0)) (+ (^ (^ x4 0.5) 2.0) (^ (^ x5 0.5) 2.0))))))) (+ (* (^ (^ x1 0.5) 2.0) (* (^ (^ x4 0.5) 2.0) (+ (- (^ (^ x3 0.5) 2.0) (^ (^ x1 0.5) 2.0)) (+ (^ (^ x2 0.5) 2.0) (+ (- (^ (^ x6 0.5) 2.0) (^ (^ x4 0.5) 2.0)) (^ (^ x5 0.5) 2.0)))))) (- (- (- (- (* (^ (^ x2 0.5) 2.0) (* (^ (^ x5 0.5) 2.0) (+ (^ (^ x3 0.5) 2.0) (+ (- (^ (^ x1 0.5) 2.0) (^ (^ x2 0.5) 2.0)) (+ (^ (^ x6 0.5) 2.0) (- (^ (^ x4 0.5) 2.0) (^ (^ x5 0.5) 2.0))))))) (* (^ (^ x1 0.5) 2.0) (* (^ (^ x2 0.5) 2.0) (^ (^ x6 0.5) 2.0)))) (* (^ (^ x3 0.5) 2.0) (* (^ (^ x2 0.5) 2.0) (^ (^ x4 0.5) 2.0)))) (* (^ (^ x3 0.5) 2.0) (* (^ (^ x1 0.5) 2.0) (^ (^ x5 0.5) 2.0)))) (* (^ (^ x6 0.5) 2.0) (* (^ (^ x4 0.5) 2.0) (^ (^ x5 0.5) 2.0)))))))) 0.5)))) (- 1.0)) (+ (* 1.0 3.14159265) (+ (* 1.0 (* (/ (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (+ (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) (- (+ (/ 3.14159265 2.0) (arctan2 (- (+ (- (* (- (^ 2.0 2.0)) (^ 2.0 2.0)) (^ (^ 2.0 2.0) 2.0)) (+ (^ (^ 2.0 2.0) 2.0) (+ (- (^ (^ 2.0 2.0) 2.0) (^ (^ 2.0 2.0) 2.0)) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0)))))))))) (^ (* 4.0 (* (^ 2.0 2.0) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (^ 2.0 2.0))))))) (+ (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (^ 2.0 2.0)))))) (- (- (- (- (* (^ 2.0 2.0) (* (^ 2.0 2.0) (+ (^ 2.0 2.0) (+ (- (^ 2.0 2.0) (^ 2.0 2.0)) (+ (^ 2.0 2.0) (- (^ 2.0 2.0) (^ 2.0 2.0))))))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))) (* (^ 2.0 2.0) (^ (^ 2.0 2.0) 2.0))))))) 0.5))) 3.14159265))) 3.14159265) 3.14159265)) (+ (* 1.0 (- 0.0008)) (+ (* (^ x1 0.5) 0.1631) (+ (* (^ x2 0.5) 0.1631) (+ (* (^ x3 0.5) 0.1631) (+ (* 1.0 (* 0.1631 (- 6.0))) (+ (* (^ x4 0.5) 0.2127) (+ (* (^ x5 0.5) 0.2127) (+ (* (^ x6 0.5) 0.2127) (* 1.0 (* 0.2127 (- 6.0)))))))))))))))) 0.0)))
(check-sat)
(exit)
