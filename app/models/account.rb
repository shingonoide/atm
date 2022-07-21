class Account < ApplicationRecord
  AccountError = Class.new(StandardError)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
  
  has_many :transactions
  has_many :deposits
  has_many :withdraws

  validates_uniqueness_of :account_number

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

  def transfer_to_account(amount, to_account)
    fee = calculate_transfer_fee(amount)
    to_acc = Account.find_by_account_number(to_account)
    if to_acc.nil?
      raise AccountError, "Account #{to_account} not found"
    end
    if amount.to_d <= fee
      raise AccountError, "Cannot transfer funds (account id: #{id}, to account: #{to_acc.id} fee: #{fee}, amount: #{amount}, balance: #{balance})."
    end
    transfer_amount = amount.to_d - fee
    with_lock {
      withdraws.create(amount: fee)
      withdraws.create(amount: transfer_amount)
      to_acc.deposits.create(amount: transfer_amount)
    }
  end

  def calculate_transfer_fee(amount)
    return 5.to_d
  end

end
