#lang racket

; Traffic Light simulation. 
; Run through the sequence of states for a single traffic light; time delay between each state transition.
; 

;(require "AsipMain.rkt")
(require "AsipSimulated.rkt")

;(define led1 10)
(define led1 11)
(define led2 12)
(define led3 13)

; pins we're using
(define lights (list led1 led2 led3))

; sequence of light states
; each state has the form (redValue orangeValue greenValue).
; So (list 1 0 0 ) is the state in which red is on and the other two lights aren't.
(define lightSequence ( list (list 1 0 0 ) (list 1 1 0) (list 0 0 1) (list 0 1 0)))


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


; main entry point:
; start it off!
(setup)
(lightCycle lightSequence)



