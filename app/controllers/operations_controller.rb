class OperationsController < ApplicationController
  def deposit
    Account.find_by_account_number(params["account_number"]).deposit(params["amount"])
  end

  def withdraw
    Account.find_by_account_number(params["account_number"]).withdraw(params["amount"])
  end

  def transfer
    Account.find_by_account_number(params["account_number"]).transfer_to_account(params["amount"], params["to_account_number"])
  end
end
