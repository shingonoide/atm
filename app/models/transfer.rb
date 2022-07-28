class Transfer < Transaction
  before_save :update_account_balance
  validates_presence_of :account
  validates_presence_of :to_account_number
  validates :amount, numericality: { greater_than_or_equal_to: 0.to_d }
  validate :amount_greater_than_fee
  validate :is_not_same_account

  def fee(time=Time.now.in_time_zone)
    fee = 0.to_d
    if fee_time_in_range?(time)
      fee = 5.to_d
    else
      fee = 7.to_d
    end
    fee += 10.to_d if self.amount.to_d > 1000.to_d
    return fee 
  end

  def fee_time_in_range?(time)
    time.wday.between?(1,5) && time.between?(
      time.in_time_zone.beginning_of_day + 9.hours,
      time.in_time_zone.beginning_of_day + 18.hours,
    )
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

  private
  def update_account_balance
    transfer_amount = amount - fee
    account.with_lock do
      account.withdraws.create(amount: fee)
      account.withdraws.create(amount: transfer_amount)
      to_account_number.deposits.create(amount: transfer_amount)
      self.balance = account.reload.balance
    end
  end

  def amount_greater_than_fee
    errors.add(:amount, "should be gretter than fee") if fee >= self.amount.to_d
  end
  
  def is_not_same_account
    errors.add(:to_account_number, "should be another account") if account === to_account_number
  end
end