class Operations::WithdrawsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_withdraw, only: %i[ show ]
  # skip_before_action :verify_authenticity_token

  def new
    @withdraw = Withdraw.new
  end

  def create
    @withdraw = Withdraw.new(withdraw_params)

    respond_to do |format|
      if @withdraw.save
        format.html { redirect_to operations_withdraw_url(@withdraw), notice: "Withdraw was successfully created." }
        format.json { render :show, status: :created, location: @withdraw }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @withdraw.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def set_withdraw
      @withdraw = Withdraw.find(params[:id])
    end

    def withdraw_params
      params.require(:withdraw).permit(:amount).with_defaults(account: current_account)
    end
end
