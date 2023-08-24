;; random

(defun k60/random-range (a &optional b)
   (let* ((max (or b a))
          (min (or (and b a) 0)))
     (+ min (random (- max min)))))

(defun k60/random-choice (sequencep)
  (let ((length (length sequencep)))
    (nth (random length) sequencep)))

(defun k60/choose-randomly (&optional expr)
  (interactive "sList items to choose randomly from: ")
  (let ((list (split-string expr)))
    (message "%s" (k60/random-choice list))))
