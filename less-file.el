;;; less-file.el --- Given a pathname run less in a line mode ansi-term.  -*- lexical-binding: t; -*-

;; Copyright (C) 2017 Ben Hyde

;; Author: Ben Hyde
;; Keywords: lisp
;; Version: 0.0.1

;; License:

;; Apache 2.0

;;; Commentary:

;;; Code:

(require 'tramp)
(require 'term)

(defun less-file (pathname)
  "Open a line-mode 'ansi-term' running unix less on the given PATHNAME."
  (interactive "fpathname:")
  (cond
   ((tramp-tramp-file-p pathname)
    (with-parsed-tramp-file-name pathname f
      (let ((buff (term-ansi-make-term "*log-view*" "/bin/bash")))
        (set-buffer buff)
        (switch-to-buffer buff)
        (term-mode)
        (term-line-mode)
        (cl-flet ((f (fmt &rest args)
                     (let ((x (apply #'format fmt args)))
                       (message x)
                       (term-send-string buff x))))
          (f "ssh %s\n" f-host)
          (sleep-for 1)

          (f "%sless %s\n" (if (string= f-method "sudo") "sudo " "") f-localname)))))
   (t
    (let ((buff (term-ansi-make-term "*log-view*" "/bin/bash")))
      (set-buffer buff)
      (switch-to-buffer buff)
      (term-mode)
      (term-line-mode)
      (term-send-string buff (format "less %s\n" pathname))))))

(provide 'less-file)
;;; less-file.el ends here
