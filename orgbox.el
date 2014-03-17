;; TODO: 21:00 過ぎてたらどうする？
(defun org-agenda-schedule-later-today ()
  (interactive)
  (let ((later-today (format-time-string "%Y-%m-%d %H:%M"
                                           (time-add (current-time)
                                                     (seconds-to-time (* 3 60 60))))))
    (org-agenda-schedule nil later-today)))

;; TODO: 18:00 過ぎてたらどうする？
(defun org-agenda-schedule-this-evening ()
  (interactive)
  (org-agenda-schedule nil "18:00"))

;; TODO: 明日が週末だったら 10:00am
(defun org-agenda-schedule-tomorrow ()
  (interactive)
  (org-agenda-schedule nil "+1d 8:00"))

(defun org-agenda-schedule-this-weekend ()
  (interactive)
  (org-agenda-schedule nil "+sat 10:00"))

(defun org-agenda-schedule-next-week ()
  (interactive)
  (org-agenda-schedule nil "+mon 8:00"))

(defun org-agenda-schedule-in-a-month ()
  (interactive)
  (org-agenda-schedule nil "+1m"))

(defun org-agenda-schedule-someday ()
  (interactive)
  (org-agenda-schedule nil "+3m"))

(defun org-agenda-schedule-like-mailbox ()
  (interactive)
  (message "Schedule: [l]ater today  this [e]vening  [t]omorrow  this [w]eekend
        [n]ext week  [i]n a month  [s]omeday  [p]ick date  [q]uit/abort")
  (let ((a (read-char-exclusive)))
    (case a
      (?l (call-interactively 'org-agenda-schedule-later-today))
      (?e (call-interactively 'org-agenda-schedule-this-evening))
      (?t (call-interactively 'org-agenda-schedule-tomorrow))
      (?w (call-interactively 'org-agenda-schedule-this-weekend))
      (?n (call-interactively 'org-agenda-schedule-next-week))
      (?i (call-interactively 'org-agenda-schedule-in-a-month))
      (?s (call-interactively 'org-agenda-schedule-someday))
      (?p (call-interactively 'org-agenda-schedule))
      (?q (message "Abort"))
      (otherwise (error "Invalid key" )))))
