#lang racket
; LDR TEST

(require "AsipMain.rkt")

(define led1 11)
(define led2 12)
(define led3 13)

(define setup 
  (lambda ()
    ;; connect to the Arduino:
    (open-asip)

    (set-pin-mode led1 OUTPUT_MODE)
    (set-pin-mode led2 OUTPUT_MODE)
    (set-pin-mode led3 OUTPUT_MODE)
    
    ;; Set pins to OUTPUT_MODE
   ; (map (lambda (x) (set-pin-mode  x  OUTPUT_MODE)) lights)
    
    ;; Turn the  lights off
    ;(map (lambda (x) (digital-write x LOW)) lights)

    ; set button pin as inputs
    ;(set-pin-mode! step-button-pin INPUT_MODE)

    ) ;; end of lambda
  ) ;; end of setup

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

(setup)
(loop n)
(digital-write led1 HIGH)