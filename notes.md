# Application Notes

## Requirements

### The Client can do:
- [ ] Register, edit and close your account
- [ ] Make Deposits
- [ ] Make Withdraws
- [ ] Make Transfers between accounts
- [ ] Request for account balance
- [ ] Request for account statement filtered by initial and end date.

### Rules:
- [ ] The account can't be destroyed
- [ ] To request withdrawal and transfers user must be authenticated
- [ ] The account balance should never be a negative value
- [ ] Transfer fee rules
  - Monday to Friday between 9 to 18 hours the is 5 Reais per transfer
  - Outside that time the fee is 7 Reais
  - More than 1000 Reais additional fee of 10 Reais

## Entities
- Account
  - Authentication
  - Validate account never below zero
  - fields:
    - account_number
    - balance
- Transactions
  - fields:
    - account_id
    - type (DEPOSIT,WITHDRAW)
    - amount
    - created_at

## SQL
```
# Tranfer
transaction:
  SELECT ... FOR UPDATE
  INSERT INTO transactions (transaction_id, account_id, type, value, description, created_at) VALUES (id, 1, 'WITHDRAW', 10, 'Tranfer to 2', now())
  INSERT INTO transactions (transaction_id, account_id, type, value, description, created_at) VALUES (id, 2, 'DEPOSIT', 10, 'Tranfer from 1', now())
  INSERT INTO transactions (transaction_id, account_id, type, value, description, created_at) VALUES (id, 1, 'WITHDRAW', 5, 'Tranfer Fee', now())
end

DEPOSIT
transaction:
  INSERT INTO transactions (transaction_id, account_id, type, value, description, created_at) VALUES (id, 1, 'DEPOSIT', 10, '', now())
end

-- WITHDRAW
transaction:
  INSERT INTO transactions (transaction_id, account_id, type, value, description, created_at) VALUES (id, 1, 'WITHDRAW', 10, '', now())
end
```

# Plugins
- Logic deletion to end account (deleted_at)
- Devise
