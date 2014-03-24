;;; orgbox.el --- Mailbox-like task scheduling in org agenda.

;; Copyright © 2014 Yasuhito Takamiya <yasuhito@gmail.com>

;; Author: Yasuhito Takamiya <yasuhito@gmail.com>
;; URL: https://github.com/yasuhito/orgbox
;; Keywords: org
;; Version: 0.2.0
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

(defvar orgbox-start-time-of-day)
(defvar orgbox-start-day-of-week)
(defvar orgbox-start-time-of-weekends)
(defvar orgbox-start-day-of-weekends)
(defvar orgbox-start-time-of-evening)
(defvar orgbox-later)
(defvar orgbox-someday)

(defgroup orgbox nil
  "Mailbox-like task scheduling in org agenda."
  :group 'org)

(defcustom orgbox-start-time-of-day "8:00"
  "What time does your day start?"
  :group 'orgbox
  :type 'string)

(defcustom orgbox-start-day-of-week "mon"
  "What day does your week start?"
  :group 'orgbox
  :type '(choice (const :tag "Monday" "mon")
                 (const :tag "Tuesday" "tue")
                 (const :tag "Wednesday" "wed")
                 (const :tag "Thursday" "thu")
                 (const :tag "Friday" "fri")
                 (const :tag "Saturday" "sat")
                 (const :tag "Sunday" "sun")))

(defcustom orgbox-start-time-of-weekends "10:00"
  "What time does your weekends start?"
  :group 'orgbox
  :type 'string)

(defcustom orgbox-start-day-of-weekends "sat"
  "What day does your weekends start?"
  :group 'orgbox
  :type '(choice (const :tag "Monday" "mon")
                 (const :tag "Tuesday" "tue")
                 (const :tag "Wednesday" "wed")
                 (const :tag "Thursday" "thu")
                 (const :tag "Friday" "fri")
                 (const :tag "Saturday" "sat")
                 (const :tag "Sunday" "sun")))

(defcustom orgbox-start-time-of-evening "18:00"
  "What time does your evening start?"
  :group 'orgbox
  :type 'string)

(defcustom orgbox-later 3
  "Specify 'later' in number of hours."
  :type '(choice (const :tag "1 Hour" 1)
                 (const :tag "2 Hours" 2)
                 (const :tag "3 Hours" 3)
                 (const :tag "4 Hours" 4)
                 (const :tag "5 Hours" 5)
                 (const :tag "6 Hours" 6)
                 (const :tag "7 Hours" 7)
                 (const :tag "8 Hours" 8)
                 (const :tag "9 Hours" 9)
                 (const :tag "10 Hours" 10)
                 (const :tag "11 Hours" 11)
                 (const :tag "12 Hours" 12)
                 (const :tag "13 Hours" 13)
                 (const :tag "14 Hours" 14)
                 (const :tag "15 Hours" 15)
                 (const :tag "16 Hours" 16)
                 (const :tag "17 Hours" 17)
                 (const :tag "18 Hours" 18)
                 (const :tag "19 Hours" 19)
                 (const :tag "20 Hours" 20)
                 (const :tag "21 Hours" 21)
                 (const :tag "22 Hours" 22)
                 (const :tag "23 Hours" 23)
                 (const :tag "24 Hours" 24))
  :group 'orgbox)

(defcustom orgbox-someday "+3m"
  "Specify 'Someday' in number of months."
  :type '(choice (const :tag "1 Month" "+1m")
                 (const :tag "2 Months" "+2m")
                 (const :tag "3 Months" "+3m")
                 (const :tag "4 Months" "+4m")
                 (const :tag "5 Months" "+5m")
                 (const :tag "6 Months" "+6m")
                 (const :tag "7 Months" "+7m")
                 (const :tag "8 Months" "+8m")
                 (const :tag "9 Months" "+9m")
                 (const :tag "10 Months" "+10m")
                 (const :tag "11 Months" "+11m")
                 (const :tag "12 Months" "+12m"))
  :group 'orgbox)

(defun orgbox-schedule-later-today ()
  "Schedule a task for later today."
  (interactive)
  (let ((later (format-time-string "%Y-%m-%d %H:%M"
                                   (time-add (current-time)
                                             (seconds-to-time (* orgbox-later 60 60))))))
    (org-agenda-schedule nil later)))

(defun orgbox-evening-p ()
  "Is already evening?"
  (string< orgbox-start-time-of-evening (format-time-string "%H:%M" (current-time))))

(defun orgbox-schedule-this-or-tomorrow-evening ()
  "Schedule a task for this or tomorrow evening."
  (interactive)
  (if (orgbox-evening-p)
      (org-agenda-schedule nil (format "+1d %s" orgbox-start-time-of-evening))
    (org-agenda-schedule nil orgbox-start-time-of-evening)))

(defun orgbox-schedule-tomorrow ()
  "Schedule a task for tomorrow."
  (interactive)
  (org-agenda-schedule nil (format "+1d %s" orgbox-start-time-of-day)))

(defun orgbox-weekend-p ()
  "Today is weekend?"
  (let ((day-of-week (calendar-day-of-week
                      (calendar-gregorian-from-absolute (org-today)))))
    (member day-of-week org-agenda-weekend-days)))

(defun orgbox-schedule-this-or-next-weekend ()
  "Schedule a task for this or next weekend."
  (interactive)
  (org-agenda-schedule nil (format "+%s %s" orgbox-start-day-of-weekends orgbox-start-time-of-weekends)))

(defun orgbox-schedule-next-week ()
  "Schedule a task for next week."
  (interactive)
  (org-agenda-schedule nil (format "+%s %s" orgbox-start-day-of-week orgbox-start-time-of-day)))

(defun orgbox-schedule-in-a-month ()
  "Schedule a task for 1 month later."
  (interactive)
  (org-agenda-schedule nil "+1m"))

(defun orgbox-schedule-someday ()
  "Schedule a task for someday."
  (interactive)
  (org-agenda-schedule nil orgbox-someday))

(defun orgbox ()
  "Schedule a task interactively."
  (interactive)
  (message "Schedule: [l]ater today  %s [e]vening  [t]omorrow  %s [w]eekend
          [n]ext week  in a [m]onth  [s]omeday  [p]ick date  [q]uit/abort"
           (if (orgbox-evening-p) "tomorrow" "this")
           (if (orgbox-weekend-p) "next" "this"))
  (let ((a (read-char-exclusive)))
    (cl-case a
      (?l (call-interactively 'orgbox-schedule-later-today))
      (?e (call-interactively 'orgbox-schedule-this-or-tomorrow-evening))
      (?t (call-interactively 'orgbox-schedule-tomorrow))
      (?w (call-interactively 'orgbox-schedule-this-or-next-weekend))
      (?n (call-interactively 'orgbox-schedule-next-week))
      (?m (call-interactively 'orgbox-schedule-in-a-month))
      (?s (call-interactively 'orgbox-schedule-someday))
      (?p (call-interactively 'org-agenda-schedule))
      (?q (message "Abort"))
      (otherwise (error "Invalid key")))))

(org-defkey org-agenda-mode-map (kbd "C-c C-s") 'orgbox)

(provide 'orgbox)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; orgbox.el ends here
