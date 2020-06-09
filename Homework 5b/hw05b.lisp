;Joseph Garcia
;4/20/2020
;CS 461

(defun TERMINAL-TEST (state)
        (and
            (and (not (eq (first state) 'B)) 
            (not (eq (first (cdr state)) 'B))) 
            (not (eq (first (cddr state)) 'B)) 
        )
)

(defun UTILITY (state)
    (cond
        ((and
            (and (eq (first state) 'A) 
            (eq (first (cdr state)) 'A))
            (eq (first (cddr state)) 'A)
        ) 1 )
        ((and
            (and (eq (first state) 'C) 
            (eq (first (cdr state)) 'C))
            (eq (first (cddr state)) 'C)
        ) -1 )
        (T 0)
    )
)

(defun ACTIONS (state)
    (append
        (if (eq (first state) 'B) '(A1))
        (if (eq (first (cdr state)) 'B) '(A2))
        (if (eq (first (cddr state)) 'B) '(A3))
    )
)

(defun RESULT (state action)
    (cond
        ((and (eq action 'A1) 
            (eq (first state) 'B)) 
            (cons 'A (cdr state)))
        ((and (eq action 'A2) 
            (eq (first (cdr state)) 'B))
            (cons (first state) 
            (cons 'A (cddr state))))
        ((and (eq action 'A3) 
            (eq (first (cddr state)) 'B))
            (cons (first state) 
            (cons (first (cdr state)) '(A))))
        (T state)
    )
)

;Arguments for TERMINAL-TEST
(format t "(TERMINAL-TEST '(A B C)) = ~s" (TERMINAL-TEST '(A B C)))(terpri)
(format t "(TERMINAL-TEST '(B B B)) = ~s" (TERMINAL-TEST '(B B B)))(terpri)
(format t "(TERMINAL-TEST '(A C A)) = ~s" (TERMINAL-TEST '(A C A)))(terpri)
(terpri)

;Arguments for UTILITY
(format t "(UTILITY '(A A A)) = ~s" (UTILITY '(A A A)))(terpri)
(format t "(UTILITY '(A B C)) = ~s" (UTILITY '(A B C)))(terpri)
(format t "(UTILITY '(C C C)) = ~s" (UTILITY '(C C C)))(terpri)
(terpri)

;Arguments for ACTIONS
(format t "(ACTIONS '(A B C)) = ~s" (ACTIONS '(A B C)))(terpri)
(format t "(ACTIONS '(B C B)) = ~s" (ACTIONS '(B C B)))(terpri)
(format t "(ACTIONS '(B B B)) = ~s" (ACTIONS '(B B B)))(terpri)
(terpri)

;Arguments for RESULT
(format t "(RESULT '(B A A) 'A1) = ~s" (RESULT '(B A A) 'A1))(terpri)
(format t "(RESULT '(A B C) 'A2) = ~s" (RESULT '(A B C) 'A2))(terpri)
(format t "(RESULT '(B C B) 'A3) = ~s" (RESULT '(B C B) 'A3))(terpri)
(format t "(RESULT '(C C C) 'A1) = ~s" (RESULT '(C C C) 'A1))(terpri)