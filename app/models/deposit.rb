class Deposit < Transaction
  before_save :update_account_balance
  
  def account_number=(account_number)
    self.account = Account.find_by(account_number: account_number)
  end

  private
  def update_account_balance
    account.with_lock do
      account.plus_funds(amount)
      self.balance = account.balance
    end
  end
end