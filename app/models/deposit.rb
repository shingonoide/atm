class Deposit < Transaction
  before_save :update_account_balance

  def update_account_balance
    account.plus_funds(amount)
  end
end