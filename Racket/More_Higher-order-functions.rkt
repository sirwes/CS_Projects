;;Default parms
(define (default-parms f values) (lambda args (apply f (append args (list-tail values (length args))))))

;;(define g (default-parms + (list 42 1 10)))
;;(writeln (g))
;;(writeln (g 8))
;;(writeln (g 8 42))

;;Type Parms
(define (checker types args) (if (null? types) (values) (if ((first types) (first args)) (checker (rest types) (rest args)) (error "wrong type"))))
(define (type-parms f types) (lambda args (checker types args) (apply f args)))

;;Chaining
;;(define g (default-parms (type-parms (lambda (arg1 arg2) (cons arg1 (cons arg2 (cons arg1 null)))) (list number? string?)) (list 0 "")))
;;(writeln (g))
;;(writeln (g 50))
;;(writeln (g 2 "se"))

;;New Sine
(define (degrees-to-radians angle) (* (/ angle 180) pi))
(define (new-sin angle type) (cond [(symbol=? type 'degrees) (sin (degrees-to-radians angle))] [(symbol=? type 'radians) (sin angle)]))
(define new-sin2 (default-parms (type-parms (lambda (arg1 arg2) (new-sin arg1 arg2)) (list number? symbol?)) (list 0 'radians)))
