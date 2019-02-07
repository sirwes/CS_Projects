;; Sum Coins Function
(define (sum-coins pennies nickels dimes quarters) 
(+ pennies (* 5 nickels) (* 10 dimes) (* 25 quarters)))

;;Degree to Radians Function
(define (degrees-to-radians angle) (* (/ angle 180) pi))

;;Sign Function
(define (sign x) 
(if (> x  0) 1
(if (< x 0) -1 0)))

;;New Sine Function
(define (new-sin angle type) 
(cond [(symbol=? type 'degrees) (sin (degrees-to-radians angle))] [(symbol=? type 'radians) (sin angle)]))
