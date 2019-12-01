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

;button/switch check
(on-button-pressed button (lambda () (printf "ButtonClick\n" )))
;(on-button-pressed switch (lambda () (gotoNextState "e")))

; pins we're using for car lights
(define lights (list led1R led1Y led1G led2R led2Y led2G led3R led3Y led3G))

(define lightSequence ( list (list 1 0 0 ) (list 1 1 0) (list 0 0 1) (list 0 1 0)))

; takes a list of light values (0/1) and an equal length list of pin numbers
; and recurses through the lists to turn the pins on or off accordingly
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

; take a list of light settings and cycle through them repeatedly forever.
(define lightCycle (lambda (seq)
                     (cond [(not (empty? seq))
                            ;(printf "Setting lights ~s to ~s\n" lights lightSetting)
                            (setLights lights (first seq))
                            ; arbitrary sleep time?
                            ; could put into the sequence?
                            (sleep 1)
                            ; recurse, putting the head of the list at the end of the sequence
                            ; that way, we keep going around the sequence forever.
                            (lightCycle 
                             (append (rest seq) (list (first seq))
                                     )
                             )]
                           )
                     )
  )



;Mode 2
(define lightStates (hash 
                     1 (list 1 0 0  1 0 0  1 0 0 ) 
                     2 (list 1 1 0  1 0 0  1 0 0 ) 
                     3 (list 0 0 1  1 0 0  1 0 0 ) 
                     4 (list 0 1 0  1 0 0 )
                     5 (list 1 0 0  1 0 0 ) 
                     6 (list 1 0 0  1 1 0 ) 
                     7 (list 1 0 0  0 0 1 ) 
                     8 (list 1 0 0  0 1 0 )                     
                     9  (list 1 0 1  0 1 0 )
                     10 (list 0 0 1  0 0 1 )
                     11 (list 1 0 1  0 1 1 )
                     12 (list 0 0 0  0 0 0 ); etc 
                     ))

;START
(setup)
(lightCycle lightSequence)


