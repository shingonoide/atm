class Operations::TransfersController < ApplicationController
  before_action :authenticate_account!

  def new
    @transfer = Transfer.new    
  end

  def create
    @transfer = Transfer.new(transfer_params)

    respond_to do |format|
      if @transfer.save
        format.html { redirect_to new_operations_transfer_url, notice: "Transfer was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  private
    def transfer_params
      params.require(:transfer).permit(:to_account_number, :amount).with_defaults(account: current_account)
    end
end
