class Account < ApplicationRecord
  AccountError = Class.new(StandardError)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :validatable
  
  has_many :transactions
  has_many :deposits
  has_many :withdraws

  ZERO = 0.to_d

  validates :balance, numericality: { greater_than_or_equal_to: ZERO }

  def email_required?
    false
  end

  def will_save_change_to_email?
  end

  def plus_funds(amount)
    with_lock { update_columns(attributes_after_plus_funds!(amount)) }
    self
  end

  def attributes_after_plus_funds!(amount)
    if amount <= ZERO
      raise AccountError, "Cannot add funds (account id: #{id}, amount: #{amount}, balance: #{balance})."
    end

    { balance: balance + amount }
  end

  def sub_funds(amount)
    with_lock { update_columns(attributes_after_sub_funds!(amount)) }
    self
  end

  def attributes_after_sub_funds!(amount)
    if amount <= ZERO || amount > balance
      raise AccountError, "Cannot subtract funds (account id: #{id}, amount: #{amount}, balance: #{balance})."
    end

    { balance: balance - amount }
  end

  def deposit(amount)
    with_lock {
      deposits.create(amount: amount)
    }
  end

  def withdraw(amount)
    with_lock {
      withdraws.create(amount: amount)
    }
  end

  def transfer_to_account(amount, account_id)
    fee = calculate_transfer_fee(amount)
    acc = self.find(account_id)
    if amount <= fee
      raise AccountError, "Cannot transfer funds (account id: #{id}, to account: #{acc.id} fee: #{fee}, amount: #{amount}, balance: #{balance})."
    end
    transfer_amount = amount - fee
    with_lock {
      self.withdraws.create(amount: fee)
      self.withdraws.create(amount: transfer_amount)
      acc.deposits.create(amount: transfer_amount)
    }
  end

  def calculate_transfer_fee(amount)
    return 5
  end

end
