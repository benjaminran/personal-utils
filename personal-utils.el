;;; personal-utils.el --- personal emacs utils -*- lexical-binding: t -*-
;; Version: 1.0
;; Package-requires (cl-lib)
;;; Commentary:
;;; Code:

;;;###autoload
(defun insert-current-date ()
  "Insert e.g. '2017-10-29'."
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(provide 'personal-utils)
;;; personal-utils.el ends here
