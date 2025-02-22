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
    
    ;; Set pins to OUTPUT_MODE
   ; (map (lambda (x) (set-pin-mode  x  OUTPUT_MODE)) lights)
    
    ;; Turn the  lights off
    ;(map (lambda (x) (digital-write x LOW)) lights)

    ; set button pin as inputs
    ;(set-pin-mode! step-button-pin INPUT_MODE)

    ) ;; end of lambda
  ) ;; end of setup

#|
(define n 10)
(define loop (lambda (n)
               (cond [;(not (empty? n))
                      (digital-write led2 HIGH)
                      (sleep 1)
                      (digital-write led2 LOW)
                      (- n 1)
                      (loop n)
                      ;(digital-write led3 HIGH)
                      ]
                )))
|#

(setup)
;(loop n)
(digital-write led1R HIGH)
(digital-write led1Y HIGH)
(digital-write led1G HIGH)
(digital-write led2R HIGH)
(digital-write led2Y HIGH)
(digital-write led2G HIGH)
(digital-write led3R HIGH)
(digital-write led3Y HIGH)
(digital-write led3G HIGH)
(digital-write ledPR HIGH)
(digital-write ledPG HIGH)
