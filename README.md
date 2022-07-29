# ATM application sample

## Description

This is a simple application to emulate simple bank ATM features.

## Bootstrap application

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  - Ruby 3.1.2

* System dependencies
  - Docker

* Configuration
  - Setup time zone 'America/Sao_Paulo'

* Database creation
  - make shell
  - bin/rails db:create

* Database initialization
  - make shell
  - bin/rails db:create

* How to run the test suite
  - make test


# Application Notes for Development

## Requirements

### The Client can do:
- [x] Register, edit and close your account
- [x] Make Deposits
- [x] Make Withdraws
- [x] Make Transfers between accounts
- [x] Request for account balance
- [x] Request for account statement filtered by initial and end date.

### Rules:
- [x] The account can't be destroyed
- [x] To request withdrawal and transfers user must be authenticated
- [x] The account balance should never be a negative value
- [x] Transfer fee rules
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
    - type (DEPOSIT,WITHDRAW,TRANSFER)
    - amount
    - created_at

### SQL samples
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
