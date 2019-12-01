#lang racket
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
    

    ;; Turn the lights off before start
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

; helper for changing pins voltage
(define setLights (lambda (lightPins vals) 
                    (cond [(not (empty? lightPins))
                           (cond [(equal? (first vals) 1)
                                  (digital-write (first lightPins) HIGH)
                                  (printf "Setting light ~s to HIGH\n" (first lightPins) )
                                  ]
                                 (else
                                  (digital-write (first lightPins) LOW)
                                  (printf "Setting light ~s to LOW\n" (first lightPins) )
                                  )
                                 )
                           (setLights (rest lightPins) (rest vals))
                           ]
                          )
                    )
  )



; pins we're using for car lights (as a set)
(define lights1 (list led1R led1Y led1G ))
(define lights2 (list led2R led2Y led2G ))
(define lights3 (list led3R led3Y led3G ))


(define lightSequence1 ( list (list 0 0 1 ) (list 0 1 0) (list 1 0 0) (list 1 0 0) (list 1 0 0) (list 1 1 0)))
(define lightSequence2 ( list (list 1 0 0 ) (list 1 1 0) (list 0 0 1) (list 0 1 0) (list 1 0 0) (list 1 0 0)))
(define lightSequence3 ( list (list 1 0 0 ) (list 1 0 0) (list 1 0 0) (list 1 1 0) (list 0 0 1) (list 1 0 0)))

; take a list of light settings and cycle through them repeatedly forever.
(define mainloop (lambda (seq1 seq2 seq3)
                   ;we use this check to stop function (from button)
                     (cond [(not (empty? seq1))
                            ;pedestrian goes red
                            (digital-write ledPR HIGH)
                            
                            
                            (setLights lights1 (first seq1))
                            (setLights lights2 (first seq2))
                            (setLights lights3 (first seq3))
                            ; arbitrary sleep time?
                            ; could put into the sequence?
                            (sleep 2)
                            ; recurse, putting the head of the list at the end of the sequence
                            ; that way, we keep going around the sequence forever.

                            (mainloop 

                             (append (rest seq1) (list (first seq1))
                                     )
                             (append (rest seq2) (list (first seq2))
                                     )
                             (append (rest seq3) (list (first seq3))
                                     )
                             
                             )]
                           )
                     )
  )


;MODE1
#|

;(on-button-pressed switch (lambda () (gotoNextState "e")))

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
|#

;MODE3 BY KZ
;button/switch check
(on-button-pressed button
                   (λ ()
                     (printf "ButtonClick\n" )
                     ;stoping main loop
                     (displayln "mapin loop sto")
                     
                     
                     

                     
                            (digital-write led1R HIGH)
                            (digital-write led2R HIGH)
                            (digital-write led3R HIGH)
                            (digital-write ledPR HIGH)
                            (sleep 3)
                            (digital-write ledPR LOW)
                            (digital-write ledPG HIGH)
                            (sleep 8)
                            (digital-write ledPR HIGH)
                            (digital-write ledPG LOW)
                     
                            ))


;START
(setup)
(mainloop lightSequence1 lightSequence2 lightSequence3)

