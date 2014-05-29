# Changelog

## develop (unreleased)


## 0.5.0 (5/29/2004)

### New features

* New functions `orgbox-now`, `orgbox-schedule-now` and `orgbox-agenda-schedule-now`.
  It's bound to <kbd>SPC</kbd>


## 0.4.0 (3/25/2004)

### New features

* New function `orgbox-schedule` for org-mode buffer.
* New function `orgbox-schedule-lator-today` for org-mode buffer.
* New function `orgbox-schedule-this-or-tomorrow-evening` for org-mode
  buffer.
* New function `orgbox-schedule-tomorrow` for org-mode buffer.
* New function `orgbox-schedule-this-or-next-weekend` for org-mode
  buffer.
* New function `orgbox-schedule-next-week` for org-mode buffer.
* New function `orgbox-schedule-in-a-month` for org-mode buffer.
* New function `orgbox-schedule-someday` for org-mode buffer.

### Changes

* Replaced function `orgbox-schedule` with `orgbox-agenda-schedule`.
* Replaced function `orgbox-schedule-later-today` with
  `orgbox-agenda-schedule-later-today`.
* Replaced function `orgbox-schedule-this-or-tomorrow-evening` with
  `orgbox-agenda-schedule-this-or-tomorrow-evening`
* Replaced function `orgbox-schedule-tomorrow` with
  `orgbox-agenda-schedule-tomorrow`
* Replaced function `orgbox-schedule-this-or-next-weekend` with
  `orgbox-agenda-schedule-this-or-next-weekend`
* Replaced function `orgbox-schedule-next-week` with
  `orgbox-agenda-schedule-next-week`
* Replaced function `orgbox-schedule-in-a-month` with
  `orgbox-agenda-schedule-in-a-month`
* Replaced function `orgbox-schedule-someday` with
  `orgbox-agenda-schedule-someday`


## 0.3.0 (3/24/2004)

### New features

* New defcustom `orgbox-start-time-of-day` allows users to customize
  the start time of day.
* New defcustom `orgbox-start-day-of-week` allows users to customize
  the start day of week.
* New defcustom `orgbox-start-time-of-weekends` allows users to
  customize the start time of weekends.
* New defcustom `orgbox-start-day-of-weekends` allows users to
  customize the start day of weekends.
* New defcustom `orgbox-start-time-of-evening` allows users to
  customize the start time of evening.
* New defcustom `orgbox-later` allows users to customize 'later'.
* New defcustom `orgbox-someday` allows users to customize 'someday'.

### Changes

* Replaced function `orgbox-later-today` with
  `orgbox-schedule-later-today`.
* Replaced function `orgbox-this-or-next-weekend` with
  `orgbox-schedule-this-or-next-weekend`.
* Replaced function `orgbox-this-or-tomorrow-evening` with
  `orgbox-schedule-this-or-tomorrow-evening`.
* Replaced function `orgbox-tomorrow` with `orgbox-schedule-tomorrow`.
* Replaced function `orgbox-next-week` with
  `orgbox-schedule-next-week`.
* Replaced function `orgbox-in-a-month` with
  `orgbox-schedule-in-a-month`.
* Replaced function `orgbox-someday` with `orgbox-schedule-someday`.


## 0.2.0 (3/21/2014)

### Changes

* Rebound 'in a month' to <kbd>C-c C-s m</kbd>


## 0.1.6 (3/21/2014)

### Bugs fixed

* #1 - Fix compilation warnings.


## 0.1.5 (3/18/2014)

### Bugs fixed

* Correct `orgbox` keybinding in the README.md


## 0.1.4 (3/18/2014)

### Changes

* Rebound `orgbox` to <kbd>C-c C-s</kbd>
