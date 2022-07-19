class Withdraw < Transaction
  before_save :update_account_balance

  def update_account_balance
    account.sub_funds(amount)
  end
end