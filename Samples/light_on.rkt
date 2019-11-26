#lang racket


(require "AsipMain.rkt")


(define led1 11)

(define setup 
  (lambda ()
    ;; connect to the Arduino:
    (open-asip)  
    ;; Setting pins to OUTPUT_MODE
    
    ;; Could do this:
    ;(set-pin-mode led1 OUTPUT_MODE)
    ;(set-pin-mode led2 OUTPUT_MODE)
    ;(set-pin-mode led3 OUTPUT_MODE)
    
    ;; but it's shorter to do:
    (map (lambda (x) (set-pin-mode  x  OUTPUT_MODE)) lights)
    
    ;; Turn the  lights off
    (map (lambda (x) (digital-write x LOW)) lights)
    ) ;; end of lambda
  ) ;; end of setup

(setup)
(led1 HIGH)

