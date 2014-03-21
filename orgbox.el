;;; orgbox.el --- Mailbox-like task scheduling in org agenda

;; Copyright © 2014 Yasuhito Takamiya <yasuhito@gmail.com>

;; Author: Yasuhito Takamiya <yasuhito@gmail.com>
;; URL: https://github.com/yasuhito/orgbox
;; Keywords: org
;; Version: 0.1.6
;; Package-Requires: ((org "8.0") (cl-lib "0.5"))

;; This file is not part of Org.
;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; This package defines a set of handy functions to schedule your
;; agenda tasks like Mailbox (http://www.mailboxapp.com/).  Supported
;; scheduling methods are as follows:
;;
;; - Later Today
;; - This Evening
;; - Tomorrow
;; - This Weekend
;; - Next Week
;; - In a Month
;; - Someday
;; - Pick Date
;;
;;; Code:

(require 'cl-lib)
(require 'org-agenda)

(defun orgbox-later-today ()
  "Schedule a task for later today."
  (interactive)
  (let ((later-today (format-time-string "%Y-%m-%d %H:%M"
                                           (time-add (current-time)
                                                     (seconds-to-time (* 3 60 60))))))
    (org-agenda-schedule nil later-today)))

(defun orgbox-evening-p ()
  "Is already evening?"
  (> (nth 2 (decode-time (current-time))) 18))

(defun orgbox-this-or-tomorrow-evening ()
  "Schedule a task for this or tomorrow evening."
  (interactive)
  (if (orgbox-evening-p)
      (org-agenda-schedule nil "+1d 18:00")
    (org-agenda-schedule nil "18:00")))

(defun orgbox-tomorrow ()
  "Schedule a task for tomorrow."
  (interactive)
  (org-agenda-schedule nil "+1d 8:00"))

(defun orgbox-weekend-p ()
  "Today is weekend?"
  (let ((day-of-week (calendar-day-of-week
                      (calendar-gregorian-from-absolute (org-today)))))
    (member day-of-week org-agenda-weekend-days)))

(defun orgbox-this-or-next-weekend ()
  "Schedule a task for this or next weekend."
  (interactive)
  (org-agenda-schedule nil "+sat 10:00"))

(defun orgbox-next-week ()
  "Schedule a task for next week."
  (interactive)
  (org-agenda-schedule nil "+mon 8:00"))

(defun orgbox-in-a-month ()
  "Schedule a task for 1 month later."
  (interactive)
  (org-agenda-schedule nil "+1m"))

(defun orgbox-someday ()
  "Schedule a task for someday."
  (interactive)
  (org-agenda-schedule nil "+3m"))

(defun orgbox ()
  "Schedule a task interactively."
  (interactive)
  (message "Schedule: [l]ater today  %s [e]vening  [t]omorrow  %s [w]eekend
          [n]ext week  [i]n a month  [s]omeday  [p]ick date  [q]uit/abort"
           (if (orgbox-evening-p) "tomorrow" "this")
           (if (orgbox-weekend-p) "next" "this"))
  (let ((a (read-char-exclusive)))
    (cl-case a
      (?l (call-interactively 'orgbox-later-today))
      (?e (call-interactively 'orgbox-this-or-tomorrow-evening))
      (?t (call-interactively 'orgbox-tomorrow))
      (?w (call-interactively 'orgbox-this-or-next-weekend))
      (?n (call-interactively 'orgbox-next-week))
      (?i (call-interactively 'orgbox-in-a-month))
      (?s (call-interactively 'orgbox-someday))
      (?p (call-interactively 'org-agenda-schedule))
      (?q (message "Abort"))
      (otherwise (error "Invalid key" )))))

(org-defkey org-agenda-mode-map (kbd "C-c C-s") 'orgbox)

(provide 'orgbox)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; orgbox.el ends here
