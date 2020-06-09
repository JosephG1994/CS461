; Tic tac toe game on a 3x3 game board.
; First to make three in a row wins.

; print each row of game board
(defun printRow (row)
  (format t "~a ~a ~a ~%" (car row) (cadr row) (caddr row))
)

; add an empty line
(defun emptyLine ()
 (write-char #\linefeed)
 (finish-output nil))
 
; print the full board
(defun printBoard (board)
  (if (>= (length board) 3)
    (progn
     (printRow board)
     (printBoard (cdddr board)))
    (emptyLine)
  )
) 

; identify a winning row
(defun triplet (pos3 board player)
 (and (eq (nth (car pos3) board) player)
      (eq (nth (cadr pos3) board) player)
      (eq (nth (caddr pos3) board) player))
)

; all combinations of four in a row
(defun winner (player board)
 (or
  (triplet '(0 1 2) board player)
  (triplet '(3 4 5) board player)
  (triplet '(6 7 8) board player)
  (triplet '(0 4 8) board player)
  (triplet '(6 4 2) board player)
  (triplet '(0 3 6) board player)
  (triplet '(1 4 7) board player)
  (triplet '(2 5 8) board player)
 )
)

; display menu 
(defun menu (prompt options)
 (mapcar 'print options)
 (emptyline)
 (loop
   (format t "~a" prompt)
   (finish-output nil)
   (let
    ((v (read t)))
   (if (or (< v 1) (> v (length options)))
    (print 'invalid)
    (return v)
   ))))

; check if a move is valid
(defun legal (move board)
 (eq (nth move board) '-))

; change player
(defun otherPlayer (p)
 (if (eq p 'x) 'o 'x))

; user makes a move
(defun userMove (board player)																						
 (loop
  (format t "Player ~a Select Space (1-9): " player)
  (finish-output nil)
  (let ((move (- (read t) 1)))
   (if (legal move board)
    (return move))
   (format t "Invalid Space, Try Again ~%")
  )
 )
)

; minimax search algorithm
(defun minmax (depth board player maxmin)
 (let
  ((bestMove (cons nil 0)) ; no more moves can be done 
   temp opponent
  )
  (loop for p from 0 to 8 do ; generate moves
   (when (legal p board)
     (setq temp (copy-list board))
     (setf (nth p temp) player)
   
     (if (not (car bestMove)) ; first move
       (setq bestMove (cons p maxmin)))

     (when (winner player temp)
      (return (cons p maxmin))
     )
	 ; recursive call
     (setq opponent
        (minmax (+ 1 depth) temp (otherPlayer player) (* -1 maxmin)))
     
     (if (= maxmin 1)
       (if (< (cdr opponent) (cdr bestMove))
        (setq bestMove opponent))
       (if (> (cdr opponent) (cdr bestMove))
        (setq bestMove opponent))
     )
   )
  )
  bestMove
 )
)
; computer makes a move
(defun computerMove (board player)
 (car (minmax 0 board player 1)))

; call appropriate function according to user input
(defun chosenMove (board pick player)
 (cond
  ((eq pick 1) (userMove board player)) ; User
  ((eq pick 2) (computerMove board player)) ; Computer
 ))

; play a game of tic tac toe
(defun ticTacToe(mode_x mode_o)
 (let
  ( (board (list '- '- '- '- '- '- '- '- '-))
    (player 'x)
    move
  )
  (loop
    (emptyLine)
    (printBoard board)

    (setq move
      (chosenMove board
        (if (eq player 'x) mode_x mode_o) player))

    (setf (nth move board) player)

    (when (winner player board)  
      (printBoard board)
      (return player))

    (when (not (find '- board)) ; there are no more empty spaces
      (printBoard board)
      (return 'draw))																						
   
    (setq player (otherPlayer player)) ; switch players
  )))

; game interface
(let
    ((options '(1=Human 2=Computer))
     (firstp 3)
     (secondp 5)
    )
    (if t
     (progn
      (setq firstp (menu "Player X Select Mode:" options))
      (setq secondp (menu "Player O Select Mode:" options)) ))
    (if t
     (let
      ((result (ticTacToe firstp secondp)))
      (if (eq result 'draw)
       (format t "Draw!")
       (format t "Player ~a Wins!" result))
     )))