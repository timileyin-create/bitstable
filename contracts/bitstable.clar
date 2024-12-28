;; Title: Stablecoin Vault Contract

;; Summary: A collateralized debt position (CDP) system for minting stablecoins against STX collateral

;; Description: This contract implements a decentralized stablecoin system where users can:
;;  - Create vaults by depositing STX as collateral
;;  - Mint stablecoins against their collateral maintaining a minimum collateral ratio
;;  - Manage their positions (repay debt, withdraw collateral)
;;  - Get liquidated if their position falls below the liquidation ratio
;;  The system includes:
;;  - Price oracle integration for real-time collateral valuation
;;  - Liquidation mechanism to ensure system solvency
;;  - Governance controls for risk parameters
;;  - Emergency shutdown capability
;;  - Stability fee mechanism for system sustainability

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-insufficient-collateral (err u101))
(define-constant err-below-mcr (err u102))
(define-constant err-already-initialized (err u103))
(define-constant err-not-initialized (err u104))
(define-constant err-low-balance (err u105))
(define-constant err-invalid-price (err u106))
(define-constant err-emergency-shutdown (err u107))
(define-constant err-invalid-parameter (err u108))
(define-constant maximum-price u1000000000) ;; Maximum allowed price (sanity check)
(define-constant minimum-price u1) ;; Minimum allowed price
(define-constant maximum-ratio u1000) ;; Maximum collateral ratio (1000%)
(define-constant minimum-ratio u101) ;; Minimum collateral ratio (101%)
(define-constant maximum-fee u100) ;; Maximum stability fee (100%)

;; Data Variables
(define-data-var minimum-collateral-ratio uint u150) ;; 150% collateralization ratio
(define-data-var liquidation-ratio uint u120) ;; 120% liquidation threshold
(define-data-var stability-fee uint u2) ;; 2% annual stability fee
(define-data-var initialized bool false)
(define-data-var emergency-shutdown bool false)
(define-data-var last-price uint u0) ;; Latest BTC/USD price
(define-data-var price-valid bool false)
(define-data-var governance-token principal 'SP000000000000000000002Q6VF78.governance-token)

;; Storage
(define-map vaults
    principal
    {
        collateral: uint,
        debt: uint,
        last-fee-timestamp: uint
    }
)

(define-map liquidators principal bool)
(define-map price-oracles principal bool)

;; Validation Functions
(define-private (is-valid-price (price uint))
    (and 
        (>= price minimum-price)
        (<= price maximum-price)
    )
)

(define-private (is-valid-ratio (ratio uint))
    (and 
        (>= ratio minimum-ratio)
        (<= ratio maximum-ratio)
    )
)

(define-private (is-valid-fee (fee uint))
    (<= fee maximum-fee)
)