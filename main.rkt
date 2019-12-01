#lang racket
; LDR TEST

(require "AsipMain.rkt")
(require "AsipButtons.rkt")

(define led1R 13)
(define led1Y 12)
(define led1G 11)
(define led2R 10)
(define led2Y 9)
(define led2G 8)
(define led3R 7)
(define led3Y 6)
(define led3G 5)
(define button 4)
(define ledPR 3)
(define ledPG 2)
;(define switch 1)

(define setup 
  (lambda ()
    ;; connect to the Arduino:
    (open-asip)

    (set-pin-mode led1R OUTPUT_MODE)
    (set-pin-mode led1Y OUTPUT_MODE)
    (set-pin-mode led1G OUTPUT_MODE)
    (set-pin-mode led2R OUTPUT_MODE)
    (set-pin-mode led2Y OUTPUT_MODE)
    (set-pin-mode led2G OUTPUT_MODE)
    (set-pin-mode led3R OUTPUT_MODE)
    (set-pin-mode led3Y OUTPUT_MODE)
    (set-pin-mode led3G OUTPUT_MODE)
    (set-pin-mode button INPUT_MODE)
    (set-pin-mode ledPR OUTPUT_MODE)
    (set-pin-mode ledPG OUTPUT_MODE)
    

    ;; Turn the  lights off
    (digital-write led1R LOW)
    (digital-write led1Y LOW)
    (digital-write led1G LOW)
    (digital-write led2R LOW)
    (digital-write led2Y LOW)
    (digital-write led2G LOW)
    (digital-write led3R LOW)
    (digital-write led3Y LOW)
    (digital-write led3G LOW)
    (digital-write ledPR LOW)
    (digital-write ledPG LOW)
    
    ) ;; end of lambda
  ) ;; end of setup




;START
(setup)

