class Transfer < Transaction
  before_save :update_account_balance
  validates_presence_of :account
  validates_presence_of :to_account_number
  validates :amount, numericality: { greater_than_or_equal_to: 0.to_d }
  validate :amount_greater_than_fee
  validate :is_not_same_account

  def update_account_balance
    transfer_amount = amount - fee
    account.with_lock {
      account.withdraws.create(amount: fee)
      account.withdraws.create(amount: transfer_amount)
      to_account_number.deposits.create(amount: transfer_amount)
    }
  end

  def fee
    return 5.to_d
  end

  def account_number=(account_number)
    self.account = Account.find_by(account_number: account_number)
    errors.add(:account_number, "Account not found") if self.account
  end

  def to_account_number=(account_number)
    @to_account_number = Account.find_by_account_number(account_number)
    errors.add(:to_account_number, "not found") if @to_account_number.nil?
    @to_account_number
  end

  def to_account_number
    @to_account_number
  end

  def amount_greater_than_fee
    errors.add(:amount, "should be gretter than fee") if fee >= self.amount.to_d
  end
  
  def is_not_same_account
    errors.add(:to_account_number, "should be another account") if account === to_account_number
  end
end