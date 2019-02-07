;;Temps1
(define (check-temps1 temps) 
(cond [(null? temps) #t]
[(and (>= (car temps) 5) (<= (car temps) 95)) (check-temps1 (cdr temps))] 
[else #f]))

;;Check Temps
(define (check-temps temps low high) 
(cond [(null? temps) #t]
[(and (>= (car temps) low) (<= (car temps) high)) (check-temps (cdr temps) low high)] 
[else #f]))

;;Convert
(define (convert digits) (if (null? digits) 0 (+ (car digits) (convert (for/list ([i (cdr digits)]) (* 10 i))))))

;;Duple
(define (duple lst)  (if (null? lst) null (cons (list (car lst) (car lst)) (duple (cdr lst)))))

;;Average
(define (average lst) (/ (for/sum ([i lst]) i) (length lst)))

;;Convert FC
(define (convertFC temps) (for/list ([i temps]) (/ (* (- i 32) 5) 9)))

;;Eliminate Larger

;;IsSmaller tells us if the test-Digit is not larger than all subsequent ones
(define (isSmaller testDigit lst) (cond [(or (null? lst) (null? (car lst))) #t]
                                        [(> testDigit (car lst)) #f] 
                                        [else (isSmaller testDigit (cdr lst))]))
;;Returns null if every element is smaller. returns the list at which point it broke otherwise
(define (rmvProblem testDigit lst) (cond [(or (null? lst) (null? (car lst))) null]
                                      [(<= testDigit (car lst)) (cons (car lst) (rmvProblem testDigit (cdr lst)))] 
                                      [else (cdr lst)]))
;;If the element of the list we're looking at is not larger than all of the ones after, then we keep it
;;Otherwise, we test the ones after the element recursively, then make the decision to drop it or not
(define (eliminate-larger lst) (cond [(null? lst) null]
                               [(isSmaller (car lst) (cdr lst)) (cons (car lst) (eliminate-larger (cdr lst)))]  
                               [else (eliminate-larger (cdr lst))]))


;;Get nth
(define (get-nth lst n) (if (= n 0) (car lst) (get-nth (cdr lst) (- n 1))))

;;Find Item
(define (find-item-helper lst target position) (cond [(null? lst) -1] [(= (car lst) target) position] [else (find-item-helper (cdr lst) target (+ 1 position))]))
(define (find-item lst target) (find-item-helper lst target 0))

