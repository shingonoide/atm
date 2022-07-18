# notes

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
