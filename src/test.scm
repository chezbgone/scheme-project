;; A state represents the internal state when testing a property.

(define-record-type state
  (make-state successful-tests max-successful-tests)
  state?
  (successful-tests state-successful-tests set-state-successful-tests!)
  (max-successful-tests state-max-successful-tests
                        set-state-max-successful-tests!))

(define (generate-value type)
  ((generate (arbitrary type))))

(define (check-once property)
  (let ((types (property-types property))
        (assertion (property-assertion property)))
    (let ((generated-values (map generate-value types)))
      (apply assertion generated-values))))

;; Main state machine.
;; Run a test on property.
;; BROKEN
(define (test state property)
  (define res (property-assertion (map gen (property-types))))
  (and res
    (set-state-successful-tests! state (+ 1 (successful-tests state))))
  'done)

#|
(define prop:addition-commutativity
  (forall ((x integer) (y integer))
          (= (+ x y) (+ y x))))
(check-once prop:addition-commutativity)
|#
