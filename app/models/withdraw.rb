class Withdraw < Transaction
  before_save :update_account_balance

  def update_account_balance
    account.sub_funds(amount)
  end

  def account_number=(account_number)
    account_by_number = Account.find_by_account_number(account_number)
    self.account = account_by_number unless account_by_number.nil?
  end
end