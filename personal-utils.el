;;; personal-utils.el -- personal emacs utils -*- lexical-binding:t -*-
;;;

(require 'cl-lib)

(defun insert-current-date ()
  "Insert e.g. '2017-10-29'."
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(provide 'personal-utils)
;;; pu.el ends here
