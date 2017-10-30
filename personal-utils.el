;;; personal-utils.el --- personal emacs utils -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;;###autoload
(defun insert-current-date ()
  "Insert e.g. '2017-10-29'."
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

;; Local Variables:
;; projectile-project-root: ~/.emacs.d/private/local/personal-utils/
;; End:
(provide 'personal-utils)
;;; personal-utils.el ends here
