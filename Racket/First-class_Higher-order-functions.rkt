;;Temps1
(define (check-temps1 temps) (and (not (ormap negative? (map (lambda (num) (- num 5)) temps))) (not (ormap positive? (map (lambda (num) (- num 95)) temps)))))


;;Check Temps
(define (check-temps temps low high) (and (not (ormap negative? (map (lambda (num) (- num low)) temps))) (not (ormap positive? (map (lambda (num) (- num high)) temps)))))

;;Convert
(define (convert digits) (apply + (map * (for/list ([i (length digits)]) (expt 10 i)) digits)))

;;Duple
(define (duple lst)  (map (lambda (num) (list num num)) lst))

;;Average
(define (average lst) (/ (apply + lst) (length lst)))

;;Convert FC
(define (convertFC temps) (map (lambda (i) (/ (* (- i 32) 5) 9)) temps))

;;Eliminate Larger
(define (eliminate-larger lst) (foldr (lambda (member memo) (if (andmap (lambda (n) (<= member n)) memo) (cons member memo) memo)) '() lst))

;;Curry 2
(define (curry2 func) (lambda (first) (lambda (second) (func first second))))
