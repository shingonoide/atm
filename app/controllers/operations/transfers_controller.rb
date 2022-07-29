class Operations::TransfersController < ApplicationController
  before_action :authenticate_account!
  before_action :set_transfer, only: :show

  def new
    @transfer = Transfer.new    
  end

  def create
    @transfer = Transfer.new(transfer_params)

    respond_to do |format|
      if @transfer.save
        format.html { redirect_to operations_transfer_url(@transfer), notice: "Transfer was successfully created." }
        format.json { render :show, status: :created, location: @transfer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    def transfer_params
      params.require(:transfer).permit(:to_account_number, :amount).with_defaults(account: current_account)
    end
end
