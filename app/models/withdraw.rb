class Withdraw < Transaction
  before_save :update_account_balance

  def update_account_balance
    account.sub_funds(amount)
  end

  def account_number=(account_number)
    self.account = Account.find_by(account_number: account_number)
  end
end