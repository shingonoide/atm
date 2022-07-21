class Operations::TransfersController < ApplicationController

  def create
    @account = Account.find_by_account_number(transfer_params[:account_number])

    respond_to do |format|
      if @account.transfer_to_account(transfer_params[:amount], transfer_params[:to_account_number])
        format.html { redirect_to new_operations_transfer_url, notice: "Transfer was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  private
    def transfer_params
      params.require(:transfer).permit(:account_number, :to_account_number, :amount)
    end
end
