class OperationsController < ApplicationController

  def index
    @deposit = Deposit.new
    @withdraw = Withdraw.new
    @transfer = Transfer.new
  end

end
