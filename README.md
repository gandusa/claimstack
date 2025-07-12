 ClaimStack Smart Contract

**ClaimStack** is a Clarity smart contract for managing **STX airdrops** in a decentralized and secure way on the Stacks blockchain. It allows administrators to assign claimable balances to users who can each claim their share exactly once.

---

 Features

-  Admin-only airdrop assignment
-  Users claim their STX once only
-  Prevents double-claims
-  Eligibility & claim status checks
-  Admin withdrawal of unused STX

---

 Contract Overview

| Function | Type | Description |
|----------|------|-------------|
| `set-claimable` | Public | Admin assigns STX to a user |
| `claim` | Public | Eligible user claims their STX |
| `withdraw-unused` | Public | Admin withdraws unclaimed STX |
| `check-eligibility` | Read-only | Check if a user is eligible |
| `has-user-claimed` | Read-only | Check if a user has already claimed |

---

 How It Works

1. **Admin allocates** claimable STX to users using `set-claimable`.
2. **Users claim** their STX through the `claim` function.
3. Claims are **recorded and restricted** to one-time use.
4. Admin can **withdraw remaining funds** after campaign ends.

---

Deployment Instructions

> Requires Clarinet and Stacks CLI.

1. Clone the repository.
2. Run tests:
   ```bash
   clarinet test
