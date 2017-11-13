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

;;
;; ggtags stuff
;;
(require 'json)
(require 'dash)

(defgroup pu-ggtags nil
  "Group for pu-ggtags customizations."
  :group 'emacs)

(defcustom pu-ggtags-lib-path-config-file "~/.global/libsets.json"
  "Path to global libsets config file."
  :type '(file)
  :options '("~/.global/libsets.json")
  :group 'pu-ggtags)

(defun pu-ggtags-load-lib-path-config ()
  "Return the lib-path config from the file at pu-ggtags-lib-path-config-file as a plist."
  (let* ((json-object-type 'plist))
    (json-read-file (expand-file-name pu-ggtags-lib-path-config-file))))

(defun pu-ggtags-select-profile (config profile-name)
  "Return the CONFIG plist's value for the PROFILE-NAME property, or nil if not found."
  (let ((profile-symbol (intern (concat ":" profile-name))))
    (plist-get config profile-symbol)))

(defun pu-ggtags-assemble-libs-path (profile)
  "Return a suitable value for the GTAGSLIBPATH from the given configuration PROFILE plist."
  (s-join path-separator (plist-get profile :libs)))

(defun pu-ggtags-config-profiles (config)
  "Return a list of the available profile names in CONFIG."
  (-map (lambda (e) (substring (symbol-name e) 1)) (-filter 'symbolp config)))

(defun pu-ggtags-set-lib-path (profile-name)
  "Read the lib path for the given PROFILE-NAME and set the GTAGSLIBPATH environment variable accordingly."
  (interactive)
  (let* ((config (pu-ggtags-load-lib-path-config))
        (profile-name (completing-read "Profile: " (pu-ggtags-config-profiles config)))
        (profile (pu-ggtags-select-profile config profile-name))
        (gtagslibpath (pu-ggtags-assemble-libs-path profile)))
    (setenv "GTAGSLIBPATH" gtagslibpath)))
;;
;; end ggtags stuff
;;

(provide 'personal-utils)
;;; personal-utils.el ends here
