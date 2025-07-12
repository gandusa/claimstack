;; ClaimStack - Time-Limited Airdrop Contract

(define-constant contract-owner tx-sender)
(define-constant DROP_AMOUNT u50000) ;; 0.05 STX in microSTX
(define-data-var claim-start uint u0)
(define-data-var claim-end uint u0)
(define-data-var total-claimed uint u0)

(define-map has-claimed
  {user: principal}
  {claimed: bool})

;; Admin sets claim window
(define-public (set-claim-window (start uint) (end uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err u100))
    (asserts! (< start end) (err u101))
    (var-set claim-start start)
    (var-set claim-end end)
    (ok true)))

;; Users claim their STX drop
(define-public (claim)
  (let
    ((start (var-get claim-start))
     (end (var-get claim-end))
     (now stacks-block-height)
     (already (default-to { claimed: false } (map-get? has-claimed {user: tx-sender}))))
    (begin
      (asserts! (>= now start) (err u102))
      (asserts! (<= now end) (err u103))
      (asserts! (is-eq (get claimed already) false) (err u104))

      ;; Transfer the drop
      (try! (stx-transfer? DROP_AMOUNT (as-contract tx-sender) tx-sender))

      ;; Mark as claimed
      (map-set has-claimed {user: tx-sender} {claimed: true})
      (var-set total-claimed (+ (var-get total-claimed) DROP_AMOUNT))

      (ok (tuple (claimed true) (block now))))))
