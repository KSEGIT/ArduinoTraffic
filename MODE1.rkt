#lang racket

(require "AsipMain.rkt")
(define LEDY1 6)
(define LEDY2 9)
(define LEDY3 12)
(define LEDP1 3)
(define SWITCH 1)

(open-asip)

(set-pin mode! LEDY1 OUTPUT_MODE)
(set-pin mode! LEDY2 OUTPUT_MODE)
(set-pin mode! LEDY3 OUTPUT_MODE)
(set-pin mode! LEDP1 OUTPUT_MODE)
(set-pin mode! SWITCH INPUT_MODE)

(define MODE1
  (begin
    (digital-write SWITCH HIGH)
    (digital-write LEDP1 HIGH)
    (digital-write LEDY1 HIGH)
    (sleep 0.2)
    (digital-write LEDY1 LOW)
    (digital-write LEDY2 HIGH)
    (sleep 0.2)
    (digital-write LEDY2 LOW)
    (digital-write LEDY13 HIGH)
    (sleep 0.2)
    (digital-write LEDY3 LOW)
    (MODE1)))